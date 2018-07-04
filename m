Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A45CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71CE24633
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71CE24633
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753604AbeGDHO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:14:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35676 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752918AbeGDHO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:14:26 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6ED172084E; Wed,  4 Jul 2018 09:14:23 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id C769F20741;
        Wed,  4 Jul 2018 09:14:12 +0200 (CEST)
Date:   Wed, 4 Jul 2018 09:14:12 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 02/32] mtd: rawnand: brcmnand: convert driver to
 nand_scan()
Message-ID: <20180704091412.1118c857@bbrezillon>
In-Reply-To: <20180703220029.19565-3-miquel.raynal@bootlin.com>
References: <20180703220029.19565-1-miquel.raynal@bootlin.com>
        <20180703220029.19565-3-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Jul 2018 23:59:59 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 43 ++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index 1306aaa7a8bf..99ab7b93756c 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -2208,6 +2208,28 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
>  	return 0;
>  }
>  
> +static int brcmnand_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct brcmnand_host *host = nand_get_controller_data(chip);
> +	int ret;
> +
> +	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +
> +	if (brcmnand_setup_dev(host))
> +		return -ENXIO;
> +
> +	chip->ecc.size = host->hwcfg.sector_size_1k ? 1024 : 512;
> +
> +	/* only use our internal HW threshold */
> +	mtd->bitflip_threshold = 1;
> +
> +	ret = brcmstb_choose_ecc_layout(host);
> +
> +	return ret;
> +}
> +
>  static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
>  {
>  	struct brcmnand_controller *ctrl = host->ctrl;
> @@ -2267,10 +2289,6 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
>  	nand_writereg(ctrl, cfg_offs,
>  		      nand_readreg(ctrl, cfg_offs) & ~CFG_BUS_WIDTH);
>  
> -	ret = nand_scan_ident(mtd, 1, NULL);
> -	if (ret)
> -		return ret;
> -
>  	chip->options |= NAND_NO_SUBPAGE_WRITE;
>  	/*
>  	 * Avoid (for instance) kmap()'d buffers from JFFS2, which we can't DMA
> @@ -2279,21 +2297,8 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
>  	 */
>  	chip->options |= NAND_USE_BOUNCE_BUFFER;
>  
> -	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> -		chip->bbt_options |= NAND_BBT_NO_OOB;
> -
> -	if (brcmnand_setup_dev(host))
> -		return -ENXIO;
> -
> -	chip->ecc.size = host->hwcfg.sector_size_1k ? 1024 : 512;
> -	/* only use our internal HW threshold */
> -	mtd->bitflip_threshold = 1;
> -
> -	ret = brcmstb_choose_ecc_layout(host);
> -	if (ret)
> -		return ret;
> -
> -	ret = nand_scan_tail(mtd);
> +	chip->controller->attach_chip = brcmnand_attach_chip;

Hm, this assignment should be done once, when initializing the
controller (in brcmnand_probe()), not every time you add a NAND chip.

> +	ret = nand_scan(mtd, 1);
>  	if (ret)
>  		return ret;
>  

