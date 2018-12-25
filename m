Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293FFC64E79
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 03:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F2720449
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 03:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeLYDGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 22:06:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbeLYDGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 22:06:52 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 766518D1600D1;
        Tue, 25 Dec 2018 11:06:49 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 25 Dec 2018
 11:06:45 +0800
Subject: Re: [PATCH] f2fs: fix use-after-free issue with sbi->stat_info
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1545656812-14695-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0938f41e-53ed-6290-9b79-d221b1e64db6@huawei.com>
Date:   Tue, 25 Dec 2018 11:06:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1545656812-14695-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/24 21:06, Sahitya Tummala wrote:
> iput() on sbi->node_inode can update sbi->stat_info
> in the below context, if the f2fs_write_checkpoint()
> has failed with error.
> 
> f2fs_balance_fs_bg+0x1ac/0x1ec
> f2fs_write_node_pages+0x4c/0x260
> do_writepages+0x80/0xbc
> __writeback_single_inode+0xdc/0x4ac
> writeback_single_inode+0x9c/0x144
> write_inode_now+0xc4/0xec
> iput+0x194/0x22c
> f2fs_put_super+0x11c/0x1e8
> generic_shutdown_super+0x70/0xf4
> kill_block_super+0x2c/0x5c
> kill_f2fs_super+0x44/0x50
> deactivate_locked_super+0x60/0x8c
> deactivate_super+0x68/0x74
> cleanup_mnt+0x40/0x78
> 
> Fix this by moving f2fs_destroy_stats() further below iput().
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/super.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index e184ad4e..df41a3a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1058,9 +1058,6 @@ static void f2fs_put_super(struct super_block *sb)
>  		f2fs_write_checkpoint(sbi, &cpc);
>  	}
>  
> -	/* f2fs_write_checkpoint can update stat informaion */
> -	f2fs_destroy_stats(sbi);

The code order in error path of fill_super is almost the same as the one of
put_super, could you please check that as well?

Thanks,

> -
>  	/*
>  	 * normally superblock is clean, so we need to release this.
>  	 * In addition, EIO will skip do checkpoint, we need this as well.
> @@ -1080,6 +1077,12 @@ static void f2fs_put_super(struct super_block *sb)
>  	iput(sbi->node_inode);
>  	iput(sbi->meta_inode);
>  
> +	/*
> +	 * iput() can update stat information, if f2fs_write_checkpoint()
> +	 * above failed with error.
> +	 */
> +	f2fs_destroy_stats(sbi);
> +
>  	/* destroy f2fs internal modules */
>  	f2fs_destroy_node_manager(sbi);
>  	f2fs_destroy_segment_manager(sbi);
> 

