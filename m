Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71A6ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62322214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62322214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeISNVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:21:39 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6468 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeISNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:21:39 -0400
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="20143902"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Sep 2018 00:44:58 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Wed, 19 Sep 2018 00:44:57 -0700
Subject: Re: [PATCH v2] mtd: rawnand: atmel: Fix potential NULL pointer
 dereference
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180918135555.GA18114@embeddedor.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <61472393-b699-45b4-6d74-cfa774669ad2@microchip.com>
Date:   Wed, 19 Sep 2018 10:44:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180918135555.GA18114@embeddedor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/18/2018 04:55 PM, Gustavo A. R. Silva wrote:
> There is a potential execution path in which function
> of_find_compatible_node() returns NULL. In such a case,
> we end up having a NULL pointer dereference when accessing
> pointer *nfc_np* in function of_clk_get().
> 
> So, we better don't take any chances and fix this by null
> checking pointer *nfc_np* before calling of_clk_get().
> 
> Addresses-Coverity-ID: 1473052 ("Dereference null return value")
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Tudor Ambarus <tudor.ambarus@microchip.com>

> ---
> Changes in v2:
>  - Add Fixes tag to the commit log.
>  - Remove blank line before null checking nfc_np.
> 
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index a38633a..5bfbe97 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -2034,6 +2034,10 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
>  	nand_np = dev->of_node;
>  	nfc_np = of_find_compatible_node(dev->of_node, NULL,
>  					 "atmel,sama5d3-nfc");
> +	if (!nfc_np) {
> +		dev_err(dev, "Could not find device node for sama5d3-nfc\n");
> +		return -ENODEV;
> +	}
>  
>  	nc->clk = of_clk_get(nfc_np, 0);
>  	if (IS_ERR(nc->clk)) {
> 
