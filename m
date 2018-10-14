Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6996C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60EA2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60EA2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeJNXo4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:44:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50858 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeJNXoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:44:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7EAC2207BB; Sun, 14 Oct 2018 18:03:24 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id CE3AE20703;
        Sun, 14 Oct 2018 18:03:23 +0200 (CEST)
Date:   Sun, 14 Oct 2018 18:03:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] irqchip/irq-mvebu-sei: Fix a NULL vs IS_ERR() bug in
 probe
Message-ID: <20181014180324.56e7d8d5@xps13>
In-Reply-To: <20181013102246.GD16086@mwanda>
References: <20181013102246.GD16086@mwanda>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Dan Carpenter <dan.carpenter@oracle.com> wrote on Sat, 13 Oct 2018
13:22:46 +0300:

> The devm_ioremap_resource() function never returns NULL, it returns
> error pointers.
> 
> Fixes: 61ce8d8d8a81 ("irqchip/irq-mvebu-sei: Add new driver for Marvell SEI")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/irqchip/irq-mvebu-sei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
> index 566d69a2edbc..add4c9c934c8 100644
> --- a/drivers/irqchip/irq-mvebu-sei.c
> +++ b/drivers/irqchip/irq-mvebu-sei.c
> @@ -384,9 +384,9 @@ static int mvebu_sei_probe(struct platform_device *pdev)
>  
>  	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sei->base = devm_ioremap_resource(sei->dev, sei->res);
> -	if (!sei->base) {
> +	if (IS_ERR(sei->base)) {
>  		dev_err(sei->dev, "Failed to remap SEI resource\n");
> -		return -ENODEV;
> +		return PTR_ERR(sei->base);
>  	}
>  
>  	/* Retrieve the SEI capabilities with the interrupt ranges */


Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
