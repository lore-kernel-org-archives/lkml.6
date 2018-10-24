Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21352C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C3020831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C3020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeJXSWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:22:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43083 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbeJXSWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:22:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E24B051D74681;
        Wed, 24 Oct 2018 17:55:16 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Wed, 24 Oct 2018
 17:55:09 +0800
Subject: Re: [PATCH] f2fs: only flush the single temp bio cache which owns the
 target page
To:     Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5a92fd67-5a36-b14e-0c4d-820bcaa86568@huawei.com>
Date:   Wed, 24 Oct 2018 17:55:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunlong,

On 2018/10/24 16:10, Yunlong Song wrote:
> Previously, when f2fs finds which temp bio cache owns the target page,
> it will flush all the three temp bio caches, but we only need to flush
> one single bio cache indeed, which can help to keep bio merged.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/data.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 106f116..04ebbad 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -374,7 +374,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
>  
>  static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
>  						struct page *page, nid_t ino,
> -						enum page_type type)
> +						enum page_type type, enum temp_type *owner)
>  {
>  	enum page_type btype = PAGE_TYPE_OF_BIO(type);
>  	enum temp_type temp;
> @@ -392,6 +392,10 @@ static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
>  		if (ret || btype == META)
>  			break;
>  	}
> +	if (!ret || (!inode && !page && !ino))
> +		*owner = NR_TEMP_TYPE;
> +	else
> +		*owner = temp;
>  	return ret;
>  }
>  
> @@ -421,9 +425,14 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>  {
>  	enum temp_type temp;
>  
> -	if (!force && !has_merged_page(sbi, inode, page, ino, type))
> +	if (!force && !has_merged_page(sbi, inode, page, ino, type, &temp))
>  		return;
>  
> +	if (!force && temp != NR_TEMP_TYPE) {
> +		__f2fs_submit_merged_write(sbi, type, temp);

I think we need to add has_merged_page into __f2fs_submit_merged_write to
check whether we should submit bio from different log, otherwise we will
missed to submit bio in below condition:

- f2fs_write_cache_pages
 - add page into bio cache of cold log
 - add page into bio cache of warm log
 - f2fs_submit_merged_write_cond(inode)
   - __f2fs_submit_merged_write(warm) -- missed to submit bio of cold log

Thanks,

> +		return;
> +	}
> +
>  	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
>  
>  		__f2fs_submit_merged_write(sbi, type, temp);
> 

