Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77086C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3408A206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HTL78Lep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfBVVkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:40:00 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:35354 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBVVkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5xlNKm0UTEz0zSlWyhNfJxuNbz0w6R17EICj0Du82NA=; b=HTL78LepesOGKv3KGtFlyj3cGy
        kK0XCP3gmFFhvhnr8IP5Tzvbso2krWH11B/4GunkNgWbMI2OUbxYizuyJnxvptP4Qqphbt5VuFEJ5
        B7T0CKNeOUTUFfpcOdBwxVfB50RjOLDpJEtm2q3SggMUlVA0N29c8W0FpMeOmVfh98l4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gxIXx-0003Vs-IC; Fri, 22 Feb 2019 22:39:53 +0100
Date:   Fri, 22 Feb 2019 22:39:53 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, rafalc@cadence.com,
        piotrs@cadence.com, jank@cadence.com
Subject: Re: [PATCH 1/3] net: ethernet: add support for PCS and 2.5G speed
Message-ID: <20190222213953.GN5894@lunn.ch>
References: <20190222201225.GA15633@lvlogina.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222201225.GA15633@lvlogina.cadence.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	/* mask with MAC supported features */
> -	if (macb_is_gem(bp) && bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)
> -		phy_set_max_speed(phydev, SPEED_1000);
> -	else
> -		phy_set_max_speed(phydev, SPEED_100);
> +	if (macb_is_gem(bp)) {
> +		linkmode_copy(phydev->supported, PHY_GBIT_FEATURES);
> +		if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED)
> +			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +					 phydev->supported);
> +	} else {
> +		linkmode_copy(phydev->supported, PHY_BASIC_FEATURES);
> +	}
> +
> +	linkmode_copy(phydev->advertising, phydev->supported);

This is not correct. Just because the MAC can do 2.5G does not mean
the PHY can. So you should not be adding links modes. Also, somebody
might be using a PHY that can do 2.5G with a MAC which can only do 1G.

The correct thing to do is call phy_set_max_speed() with the maximum
speed the MAC can do.

      Andrew
