Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF252C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75D320663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfAUKEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:04:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2283 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbfAUKEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:04:20 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1CE0788A4902F56641D8;
        Mon, 21 Jan 2019 10:18:34 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Mon, 21 Jan 2019
 10:18:23 +0800
Subject: Re: [PATCH] squashfs: fix mtime underflow on 64 bit system
To:     <phillip@squashfs.org.uk>, <linux-kernel@vger.kernel.org>
CC:     <houtao1@huawei.com>, <zhaohongjiang@huawei.com>
References: <20190117082148.129347-1-zhengbin13@huawei.com>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <ba753b88-7134-b5aa-c39a-05aed9001b13@huawei.com>
Date:   Mon, 21 Jan 2019 10:18:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190117082148.129347-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Phillip, when you have time, help to confirm it?

Looking forward to your reply.

On 2019/1/17 16:21, zhengbin wrote:
> If we change the file mtime to 1969, mksquashfs and mount,
> the atime/mtime of this file will be underflow. The reason is
> treating timestamps with the high bit set as positive
> times(before 1970), which should be set as negative times
> just like on 32 bit system. After this, the poissble range
> of timestamps will be 1901-2038(prev is 1970-2106) on 64
> bit system.
> 
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  fs/squashfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
> index e9793b1e49a5..03a6ef77a2d2 100644
> --- a/fs/squashfs/inode.c
> +++ b/fs/squashfs/inode.c
> @@ -72,7 +72,7 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
>  	i_uid_write(inode, i_uid);
>  	i_gid_write(inode, i_gid);
>  	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
> -	inode->i_mtime.tv_sec = le32_to_cpu(sqsh_ino->mtime);
> +	inode->i_mtime.tv_sec = (signed int)le32_to_cpu(sqsh_ino->mtime);
>  	inode->i_atime.tv_sec = inode->i_mtime.tv_sec;
>  	inode->i_ctime.tv_sec = inode->i_mtime.tv_sec;
>  	inode->i_mode = le16_to_cpu(sqsh_ino->mode);
> --
> 2.16.2.dirty
> 
> 
> .
> 

