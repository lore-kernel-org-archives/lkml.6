Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151E0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3385205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jbqG0Oym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3385205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966671AbeFSP3B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:29:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36605 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965953AbeFSP3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=mAjYaPgbW12wWysY+Evz63esk3CPbDRtSaz88fUKj1Y=;
        b=jbqG0Oym3ngqcPdpGRk7ZBHZ/6O1CCMyh9XvvYl1PWXJ7zbi4uvxvFScbEEgRvbFdWyt1byXuttdQEoNEFuMkA1x3DBXAX2o2PNJsIFh7QOGCg6RykcTJKD2IuqbTVbWxNzWU7q4Ee9Nr9cgpEBgqz4WzclfPNc5bN/n7KVydyA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fVIZ0-0007ME-5d; Tue, 19 Jun 2018 17:28:58 +0200
Date:   Tue, 19 Jun 2018 17:28:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable
 connect
Message-ID: <20180619152858.GD26796@lunn.ch>
References: <1528272198-10825-1-git-send-email-alexander.onnasch@landisgyr.com>
 <20180606123947.GB14898@lunn.ch>
 <AM6PR01MB4262F8BB6004D246DFF5C3FEF0700@AM6PR01MB4262.eurprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR01MB4262F8BB6004D246DFF5C3FEF0700@AM6PR01MB4262.eurprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:23:41PM +0000, Onnasch, Alexander (EXT) wrote:
> Hi Andrew
> thanks for the hint. But actually I cannot confirm - or I don't see it yet. 
> 
> Without having tested, just from the code, the struct phy_driver instance for PHY_ID_KSZ8061 in micrel.c does not have a .write_mmd function assigned, thus phy_write_mmd should evaluate to its else-clause (see below) and not to mdiobus_write (as in phy_write).
> 
> Also the ksz8061_extended_write() function which I have added uses the same principle as already existing HW-specific functions in micrel.c for simular reasons (kszphy_extended_write and ksz9031_extended_write).
> They use phy_write all over the place in that file and never phy_write_mmd - for whatever reason they had.
> Thus I thought it would be a good idea ...

Hi Alexander

Please don't top post. And wrap your lines at around 75 characters 

> 		struct mii_bus *bus = phydev->mdio.bus;
> 		int phy_addr = phydev->mdio.addr;
> 
> 		mutex_lock(&bus->mdio_lock);
> 		mmd_phy_indirect(bus, phy_addr, devad, regnum);
> 
> 		/* Write the data into MMD's selected register */
> 		bus->write(bus, phy_addr, MII_MMD_DATA, val);
> 		mutex_unlock(&bus->mdio_lock);


> > +static int ksz8061_extended_write(struct phy_device *phydev,
> > +				  u8 mode, u32 dev_addr, u32 regnum, u16 val) {
> > +	phy_write(phydev, MII_KSZ8061RN_MMD_CTRL_REG, dev_addr);
> > +	phy_write(phydev, MII_KSZ8061RN_MMD_REGDATA_REG, regnum);
> > +	phy_write(phydev, MII_KSZ8061RN_MMD_CTRL_REG, (mode << 14) | dev_addr);
> > +	return phy_write(phydev, MII_KSZ8061RN_MMD_REGDATA_REG, val); }
> 
> Hi Alexander
> 
> This looks a lot like phy_write_mmd().

Look closely at the two implementations. Look at what
mmd_phy_indirect() does. I _think_ these are identical. So don't add
your own helper, please use the core code.

     Andrew
