Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF460C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D54120869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qLtjirJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D54120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeIEFfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:35:39 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52421 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbeIEFfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=/DzokV9yKpRI1xBDAJpjMelIzPlMSsIbStb2Ra+5Plg=;
        b=qLtjirJJysQqccb8CyTVPljVgqKwJXmt6vozxeWJUr2xITPutgSnJBzR8+tq1TSbAAGxJ9DCJKo48kGH0X2BR0W5eo+buTqM4GOfrOFGYHl8th6UjoFD2N6mrg0O4FEub+H3nK8FBqrRRxZr/juQOuhoK/HEyVkydymwQyS+mME=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fxMIV-00044F-35; Wed, 05 Sep 2018 03:07:55 +0200
Date:   Wed, 5 Sep 2018 03:07:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, f.fainelli@gmail.com,
        alex.williams@ni.com, moritz.fischer@ettus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] net: nixge: Add PHYLINK support
Message-ID: <20180905010755.GO29121@lunn.ch>
References: <20180905001535.19168-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905001535.19168-1-mdf@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static void nixge_handle_link_change(struct net_device *ndev)
> -{
> -	struct nixge_priv *priv = netdev_priv(ndev);
> -	struct phy_device *phydev = ndev->phydev;
> -
> -	if (phydev->link != priv->link || phydev->speed != priv->speed ||
> -	    phydev->duplex != priv->duplex) {
> -		priv->link = phydev->link;
> -		priv->speed = phydev->speed;
> -		priv->duplex = phydev->duplex;
> -		phy_print_status(phydev);
> -	}
> -}

I think this is why you are having trouble with the phylink
callbacks. You currently don't have any configuration of the MAC. You
normally need to tell the MAC what speed it should be doing. What
duplex it should be doing, if the link is up or down, if it should do
pause, or asym pause or no pause, etc.

       Andrew
