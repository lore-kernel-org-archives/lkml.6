Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AFDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542FB20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CnHW246h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542FB20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeKIThQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:37:16 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44166 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKIThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vqdYluIInjXyYIc/BJebPfDpcyqotxid1YCejfctuQ8=; b=CnHW246hk/TRRMoP5tfUPHwlk
        HQtswYA9NBepm7KDxFtE4hKSocZEfiuixi54F33w5mT4k+eUWnDnu43YqL1iwe6xEyI+3pQY3jGqZ
        Nuot6b0uzQjCjg56blAu12htt5M8TC8fnZ6cGLQprC5Xxmhcoq0ky24z2MIG/CI4NWj8o=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:47409)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gL3XV-0001O2-BF; Fri, 09 Nov 2018 09:57:21 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gL3XR-0003jW-8k; Fri, 09 Nov 2018 09:57:17 +0000
Date:   Fri, 9 Nov 2018 09:57:15 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: mvneta: Don't advertise 2.5G modes
Message-ID: <20181109095715.GA30658@n2100.armlinux.org.uk>
References: <20181109081733.24458-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109081733.24458-1-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:17:33AM +0100, Maxime Chevallier wrote:
> Using 2.5G speed relies on the SerDes lanes being configured
> accordingly. The lanes have to be reconfigured to switch between
> 1G and 2.5G, and for now only the bootloader does this configuration.
> 
> In the case we add a Comphy driver to handle switching the lanes
> dynamically, it's better for now to stick with supporting only 1G and
> add advertisement for 2.5G once we really are capable of handling both
> speeds without problem.
> 
> Since the interface mode is initialy taken from the DT, we want to make
> sure that adding comphy support won't break boards that don't update
> their dtb.
> 
> Fixes: da58a931f248 ("net: mvneta: Add support for 2500Mbps SGMII")
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Reported-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

As we discussed on IRC... however, please can we wait until Monday/
Tuesday before merging this patch to allow for some further thought
and discussion - by which time I expect to have a comphy driver.

Thanks.

> ---
>  drivers/net/ethernet/marvell/mvneta.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 5bfd349bf41a..c19ecd153499 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -3343,7 +3343,6 @@ static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
>  	if (state->interface != PHY_INTERFACE_MODE_NA &&
>  	    state->interface != PHY_INTERFACE_MODE_QSGMII &&
>  	    state->interface != PHY_INTERFACE_MODE_SGMII &&
> -	    state->interface != PHY_INTERFACE_MODE_2500BASEX &&
>  	    !phy_interface_mode_is_8023z(state->interface) &&
>  	    !phy_interface_mode_is_rgmii(state->interface)) {
>  		bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
> @@ -3357,14 +3356,9 @@ static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
>  	/* Asymmetric pause is unsupported */
>  	phylink_set(mask, Pause);
>  
> -	/* We cannot use 1Gbps when using the 2.5G interface. */
> -	if (state->interface == PHY_INTERFACE_MODE_2500BASEX) {
> -		phylink_set(mask, 2500baseT_Full);
> -		phylink_set(mask, 2500baseX_Full);
> -	} else {
> -		phylink_set(mask, 1000baseT_Full);
> -		phylink_set(mask, 1000baseX_Full);
> -	}
> +	/* Half-duplex at speeds higher than 100Mbit is unsupported */
> +	phylink_set(mask, 1000baseT_Full);
> +	phylink_set(mask, 1000baseX_Full);
>  
>  	if (!phy_interface_mode_is_8023z(state->interface)) {
>  		/* 10M and 100M are only supported in non-802.3z mode */
> -- 
> 2.11.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
