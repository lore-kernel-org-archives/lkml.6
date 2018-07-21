Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D76ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54DB20849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54DB20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeGUSmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:42:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49984 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbeGUSmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:42:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EA21B20737; Sat, 21 Jul 2018 19:48:44 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.79.60])
        by mail.bootlin.com (Postfix) with ESMTPSA id 32D2D206F3;
        Sat, 21 Jul 2018 19:48:32 +0200 (CEST)
Date:   Sat, 21 Jul 2018 19:48:29 +0200
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
Subject: Re: [PATCH v4 19/35] mtd: rawnand: sh_flctl: move all NAND chip
 related setup in one function
Message-ID: <20180721194829.44e9b29f@bbrezillon>
In-Reply-To: <20180720151527.16038-20-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-20-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:11 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> @@ -1007,6 +1007,16 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
>  	struct sh_flctl *flctl = mtd_to_flctl(mtd);
>  	struct nand_chip *chip = &flctl->chip;
>  
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		/*
> +		 * NAND_BUSWIDTH_16 may have been set by nand_scan_ident().
> +		 * Add the SEL_16BIT flag in pdata->flcmncr_val and re-assign
> +		 * flctl->flcmncr_base to pdata->flcmncr_val.
> +		 */
> +		flctl->pdata->flcmncr_val |= SEL_16BIT;
> +		flctl->flcmncr_base = flctl->pdata->flcmncr_val;

pdata->flcmncr_val is not used after this point. I think you can just do

		flctl->flcmncr_base |= SEL_16BIT;

and get rid of the ftcl->pdata field you add in this patch.

> +	}
> +


