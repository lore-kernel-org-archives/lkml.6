Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED00C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3720C208E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3720C208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeH0MOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:14:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60568 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeH0MOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:14:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B40BA20799; Mon, 27 Aug 2018 10:28:55 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2211622A3C;
        Mon, 27 Aug 2018 10:28:22 +0200 (CEST)
Date:   Mon, 27 Aug 2018 10:28:20 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>
Subject: Re: [PATCH v2 5/9] mtd: nand: atmel: fix OF child-node lookup
Message-ID: <20180827102820.3abf7291@bbrezillon>
In-Reply-To: <20180827082153.22537-6-johan@kernel.org>
References: <20180827082153.22537-1-johan@kernel.org>
        <20180827082153.22537-6-johan@kernel.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan

On Mon, 27 Aug 2018 10:21:49 +0200
Johan Hovold <johan@kernel.org> wrote:

> Use the new of_get_compatible_child() helper to lookup the nfc child
> node instead of using of_find_compatible_node(), which searches the
> entire tree from a given start node and thus can return an unrelated
> (i.e. non-child) node.
> 
> This also addresses a potential use-after-free (e.g. after probe
> deferral) as the tree-wide helper drops a reference to its first
> argument (i.e. the node of the device being probed).
> 
> While at it, also fix a related nfc-node reference leak.
> 
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Cc: stable <stable@vger.kernel.org>     # 4.11
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Josh Wu <rainyfeeling@outlook.com>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

I'll let Miquel queue this patch to the nand/next branch, unless you
want it to be merged in 4.19, in which case I'll queue it to the
mtd/fixes branch.

Thanks,

Boris

> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index a068b214ebaa..d3dfe63956ac 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -2061,8 +2061,7 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
>  	int ret;
>  
>  	nand_np = dev->of_node;
> -	nfc_np = of_find_compatible_node(dev->of_node, NULL,
> -					 "atmel,sama5d3-nfc");
> +	nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
>  
>  	nc->clk = of_clk_get(nfc_np, 0);
>  	if (IS_ERR(nc->clk)) {
> @@ -2472,15 +2471,19 @@ static int atmel_nand_controller_probe(struct platform_device *pdev)
>  	}
>  
>  	if (caps->legacy_of_bindings) {
> +		struct device_node *nfc_node;
>  		u32 ale_offs = 21;
>  
>  		/*
>  		 * If we are parsing legacy DT props and the DT contains a
>  		 * valid NFC node, forward the request to the sama5 logic.
>  		 */
> -		if (of_find_compatible_node(pdev->dev.of_node, NULL,
> -					    "atmel,sama5d3-nfc"))
> +		nfc_node = of_get_compatible_child(pdev->dev.of_node,
> +						   "atmel,sama5d3-nfc");
> +		if (nfc_node) {
>  			caps = &atmel_sama5_nand_caps;
> +			of_node_put(nfc_node);
> +		}
>  
>  		/*
>  		 * Even if the compatible says we are dealing with an

