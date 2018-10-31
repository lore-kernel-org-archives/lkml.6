Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517B3C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0624220821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0624220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbeJaMbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:31:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728578AbeJaMbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:31:18 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DB3B7B138A889;
        Wed, 31 Oct 2018 11:35:03 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 31 Oct 2018
 11:34:56 +0800
Subject: Re: [PATCH v2] f2fs: fix get_blocktype_secs bug when segs_per_sec is
 larger than 1
To:     Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1540902495-60197-1-git-send-email-yunlong.song@huawei.com>
 <1540903593-65539-1-git-send-email-yunlong.song@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <251de9ca-79b1-d509-13dc-87f80554a60d@huawei.com>
Date:   Wed, 31 Oct 2018 11:34:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540903593-65539-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/30 20:46, Yunlong Song wrote:
> f2fs_need_SSR uses get_blocktype_secs to calculate needed dirty
> sections, however, for the case segs_per_sec > 1, when needed segs are
> smaller than segs_per_sec, it will just return 0, so fix it.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 56204a8..ef41ea2 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1842,7 +1842,7 @@ static inline int get_blocktype_secs(struct f2fs_sb_info *sbi, int block_type)
>  	unsigned int segs = (get_pages(sbi, block_type) + pages_per_sec - 1) >>
>  						sbi->log_blocks_per_seg;
>  
> -	return segs / sbi->segs_per_sec;
> +	return (segs + sbi->segs_per_sec - 1) / sbi->segs_per_sec;

roundup(segs, sbi->segs_per_sec)?

Thanks,

>  }
>  
>  static inline block_t valid_user_blocks(struct f2fs_sb_info *sbi)
> 

