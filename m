Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeDSJAt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:00:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1741 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDSJAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:00:47 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 19 Apr 2018 02:00:46 -0700
From: Bhadram Varka <vbhadram@nvidia.com>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jingju Hou <Jingju.Hou@synaptics.com>
Subject: RE: [PATCH] net: phy: marvell: clear wol event before setting it
Thread-Topic: [PATCH] net: phy: marvell: clear wol event before setting it
Thread-Index: AQHT17Tmskie4f0tkky4KxMjyNmTQKQHwlIAgAAGJICAAADlUA==
Date: Thu, 19 Apr 2018 09:00:40 +0000
Message-ID: <e1409c9493f64188a71b44f69ccb24cf@bgmail102.nvidia.com>
References: <20180419160232.519d15be@xhacker.debian>
        <96e77eac86794bef9a5b772147527c67@bgmail102.nvidia.com>
 <20180419165351.5388021e@xhacker.debian>
In-Reply-To: <20180419165351.5388021e@xhacker.debian>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.24.193.52]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Sent: Thursday, April 19, 2018 2:24 PM
> To: Bhadram Varka <vbhadram@nvidia.com>
> Cc: Andrew Lunn <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>;
> David S. Miller <davem@davemloft.net>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Jingju Hou <Jingju.Hou@synaptics.com>
> Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
> 
> Hi,
> 
> On Thu, 19 Apr 2018 08:38:45 +0000 Bhadram Varka wrote:
> 
> > Hi,
> >
> > > -----Original Message-----
> > > From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On
> > > Behalf Of Jisheng Zhang
> > > Sent: Thursday, April 19, 2018 1:33 PM
> > > To: Andrew Lunn <andrew@lunn.ch>; Florian Fainelli
> > > <f.fainelli@gmail.com>; David S. Miller <davem@davemloft.net>
> > > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Jingju Hou
> > > <Jingju.Hou@synaptics.com>
> > > Subject: [PATCH] net: phy: marvell: clear wol event before setting
> > > it
> > >
> > > From: Jingju Hou <Jingju.Hou@synaptics.com>
> > >
> > > If WOL event happened once, the LED[2] interrupt pin will not be
> > > cleared unless reading the CSISR register. So clear the WOL event before
> enabling it.
> > >
> > > Signed-off-by: Jingju Hou <Jingju.Hou@synaptics.com>
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > ---
> > >  drivers/net/phy/marvell.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> > > index c22e8e383247..b6abe1cbc84b 100644
> > > --- a/drivers/net/phy/marvell.c
> > > +++ b/drivers/net/phy/marvell.c
> > > @@ -115,6 +115,9 @@
> > >  /* WOL Event Interrupt Enable */
> > >  #define MII_88E1318S_PHY_CSIER_WOL_EIE			BIT(7)
> > >
> > > +/* Copper Specific Interrupt Status Register */
> > > +#define MII_88E1318S_PHY_CSISR				0x13
> > > +
> >
> > There is already macro to represent this register - MII_M1011_IEVENT. Do we
> need this macro ?
> 
> Good point. Will use MII_M1011_IEVENT instead in v2.
> 
> >
> > >  /* LED Timer Control Register */
> > >  #define MII_88E1318S_PHY_LED_TCR			0x12
> > >  #define MII_88E1318S_PHY_LED_TCR_FORCE_INT		BIT(15)
> > > @@ -1393,6 +1396,12 @@ static int m88e1318_set_wol(struct phy_device
> > > *phydev,
> > >  		if (err < 0)
> > >  			goto error;
> > >
> > > +		/* If WOL event happened once, the LED[2] interrupt pin
> > > +		 * will not be cleared unless reading the CSISR register.
> > > +		 * So clear the WOL event first before enabling it.
> > > +		 */
> > > +		phy_read(phydev, MII_88E1318S_PHY_CSISR);
> >
> > This part of the operation already taken care by ack_interrupt and
> > did_interrupt [....] .ack_interrupt = &marvell_ack_interrupt,
> > .did_interrupt = &m88e1121_did_interrupt, [...]
> >
> > If at all WOL event occurred marvell_ack_interrupt will take care of clearing the
> interrupt status register.
> > Am I missing anything here ?
> 
> If there's no valid irq for phy, the ack_interrupt/did_interrupt won't be called.

Which means that the PHY is not having Interrupt pin ?

Generally through PHY interrupt will wake up the system right. If there is no interrupt pin then how the system will wake up the from suspend for the magic packet.?

Thanks!
