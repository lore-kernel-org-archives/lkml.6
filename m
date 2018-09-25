Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6093C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5046521480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5046521480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeIYNa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:30:29 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:22609 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeIYNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:30:29 -0400
X-IronPort-AV: E=Sophos;i="5.54,301,1534834800"; 
   d="scan'208";a="17718251"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Sep 2018 00:24:17 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Tue, 25 Sep 2018 00:24:17 -0700
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: Use proper enum for
 dma_unmap_single
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20180921102944.27968-1-natechancellor@gmail.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <5e1d2e30-764f-f3a9-d0c1-7a6c81f296b7@microchip.com>
Date:   Tue, 25 Sep 2018 10:24:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180921102944.27968-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nathan,

On 09/21/2018 01:29 PM, Nathan Chancellor wrote:
> Clang warns when one enumerated type is converted implicitly to another.
> 
> drivers/mtd/spi-nor/cadence-quadspi.c:962:47: warning: implicit
> conversion from enumeration type 'enum dma_transfer_direction' to
> different enumeration type 'enum dma_data_direction' [-Wenum-conversion]
>         dma_dst = dma_map_single(nor->dev, buf, len, DMA_DEV_TO_MEM);
>                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> ./include/linux/dma-mapping.h:428:66: note: expanded from macro
> 'dma_map_single'
> #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
>                                    ~~~~~~~~~~~~~~~~~~~~          ^
> drivers/mtd/spi-nor/cadence-quadspi.c:997:43: warning: implicit
> conversion from enumeration type 'enum dma_transfer_direction' to
> different enumeration type 'enum dma_data_direction' [-Wenum-conversion]
>         dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> ./include/linux/dma-mapping.h:429:70: note: expanded from macro
> 'dma_unmap_single'
> #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
>                                      ~~~~~~~~~~~~~~~~~~~~~~          ^
> 2 warnings generated.
> 
> Use the proper enums from dma_data_direction to satisfy Clang.
> 
> DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
> DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/108
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index 8e714fbfa521..d0e57ac81098 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -959,7 +959,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
>  		return 0;
>  	}
>  
> -	dma_dst = dma_map_single(nor->dev, buf, len, DMA_DEV_TO_MEM);
> +	dma_dst = dma_map_single(nor->dev, buf, len, DMA_FROM_DEVICE);
>  	if (dma_mapping_error(nor->dev, dma_dst)) {
>  		dev_err(nor->dev, "dma mapping failed\n");
>  		return -ENOMEM;
> @@ -994,7 +994,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
>  	}
>  
>  err_unmap:
> -	dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
> +	dma_unmap_single(nor->dev, dma_dst, len, DMA_TO_DEVICE);

Should have used DMA_FROM_DEVICE, as you did above. Otherwise looks good.

Cheers,
ta
