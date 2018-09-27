Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B56C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75782156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDQ3ex92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75782156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeI0LVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbeI0LVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:21:30 -0400
Received: from localhost (c-67-160-202-76.hsd1.ca.comcast.net [67.160.202.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B455721537;
        Thu, 27 Sep 2018 05:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538024709;
        bh=pyi8GGnzN5sEqMWyKcMVUsILcsw2FP/KIdq2Bb2fU4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDQ3ex92COoPvzWA4sVGGvW8oRNywHmrnnOA2t+pydnZwIi/Ziz7P7q3isSYT+KYO
         NvURVE1oKjFUue7xsUtObh8PRvCETNYOoqPVIjg7YEvpYKCO5V9oP5WLfkhsFDzFbk
         WAazIe8Jr7cCdyp5UlyKXy0zILnU9d11vLpvUCX4=
Date:   Wed, 26 Sep 2018 22:05:09 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: refactor ->page_mkwrite() flow
Message-ID: <20180927050509.GA72357@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180926144552.3302-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926144552.3302-1-chao@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes xfstests/083 stuck. So, I'll drop it for a while.

On 09/26, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Thread A				Thread B
> - f2fs_vm_page_mkwrite
> 					- f2fs_setattr
> 					 - down_write(i_mmap_sem)
> 					 - truncate_setsize
> 					 - f2fs_truncate
> 					 - up_write(i_mmap_sem)
>  - f2fs_reserve_block
>  reserve NEW_ADDR
>  - skip dirty page due to truncation
> 
> 1. we don't need to rserve new block address for a truncated page.
> 2. dn.data_blkaddr is used out of node page lock coverage.
> 
> Refactor ->page_mkwrite() flow to fix above issues:
> - use __do_map_lock() to avoid racing checkpoint()
> - lock data page in prior to dnode page
> - cover f2fs_reserve_block with i_mmap_sem lock
> - access dn.data_blkaddr under dnode lock
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/file.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6f02c8daff76..fcb4788b48aa 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -47,7 +47,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	struct page *page = vmf->page;
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	struct dnode_of_data dn;
> +	struct dnode_of_data dn = { .node_changed = false };
>  	int err;
>  
>  	if (unlikely(f2fs_cp_error(sbi))) {
> @@ -59,19 +59,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
>  
> -	/* block allocation */
> -	f2fs_lock_op(sbi);
> -	set_new_dnode(&dn, inode, NULL, NULL, 0);
> -	err = f2fs_reserve_block(&dn, page->index);
> -	if (err) {
> -		f2fs_unlock_op(sbi);
> -		goto out;
> -	}
> -	f2fs_put_dnode(&dn);
> -	f2fs_unlock_op(sbi);
> -
> -	f2fs_balance_fs(sbi, dn.node_changed);
> -
>  	file_update_time(vmf->vma->vm_file);
>  	down_read(&F2FS_I(inode)->i_mmap_sem);
>  	lock_page(page);
> @@ -108,12 +95,24 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	/* fill the page */
>  	f2fs_wait_on_page_writeback(page, DATA, false);
>  
> +	/* block allocation */
> +	__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
> +	set_new_dnode(&dn, inode, NULL, NULL, 0);
> +	err = f2fs_reserve_block(&dn, page->index);
> +	if (err)
> +		goto out_unlock;
> +
>  	/* wait for GCed page writeback via META_MAPPING */
>  	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>  
> +	f2fs_put_dnode(&dn);
> +out_unlock:
> +	__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
>  out_sem:
>  	up_read(&F2FS_I(inode)->i_mmap_sem);
> -out:
> +
> +	f2fs_balance_fs(sbi, dn.node_changed);
> +
>  	sb_end_pagefault(inode->i_sb);
>  	f2fs_update_time(sbi, REQ_TIME);
>  err:
> -- 
> 2.18.0
