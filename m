Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09CC13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7B120873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ekizksp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7B120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeG3PZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:25:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50431 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeG3PZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=U3oipQDuKhWXq1o6qVl/9OolBNXLVPhtpVyoIhKPzuI=;
        b=Ekizksp68Ckc3otkrt30ClAdVFlQQGHlmssJZyGB6iaNArf1vcx88XX4qTD8IODmPSWBKEsbtQ7bKBCRLGlrqJaxcSod7bXXnFB4ZHRTHQOx+w87pE0/M7p0I+K4mfYknwJkehAGqx3OQqkhbT3QKv1o3JPn+hrXjUN/PV0Vqjw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fk8Z0-0008Ce-0N; Mon, 30 Jul 2018 15:50:18 +0200
Date:   Mon, 30 Jul 2018 15:50:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 10/10] net: mscc: ocelot: make use of SerDes
 PHYs for handling their configuration
Message-ID: <20180730135018.GF13198@lunn.ch>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <0ce1b3e8466064741dc6e484f87bbe48542cb978.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce1b3e8466064741dc6e484f87bbe48542cb978.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jul 30, 2018 at 02:43:55PM +0200, Quentin Schulz wrote:

> +		err = of_get_phy_mode(portnp);
> +		if (err < 0)
> +			ocelot->ports[port]->phy_mode = PHY_INTERFACE_MODE_NA;
> +		else
> +			ocelot->ports[port]->phy_mode = err;
> +
> +		if (ocelot->ports[port]->phy_mode == PHY_INTERFACE_MODE_NA)
> +			continue;
> +
> +		if (ocelot->ports[port]->phy_mode == PHY_INTERFACE_MODE_SGMII)
> +			phy_mode = PHY_MODE_SGMII;
> +		else
> +			phy_mode = PHY_MODE_QSGMII;

Hi Quentin

Say somebody puts RGMII as the phy-mode? It would be better to verify
it is only SGMII or QSGMII and return -EINVAL otherwise.

> +
> +		serdes = devm_of_phy_get(ocelot->dev, portnp, NULL);
> +		if (IS_ERR(serdes)) {
> +			if (PTR_ERR(serdes) == -EPROBE_DEFER) {
> +				dev_err(ocelot->dev, "deferring probe\n");

dev_dbg() ? It is not really an error.

> +				err = -EPROBE_DEFER;
> +				goto err_probe_ports;
> +			}
> +
> +			dev_err(ocelot->dev, "missing SerDes phys for port%d\n",
> +				port);
> +			err = -ENODEV;

err = PTR_ERR(serdes) so we get the actual error?

>  			goto err_probe_ports;
>  		}
> +
> +		ocelot->ports[port]->serdes = serdes;
>  	}
>  
>  	register_netdevice_notifier(&ocelot_netdevice_nb);


	Andrew
