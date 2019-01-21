Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03F6C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D1A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="np8gI06k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfAUKwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:52:18 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46524 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfAUKwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bHl6u5CSoO8WLLMUhKDWOpKdoQzA9HnxTdbysIoV06w=; b=np8gI06kfhZ5DUVAtPKhd4E23
        yO+WCGg+TBIw1Nq6GweH8VBun8qehtcT/RwpooyhqcW6r7x/bwehbrugS3ufkj419u2N+a7dzC9Qd
        0toGnyKlSdZXzzXoQoZT7DokWtd87KVl47RZ8t6lTLPtMWKYafAl6pPz/GrnvlwDjyO7A=;
Received: from e5254000004ec.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49384 helo=shell.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1glXBX-0002zt-6C; Mon, 21 Jan 2019 10:52:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1glXBW-0000oX-GB; Mon, 21 Jan 2019 10:52:06 +0000
Date:   Mon, 21 Jan 2019 10:52:06 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of
 2.5/5G PMA extended abilities
Message-ID: <20190121105206.mxxxosytk5qiysc2@e5254000004ec.dyn.armlinux.org.uk>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-6-maxime.chevallier@bootlin.com>
 <20190120190809.GB19714@lunn.ch>
 <20190121113531.7a8b5b51@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121113531.7a8b5b51@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:35:31AM +0100, Maxime Chevallier wrote:
> Hello Andrew,
> 
> On Sun, 20 Jan 2019 20:08:09 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> >On Fri, Jan 18, 2019 at 04:23:50PM +0100, Maxime Chevallier wrote:
> >> As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
> >> whether or not we should read register (1.21) "2.52/5G PMA Extended
> >> Abilities", which contains information on the support of 2.5GBASET and
> >> 5GBASET.
> >> 
> >> After testing on several variants of PHYS of this family, it appears
> >> that bit 14 in (1.11) isn't always set when it should be.
> >> 
> >> PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
> >> but don't have 1.11.14 set. Their register 1.21 is filled with the
> >> correct values, indicating 2.5G and 5G support.
> >> 
> >> PHYs 88X2110 do have their 1.11.14 bit set, as it should.  
> >
> >Hi Maxime
> >
> >Is there anything about this in any Errata?
> 
> I haven't seen any Errata on that unfortunately.
> 
> I also thought about reading (1.4) "PMA/PMD Speed Ability", but the
> 2.5G and 5G speeds are also reported as not being supported on the
> 88X3310.

It's entirely possible that the 3310 switches to different hardware
blocks for 2.5G and 5G speeds, and reading _just_ the 1.4 register
is not sufficient.

The 88x3310 is multiple PHY devices in one package, with a CPU that
manages the routing between each individual device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
