Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EECAC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC352086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC352086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeGVJzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 05:55:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59418 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbeGVJzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 05:55:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1A1EE207AD; Sun, 22 Jul 2018 10:59:47 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.20.83])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1918D20737;
        Sun, 22 Jul 2018 10:59:45 +0200 (CEST)
Date:   Sun, 22 Jul 2018 10:59:44 +0200
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
Subject: Re: [PATCH v4 30/35] mtd: rawnand: qcom: convert driver to
 nand_scan()
Message-ID: <20180722105944.76a5941c@bbrezillon>
In-Reply-To: <20180720151527.16038-31-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-31-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:22 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

>  
> -static int qcom_nand_host_init(struct qcom_nand_controller *nandc,
> -			       struct qcom_nand_host *host,
> -			       struct device_node *dn)
> +static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
> +					    struct qcom_nand_host *host,
> +					    struct device_node *dn)
>  {
>  	struct nand_chip *chip = &host->chip;
>  	struct mtd_info *mtd = nand_to_mtd(chip);
> @@ -2824,36 +2828,20 @@ static int qcom_nand_host_init(struct qcom_nand_controller *nandc,
>  	chip->block_markbad	= qcom_nandc_block_markbad;
>  
>  	chip->controller = &nandc->controller;
> +	chip->controller->ops = &qcom_nandc_ops;

This assignment should be moved here [1].

Once fixed you can add

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>


[1]https://elixir.bootlin.com/linux/v4.18-rc5/source/drivers/mtd/nand/raw/qcom_nandc.c#L2574
