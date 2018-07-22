Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0C5C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505702086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505702086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeGVJpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 05:45:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59212 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbeGVJpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 05:45:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 02F06207AD; Sun, 22 Jul 2018 10:49:15 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.20.83])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0AD7320737;
        Sun, 22 Jul 2018 10:49:12 +0200 (CEST)
Date:   Sun, 22 Jul 2018 10:49:12 +0200
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
Subject: Re: [PATCH v4 28/35] mtd: rawnand: allow exiting immediately
 nand_scan_ident()
Message-ID: <20180722104912.77e81f8d@bbrezillon>
In-Reply-To: <20180720151527.16038-29-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-29-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:20 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Some driver (eg. docg4) will need to handle themselves the
> identification phase. As part of the migration to use nand_scan()
> everywhere (which will unconditionnaly call nand_scan_ident()), we add
> a condition at the start of nand_scan_ident() to just "do nothing" if
> the maxchips parameters is zero, meaning that the driver does not want
> the core to handle this phase.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index dea41fa25be1..e7f135c100c2 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5926,7 +5926,7 @@ static int nand_dt_init(struct nand_chip *chip)
>  /**
>   * nand_scan_ident - [NAND Interface] Scan for the NAND device
>   * @mtd: MTD device structure
> - * @maxchips: number of chips to scan for
> + * @maxchips: number of chips to scan for, returns immediately if 0
>   * @table: alternative NAND ID table
>   *
>   * This is the first phase of the normal nand_scan() function. It reads the
> @@ -5940,6 +5940,14 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
>  	struct nand_chip *chip = mtd_to_nand(mtd);
>  	int ret;
>  
> +	/*
> +	 * If the number of chips to scan for is null, just return silently.

						 ^ zero


> +	 * This is for specific drivers that must handle this part of the
> +	 * probe process themselves (e.g docg4).
> +	 */

I think that description of the special case maxchips == 0 should be
placed in the kernel doc header.

> +	if (!maxchips)
> +		return 0;

Can we move this check in nand_scan_with_ids()?

> +
>  	/* Enforce the right timings for reset/detection */
>  	onfi_fill_data_interface(chip, NAND_SDR_IFACE, 0);
>  

