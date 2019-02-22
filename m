Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF7EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E96206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yQyLUbpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfBVVoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:44:10 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:35368 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfBVVoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MOSOAG8utsUEcvDMAeGkKRABFhro6yKep9JlUm0lWB8=; b=yQyLUbpDtdnSCQVZX1ZwoFSK9V
        sBFpDUmeIFFOtxnTWEBGZlZJfXMdv9nR8LkEFSFZYTLcllpmRnV6yAlhtuGIjIuHIWbU2Ym25I4K/
        PJtdtW4+7CuwzXZWxkFaLtA0qKJmojbbb9na/mgWol1SgVFloVlRUee2Plkx2e/mzhLY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gxIc0-0003ac-28; Fri, 22 Feb 2019 22:44:04 +0100
Date:   Fri, 22 Feb 2019 22:44:04 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, rafalc@cadence.com,
        piotrs@cadence.com, jank@cadence.com
Subject: Re: [PATCH 3/3] net: ethernet: add support for high speed mac and
 usxgmii pcs
Message-ID: <20190222214404.GP5894@lunn.ch>
References: <20190222201309.GA23470@lvlogina.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222201309.GA23470@lvlogina.cadence.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	if (macb_is_gem(bp)) {
> -		linkmode_copy(phydev->supported, PHY_GBIT_FEATURES);
> -		if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED)
> -			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> -					 phydev->supported);
> +		if (bp->caps & MACB_CAPS_HIGH_SPEED) {
> +			linkmode_copy(phydev->supported, PHY_10GBIT_FEATURES);
> +		} else {
> +			u32 bitmask = ETHTOOL_LINK_MODE_2500baseT_Full_BIT;
> +
> +			linkmode_copy(phydev->supported, PHY_GBIT_FEATURES);
> +			if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED)
> +				linkmode_set_bit(bitmask, phydev->supported);
> +		}

Same issue again. Somebody could be using a 10G MAC with a 2.5G PHY.

     Andrew
