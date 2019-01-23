Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9DFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4269621855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BQKoFgSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfAWRIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:08:21 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:52995 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfAWRIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=tQZNkNhJNalLii6OpSDc6FFmV9lqkUO4OGYFNQvOYB0=;
        b=BQKoFgSpJCVPGjVwNNgr+pRefa5nHzcDPwcokhaJEIiVS4BEWSB3QDEZyPiYdv7mYBjwSnVQYnEf/euhl80MvdlMAc0rM9mxaE8HZV3Z7FkfEfUccAE9vqH6H7jQfq13p4fcfzarKqcEOOAxlQlcqgs9MJhWZowRWg4UhSUssCI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gmM0e-0002wy-AF; Wed, 23 Jan 2019 18:08:16 +0100
Date:   Wed, 23 Jan 2019 18:08:16 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, sd@queasysnail.net, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 05/10] net: phy: introduce a phy_driver macsec
 helper
Message-ID: <20190123170816.GH5310@lunn.ch>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-6-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123155638.13852-6-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int phy_macsec(struct phy_device *phydev, struct netdev_macsec *macsec)
> +{
> +	int ret = -EOPNOTSUPP;
> +
> +	if (!phydev->drv)
> +		return -EIO;
> +
> +	mutex_lock(&phydev->lock);
> +
> +	if (phydev->drv->macsec)
> +		ret = phydev->drv->macsec(phydev, macsec);
> +
> +	mutex_unlock(&phydev->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_macsec);
> +

> @@ -630,6 +634,10 @@ struct phy_driver {
>  			    struct ethtool_tunable *tuna,
>  			    const void *data);
>  	int (*set_loopback)(struct phy_device *dev, bool enable);
> +
> +#ifdef CONFIG_MACSEC
> +	int (*macsec)(struct phy_device *dev, struct netdev_macsec *macsec);
> +#endif

Hi Antoine

So the member only exists if CONFIG_MACSEC is defined. So i think you
need similar protection in phy_macsec() or you are going to try to
access a member which sometimes does not exist.

       Andrew
