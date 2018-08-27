Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9524CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0D121735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0D121735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeH0LLu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:11:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58368 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbeH0LLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:11:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7BCC7207B1; Mon, 27 Aug 2018 09:26:24 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2B2F920787;
        Mon, 27 Aug 2018 09:26:14 +0200 (CEST)
Date:   Mon, 27 Aug 2018 09:26:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] mtd: rawnand: denali: do not pass zero maxchips to
 nand_scan()
Message-ID: <20180827092612.38e8fc64@xps13>
In-Reply-To: <1535353301-1727-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535353301-1727-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Mon, 27 Aug
2018 16:01:41 +0900:

> Commit 49aa76b16676 ("mtd: rawnand: do not execute nand_scan_ident()
> if maxchips is zero") gave a new meaning for calling nand_scan_ident()
> with maxchips=0.
> 
> It is a special usage for some drivers such as docg4, but actually
> the Denali driver may pass maxchips=0 to nand_scan() when the driver
> is enabled but no NAND chip is found on the board for some reasons.
> 
> If nand_scan_with_ids() is called with maxchips=0, nand_scan_ident()
> is skipped, then nand_set_defaults() is skipped as well.  Thus, the
> driver must set chip->controller beforehand.  Otherwise, nand_attach()
> causes NULL pointer dereference.
> 
> In fact, the Denali controller knows the number of connected chips
> before calling nand_scan_ident(); if DEVICE_RESET fails, there is no
> chip in that chip select.  Then, denali_reset_banks() sets the maxchips
> to the number of detected chips.  If no chip is found, maxchips is zero.
> 
> In this case, there is no point for calling nand_scan() because we know
> it will fail for sure.  Let's make the probe function fail immediately.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Return -ENODEV immediately if no chip was found on the board
>     for some reasons.
>     This is the smallest, and safest change for the fixes branch.
>     (I will investigate later if further cleanups are possible or not.)
> 
>  drivers/mtd/nand/raw/denali.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> index ca18612..67b2065 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c
> @@ -1338,6 +1338,11 @@ int denali_init(struct denali_nand_info *denali)
>  
>  	denali_enable_irq(denali);
>  	denali_reset_banks(denali);
> +	if (!denali->max_banks) {
> +		/* Error out earlier if no chip is found for some reasons. */
> +		ret = -ENODEV;
> +		goto disable_irq;
> +	}
>  
>  	denali->active_bank = DENALI_INVALID_BANK;
>  

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Boris, This is for you :)

Thanks,
Miquèl
