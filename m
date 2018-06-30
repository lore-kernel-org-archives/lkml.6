Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6A1C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E5B2532E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E5B2532E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeF3QGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 12:06:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60188 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751054AbeF3QGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 12:06:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6F2E78E90CF98;
        Sun,  1 Jul 2018 00:06:41 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.382.0; Sun, 1 Jul 2018
 00:06:34 +0800
Subject: Re: [PATCH] f2fs: avoid the global name 'fault_name'
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1530374223-130895-1-git-send-email-gaoxiang25@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <174b5d84-8d41-4b8e-4e87-39f8cc3948ae@huawei.com>
Date:   Sun, 1 Jul 2018 00:06:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1530374223-130895-1-git-send-email-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Oh, I just found the same patch written by Chao at:
https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev

I just fixed the erofs name conflicts, so fixed f2fs as well.
Please ignore this one.

Thanks, 
Gao Xiang

On 2018/6/30 23:57, Gao Xiang wrote:
> Non-prefix global name 'fault_name' will pollute global
> namespace, fix it.
> 
> Refer to:
> https://lists.01.org/pipermail/kbuild-all/2018-June/049660.html
> 
> To: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Chao Yu <yuchao0@huawei.com>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  fs/f2fs/f2fs.h  | 4 ++--
>  fs/f2fs/super.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4d8b1de..11a2e09 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -65,7 +65,7 @@ struct f2fs_fault_info {
>  	unsigned int inject_type;
>  };
>  
> -extern char *fault_name[FAULT_MAX];
> +extern char *f2fs_fault_name[FAULT_MAX];
>  #define IS_FAULT_SET(fi, type) ((fi)->inject_type & (1 << (type)))
>  #endif
>  
> @@ -1279,7 +1279,7 @@ struct f2fs_sb_info {
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  #define f2fs_show_injection_info(type)				\
>  	printk("%sF2FS-fs : inject %s in %s of %pF\n",		\
> -		KERN_INFO, fault_name[type],			\
> +		KERN_INFO, f2fs_fault_name[type],		\
>  		__func__, __builtin_return_address(0))
>  static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
>  {
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3995e92..df12dcd 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -41,7 +41,7 @@
>  
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  
> -char *fault_name[FAULT_MAX] = {
> +char *f2fs_fault_name[FAULT_MAX] = {
>  	[FAULT_KMALLOC]		= "kmalloc",
>  	[FAULT_KVMALLOC]	= "kvmalloc",
>  	[FAULT_PAGE_ALLOC]	= "page alloc",
> 
