Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406EBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE4E206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE4E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504138AbeKWWz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:55:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:35585 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388020AbeKWWz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:55:29 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED7239242D802;
        Fri, 23 Nov 2018 20:11:23 +0800 (CST)
Received: from [127.0.0.1] (10.111.221.165) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Fri, 23 Nov 2018
 20:11:16 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: check memory boundary by insane namelen
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20181115075040.83500-1-jaegeuk@kernel.org>
CC:     "gongchen (E)" <gongchen4@huawei.com>
From:   Sheng Yong <shengyong1@huawei.com>
Message-ID: <3d213d40-a4b0-6e60-87b2-81e66866ac4c@huawei.com>
Date:   Fri, 23 Nov 2018 20:11:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181115075040.83500-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.111.221.165]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jaegeuk and Chao,

On 2018/11/15 15:50, Jaegeuk Kim wrote:
> If namelen is corrupted to have very long value, fill_dentries can copy
> wrong memory area.
> 
Is there any scenario that could hit this corruption? Or this is triggered
by fuzzing injection?

thanks,
Sheng Yong

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/dir.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index bacc667950b6..c0c845da12fa 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -808,6 +808,17 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>   		de_name.name = d->filename[bit_pos];
>   		de_name.len = le16_to_cpu(de->name_len);
>   
> +		/* check memory boundary before moving forward */
> +		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
> +		if (unlikely(bit_pos > d->max)) {
> +			f2fs_msg(sbi->sb, KERN_WARNING,
> +				"%s: corrupted namelen=%d, run fsck to fix.",
> +				__func__, le16_to_cpu(de->name_len));
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
>   		if (f2fs_encrypted_inode(d->inode)) {
>   			int save_len = fstr->len;
>   
> @@ -830,7 +841,6 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>   		if (readdir_ra)
>   			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
>   
> -		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
>   		ctx->pos = start_pos + bit_pos;
>   	}
>   out:
> 

