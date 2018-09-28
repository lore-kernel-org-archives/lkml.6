Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0492DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C531C20676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C531C20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wedev4u.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbeI1Wli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:41:38 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:53060 "EHLO
        6.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeI1Wli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:41:38 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Sep 2018 18:41:37 EDT
Received: from player728.ha.ovh.net (unknown [10.109.160.54])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id ED5BA34EFA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 18:01:32 +0200 (CEST)
Received: from [127.0.0.1] (cor13-1-82-232-94-13.fbx.proxad.net [82.232.94.13])
        (Authenticated sender: cyrille.pitchen@wedev4u.fr)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 08A0A5400B2;
        Fri, 28 Sep 2018 18:01:08 +0200 (CEST)
Subject: Re: [RFC/RFT PATCH v1 9/9] mtd: spi: Skip reading the Serial Flash
 Discoverable Parameters
To:     Lukasz Majewski <lukma@denx.de>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        boris.brezillon@bootlin.com, Mark Rutland <mark.rutland@arm.com>
Cc:     yogeshnarayan.gaur@nxp.com, richard@nod.at, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        linux-spi@vger.kernel.org, albert.aribaud@3adev.fr,
        prabhakar.kushwaha@nxp.com, linux-mtd@lists.infradead.org,
        david.wolfe@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
        han.xu@nxp.com, computersforpeace@gmail.com,
        Fabio Estevam <festevam@gmail.com>, dwmw2@infradead.org
References: <20180926220739.620-1-lukma@denx.de>
 <20180926220739.620-10-lukma@denx.de>
From:   Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Openpgp: preference=signencrypt
Message-ID: <1a85becb-6cb0-ede4-be0a-2608e8532c9e@wedev4u.fr>
Date:   Fri, 28 Sep 2018 18:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926220739.620-10-lukma@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5790503222867744613
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedruddtledgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

Le 27/09/2018 à 00:07, Lukasz Majewski a écrit :
> The fsl-quadspi.c driver is not supporting SPINOR_OP_RDSFDP (0x5a)
> read opcode - in the legacy driver we do read some garbage
> data from AHB mapped area and then return on the first check

If your controller reads garbage then spi_nor_parse_sfdp() fails and exists on the
very first check: signature of the SFDP header. Hence everything should already go on
as if the SPI_NOR_SKIP_SFDP flag is set.

So this patch doesn't change anything for your controller but prevents other controller
from using QSPI protocols like SPI 1-4-4.

This patch introduces a regression for other chips.

Best regards,

Cyrille

> (L2376 @ ./mtd/spi-nor/spi-nor.c)
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 442102be174e..c79b8c33aeeb 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1103,7 +1103,7 @@ static const struct flash_info spi_nor_ids[] = {
>  	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
> -	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
> +	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ | SPI_NOR_SKIP_SFDP) },
>  	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
> 
