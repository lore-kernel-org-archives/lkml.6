Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111C9C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EEB21708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EEB21708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeHHMNq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:13:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54711 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeHHMNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:13:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 531E820739; Wed,  8 Aug 2018 11:54:46 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-99-143.w90-88.abo.wanadoo.fr [90.88.4.143])
        by mail.bootlin.com (Postfix) with ESMTPSA id 162E4206A6;
        Wed,  8 Aug 2018 11:54:36 +0200 (CEST)
Date:   Wed, 8 Aug 2018 11:54:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     boris.brezillon@bootlin.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mtd: rawnand: vf610_nfc: explicitly disable
 interrupts first
Message-ID: <20180808115437.34365451@xps13>
In-Reply-To: <20180806092909.28980-2-stefan@agner.ch>
References: <20180806092909.28980-1-stefan@agner.ch>
        <20180806092909.28980-2-stefan@agner.ch>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Stefan Agner <stefan@agner.ch> wrote on Mon,  6 Aug 2018 11:29:08 +0200:

> Explicitly disable all interrupts on probe. This should be the
> default state, but the bootloader could leave the device in any
> state. No issues have been observed so far, but it is still worth
> fixing it.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mtd/nand/raw/vf610_nfc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
> index 740a91c5c86e..52e7811c0bde 100644
> --- a/drivers/mtd/nand/raw/vf610_nfc.c
> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> @@ -130,8 +130,13 @@
>  #define CONFIG_PAGE_CNT_SHIFT			0
>  
>  /* NFC_IRQ_STATUS Field */
> +#define WERR_IRQ_BIT				BIT(31)
> +#define DONE_IRQ_BIT				BIT(30)
>  #define IDLE_IRQ_BIT				BIT(29)
> +#define WERR_EN_BIT				BIT(22)
> +#define DONE_EN_BIT				BIT(21)
>  #define IDLE_EN_BIT				BIT(20)
> +#define WERR_CLEAR_BIT				BIT(19)
>  #define DONE_CLEAR_BIT				BIT(18)
>  #define IDLE_CLEAR_BIT				BIT(17)
>  
> @@ -819,6 +824,10 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  
>  	init_completion(&nfc->cmd_done);
>  
> +	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, WERR_EN_BIT);
> +	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, DONE_EN_BIT);
> +	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, IDLE_EN_BIT);
> +

Why not just one call with:

	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, WERR_EN_BIT | DONE_EN_BIT | IDLE_EN_BIT);

The comment applies for the next patch as well.

>  	err = devm_request_irq(nfc->dev, irq, vf610_nfc_irq, 0, DRV_NAME, mtd);
>  	if (err) {
>  		dev_err(nfc->dev, "Error requesting IRQ!\n");

Thanks,
Miquèl
