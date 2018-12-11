Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77101C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B6520811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B6520811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLKJki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:40:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:44304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbeLKJkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:40:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45934AE03;
        Tue, 11 Dec 2018 09:40:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 33C751E13F8; Tue, 11 Dec 2018 10:40:34 +0100 (CET)
Date:   Tue, 11 Dec 2018 10:40:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jan Kara <jack@suse.cz>, kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com
Subject: Re: [PATCH 3/4] filemap: drop the mmap_sem for all blocking
 operations
Message-ID: <20181211094034.GD17539@quack2.suse.cz>
References: <20181130195812.19536-1-josef@toxicpanda.com>
 <20181130195812.19536-4-josef@toxicpanda.com>
 <20181207110138.GE13008@quack2.suse.cz>
 <20181210184438.va7mdwjgwndgri4s@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210184438.va7mdwjgwndgri4s@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-12-18 13:44:39, Josef Bacik wrote:
> On Fri, Dec 07, 2018 at 12:01:38PM +0100, Jan Kara wrote:
> > On Fri 30-11-18 14:58:11, Josef Bacik wrote:
> > > @@ -2433,9 +2458,32 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> > >  			return vmf_error(-ENOMEM);
> > >  	}
> > >  
> > > -	if (!lock_page_or_retry(page, vmf->vma->vm_mm, vmf->flags)) {
> > > -		put_page(page);
> > > -		return ret | VM_FAULT_RETRY;
> > > +	/*
> > > +	 * We are open-coding lock_page_or_retry here because we want to do the
> > > +	 * readpage if necessary while the mmap_sem is dropped.  If there
> > > +	 * happens to be a lock on the page but it wasn't being faulted in we'd
> > > +	 * come back around without ALLOW_RETRY set and then have to do the IO
> > > +	 * under the mmap_sem, which would be a bummer.
> > > +	 */
> > 
> > Hum, lock_page_or_retry() has two callers and you've just killed one. I
> > think it would be better to modify the function to suit both callers rather
> > than opencoding? Maybe something like lock_page_maybe_drop_mmap() which
> > would unconditionally acquire the lock and return whether it has dropped
> > mmap sem or not? Callers can then decide what to do.
> > 
> 
> I tried this, but it ends up being convoluted, since swap doesn't have a file to
> pin we have to add extra cases for that, and then change the return value to
> indicate wether we locked the page _and_ dropped the mmap sem, or just locked
> the page, etc.  It didn't seem the extra complication, so I just broke the open
> coding out into its own helper.

OK. Thanks for looking into this!

> > BTW I'm not sure this complication is really worth it. The "drop mmap_sem
> > for IO" is never going to be 100% thing if nothing else because only one
> > retry is allowed in do_user_addr_fault(). So the second time we get to
> > filemap_fault(), we will not have FAULT_FLAG_ALLOW_RETRY set and thus do
> > blocking locking. So I think your code needs to catch common cases you
> > observe in practice but not those super-rare corner cases...
> 
> I had counters in all of these paths because I was sure some things weren't
> getting hit at all, but it turns out each of these cases gets hit with
> surprisingly high regularity. 

Cool! Could you share these counters? I'd be curious and they'd be actually
nice as a motivation in the changelog of this patch to show the benefit.

> The lock_page_or_retry() case in particular gets hit a lot with
> multi-threaded applications that got paged out because of heavy memory
> pressure.  By no means is it as high as just the normal readpage or
> readahead cases, but it's not 0, so I'd rather have the extra helper here
> to make sure we're never getting screwed.

Do you mean the case where we the page is locked in filemap_fault() (so
that lock_page_or_retry() bails after waiting) and when the page becomes
unlocked it is not uptodate? Because that is the reason why you opencode
lock_page_or_retry(), right? I'm not aware of any normal code path that
would create page in page cache and not try to fill it with data before
unlocking it so that's why I'm really trying to make sure we understand
each other.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
