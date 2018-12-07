Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB41DC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CD4208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CD4208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeLGKhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:37:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:35542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725986AbeLGKhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:37:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FDA3ADD4;
        Fri,  7 Dec 2018 10:37:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A96BC1E0D9D; Fri,  7 Dec 2018 11:37:28 +0100 (CET)
Date:   Fri, 7 Dec 2018 11:37:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: Re: [PATCH 2/4] filemap: kill page_cache_read usage in filemap_fault
Message-ID: <20181207103728.GD13008@quack2.suse.cz>
References: <20181130195812.19536-1-josef@toxicpanda.com>
 <20181130195812.19536-3-josef@toxicpanda.com>
 <20181207095750.GC13008@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207095750.GC13008@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-12-18 10:57:50, Jan Kara wrote:
> On Fri 30-11-18 14:58:10, Josef Bacik wrote:
> > If we do not have a page at filemap_fault time we'll do this weird
> > forced page_cache_read thing to populate the page, and then drop it
> > again and loop around and find it.  This makes for 2 ways we can read a
> > page in filemap_fault, and it's not really needed.  Instead add a
> > FGP_FOR_MMAP flag so that pagecache_get_page() will return a unlocked
> > page that's in pagecache.  Then use the normal page locking and readpage
> > logic already in filemap_fault.  This simplifies the no page in page
> > cache case significantly.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks for the patch. I like the simplification but I think it could be
> even improved... see below.
> 
> > @@ -2449,9 +2426,11 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> >  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
> >  		ret = VM_FAULT_MAJOR;
> >  retry_find:
> > -		page = find_get_page(mapping, offset);
> > +		page = pagecache_get_page(mapping, offset,
> > +					  FGP_CREAT|FGP_FOR_MMAP,
> > +					  vmf->gfp_mask);
> >  		if (!page)
> > -			goto no_cached_page;
> > +			return vmf_error(-ENOMEM);
> 
> So why don't you just do:
> 
> 		page = pagecache_get_page(mapping, offset,
> 					  FGP_CREAT | FGP_LOCK, vmf->gfp_mask);
> 		if (!page)
> 			return vmf_error(-ENOMEM);
> 		goto check_uptodate;
> 
> where check_uptodate would be a label before 'PageUptodate' check?
> 
> Then you don't have to introduce new flag for pagecache_get_page() and you
> also don't have to unlock and then lock again the page... And you can still
> delete all the code you've deleted.

Ah, you don't want lock_page() to block in case someone raced with you and
instantiated the page so that you can drop mmap_sem. OK, the patch looks
good to me then. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
