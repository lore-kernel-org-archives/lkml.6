Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B4DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8AB20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8AB20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeLLKK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:10:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:37480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbeLLKK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:10:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 586C8AE88;
        Wed, 12 Dec 2018 10:10:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0B2191E11DB; Wed, 12 Dec 2018 11:10:51 +0100 (CET)
Date:   Wed, 12 Dec 2018 11:10:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: Re: [PATCH 2/3] filemap: pass vm_fault to the mmap ra helpers
Message-ID: <20181212101051.GB10902@quack2.suse.cz>
References: <20181211173801.29535-1-josef@toxicpanda.com>
 <20181211173801.29535-3-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211173801.29535-3-josef@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-12-18 12:38:00, Josef Bacik wrote:
> All of the arguments to these functions come from the vmf, and the
> following patches are going to add more arguments.  Cut down on the
> amount of arguments passed by simply passing in the vmf to these two
> helpers.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

The patch looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 03bce38d8f2b..8fc45f24b201 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2309,20 +2309,20 @@ EXPORT_SYMBOL(generic_file_read_iter);
>   * Synchronous readahead happens when we don't even find
>   * a page in the page cache at all.
>   */
> -static void do_sync_mmap_readahead(struct vm_area_struct *vma,
> -				   struct file_ra_state *ra,
> -				   struct file *file,
> -				   pgoff_t offset)
> +static void do_sync_mmap_readahead(struct vm_fault *vmf)
>  {
> +	struct file *file = vmf->vma->vm_file;
> +	struct file_ra_state *ra = &file->f_ra;
>  	struct address_space *mapping = file->f_mapping;
> +	pgoff_t offset = vmf->pgoff;
>  
>  	/* If we don't want any read-ahead, don't bother */
> -	if (vma->vm_flags & VM_RAND_READ)
> +	if (vmf->vma->vm_flags & VM_RAND_READ)
>  		return;
>  	if (!ra->ra_pages)
>  		return;
>  
> -	if (vma->vm_flags & VM_SEQ_READ) {
> +	if (vmf->vma->vm_flags & VM_SEQ_READ) {
>  		page_cache_sync_readahead(mapping, ra, file, offset,
>  					  ra->ra_pages);
>  		return;
> @@ -2352,16 +2352,16 @@ static void do_sync_mmap_readahead(struct vm_area_struct *vma,
>   * Asynchronous readahead happens when we find the page and PG_readahead,
>   * so we want to possibly extend the readahead further..
>   */
> -static void do_async_mmap_readahead(struct vm_area_struct *vma,
> -				    struct file_ra_state *ra,
> -				    struct file *file,
> -				    struct page *page,
> -				    pgoff_t offset)
> +static void do_async_mmap_readahead(struct vm_fault *vmf,
> +				    struct page *page)
>  {
> +	struct file *file = vmf->vma->vm_file;
> +	struct file_ra_state *ra = &file->f_ra;
>  	struct address_space *mapping = file->f_mapping;
> +	pgoff_t offset = vmf->pgoff;
>  
>  	/* If we don't want any read-ahead, don't bother */
> -	if (vma->vm_flags & VM_RAND_READ)
> +	if (vmf->vma->vm_flags & VM_RAND_READ)
>  		return;
>  	if (ra->mmap_miss > 0)
>  		ra->mmap_miss--;
> @@ -2418,10 +2418,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  		 * We found the page, so try async readahead before
>  		 * waiting for the lock.
>  		 */
> -		do_async_mmap_readahead(vmf->vma, ra, file, page, offset);
> +		do_async_mmap_readahead(vmf, page);
>  	} else if (!page) {
>  		/* No page in the page cache at all */
> -		do_sync_mmap_readahead(vmf->vma, ra, file, offset);
> +		do_sync_mmap_readahead(vmf);
>  		count_vm_event(PGMAJFAULT);
>  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
>  		ret = VM_FAULT_MAJOR;
> -- 
> 2.14.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
