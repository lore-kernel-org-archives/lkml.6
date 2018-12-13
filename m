Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E39BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF8020811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF8020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeLMK0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:26:22 -0500
Received: from foss.arm.com ([217.140.101.70]:58474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbeLMK0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:26:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C712080D;
        Thu, 13 Dec 2018 02:26:21 -0800 (PST)
Received: from [10.37.13.2] (unknown [10.37.13.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC5D73F6A8;
        Thu, 13 Dec 2018 02:26:18 -0800 (PST)
Subject: Re: [PATCH] Revert "iommu/io-pgtable-arm: Check for v7s-incapable
 systems"
To:     Yong Wu <yong.wu@mediatek.com>, Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK Hu <ck.hu@mediatek.com>, Stephen Boyd <swboyd@chromium.org>
References: <1544692788-24427-1-git-send-email-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <38526eab-3010-1ce6-a801-28f5c15dce44@arm.com>
Date:   Thu, 13 Dec 2018 10:26:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1544692788-24427-1-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-13 9:19 am, Yong Wu wrote:
> This reverts commit 82db33dc5e49fb625262d81125625d07a0d6184e.
> 
> After the commit 29859aeb8a6e ("iommu/io-pgtable-arm-v7s: Abort
> allocation when table address overflows the PTE"), v7s will return fail
> if the page table allocation isn't expected. this PHYS_OFFSET check
> is unnecessary now.
> 
> And this check may lead to fail. For example, If CONFIG_RANDOMIZE_BASE
> is enabled, the "memstart_addr" will be updated randomly, then the
> PHYS_OFFSET may be random.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Joerg, if you have any more fixes to send for 4.19, please consider 
picking this up directly.

Thanks,
Robin.

> Reported-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 445c3bd..cec29bf 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -709,10 +709,6 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>   {
>   	struct arm_v7s_io_pgtable *data;
>   
> -#ifdef PHYS_OFFSET
> -	if (upper_32_bits(PHYS_OFFSET))
> -		return NULL;
> -#endif
>   	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
>   		return NULL;
>   
> 
