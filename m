Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37713C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED62D2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SUz6VAd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED62D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeKSDef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:34:35 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39553 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbeKSDef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=b4BqCDnvRzSHfGj0fGA+quKitVdOp6M5NzkpKuViUSM=;
        b=SUz6VAd2wkeqZAPTda/ya+cqk3bQuo0H7gzGBqHpGf8PxHkuk4EIyltOdyVw60GfTNwIEwX3hxXdHmYKcHkxGKSN2Vitq916PkYhmByMOw5iOfw2j2c1jP1/usWLTXowyWeGUjycl8yZcnjWqJ0/dddJKKpfy4PvMyfNEZ4/36M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gOQdg-0001my-1x; Sun, 18 Nov 2018 18:13:40 +0100
Date:   Sun, 18 Nov 2018 18:13:40 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] net: phy: icplus: allow configuring the interrupt
 function on IP101GR
Message-ID: <20181118171340.GG5591@lunn.ch>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
 <20181117182007.14791-8-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117182007.14791-8-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin

> +static int ip101a_g_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct ip101a_g_phy_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (device_property_read_bool(dev, "icplus,select-rx-error"))
> +		priv->sel_intr32 = IP101GR_SEL_INTR32_RXER;
> +	else if (device_property_read_bool(dev, "icplus,select-interrupt"))
> +		priv->sel_intr32 = IP101GR_SEL_INTR32_INTR;
> +	else
> +		priv->sel_intr32 = IP101GR_SEL_INTR32_KEEP;

It would be good to return -EINVAL if both properties are found.

This looks good otherwise.

     Andrew
