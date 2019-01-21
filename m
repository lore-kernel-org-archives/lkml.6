Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9449AC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2C320861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K2BR1xn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfAUURU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:17:20 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:50890 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbfAUURU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=dzAOuP+rL6WosTL3sPQ0aYK99ACbeRXGsEa7fY6ecQY=;
        b=K2BR1xn2wDpfk+czXvkOB6IJLuQjO0itktmEHE/6SHQwZtznVus4YdRVd2QItVOTerKR0/8Mw4v9bemUmLPQNnZo6IRye/r/rKeI+rPnaMWdbvF41VtYkamj7xKHTlggm9x/aFwfTcz/XsBVyVhcLdeLKvPcu2aqzjNbJdF+tNA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1glg0R-0005T6-7B; Mon, 21 Jan 2019 21:17:15 +0100
Date:   Mon, 21 Jan 2019 21:17:15 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 4/7] net: phy: marvell10g: Add support for
 2.5GBASET and 5GBASET
Message-ID: <20190121201715.GA20277@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-5-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118152352.26417-5-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -264,8 +265,10 @@ static int mv3310_config_init(struct phy_device *phydev)
>  	if (ret)
>  		return ret;
>  
> -	linkmode_and(phydev->advertising, phydev->advertising,
> -		     phydev->supported);
> +	/* Make sure we advertise all the supported modes, and not just the
> +	 * default one specified in the driver's .features.
> +	 */
> +	linkmode_copy(phydev->advertising, phydev->supported);

Hi Maxime

What Russell is referring to is:

static int phy_probe(struct device *dev)
{
..
        /* Start out supporting everything. Eventually,
         * a controller will attach, and may modify one
         * or both of these values
         */
        linkmode_copy(phydev->supported, phydrv->features);
        of_set_phy_supported(phydev);
        linkmode_copy(phydev->advertising, phydev->supported);

        /* Get the EEE modes we want to prohibit. We will ask
         * the PHY stop advertising these mode later on
         */
        of_set_phy_eee_broken(phydev);

        /* The Pause Frame bits indicate that the PHY can support passing
         * pause frames. During autonegotiation, the PHYs will determine if
         * they should allow pause frames to pass.  The MAC driver should then
         * use that result to determine whether to enable flow control via
         * pause frames.
         *
         * Normally, PHY drivers should not set the Pause bits, and instead
         * allow phylib to do that.  However, there may be some situations
         * (e.g. hardware erratum) where the driver wants to set only one
         * of these bits.
         */
        if (test_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydrv->features) ||
            test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydrv->features)) {
                linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
                                   phydev->supported);
                linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
                                  phydev->supported);
                if (test_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydrv->features))
                        linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
                                         phydev->supported);
                if (test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
                             phydrv->features))
                        linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
                                         phydev->supported);
        } else {
                linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
                                 phydev->supported);
                linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
                                 phydev->supported);
        }

So by doing a copy of supported into advertising, you can stomping
over any restrictions applied via of_set_phy_supported(),
of_set_phy_eee_broken(phydev), and any pause control settings which
might of happened.

What might make sense here is that a PHY driver can replace its
.features member at run time, in its config_init() call. The core then
needs to perform these evaluations. So i'm guessing we need to split
this code out of probe() and move it into phy_init_hw()?

Heiner, you know this code better than anybody. What do you think?

	Andrew
