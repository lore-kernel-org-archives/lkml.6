Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47694ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FB7214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FB7214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeIQSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:00:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37498 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbeIQSAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:00:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D0CD620795; Mon, 17 Sep 2018 14:32:54 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 87CEE206A7;
        Mon, 17 Sep 2018 14:32:44 +0200 (CEST)
Date:   Mon, 17 Sep 2018 14:32:44 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: denali: fix a race condition when DMA is
 kicked
Message-ID: <20180917143244.2e55fbac@bbrezillon>
In-Reply-To: <1536818329-11068-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536818329-11068-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 14:58:49 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> I thought the read-back of the DMA_ENABLE register was unnecessary
> (at least it is working on my boards), then deleted it in commit
> 586a2c52909d ("mtd: nand: denali: squash denali_enable_dma() helper
> into caller").  Sorry, I was wrong - it caused a timing issue on
> Cyclone5 SoCFPGAs.
> 
> Revive the register read-back, commenting why this is necessary.
> 
> Fixes: 586a2c52909d ("mtd: nand: denali: squash denali_enable_dma() helper into caller")
> Reported-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Queued to master.

Thanks,

Boris

> ---
> 
>  drivers/mtd/nand/raw/denali.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> index 67b2065..b864b93 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c
> @@ -596,6 +596,12 @@ static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
>  	}
>  
>  	iowrite32(DMA_ENABLE__FLAG, denali->reg + DMA_ENABLE);
> +	/*
> +	 * The ->setup_dma() hook kicks DMA by using the data/command
> +	 * interface, which belongs to a different AXI port from the
> +	 * register interface.  Read back the register to avoid a race.
> +	 */
> +	ioread32(denali->reg + DMA_ENABLE);
>  
>  	denali_reset_irq(denali);
>  	denali->setup_dma(denali, dma_addr, page, write);

