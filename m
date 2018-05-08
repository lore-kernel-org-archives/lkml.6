Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754718AbeEHMpM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:45:12 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52502 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbeEHMpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:45:11 -0400
Date: Tue, 8 May 2018 13:44:57 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next] net: phy: sfp: handle cases where neither
 BR,min nor BR,max is given
Message-ID: <20180508124456.GN16141@n2100.armlinux.org.uk>
References: <20180504152103.18152-1-antoine.tenart@bootlin.com>
 <53A4DFE3-C335-49B2-89C5-061A96C6D99D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53A4DFE3-C335-49B2-89C5-061A96C6D99D@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 01:35:34PM -0700, Florian Fainelli wrote:
> On May 4, 2018 8:21:03 AM PDT, Antoine Tenart <antoine.tenart@bootlin.com> wrote:
> >When computing the bitrate using values read from an SFP module EEPROM,
> >we use the nominal BR plus BR,min and BR,max to determine the
> >boundaries. But in some cases BR,min and BR,max aren't provided, which
> >led the SFP code to end up having the nominal value for both the
> >minimum
> >and maximum bitrate values. When using a passive cable, the nominal
> >value should be used as the maximum one, and there is no minimum one
> >so we should use 0.
> >
> >Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> >---
> >
> >Hi Russell,
> >
> >I'm not completely sure about this patch as this case is not really
> >specified in the specification. But the issue is there, and I've
> >discuss
> >this with others. It seemed logical (at least to us :)) to use the
> >BR,nominal values as br_max and 0 as br_min when using a passive cable
> >which only provides BR,nominal as this would be the highest rate at
> >which the cable could work. And because it's passive, there should be
> >no
> >issues using it at a lower rate.
> >
> >I've tested this with one passive cable which only reports its
> >BR,nominal (which was 10300) while it could be used when using
> >1000baseX
> >or 2500baseX modes.
> 
> Which SFP modules (vendor and model) exposed this out of curiosity?
> Russell and I already saw the Cotsworks modules having so e issues
> with checksums, so building a table of quirks would help. Thanks!

I think this is just manufacturers being lazy with their EEPROM
contents - looking around, most passive cables are specified to be
"up to" some figure, and that's definitely what's specified by the
SFP+ specification by way of the high-pass pole requirement of the
coupling capacitors.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
