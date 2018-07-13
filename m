Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C039ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A092124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A092124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbeGMDal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:30:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9617 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387801AbeGMDal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:30:41 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7C6E1C7783B68;
        Fri, 13 Jul 2018 11:17:53 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 11:17:48 +0800
Subject: Re: [PATCH 4/5] f2fs: disable small discard in lfs mode
To:     Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
 <1531408170-45758-5-git-send-email-yunlong.song@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ad6411b6-effd-6dc1-c7c6-43047806784d@huawei.com>
Date:   Fri, 13 Jul 2018 11:17:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531408170-45758-5-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/12 23:09, Yunlong Song wrote:
> In lfs mode, it is better to send the discard of the overall section
> each time to avoid missing alignment with flash.

Hmm.. I think LFS mode can be used widely on different kind of device instead of
just on zoned block device, so let's just keep old implementation here.

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 3 ++-
>  fs/f2fs/sysfs.c   | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index fd38b61..f6c20e0 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1766,7 +1766,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  	atomic_set(&dcc->issing_discard, 0);
>  	atomic_set(&dcc->discard_cmd_cnt, 0);
>  	dcc->nr_discards = 0;
> -	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
> +	dcc->max_discards = test_opt(sbi, LFS) ? 0 :
> +				MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>  	dcc->undiscard_blks = 0;
>  	dcc->root = RB_ROOT;
>  	dcc->rbtree_check = false;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 2e7e611..4b6c457 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -271,6 +271,10 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		return count;
>  	}
>  
> +	if (!strcmp(a->attr.name, "max_small_discards") &&
> +		test_opt(sbi, LFS))
> +		return -EINVAL;
> +
>  	*ui = t;
>  
>  	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
> 

