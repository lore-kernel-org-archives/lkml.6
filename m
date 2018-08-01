Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885D4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D36E20855
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D36E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeHBBod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:44:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10209 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726728AbeHBBod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:44:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6D735B2FF4EAE;
        Thu,  2 Aug 2018 07:56:12 +0800 (CST)
Received: from [127.0.0.1] (10.210.172.85) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 07:56:04 +0800
Subject: Re: [PATCH 4/4] drivers/scsi/mvsas/mv_init: Use dma_zalloc_coherent
 to replace dma_alloc_coherent+memset
To:     zhong jiang <zhongjiang@huawei.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <aacraid@microsemi.com>
References: <1533129976-51930-1-git-send-email-zhongjiang@huawei.com>
 <1533129976-51930-5-git-send-email-zhongjiang@huawei.com>
CC:     <andy.shevchenko@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b533cd56-947e-e276-2ef9-a5e15b0a5d94@huawei.com>
Date:   Thu, 2 Aug 2018 00:55:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1533129976-51930-5-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.85]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2018 14:26, zhong jiang wrote:
> The dma_zalloc_coherent is better than dma_alloc_coherent+memset,
> so replace them.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/scsi/mvsas/mv_init.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index 8c91637..da62e18 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -253,33 +253,29 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
>  	/*
>  	 * alloc and init our DMA areas
>  	 */
> -	mvi->tx = dma_alloc_coherent(mvi->dev,
> +	mvi->tx = dma_zalloc_coherent(mvi->dev,
>  				     sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ,
>  				     &mvi->tx_dma, GFP_KERNEL);
>  	if (!mvi->tx)
>  		goto err_out;
> -	memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
> -	mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
> +	mvi->rx_fis = dma_zalloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
>  					 &mvi->rx_fis_dma, GFP_KERNEL);

Nit: Please ensure that you maintain alignment between the opening brace 
and each new line.

Thanks,

>  	if (!mvi->rx_fis)
>  		goto err_out;
> -	memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
>
> -	mvi->rx = dma_alloc_coherent(mvi->dev,
> +	mvi->rx = dma_zalloc_coherent(mvi->dev,
>  				     sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
>  				     &mvi->rx_dma, GFP_KERNEL);
>  	if (!mvi->rx)
>  		goto err_out;
> -	memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
>  	mvi->rx[0] = cpu_to_le32(0xfff);
>  	mvi->rx_cons = 0xfff;
>
> -	mvi->slot = dma_alloc_coherent(mvi->dev,
> +	mvi->slot = dma_zalloc_coherent(mvi->dev,
>  				       sizeof(*mvi->slot) * slot_nr,
>  				       &mvi->slot_dma, GFP_KERNEL);
>  	if (!mvi->slot)
>  		goto err_out;
> -	memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
>
>  	mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
>  				       TRASH_BUCKET_SIZE,
>


