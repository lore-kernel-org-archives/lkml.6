Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBD0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0880205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sfYEvZdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393788AbfAPPAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:00:15 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45309 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728675AbfAPPAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=FAJnXUUIubJJzqURBD3F7bfBh9AUxwlewlTQHGPdEOU=;
        b=sfYEvZdI7qX1qFsR8i4TOxgaVXF7wF4jLvIN0nDZSbEVK0htRr8Euk7W229GW4uFSSZxhyfOlr3obdqbp8l9Z1sMlsf1AzxhV3DFGY7psSJ+m+3N9CR3XxnAlBr0u+6eOT7g4v6Nd778t2G4539dKY2sys+EML0xmrGY7RnAHyI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjmfp-0007PC-Kp; Wed, 16 Jan 2019 16:00:09 +0100
Date:   Wed, 16 Jan 2019 16:00:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Johan Hovold <johan@kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] net: dsa: lantiq_gswip: fix use-after-free on failed
 probe
Message-ID: <20190116150009.GE25731@lunn.ch>
References: <20190116102335.30433-1-johan@kernel.org>
 <20190116102335.30433-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116102335.30433-2-johan@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:23:33AM +0100, Johan Hovold wrote:
> Make sure to disable and deregister the switch on late probe errors to
> avoid use-after-free when the device-resource-managed switch is freed.
> 
> Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
> Cc: stable <stable@vger.kernel.org>	# 4.20
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>
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

This is correct. But it would be nice if somebody in the future could
move the disabling of the switch to the inverse of the gswip_setup()
function to make the code symmetrical.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
