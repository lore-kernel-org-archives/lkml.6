Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3722C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B70218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfBMDm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:42:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727614AbfBMDm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:42:27 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 623AB5D5F434A0FFBD01;
        Wed, 13 Feb 2019 11:42:25 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Feb 2019
 11:42:22 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190212023343.52215-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <df77f830-e5dd-5943-d5b0-e21ced3a7df2@huawei.com>
Date:   Wed, 13 Feb 2019 11:42:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190212023343.52215-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/12 10:33, Jaegeuk Kim wrote:
> If we met this once, let fsck.f2fs clear this only.
> Note that, this addresses all the subtle fault injection test.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 03fea4efd64b..10a3ada28715 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1267,8 +1267,6 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> -	else
> -		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);

I didn't get it, previously, if we didn't persist all quota file's data in
checkpoint, then we will tag CP_QUOTA_NEED_FSCK_FLAG in CP area, but in current
checkpoint, we have persisted all quota file's data, quota files are consistent
with all other files in filesystem, why we can't remove this NEED_FSCK flag..?

Thanks,

>  
>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> 

