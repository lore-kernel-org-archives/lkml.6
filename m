Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A8EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64A520836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cyOUkgBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfBUKWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:22:25 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45706 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfBUKWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xEK0IHUte+obtGXTYx1zP2LBx69m7SbIXj0mflMWGI8=; b=cyOUkgBYbBSvE2PdYM+w1UMaA
        sQPlN4ojGQsH8VAd2Yfy9GOlwLrBaBONy4vNEWpev/tqGGcuUtFRFyTUmIXaKawFsaT4Wfj+lAr3B
        f4xVL9iHo6E3aJQpZT9iChujrHf/XzBWiU0R1FzDKTRJkMRyf6FvjSzLC+wyScWjUl3gdZUSX0md1
        RjJnG0iaVzFUwnRIpZRzUpqaRu0D4NmFa1nmRsLrRfVYm84u4OMA8TKhpNrs5/qbzVCVmSC8jYKed
        /FYxwGTsL9PwzVLqnMmq3g74MI8VON2iZstzNlYOpc8Wx4pH/1L7SNOx0kTCyA263XsmA+Fq7H8FG
        gIT15QQ2A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51314)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gwlUi-0001hv-NH; Thu, 21 Feb 2019 10:22:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gwlUd-0001H7-AO; Thu, 21 Feb 2019 10:22:15 +0000
Date:   Thu, 21 Feb 2019 10:22:15 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 1/7] net: phy: marvell10g: Use get_features to
 get the PHY abilities
Message-ID: <20190221102215.jg7bsxfdjkqrf6xn@shell.armlinux.org.uk>
References: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
 <20190221095128.28188-2-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221095128.28188-2-maxime.chevallier@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:51:22AM +0100, Maxime Chevallier wrote:
> The Alaska family of 10G PHYs has more abilities than the ones listed in
> PHY_10GBIT_FULL_FEATURES, the exact list depending on the model.
> 
> Make use of the newly introduced .get_features call to build this list,
> using genphy_c45_pma_read_abilities to build the list of supported
> linkmodes, and adding autoneg ability based on what's reported by the AN
> MMD.
> 
> .config_init is still used to validate the interface_mode.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/marvell10g.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index 9ea27acf05ad..65ef469adf58 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -233,8 +233,6 @@ static int mv3310_resume(struct phy_device *phydev)
>  
>  static int mv3310_config_init(struct phy_device *phydev)
>  {
> -	int ret, val;
> -
>  	/* Check that the PHY interface type is compatible */
>  	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
>  	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
> @@ -242,6 +240,12 @@ static int mv3310_config_init(struct phy_device *phydev)
>  	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
>  		return -ENODEV;
>  
> +	return 0;
> +}
> +
> +static int mv3310_get_features(struct phy_device *phydev)
> +{
> +	int ret, val;

Please try to keep the formatting/style consistent in the file you are
editing.  A blank line here would do that.  Thanks.

>  	if (phydev->c45_ids.devices_in_package & MDIO_DEVS_AN) {
>  		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
>  		if (val < 0)
> @@ -429,7 +433,7 @@ static struct phy_driver mv3310_drivers[] = {
>  		.phy_id		= 0x002b09aa,
>  		.phy_id_mask	= MARVELL_PHY_ID_MASK,
>  		.name		= "mv88x3310",
> -		.features	= PHY_10GBIT_FEATURES,
> +		.get_features	= mv3310_get_features,
>  		.soft_reset	= gen10g_no_soft_reset,
>  		.config_init	= mv3310_config_init,
>  		.probe		= mv3310_probe,
> -- 
> 2.19.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
