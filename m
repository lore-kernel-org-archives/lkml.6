Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36856C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D722A20C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D722A20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeHTNPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:15:30 -0400
Received: from foss.arm.com ([217.140.101.70]:35378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTNP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:15:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A762880D;
        Mon, 20 Aug 2018 03:00:32 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F8DE3F2EA;
        Mon, 20 Aug 2018 03:00:31 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Fix uninitialized pointer on DMA ops
To:     Esteban Zamora <estebanzacr.20@gmail.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1534619091-14258-1-git-send-email-estebanzacr.20@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e6f42561-e47f-ae6a-a444-da007e88459f@arm.com>
Date:   Mon, 20 Aug 2018 11:00:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534619091-14258-1-git-send-email-estebanzacr.20@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/18 20:04, Esteban Zamora wrote:
> The mmap function pointer on swiotlb_dma_ops struct is
> uninitialized, which causes a random crash when calling
> the dma_mmap_coherent function on platforms where no DMA
> address translation hardware is available.

Can you share any kernel logs with details of those crashes? As Konrad 
mentions, the rules for partial structure initialisation in C are 
well-defined, even with designated initialisers[1], and if this commit 
message were true then half of the subsystems in the kernel would be 
crashing left right and centre.

Robin.

[1] 
https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html#Designated-Inits

> Set this pointer to NULL in order to fix the issue.
> 
> Signed-off-by: Esteban Zamora <estebanzacr.20@gmail.com>
> ---
>   kernel/dma/swiotlb.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 4f8a6db..9a7718c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1082,5 +1082,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
>   	.map_page		= swiotlb_map_page,
>   	.unmap_page		= swiotlb_unmap_page,
>   	.dma_supported		= dma_direct_supported,
> +	.mmap                   = NULL,
>   };
>   EXPORT_SYMBOL(swiotlb_dma_ops);
> 
