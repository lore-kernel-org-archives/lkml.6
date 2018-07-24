Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5251FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1401620856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1401620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbeGXKma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:42:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbeGXKm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:42:29 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 027DB728B47E8;
        Tue, 24 Jul 2018 17:36:50 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Tue, 24 Jul 2018
 17:36:44 +0800
Subject: Re: [PATCH v2] f2fs: clear victim_secmap when section has full valid
 blocks
To:     Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
 <1532424442-9867-1-git-send-email-yunlong.song@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8026538e-2a8b-fad4-82b1-9bb2c04e097d@huawei.com>
Date:   Tue, 24 Jul 2018 17:36:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532424442-9867-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/24 17:27, Yunlong Song wrote:
> Without this patch, f2fs only clears victim_secmap when it finds out
> that the section has no valid blocks at all, but forgets to clear the
> victim_secmap when the whole section has full valid blocks.

Look this patch again, I have a question, why bggc selected section can
get back to full state?

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index cfff7cf..0a79554 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -776,7 +776,8 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>  		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
>  			dirty_i->nr_dirty[t]--;
>  
> -		if (get_valid_blocks(sbi, segno, true) == 0)
> +		if (get_valid_blocks(sbi, segno, true) == 0 ||
> +			get_valid_blocks(sbi, segno, true) == BLKS_PER_SEC(sbi))
>  			clear_bit(GET_SEC_FROM_SEG(sbi, segno),
>  						dirty_i->victim_secmap);
>  	}
> 

