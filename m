Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C961FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816DE22539
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNhRLB+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816DE22539
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbeGFWcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754253AbeGFWcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:32:48 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4EA3208F7;
        Fri,  6 Jul 2018 22:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530916367;
        bh=Rs61nFOBJKsdSuF4mBl3bYUTuWt1ANQVl+x1yeI5Qe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNhRLB+to1VXlUMOJZrGUnYogOk80KHRXVwMKZ12XJG7dBdfH0y4xiKzUTB/HV0x0
         yFjXLtwNaigFOESF7XbFNp2sVsxQoi3DrLslBGFbA3SJ/rAXbIi9Z3VDEy7T5gQTQs
         FDugXruhXUZPzoH63jOKulCQp7Jiro+7HcRvN89Q=
Date:   Fri, 6 Jul 2018 15:32:46 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2 1/2] f2fs: fix to avoid broken of dnode block list
Message-ID: <20180706223246.GA77984@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180704085614.13004-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704085614.13004-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04, Chao Yu wrote:
> f2fs recovery flow is relying on dnode block link list, it means fsynced
> file recovery depends on previous dnode's persistence in the list, so
> during fsync() we should wait on all regular inode's dnode writebacked
> before issuing flush.

We don't need to wait for all the writebacking nodes which can enter later.
Can we add a list of nids that we need to wait for?

> 
> By this way, we can avoid dnode block list being broken by out-of-order
> IO submission due to IO scheduler or driver.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2: add missing definition modification in f2fs.h.
>  fs/f2fs/f2fs.h |  2 +-
>  fs/f2fs/file.c | 17 ++++-------------
>  fs/f2fs/node.c |  4 ++--
>  3 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 859ecde81dd0..a9da5a089cb4 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2825,7 +2825,7 @@ pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
>  int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
>  int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
>  int f2fs_truncate_xattr_node(struct inode *inode);
> -int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino);
> +int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi);
>  int f2fs_remove_inode_page(struct inode *inode);
>  struct page *f2fs_new_inode_page(struct inode *inode);
>  struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 752ff678bfe0..ecca7b833268 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -292,19 +292,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  		goto sync_nodes;
>  	}
>  
> -	/*
> -	 * If it's atomic_write, it's just fine to keep write ordering. So
> -	 * here we don't need to wait for node write completion, since we use
> -	 * node chain which serializes node blocks. If one of node writes are
> -	 * reordered, we can see simply broken chain, resulting in stopping
> -	 * roll-forward recovery. It means we'll recover all or none node blocks
> -	 * given fsync mark.
> -	 */
> -	if (!atomic) {
> -		ret = f2fs_wait_on_node_pages_writeback(sbi, ino);
> -		if (ret)
> -			goto out;
> -	}
> +
> +	ret = f2fs_wait_on_node_pages_writeback(sbi);
> +	if (ret)
> +		goto out;
>  
>  	/* once recovery info is written, don't need to tack this */
>  	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 849c2ed9c152..0810c8117d46 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1710,7 +1710,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>  	return ret;
>  }
>  
> -int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
> +int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi)
>  {
>  	pgoff_t index = 0;
>  	struct pagevec pvec;
> @@ -1726,7 +1726,7 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
>  		for (i = 0; i < nr_pages; i++) {
>  			struct page *page = pvec.pages[i];
>  
> -			if (ino && ino_of_node(page) == ino) {
> +			if (IS_DNODE(page) && is_cold_node(page)) {
>  				f2fs_wait_on_page_writeback(page, NODE, true);
>  				if (TestClearPageError(page))
>  					ret = -EIO;
> -- 
> 2.18.0.rc1
