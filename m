Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbeEHMam (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:30:42 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52224 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeEHMak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:30:40 -0400
Date: Tue, 8 May 2018 13:30:26 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next] net: phy: sfp: handle cases where neither
 BR,min nor BR,max is given
Message-ID: <20180508123026.GJ16141@n2100.armlinux.org.uk>
References: <20180504152103.18152-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504152103.18152-1-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 05:21:03PM +0200, Antoine Tenart wrote:
> When computing the bitrate using values read from an SFP module EEPROM,
> we use the nominal BR plus BR,min and BR,max to determine the
> boundaries. But in some cases BR,min and BR,max aren't provided, which
> led the SFP code to end up having the nominal value for both the minimum
> and maximum bitrate values. When using a passive cable, the nominal
> value should be used as the maximum one, and there is no minimum one
> so we should use 0.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
> 
> Hi Russell,
> 
> I'm not completely sure about this patch as this case is not really
> specified in the specification. But the issue is there, and I've discuss
> this with others. It seemed logical (at least to us :)) to use the
> BR,nominal values as br_max and 0 as br_min when using a passive cable
> which only provides BR,nominal as this would be the highest rate at
> which the cable could work. And because it's passive, there should be no
> issues using it at a lower rate.
> 
> I've tested this with one passive cable which only reports its
> BR,nominal (which was 10300) while it could be used when using 1000baseX
> or 2500baseX modes.

The electronic engineer in me says that using zero isn't really valid
because there are coupling capacitors in the SFP module that block DC.
These blocking capacitors are required by the SFP+ specs to have a high
pass pole of between 20kHz and 100kHz - in other words, frequencies
below this are attenuated by the coupling capacitors.  The relationship
between this and the bit rate will be a function of the encoding, so we
can't come to a definitive figure without some math (and I want to be
lazy about that!)

Practically, we're talking about SerDes Ethernet, where the bit rate is
no lower than 100Mbps [*], which will always have a frequency well above
this cut-off.  So, I don't have any problem with your approach to
setting the minimum to zero.  Therefore,

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Please send me the EEPROM dump using:

ethtool -m <ethernetdevice> raw on > foo.bin

so I can add it to my database for future testing and validation.

Thanks.

* - 10Mbps SGMII is 1Gbps SGMII with each bit repeated 100 times.
    100Mbps SGMII is 1Gbps SGMII with each bit repeated 10 times.
    There is a capability bits for transceivers supporting
    100base-FX/LX but no one has tested those yet.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
