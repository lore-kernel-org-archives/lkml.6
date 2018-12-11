Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77AFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B2820855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B2820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeLKQiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:38:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:46200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726723AbeLKQiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:38:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7829AF89;
        Tue, 11 Dec 2018 16:38:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0AD291E13F8; Tue, 11 Dec 2018 17:38:17 +0100 (CET)
Date:   Tue, 11 Dec 2018 17:38:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jan Kara <jack@suse.cz>, kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com
Subject: Re: [PATCH 3/4] filemap: drop the mmap_sem for all blocking
 operations
Message-ID: <20181211163817.GA4020@quack2.suse.cz>
References: <20181130195812.19536-1-josef@toxicpanda.com>
 <20181130195812.19536-4-josef@toxicpanda.com>
 <20181207110138.GE13008@quack2.suse.cz>
 <20181210184438.va7mdwjgwndgri4s@macbook-pro-91.dhcp.thefacebook.com>
 <20181211094034.GD17539@quack2.suse.cz>
 <20181211160851.hqezlvlded6zujrm@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211160851.hqezlvlded6zujrm@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-12-18 11:08:53, Josef Bacik wrote:
> On Tue, Dec 11, 2018 at 10:40:34AM +0100, Jan Kara wrote:
> > > The lock_page_or_retry() case in particular gets hit a lot with
> > > multi-threaded applications that got paged out because of heavy memory
> > > pressure.  By no means is it as high as just the normal readpage or
> > > readahead cases, but it's not 0, so I'd rather have the extra helper here
> > > to make sure we're never getting screwed.
> > 
> > Do you mean the case where we the page is locked in filemap_fault() (so
> > that lock_page_or_retry() bails after waiting) and when the page becomes
> > unlocked it is not uptodate? Because that is the reason why you opencode
> > lock_page_or_retry(), right? I'm not aware of any normal code path that
> > would create page in page cache and not try to fill it with data before
> > unlocking it so that's why I'm really trying to make sure we understand
> > each other.
> 
> Uhh so that's embarressing.  We have an internal patchset that I thought
> was upstream but hasn't come along yet.  Basically before this patchset
> the way we dealt with this problem was to short-circuit readahead IO's by
> checking to see if the blkcg was congested (or if there was a fatal
> signal pending) and doing bio_wouldblock_error on the bio.  So this very
> case came up a lot, readahead would go through because it got in before
> we were congested, but would then get throttled, and then once the
> throttling was over would get aborted.  Other threads would run into
> these pages that had been locked, but they are never read in which means
> they waited for the lock to be dropped, did the VM_FAULT_RETRY, came back
> unable to drop the mmap_sem and did the actual readpage() and would get
> throttled.

OK, I'm somewhat unsure why we throttle on bios that actually get aborted
but that's a separate discussion over a different patches. Overall it makes
sense that some submitted readahead may actually get aborted on congestion
and thus unlocked pages will not be uptodate. So I agree that this case is
actually reasonably likely to happen. Just please mention case like aborted
readahead in the comment so that we don't wonder about the reason in a few
years again.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
