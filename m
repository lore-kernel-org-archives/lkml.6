Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA8C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC67824104
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC67824104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeGEM4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:56:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50996 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753926AbeGEM4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:56:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C5AF420733; Thu,  5 Jul 2018 14:56:27 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 59CD6203B4;
        Thu,  5 Jul 2018 14:56:27 +0200 (CEST)
Date:   Thu, 5 Jul 2018 14:56:28 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Philipp Puschmann <pp@emlix.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] mtd: m25p80: Call spi_mem_get_name() to let
 controller set a custom name
Message-ID: <20180705145628.57a48e87@bbrezillon>
In-Reply-To: <1530789310-16254-3-git-send-email-frieder.schrempf@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
        <1530789310-16254-3-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Jul 2018 13:14:58 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> By calling spi_mem_get_name(), the driver of the (Q)SPI controller can
> set a custom name for the memory device if necessary.
> This is useful to keep mtdparts compatible when controller drivers are
> ported from the MTD to the SPI layer.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> ---
>  drivers/mtd/devices/m25p80.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index e84563d..482f0ef 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -199,8 +199,7 @@ static int m25p_probe(struct spi_mem *spimem)
>  			hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
>  	}
>  
> -	if (data && data->name)
> -		nor->mtd.name = data->name;
> +	nor->mtd.name = spi_mem_get_name(spimem);

Hm, not sure you can do that without breaking setup that pass a
flash_platform_data object with a name.

Also, you should keep the name extracted from the label property if any
(this is done earlier, when spi_nor_set_flash_node() is called).

	if (data && data->name)
		nor->mtd.name = data->name;

	if (!nor->mtd.name)
		nor->mtd.name = spi_mem_get_name(spimem);

>  
>  	/* For some (historical?) reason many platforms provide two different
>  	 * names in flash_platform_data: "name" and "type". Quite often name is

