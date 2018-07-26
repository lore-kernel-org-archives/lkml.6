Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F0CC67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E423220852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E423220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeGZC4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:56:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728378AbeGZC4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:56:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9E84FEA56AC1E;
        Thu, 26 Jul 2018 09:42:04 +0800 (CST)
Received: from [127.0.0.1] (10.111.221.165) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.382.0; Thu, 26 Jul 2018
 09:42:00 +0800
Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: fix to restrict mount condition
 when without CONFIG_QUOTA
To:     Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180725231948.18075-1-chao@kernel.org>
From:   Sheng Yong <shengyong1@huawei.com>
Message-ID: <4b46f8b3-2858-a528-de53-c2de333c3314@huawei.com>
Date:   Thu, 26 Jul 2018 09:41:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180725231948.18075-1-chao@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.111.221.165]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chao

On 2018/7/26 7:19, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Like quota_ino feature, we need to reject mounting RDWR with image
> which enables project_quota feature when there is no CONFIG_QUOTA
> be set in kernel.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>   fs/f2fs/super.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index dbc1cb53581f..bc7c14a055bb 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -775,6 +775,12 @@ static int parse_options(struct super_block *sb, char *options)
>   			 "without CONFIG_QUOTA");
>   		return -EINVAL;
>   	}

I think the following should be checked within !CONFIG_QUOTA, like patch "f2fs: quota: do
not mount as RDWR without QUOTA if quota feature enabled" :)

thanks

> +	if (f2fs_sb_has_project_quota(sbi->sb) && !f2fs_readonly(sbi->sb)) {
> +		f2fs_msg(sb, KERN_ERR,
> +			"Filesystem with project quota feature cannot be "
> +			"mounted RDWR without CONFIG_QUOTA");
> +		return -EINVAL;
> +	}
>   #endif
>   
>   	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
> 

