Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57620C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282CB2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282CB2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeKZSS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:18:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbeKZSS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:18:57 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 506B21A43CA6E;
        Mon, 26 Nov 2018 15:25:42 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 26 Nov 2018
 15:25:41 +0800
Subject: Re: [PATCH v2] f2fs: fix to allow node segment for GC by ioctl path
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1543208334-309-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <37f1d52c-66c2-6e74-45a3-c590bf0c4150@huawei.com>
Date:   Mon, 26 Nov 2018 15:25:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543208334-309-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/26 12:58, Sahitya Tummala wrote:
> Allow node type segments also to be GC'd via f2fs ioctl
> F2FS_IOC_GARBAGE_COLLECT_RANGE.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
> v2:
> update commit message
> 
>  fs/f2fs/gc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a07241f..e4689c6 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -323,8 +323,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  	p.min_cost = get_max_cost(sbi, &p);
>  
>  	if (*result != NULL_SEGNO) {
> -		if (IS_DATASEG(get_seg_entry(sbi, *result)->type) &&
> -			get_valid_blocks(sbi, *result, false) &&
> +		if (get_valid_blocks(sbi, *result, false) &&

I'm okay with above commit message and change, but how about separating
below change into another patch?

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>  			!sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
>  			p.min_segno = *result;
>  		goto out;
> @@ -404,11 +403,12 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  		}
>  		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
>  
> +	}
> +out:
> +	if (p.min_segno != NULL_SEGNO)
>  		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
>  				sbi->cur_victim_sec,
>  				prefree_segments(sbi), free_segments(sbi));
> -	}
> -out:
>  	mutex_unlock(&dirty_i->seglist_lock);
>  
>  	return (p.min_segno == NULL_SEGNO) ? 0 : 1;
> 

