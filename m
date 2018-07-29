Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5494EECDFC4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B70E20894
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w6uVdLYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B70E20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeG2D2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 23:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731502AbeG2D2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 23:28:50 -0400
Received: from localhost (c-67-160-202-76.hsd1.ca.comcast.net [67.160.202.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37CA920842;
        Sun, 29 Jul 2018 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532829614;
        bh=3wbfSikP6uD75yDcY/izavroSCEvl0oPEPsgqK2vmTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w6uVdLYBUiYrA4+9SJgts99R5F5wcHk9jOdbFMu4AfWthBvZvGGtq2yYAFCqpcqax
         s6d48CGrTidMPSZIKWlPjjbBvTozo4dnyneuAC1UxO6Gy23lJCRB1Q9dVUvrHYNdFJ
         EFLgyOUjBcXylnZ45+tpBq/wXNvHxisuGZ5KkrXY=
Date:   Sat, 28 Jul 2018 19:00:13 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Weichao Guo <guoweichao@huawei.com>
Subject: Re: [PATCH 4/4] f2fs: fix to spread clear_cold_data()
Message-ID: <20180729020013.GG83620@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180727101516.41403-1-yuchao0@huawei.com>
 <20180727101516.41403-4-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727101516.41403-4-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27, Chao Yu wrote:
> We need to drop PG_checked flag on page as well when we clear PG_uptodate
> flag, in order to avoid treating the page as GCing one later.

What do you mean "treating the page as GCing one"?

> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c    | 8 +++++++-
>  fs/f2fs/dir.c     | 1 +
>  fs/f2fs/segment.c | 4 +++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a29f3162b887..2817e2f4eb17 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1768,6 +1768,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  	/* This page is already truncated */
>  	if (fio->old_blkaddr == NULL_ADDR) {
>  		ClearPageUptodate(page);
> +		clear_cold_data(page);
>  		goto out_writepage;
>  	}
>  got_it:
> @@ -1943,8 +1944,10 @@ static int __write_data_page(struct page *page, bool *submitted,
>  
>  out:
>  	inode_dec_dirty_pages(inode);
> -	if (err)
> +	if (err) {
>  		ClearPageUptodate(page);
> +		clear_cold_data(page);
> +	}
>  
>  	if (wbc->for_reclaim) {
>  		f2fs_submit_merged_write_cond(sbi, inode, 0, page->index, DATA);
> @@ -2534,6 +2537,8 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
>  		}
>  	}
>  
> +	clear_cold_data(page);
> +
>  	/* This is atomic written page, keep Private */
>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>  		return f2fs_drop_inmem_page(inode, page);
> @@ -2552,6 +2557,7 @@ int f2fs_release_page(struct page *page, gfp_t wait)
>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>  		return 0;
>  
> +	clear_cold_data(page);
>  	set_page_private(page, 0);
>  	ClearPagePrivate(page);
>  	return 1;
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 7f955c4e86a4..1e4a4122eb0c 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -734,6 +734,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>  		clear_page_dirty_for_io(page);
>  		ClearPagePrivate(page);
>  		ClearPageUptodate(page);
> +		clear_cold_data(page);
>  		inode_dec_dirty_pages(dir);
>  		f2fs_remove_dirty_inode(dir);
>  	}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 58abbdc53561..4d83961745e6 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -267,8 +267,10 @@ static int __revoke_inmem_pages(struct inode *inode,
>  		}
>  next:
>  		/* we don't need to invalidate this in the sccessful status */
> -		if (drop || recover)
> +		if (drop || recover) {
>  			ClearPageUptodate(page);
> +			clear_cold_data(page);
> +		}
>  		set_page_private(page, 0);
>  		ClearPagePrivate(page);
>  		f2fs_put_page(page, 1);
> -- 
> 2.18.0.rc1
