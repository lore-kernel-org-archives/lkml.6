Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E146208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E146208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbeGaJco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:32:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56136 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbeGaJco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:32:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4AACB207AB; Tue, 31 Jul 2018 09:53:38 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1C10B2069C;
        Tue, 31 Jul 2018 09:53:28 +0200 (CEST)
Date:   Tue, 31 Jul 2018 09:53:29 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        kishon@ti.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        allan.nielsen@microsemi.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 03/10] net: mscc: ocelot: get HSIO regmap from
 syscon
Message-ID: <20180731075329.GP28585@piout.net>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <fc4e6c0effa84417bddb32b4a53c6021f0b9e546.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc4e6c0effa84417bddb32b4a53c6021f0b9e546.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2018 14:43:48+0200, Quentin Schulz wrote:
> HSIO address space was moved to a syscon, hence we need to get the
> regmap of this address space from there and no more from the device
> node.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/net/ethernet/mscc/ocelot_board.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
> index 26bb3b1..b7d755b 100644
> --- a/drivers/net/ethernet/mscc/ocelot_board.c
> +++ b/drivers/net/ethernet/mscc/ocelot_board.c
> @@ -9,6 +9,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/of_mdio.h>
>  #include <linux/of_platform.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/skbuff.h>
>  
>  #include "ocelot.h"
> @@ -162,6 +163,7 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device_node *ports, *portnp;
>  	struct ocelot *ocelot;
> +	struct regmap *hsio;
>  	u32 val;
>  
>  	struct {
> @@ -173,7 +175,6 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
>  		{ QSYS, "qsys" },
>  		{ ANA, "ana" },
>  		{ QS, "qs" },
> -		{ HSIO, "hsio" },
>  	};
>  
>  	if (!np && !pdev->dev.platform_data)
> @@ -196,6 +197,14 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
>  		ocelot->targets[res[i].id] = target;
>  	}
>  
> +	hsio = syscon_regmap_lookup_by_compatible("mscc,ocelot-hsio");
> +	if (IS_ERR(hsio)) {
> +		dev_err(&pdev->dev, "missing hsio syscon\n");
> +		return PTR_ERR(hsio);
> +	}
> +
> +	ocelot->targets[HSIO] = hsio;
> +
>  	err = ocelot_chip_init(ocelot);
>  	if (err)
>  		return err;
> -- 
> git-series 0.9.1

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
