Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC312C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA82204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EhlcgmKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA82204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeJUAQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 20:16:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38988 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbeJUAQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 20:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=GXeebIyE2oxIsnleGqwhoifoN9T9343TSLy0dj5M6uw=;
        b=EhlcgmKL5eTn8aFhrQCro5D5f3rwDf4byfB49Gyxi8xNDEITwHw1mDpV91Hgmb6I7DY2zbVfOKQG1ggCqeAuL+XZALpJbi0pHjF2JsdDYcYxCJVrw7gePuvJsQ83Qp8Ff966VQeLATaxUiSJipPkYzuMfZnGVS54epFl1W1/6qc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gDtLW-0000vy-13; Sat, 20 Oct 2018 17:39:22 +0200
Date:   Sat, 20 Oct 2018 17:39:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        LABBE Corentin <clabbe@baylibre.com>, davem@davemloft.net,
        fugang.duan@nxp.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
Message-ID: <20181020153922.GC1596@lunn.ch>
References: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
 <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com>
 <20181018184715.GA31736@Red>
 <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com>
 <20181018191612.GB31736@Red>
 <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com>
 <20181018195909.GA11317@Red>
 <1b784f69-3ec2-feb2-81e1-9a335cf477c3@gmail.com>
 <f1933c0a-d124-a7ac-afab-2fa8f88907ab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1933c0a-d124-a7ac-afab-2fa8f88907ab@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> I have patched by adding:
> >> phy_remove_link_mode(phy_dev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
> 
> Instead of programmatically removing the feature bit it should be
> possible to do this in the PHY driver configuration. See also
> this part of phy_probe().
> 
> 	if (phydrv->features & (SUPPORTED_Pause | SUPPORTED_Asym_Pause)) {
> 		phydev->supported &= ~(SUPPORTED_Pause | SUPPORTED_Asym_Pause);
> 		phydev->supported |= phydrv->features &
> 				     (SUPPORTED_Pause | SUPPORTED_Asym_Pause);
> 	} else {
> 		phydev->supported |= SUPPORTED_Pause | SUPPORTED_Asym_Pause;
> 	}

Sorry for the late reply. Been on vacation.

I need to check the datasheet, but it seems like the KSZ9021 does not
support asym pause. Using the above code is the correct way to solve
this problem. Look at the bcm63xx.c:bcm63xx_config_init() which does
this.

I will cook up a patch.

  Andrew
