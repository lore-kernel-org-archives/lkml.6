Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAEEC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F601214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F601214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeIWReX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 13:34:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40056 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeIWReX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 13:34:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E322E207CF; Sun, 23 Sep 2018 13:37:09 +0200 (CEST)
Received: from xps13 (AToulouse-657-1-1019-69.w90-11.abo.wanadoo.fr [90.11.225.69])
        by mail.bootlin.com (Postfix) with ESMTPSA id 237A420723;
        Sun, 23 Sep 2018 13:37:09 +0200 (CEST)
Date:   Sun, 23 Sep 2018 13:37:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] mtd: rawnand: Use proper enum for
 flctl_dma_fifo0_transfer
Message-ID: <20180923133708.58171117@xps13>
In-Reply-To: <20180920233024.28534-1-natechancellor@gmail.com>
References: <20180920233024.28534-1-natechancellor@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Nathan Chancellor <natechancellor@gmail.com> wrote on Thu, 20 Sep 2018
16:30:25 -0700:

> Clang warns when one enumerated type is converted implicitly to another:
> 
> drivers/mtd/nand/raw/sh_flctl.c:483:46: warning: implicit conversion
> from enumeration type 'enum dma_transfer_direction' to different
> enumeration type 'enum dma_data_direction' [-Wenum-conversion]
>                 flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_DEV_TO_MEM) > 0)
>                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
> drivers/mtd/nand/raw/sh_flctl.c:542:46: warning: implicit conversion
> from enumeration type 'enum dma_transfer_direction' to different
> enumeration type 'enum dma_data_direction' [-Wenum-conversion]
>                 flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_MEM_TO_DEV) > 0)
>                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
> 2 warnings generated.
> 
> Use the proper enums from dma_data_direction to satisfy Clang.
> 
> DMA_MEM_TO_DEV = DMA_TO_DEVICE = 1
> DMA_DEV_TO_MEM = DMA_FROM_DEVICE = 2
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/mtd/nand/raw/sh_flctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
> index c0c0798f268f..4d20d033de7b 100644
> --- a/drivers/mtd/nand/raw/sh_flctl.c
> +++ b/drivers/mtd/nand/raw/sh_flctl.c
> @@ -480,7 +480,7 @@ static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
>  
>  	/* initiate DMA transfer */
>  	if (flctl->chan_fifo0_rx && rlen >= 32 &&
> -		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_DEV_TO_MEM) > 0)
> +		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_FROM_DEVICE) > 0)
>  			goto convert;	/* DMA success */
>  
>  	/* do polling transfer */
> @@ -539,7 +539,7 @@ static void write_ec_fiforeg(struct sh_flctl *flctl, int rlen,
>  
>  	/* initiate DMA transfer */
>  	if (flctl->chan_fifo0_tx && rlen >= 32 &&
> -		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_MEM_TO_DEV) > 0)
> +		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_TO_DEVICE) > 0)
>  			return;	/* DMA success */
>  
>  	/* do polling transfer */


Applied on nand/next with the subject prefix changed to

    mtd: rawnand: sh_flctl:


Thanks,
Miquèl
