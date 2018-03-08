Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754701AbeCHQqY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:46:24 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:46198 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752094AbeCHQqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:46:21 -0500
Date: Thu, 8 Mar 2018 10:46:14 -0600
From: Brad Mouring <brad.mouring@ni.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Florian Fainelli <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: Move interrupt check from phy_check to
 phy_interrupt
Message-ID: <20180308164613.GA7108@artie.amer.corp.natinst.com>
References: <20180307225042.2205-1-brad.mouring@ni.com>
 <20180308162905.GE5144@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180308162905.GE5144@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 05:29:05PM +0100, Andrew Lunn wrote:
> On Wed, Mar 07, 2018 at 04:50:42PM -0600, Brad Mouring wrote:
> > If multiple phys share the same interrupt (e.g. a multi-phy chip),
> > the first device registered is the only one checked as phy_interrupt
> > will always return IRQ_HANDLED if the first phydev is not halted.
> > Move the interrupt check into phy_interrupt and, if it was not this
> > phydev, return IRQ_NONE to allow other devices on this irq a chance
> > to check if it was their interrupt.
> > 
> > Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> > ---
> >  drivers/net/phy/phy.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > index e3e29c2b028b..ff1aa815568f 100644
> > --- a/drivers/net/phy/phy.c
> > +++ b/drivers/net/phy/phy.c
> > @@ -632,6 +632,12 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
> >  	if (PHY_HALTED == phydev->state)
> >  		return IRQ_NONE;		/* It can't be ours.  */
> >  
> > +	if (phy_interrupt_is_valid(phydev)) {
> 
> Hi Brad
> 
> Is this check needed? Can phy_interrupt() be called for a PHY which
> does not have an interrupt?

Ah, fair point (and I guess a result of copy-pasting without
thinking), to address this and the next point...

> > +		if (phydev->drv->did_interrupt &&
> > +			!phydev->drv->did_interrupt(phydev))
> > +			return IRQ_NONE;
> > +	}
> > +
> >  	phy_change(phydev);
> >  
> >  	return IRQ_HANDLED;
> > @@ -725,16 +731,6 @@ EXPORT_SYMBOL(phy_stop_interrupts);
> >   */
> >  void phy_change(struct phy_device *phydev)
> >  {
> > -	if (phy_interrupt_is_valid(phydev)) {
> > -		if (phydev->drv->did_interrupt &&
> > -		    !phydev->drv->did_interrupt(phydev))
> > -			return;
> > -
> > -		if (phydev->state == PHY_HALTED)
> > -			if (phy_disable_interrupts(phydev))
> > -				goto phy_err;
> > -	}
> > -
> 
> phy_change() can also be called via phy_mac_interrupt(). I wonder if
> this change is going to break anything? Did you think about that?

Thanks for pointing this out. I'll post a v2 that (hopefully) address
both of these valid points.

Thanks,
Brad
