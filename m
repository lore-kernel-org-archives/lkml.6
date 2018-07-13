Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C458ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8E02124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8E02124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbeGMD0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:26:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387700AbeGMD0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:26:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 64F743E365D89;
        Fri, 13 Jul 2018 11:14:03 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 11:13:55 +0800
Subject: Re: [PATCH 2/5] f2fs: clear the remaining prefree_map of the section
To:     Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
 <1531408170-45758-3-git-send-email-yunlong.song@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c9a3972b-dc52-19ca-7ed0-2f754d89ab33@huawei.com>
Date:   Fri, 13 Jul 2018 11:13:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531408170-45758-3-git-send-email-yunlong.song@huawei.com>
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
> For the case when sbi->segs_per_sec > 1, take section:segment = 5 for
> example, if the section prefree_map is ...previous section | current
> section (1 1 0 1 1) | next section..., then the start = x, end = x + 1,
> after start = start_segno + sbi->segs_per_sec, start = x + 5, then it
> will skip x + 3 and x + 4, but their bitmap is still set, which will
> cause duplicated f2fs_issue_discard of this same section in the next
> write_checkpoint, so fix it.

I didn't get it, if # 2 segment is not prefree state, so it still has valid
blocks there, so we won't issue discard due to below condition, right?

		if (!IS_CURSEC(sbi, secno) &&
			!get_valid_blocks(sbi, start, true))

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 47b6595..fd38b61 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1684,8 +1684,23 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>  		start = start_segno + sbi->segs_per_sec;
>  		if (start < end)
>  			goto next;
> -		else
> -			end = start - 1;
> +		else {
> +			start_segno = start;
> +
> +			while (1) {
> +				start = find_next_bit(prefree_map, start_segno,
> +									end + 1);
> +				if (start >= start_segno)
> +					break;
> +				end = find_next_zero_bit(prefree_map, start_segno,
> +										start + 1);
> +				for (i = start; i < end; i++)
> +					clear_bit(i, prefree_map);
> +				dirty_i->nr_dirty[PRE] -= end - start;
> +			}
> +
> +			end = start_segno - 1;
> +		}
>  	}
>  	mutex_unlock(&dirty_i->seglist_lock);
>  
> 

