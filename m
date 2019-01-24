Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B71C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3352621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfAXI4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:56:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57125 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfAXI4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:56:30 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2393C207B0; Thu, 24 Jan 2019 09:56:28 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id B9482207AC;
        Thu, 24 Jan 2019 09:56:27 +0100 (CET)
Date:   Thu, 24 Jan 2019 09:56:28 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        sd@queasysnail.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 05/10] net: phy: introduce a phy_driver macsec
 helper
Message-ID: <20190124085628.GC3662@kwain>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-6-antoine.tenart@bootlin.com>
 <20190123170816.GH5310@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190123170816.GH5310@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Jan 23, 2019 at 06:08:16PM +0100, Andrew Lunn wrote:
> > +int phy_macsec(struct phy_device *phydev, struct netdev_macsec *macsec)
> > +{
> > +	int ret = -EOPNOTSUPP;
> > +
> > +	if (!phydev->drv)
> > +		return -EIO;
> > +
> > +	mutex_lock(&phydev->lock);
> > +
> > +	if (phydev->drv->macsec)
> > +		ret = phydev->drv->macsec(phydev, macsec);
> > +
> > +	mutex_unlock(&phydev->lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(phy_macsec);
> > +
> 
> > @@ -630,6 +634,10 @@ struct phy_driver {
> >  			    struct ethtool_tunable *tuna,
> >  			    const void *data);
> >  	int (*set_loopback)(struct phy_device *dev, bool enable);
> > +
> > +#ifdef CONFIG_MACSEC
> > +	int (*macsec)(struct phy_device *dev, struct netdev_macsec *macsec);
> > +#endif
> 
> 
> So the member only exists if CONFIG_MACSEC is defined. So i think you
> need similar protection in phy_macsec() or you are going to try to
> access a member which sometimes does not exist.

Right, I'll fix that and protect the phy_macsec definition within an
'#ifdef CONFIG_MACSEC'.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
