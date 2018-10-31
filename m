Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C27C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5327920847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5327920847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbeJaWx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:53:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33953 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbeJaWx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:53:26 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D0ACD20884; Wed, 31 Oct 2018 14:55:15 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id 990B1207F4;
        Wed, 31 Oct 2018 14:55:05 +0100 (CET)
Date:   Wed, 31 Oct 2018 14:55:05 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Huijin Park <huijin.park@samsung.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        bbanghj.park@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: cast to u64 to avoid unexpected error
Message-ID: <20181031145505.6b034b84@bbrezillon>
In-Reply-To: <1535009282-1480-1-git-send-email-huijin.park@samsung.com>
References: <CGME20180823072813eucas1p2a534b4be94a3a2bc3480adcefca2ca22@eucas1p2.samsung.com>
        <1535009282-1480-1-git-send-email-huijin.park@samsung.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huijin,

Subject prefix should be "mtd: spi-nor: ...", and please replace
"unexpected error" by "unsigned int overflows".

On Thu, 23 Aug 2018 03:28:02 -0400
Huijin Park <huijin.park@samsung.com> wrote:

> From: "huijin.park" <huijin.park@samsung.com>
> 
> the params->size is defined as "u64"
> and, "info->sector_size" and "info->n_sectors" is defined as unsgined and u16

						 ^ are		^ unsigned

> thus, u64 data might have strange data(loss data) if data is overflow.

						    ^ if the result
overflows an unsigned int.

> this patch cast it to u64.

	     ^casts info->sector_size to an u64.

> 
> Signed-off-by: huijin.park <huijin.park@samsung.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index d9c368c..527f281 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2459,7 +2459,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  	memset(params, 0, sizeof(*params));
>  
>  	/* Set SPI NOR sizes. */
> -	params->size = info->sector_size * info->n_sectors;
> +	params->size = (u64)info->sector_size * (u64)info->n_sectors;

						^ this cast is not needed.

BTW, I doubt we'll ever have to deal with NORs that are more than 4GB,
but making static code analysis tools happy and enforcing code
correctness is important too.

>  	params->page_size = info->page_size;
>  
>  	/* (Fast) Read settings. */

Regards,

Boris
