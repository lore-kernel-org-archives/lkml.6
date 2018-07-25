Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71972C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0604620844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0604620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeGYIYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:24:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728658AbeGYIYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:24:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D38A383753B3E;
        Wed, 25 Jul 2018 15:13:42 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Wed, 25 Jul 2018
 15:13:36 +0800
Subject: Re: [PATCH v2] ARM: dma-mapping: always clear allocated buffers
To:     <linux@armlinux.org.uk>, <matthias.bgg@gmail.com>,
        <vladimir.murzin@arm.com>
References: <20180725070706.19576-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <akpm@linux-foundation.org>, <iamjoonsoo.kim@lge.com>,
        <robin.murphy@arm.com>, <treding@nvidia.com>,
        <zhongjiang@huawei.com>, <sean.wang@mediatek.com>,
        Christoph Hellwig <hch@infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <a7723548-b6d9-318a-49d8-71081c594db2@huawei.com>
Date:   Wed, 25 Jul 2018 15:13:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180725070706.19576-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC  Christoph Hellwig <hch@infradead.org>

On 2018/7/25 15:07, YueHaibing wrote:
> Sean Wang reported dma_zalloc_coherent doesn't work as expect on his
> armv7,the allocated mem is not zeroed.The reason is __alloc_from_pool
> doesn't honor __GFP_ZERO.
> 
> As commit 6829e274a623 ("arm64: dma-mapping: always clear allocated buffers")
> has pointed out,buffers allocated by dma_alloc_coherent() are always zeroed
> on most architectures. some drivers rely on this 'feature'. Allocated buffer
> might be also exposed to userspace with dma_mmap() call,so clearing it is
> desired from security point of view to avoid exposing random memory to userspace.
> 
> This patch unifies dma_alloc_coherent() behavior on ARM architecture with other
> implementations by unconditionally zeroing allocated buffer.Also to fix
> dma_zalloc_coherent behavior.
> 
> Reported-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: zhong jiang <zhongjiang@huawei.com>
> ---
> v2: reference more argument from arm64 commit as Christoph suggested
> ---
>  arch/arm/mm/dma-mapping.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 6656647..cf5882f 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -564,6 +564,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
>  
>  		*ret_page = phys_to_page(phys);
>  		ptr = (void *)val;
> +		memset(ptr, 0, size);
>  	}
>  
>  	return ptr;
> 

