Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D014BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995612082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995612082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeLDWuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:50:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDWuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:50:23 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A2D87A47;
        Tue,  4 Dec 2018 22:50:21 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:50:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
        jack@suse.cz
Subject: Re: [PATCH 3/4] filemap: drop the mmap_sem for all blocking
 operations
Message-Id: <20181204145017.62d952c2a209975aa5888acf@linux-foundation.org>
In-Reply-To: <20181130195812.19536-4-josef@toxicpanda.com>
References: <20181130195812.19536-1-josef@toxicpanda.com>
        <20181130195812.19536-4-josef@toxicpanda.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 14:58:11 -0500 Josef Bacik <josef@toxicpanda.com> wrote:

> Currently we only drop the mmap_sem if there is contention on the page
> lock.  The idea is that we issue readahead and then go to lock the page
> while it is under IO and we want to not hold the mmap_sem during the IO.
> 
> The problem with this is the assumption that the readahead does
> anything.  In the case that the box is under extreme memory or IO
> pressure we may end up not reading anything at all for readahead, which
> means we will end up reading in the page under the mmap_sem.

Please describe here why this is considered to be a problem. 
Application stalling, I assume?  Some description of in-the-field
observations would be appropriate.  ie, how serious is the problem
whcih is being addressed.

> Instead rework filemap fault path to drop the mmap sem at any point that
> we may do IO or block for an extended period of time.  This includes
> while issuing readahead, locking the page, or needing to call ->readpage
> because readahead did not occur.  Then once we have a fully uptodate
> page we can return with VM_FAULT_RETRY and come back again to find our
> nicely in-cache page that was gotten outside of the mmap_sem.
> 
> ...
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2304,28 +2304,44 @@ EXPORT_SYMBOL(generic_file_read_iter);
>  
>  #ifdef CONFIG_MMU
>  #define MMAP_LOTSAMISS  (100)
> +static struct file *maybe_unlock_mmap_for_io(struct file *fpin,
> +					     struct vm_area_struct *vma,
> +					     int flags)
> +{
> +	if (fpin)
> +		return fpin;
> +	if ((flags & (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT)) ==
> +	    FAULT_FLAG_ALLOW_RETRY) {
> +		fpin = get_file(vma->vm_file);
> +		up_read(&vma->vm_mm->mmap_sem);
> +	}
> +	return fpin;
> +}

A code comment would be nice.  What it does and, especially, why it does it.

> -	if (!lock_page_or_retry(page, vmf->vma->vm_mm, vmf->flags)) {
> -		put_page(page);
> -		return ret | VM_FAULT_RETRY;
> +	/*
> +	 * We are open-coding lock_page_or_retry here because we want to do the
> +	 * readpage if necessary while the mmap_sem is dropped.  If there
> +	 * happens to be a lock on the page but it wasn't being faulted in we'd
> +	 * come back around without ALLOW_RETRY set and then have to do the IO
> +	 * under the mmap_sem, which would be a bummer.

Expanding on "a bummer" would help here ;)

> +	 */
> +	if (!trylock_page(page)) {
> +		fpin = maybe_unlock_mmap_for_io(fpin, vmf->vma, vmf->flags);
> +		if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> +			goto out_retry;
> +		if (vmf->flags & FAULT_FLAG_KILLABLE) {
> +			if (__lock_page_killable(page)) {
> +				/*
> +				 * If we don't have the right flags for
> +				 * maybe_unlock_mmap_for_io to do it's thing we

"its"

> +				 * still need to drop the sem and return
> +				 * VM_FAULT_RETRY so the upper layer checks the
> +				 * signal and takes the appropriate action.
> +				 */
> +				if (!fpin)
> +					up_read(&vmf->vma->vm_mm->mmap_sem);
> +				goto out_retry;
> +			}
> +		} else
> +			__lock_page(page);
>  	}
>  
>  	/* Did it get truncated? */

