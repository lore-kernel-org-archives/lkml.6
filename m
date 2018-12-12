Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A09C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9448E20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9448E20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeLLKgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:36:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:41678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726960AbeLLKgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:36:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B18FAE72;
        Wed, 12 Dec 2018 10:36:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0C38A1E11DB; Wed, 12 Dec 2018 11:36:11 +0100 (CET)
Date:   Wed, 12 Dec 2018 11:36:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: Re: [PATCH 3/3] filemap: drop the mmap_sem for all blocking
 operations
Message-ID: <20181212103611.GC10902@quack2.suse.cz>
References: <20181211173801.29535-1-josef@toxicpanda.com>
 <20181211173801.29535-4-josef@toxicpanda.com>
 <20181211131519.8d9e91eac049f16dad7c2d1f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211131519.8d9e91eac049f16dad7c2d1f@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-12-18 13:15:19, Andrew Morton wrote:
> On Tue, 11 Dec 2018 12:38:01 -0500 Josef Bacik <josef@toxicpanda.com> wrote:
> 
> > Currently we only drop the mmap_sem if there is contention on the page
> > lock.  The idea is that we issue readahead and then go to lock the page
> > while it is under IO and we want to not hold the mmap_sem during the IO.
> > 
> > The problem with this is the assumption that the readahead does
> > anything.  In the case that the box is under extreme memory or IO
> > pressure we may end up not reading anything at all for readahead, which
> > means we will end up reading in the page under the mmap_sem.
> > 
> > Even if the readahead does something, it could get throttled because of
> > io pressure on the system and the process is in a lower priority cgroup.
> > 
> > Holding the mmap_sem while doing IO is problematic because it can cause
> > system-wide priority inversions.  Consider some large company that does
> > a lot of web traffic.  This large company has load balancing logic in
> > it's core web server, cause some engineer thought this was a brilliant
> > plan.  This load balancing logic gets statistics from /proc about the
> > system, which trip over processes mmap_sem for various reasons.  Now the
> > web server application is in a protected cgroup, but these other
> > processes may not be, and if they are being throttled while their
> > mmap_sem is held we'll stall, and cause this nice death spiral.
> > 
> > Instead rework filemap fault path to drop the mmap sem at any point that
> > we may do IO or block for an extended period of time.  This includes
> > while issuing readahead, locking the page, or needing to call ->readpage
> > because readahead did not occur.  Then once we have a fully uptodate
> > page we can return with VM_FAULT_RETRY and come back again to find our
> > nicely in-cache page that was gotten outside of the mmap_sem.
> > 
> > This patch also adds a new helper for locking the page with the mmap_sem
> > dropped.  This doesn't make sense currently as generally speaking if the
> > page is already locked it'll have been read in (unless there was an
> > error) before it was unlocked.  However a forthcoming patchset will
> > change this with the ability to abort read-ahead bio's if necessary,
> > making it more likely that we could contend for a page lock and still
> > have a not uptodate page.  This allows us to deal with this case by
> > grabbing the lock and issuing the IO without the mmap_sem held, and then
> > returning VM_FAULT_RETRY to come back around.
> > 
> > ...
...
> > @@ -2397,6 +2451,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> >  {
> >  	int error;
> >  	struct file *file = vmf->vma->vm_file;
> > +	struct file *fpin = NULL;
> >  	struct address_space *mapping = file->f_mapping;
> >  	struct file_ra_state *ra = &file->f_ra;
> >  	struct inode *inode = mapping->host;
> > @@ -2418,10 +2473,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> >  		 * We found the page, so try async readahead before
> >  		 * waiting for the lock.
> >  		 */
> > -		do_async_mmap_readahead(vmf, page);
> > +		fpin = do_async_mmap_readahead(vmf, page);
> >  	} else if (!page) {
> >  		/* No page in the page cache at all */
> > -		do_sync_mmap_readahead(vmf);
> > +		fpin = do_sync_mmap_readahead(vmf);
> >  		count_vm_event(PGMAJFAULT);
> >  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
> >  		ret = VM_FAULT_MAJOR;
> > @@ -2433,7 +2488,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> >  			return vmf_error(-ENOMEM);
> 
> hm, how does this work.  We might have taken a ref on the file and that
> ref is recorded in fpin but an error here causes us to lose track of
> that elevated refcount?

Yeah, that looks like a bug to me as well.

> >  	}
> >  
> > -	if (!lock_page_or_retry(page, vmf->vma->vm_mm, vmf->flags)) {
> > +	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin)) {
> >  		put_page(page);
> >  		return ret | VM_FAULT_RETRY;
> >  	}

And here can be the same problem. Generally if we went through 'goto
retry_find', we may have file ref already taken but some exit paths don't
drop that ref properly...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
