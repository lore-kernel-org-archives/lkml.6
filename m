Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D988C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051BB20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfAPVmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:42:09 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:61610 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfAPVmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:42:09 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 4E5AEA1152;
        Wed, 16 Jan 2019 22:42:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id kV-ni1ASqHSL; Wed, 16 Jan 2019 22:42:05 +0100 (CET)
Subject: Re: [PATCH 1/3] net: dsa: lantiq_gswip: fix use-after-free on failed
 probe
To:     Johan Hovold <johan@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
References: <20190116102335.30433-1-johan@kernel.org>
 <20190116102335.30433-2-johan@kernel.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <ceefc2e0-72c8-0621-e9f7-cd1a1fc28e49@hauke-m.de>
Date:   Wed, 16 Jan 2019 22:42:04 +0100
MIME-Version: 1.0
In-Reply-To: <20190116102335.30433-2-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 11:23 AM, Johan Hovold wrote:
> Make sure to disable and deregister the switch on late probe errors to
> avoid use-after-free when the device-resource-managed switch is freed.
> 
> Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
> Cc: stable <stable@vger.kernel.org>	# 4.20
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  drivers/net/dsa/lantiq_gswip.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> index 693a67f45bef..b06c41c98de9 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -1099,7 +1099,7 @@ static int gswip_probe(struct platform_device *pdev)
>  		dev_err(dev, "wrong CPU port defined, HW only supports port: %i",
>  			priv->hw_info->cpu_port);
>  		err = -EINVAL;
> -		goto mdio_bus;
> +		goto disable_switch;
>  	}
>  
>  	platform_set_drvdata(pdev, priv);
> @@ -1109,6 +1109,9 @@ static int gswip_probe(struct platform_device *pdev)
>  		 (version & GSWIP_VERSION_MOD_MASK) >> GSWIP_VERSION_MOD_SHIFT);
>  	return 0;
>  
> +disable_switch:
> +	gswip_mdio_mask(priv, GSWIP_MDIO_GLOB_ENABLE, 0, GSWIP_MDIO_GLOB);
> +	dsa_unregister_switch(priv->ds);
>  mdio_bus:
>  	if (mdio_np)
>  		mdiobus_unregister(priv->ds->slave_mii_bus);
> 

