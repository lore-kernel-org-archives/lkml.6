Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4E1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D569222B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vB6zY+ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbfBLVL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:11:26 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49021 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfBLVL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uuZiwe2HmvADlzNZ6ZS60EzhjyIXxXRW5JdfFSlnIp0=; b=vB6zY+ZZLMRJY8mvZBFgZy9V3H
        OrVPwegyKpES5IrVYKRZ9HyJWBup0uquS7yD0b35rqD6Di1oqLtMRmBXyCwB56Qx5PfyIh5UQ/Vpb
        2RXZOSQ4xT+j7J+t4lj6r35weQhtm/smzv/MP+ktQWr9KaRiw0yi1UjWsuNRmceh7Bko=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gtfKs-0007iC-4S; Tue, 12 Feb 2019 22:11:22 +0100
Date:   Tue, 12 Feb 2019 22:11:22 +0100
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
Subject: Re: [PATCH net-next 3/4] net: phy: Extract
 genphy_c45_pma_read_abilities from marvell10g
Message-ID: <20190212211122.GB27170@lunn.ch>
References: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
 <20190211142529.22885-4-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211142529.22885-4-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:25:28PM +0100, Maxime Chevallier wrote:
> Marvell 10G PHY driver has a generic way of initializing the supported
> link modes by reading the PHY's C45 PMA abilities. This can be made
> generic, since these registers are part of the 802.3 specifications.
> 
> This commit extracts the config_init link_mode initialization code from
> marvell10g and uses it to introduce the genphy_c45_pma_read_abilities
> function.
> 
> Only PMA modes are read, it's still up to the caller to set the Pause
> parameters.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

> -	__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
> -	__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
> +	__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->supported);
> +	__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->supported);

I think someone already pointed out, this is not ideal. The PHY driver
should only set pause bits, if it needs odd pause settings because of
HW limitations. If no bits are set, the core will set both bits.

But this is not a new problem introduced by this patch, so it can be
fixed later, rather than hold up this patchset.

      Andrew
