Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247D3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D793B2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YknKO8Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D793B2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbeKPGpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:45:08 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36501 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbeKPGpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=/WlxTxITwdKMYnY9wzLWQAo4tRiSqaKcANXS8M8FfZ4=;
        b=YknKO8Ep7LiIwzZdmY+MhgttDyGdI9CqsxSrSWLGY6OSVEC5BgFEjxNElechNs5UrVUUQ9XdyKP3FrKnGs3iA+djJY5MTV3hXIyT70Q706kvuXSb7rID92O1K1BtydL50lFkrfB3nX6do77yaWSwOdITlaxQ0f6ac3djVkHM4Gs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gNOMa-0000rH-NA; Thu, 15 Nov 2018 21:35:44 +0100
Date:   Thu, 15 Nov 2018 21:35:44 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandru.marginean@nxp.com,
        catalin.horghidan@nxp.com
Subject: Re: [PATCH net-next 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Message-ID: <20181115203544.GG32274@lunn.ch>
References: <1542298436-23422-1-git-send-email-claudiu.manoil@nxp.com>
 <1542298436-23422-2-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542298436-23422-2-git-send-email-claudiu.manoil@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 06:13:53PM +0200, Claudiu Manoil wrote:
> ENETC is a multi-port virtualized Ethernet controller supporting GbE
> designs

Hi Claudiu

Do you mean 1GbE, or multigigabit? Do you have a SERDES between the
MAC and the PHY? Could an SFP be connected?

> +static int enetc_of_get_phy(struct enetc_ndev_priv *priv)
> +{
> +	struct device_node *np = priv->dev->of_node;
> +	int err;
> +
> +	if (!np) {
> +		dev_err(priv->dev, "missing ENETC port node\n");
> +		return -ENODEV;
> +	}
> +
> +	priv->phy_node = of_parse_phandle(np, "phy-handle", 0);
> +	if (!priv->phy_node) {
> +		if (!of_phy_is_fixed_link(np)) {
> +			dev_err(priv->dev, "PHY not specified\n");
> +			return -ENODEV;
> +		}
> +
> +		err = of_phy_register_fixed_link(np);
> +		if (err < 0) {
> +			dev_err(priv->dev, "fixed link registration failed\n");
> +			return err;
> +		}
> +
> +		priv->phy_node = of_node_get(np);
> +	}
> +
> +	priv->if_mode = of_get_phy_mode(np);
> +	if (priv->if_mode < 0) {
> +		dev_err(priv->dev, "missing phy type\n");
> +		of_node_put(priv->phy_node);
> +		if (of_phy_is_fixed_link(np))
> +			of_phy_deregister_fixed_link(np);
> +
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

I asked the above questions because of this. Using phylink will
simplify a lot of this. And it makes you future proof for faster
speeds and handling the SERDES between the MAC and the PHY, and having
an SFP, etc.

       Andrew
