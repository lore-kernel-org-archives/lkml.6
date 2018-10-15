Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B63C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE7A20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE7A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeJOUUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:20:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13655 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbeJOUUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:20:23 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 86041D112B84F;
        Mon, 15 Oct 2018 20:35:14 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Mon, 15 Oct 2018
 20:35:08 +0800
Subject: Re: [PATCH] f2fs: fix count of seg_freed to make sec_freed correct
To:     Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1539168739-79848-1-git-send-email-yunlong.song@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2d4c379a-77c2-4408-2f23-36753afb95bd@huawei.com>
Date:   Mon, 15 Oct 2018 20:35:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539168739-79848-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/10 18:52, Yunlong Song wrote:
> When sbi->segs_per_sec > 1, and if some segno has 0 valid blocks before
> gc starts, do_garbage_collect will skip counting seg_freed++, and this
> will cause seg_freed < sbi->segs_per_sec and finally skip sec_freed++.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a07241f..dc63cd5 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1160,10 +1160,10 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  
>  		stat_inc_seg_count(sbi, type, gc_type);
>  
> +next:
>  		if (gc_type == FG_GC &&
>  				get_valid_blocks(sbi, segno, false) == 0)
>  			seg_freed++;
> -next:

How about:

if (get_valid_blocks(sbi, segno, false) == 0)
	goto freed;

if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi))
	goto next;


freed:
	if (gc_type == FG_GC &&
			get_valid_blocks(sbi, segno, false) == 0)
		seg_freed++;
next:

>  		f2fs_put_page(sum_page, 0);
>  	}
>  
> 

