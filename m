Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9996CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 10:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603632086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 10:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603632086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeKXVMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 16:12:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15598 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbeKXVML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 16:12:11 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A0BB19850051B;
        Sat, 24 Nov 2018 18:23:57 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Sat, 24 Nov 2018
 18:23:55 +0800
Subject: Re: [PATCH] f2fs: fix to allow node segment for GC by ioctl path
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1542949942-30275-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f94e8b8c-0c20-0668-16ad-4978b0600d36@huawei.com>
Date:   Sat, 24 Nov 2018 18:23:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542949942-30275-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/23 13:12, Sahitya Tummala wrote:
> Allow node type segments also to be GC'd via f2fs ioctls
> F2FS_IOC_GARBAGE_COLLECT and F2FS_IOC_GARBAGE_COLLECT_RANGE.

IIRC, only F2FS_IOC_GARBAGE_COLLECT_RANGE pass a valid segment number via
@result parameter in get_victim_by_default(), so in commit message, it
needs to remove F2FS_IOC_GARBAGE_COLLECT, right?

Thanks,

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
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

