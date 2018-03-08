Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeCHUQh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:16:37 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:53382 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750728AbeCHUQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:16:36 -0500
Date: Thu, 8 Mar 2018 14:16:28 -0600
From: Brad Mouring <brad.mouring@ni.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: Move interrupt check from phy_check to
 phy_interrupt
Message-ID: <20180308201628.GA9188@artie.amer.corp.natinst.com>
References: <20180307225042.2205-1-brad.mouring@ni.com>
 <704e7f37-2b94-7e1f-c42f-374254bc791c@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <704e7f37-2b94-7e1f-c42f-374254bc791c@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback, Sergei.

On Thu, Mar 08, 2018 at 10:41:04PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 03/08/2018 01:50 AM, Brad Mouring wrote:
> 
> > If multiple phys share the same interrupt (e.g. a multi-phy chip),
> > the first device registered is the only one checked as phy_interrupt
> > will always return IRQ_HANDLED if the first phydev is not halted.
> > Move the interrupt check into phy_interrupt and, if it was not this
> > phydev, return IRQ_NONE to allow other devices on this irq a chance
> > to check if it was their interrupt.
> 
>    Hm, looking at kernel/irq/handle.c, all registered IRQ handlers are always
> called regardless of their results. Care to explain?

In the phy interrupt handler case, the phy_interrupt function is
registered as the threaded secondary, and irq_default_primary_handler
is being used as the primary (which will turn around and wake the
threaded handler). It seems that we wake the thread_fns in order, and
the first to report back HANDLED stops us from waking the next.

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
>   Always true in this context, no?

Yes, already noted.

> > +		if (phydev->drv->did_interrupt &&
> > +			!phydev->drv->did_interrupt(phydev))
> 
>    I don't think we can do this in the interrupt context as this function *will*
> read from MDIO... I think that was the reason why IRQ handling is done in the
> thread context... 

phy_interrupt is the thread_fn here. We're not in interrupt context.

> > +			return IRQ_NONE;
> > +	}
> > +
> >  	phy_change(phydev);
> >  
> >  	return IRQ_HANDLED;
> [...]
> 
> MBR, Sergei

Thanks,
Brad
