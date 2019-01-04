Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957FCC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C25F2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfADJAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:00:20 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50485 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfADJAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:00:20 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 58527540CA114;
        Fri,  4 Jan 2019 17:00:16 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 4 Jan 2019
 17:00:16 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: export pin_file flag to user
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190104041945.31802-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <444eef3d-78eb-7c17-b44c-0ab310fb7c7b@huawei.com>
Date:   Fri, 4 Jan 2019 17:00:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190104041945.31802-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/4 12:19, Jaegeuk Kim wrote:
> This exports pin_file status to user.

Semantics of pin_file flag is the same as nocow flag which is more widely
used in lsattr/chattr and vfs now.

#define FS_NOCOW_FL                     0x00800000 /* Do not cow file */

lsattr/chattr
no copy on write (C)

How about exporting it via F2FS_NOCOW_FL(0x00800000)?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 3 ++-
>  fs/f2fs/file.c | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 12fabd6735dd..036fd62010c1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2303,9 +2303,10 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>  #define F2FS_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
>  #define F2FS_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
>  #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> +#define F2FS_PIN_FILE_FL		0x40000000 /* pin_file status */
>  #define F2FS_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
>  
> -#define F2FS_FL_USER_VISIBLE		0x304BDFFF /* User visible flags */
> +#define F2FS_FL_USER_VISIBLE		0x704BDFFF /* User visible flags */
>  #define F2FS_FL_USER_MODIFIABLE		0x204BC0FF /* User modifiable flags */
>  
>  /* Flags we can manipulate with through F2FS_IOC_FSSETXATTR */
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ae2b45e75847..eb099f1ee937 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1651,6 +1651,8 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
>  		flags |= F2FS_ENCRYPT_FL;
>  	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
>  		flags |= F2FS_INLINE_DATA_FL;
> +	if (is_inode_flag_set(inode, FI_PIN_FILE))
> +		flags |= F2FS_PIN_FILE_FL;
>  
>  	flags &= F2FS_FL_USER_VISIBLE;
>  
> 

