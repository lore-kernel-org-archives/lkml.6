Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A22C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344902154F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344902154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeHQRlM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:41:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52868 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbeHQRlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:41:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F2A40207B4; Fri, 17 Aug 2018 16:37:33 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9CFED20720;
        Fri, 17 Aug 2018 16:37:33 +0200 (CEST)
Date:   Fri, 17 Aug 2018 16:37:33 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <kyungmin.park@samsung.com>,
        <absahu@codeaurora.org>, <peterpandong@micron.com>,
        <frieder.schrempf@exceet.de>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michals@xilinx.com>,
        <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20180817163733.34d3199c@xps13>
In-Reply-To: <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

A user of Xilinx BSP reported a problem with lockdep that I can see is
not yet fixed in this code:

Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote on
Fri, 17 Aug 2018 18:49:24 +0530:

> +static int anfc_probe(struct platform_device *pdev)
> +{
> +	struct anfc_nand_controller *nfc;
> +	struct anfc_nand_chip *anand_chip;
> +	struct device_node *np = pdev->dev.of_node, *child;
> +	struct resource *res;
> +	int err;
> +
> +	nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
> +	if (!nfc)
> +		return -ENOMEM;
> +
> +	init_waitqueue_head(&nfc->controller.wq);

The controller structure has a lock which is not initialized here. You
should not initialize the waitqueue manually neither and instead use
nand_controller_init(&nfc->controller).

> +	INIT_LIST_HEAD(&nfc->chips);
> +	init_completion(&nfc->event);
> +	nfc->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, nfc);
> +	nfc->csnum = -1;
> +	nfc->controller.ops = &anfc_nand_controller_ops;

More to come.

Thanks,
Miquèl
