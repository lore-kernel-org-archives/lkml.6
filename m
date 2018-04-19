Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeDSPWy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:22:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751070AbeDSPWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:22:52 -0400
Date: Thu, 19 Apr 2018 17:22:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-ccw: process ssch with interrupts disabled
Message-ID: <20180419172248.0d10db2a.cohuck@redhat.com>
In-Reply-To: <b52e3aac-208c-8d55-cc77-2534a375fda5@linux.vnet.ibm.com>
References: <20180413140509.9042-1-cohuck@redhat.com>
        <b52e3aac-208c-8d55-cc77-2534a375fda5@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 16:14:25 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 13/04/2018 16:05, Cornelia Huck wrote:
> > When we call ssch, an interrupt might already be pending once we
> > return from the START SUBCHANNEL instruction. Therefore we need to
> > make sure interrupts are disabled until after we're done with our
> > processing.
> >
> > Note that the subchannel lock is the same as the ccwdevice lock that
> > is mentioned in the documentation for ccw_device_start() and friends.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   drivers/s390/cio/vfio_ccw_fsm.c | 19 ++++++++++++-------
> >   1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> > index ff6963ad6e39..3c800642134e 100644
> > --- a/drivers/s390/cio/vfio_ccw_fsm.c
> > +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> > @@ -20,12 +20,12 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
> >   	int ccode;
> >   	__u8 lpm;
> >   	unsigned long flags;
> > +	int ret;
> >
> >   	sch = private->sch;
> >
> >   	spin_lock_irqsave(sch->lock, flags);
> >   	private->state = VFIO_CCW_STATE_BUSY;
> > -	spin_unlock_irqrestore(sch->lock, flags);
> >
> >   	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
> >
> > @@ -38,10 +38,12 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
> >   		 * Initialize device status information
> >   		 */
> >   		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
> > -		return 0;
> > +		ret = 0;
> > +		break;
> >   	case 1:		/* Status pending */
> >   	case 2:		/* Busy */
> > -		return -EBUSY;
> > +		ret = -EBUSY;
> > +		break;
> >   	case 3:		/* Device/path not operational */
> >   	{
> >   		lpm = orb->cmd.lpm;
> > @@ -51,13 +53,16 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
> >   			sch->lpm = 0;
> >
> >   		if (cio_update_schib(sch))
> > -			return -ENODEV;
> > -
> > -		return sch->lpm ? -EACCES : -ENODEV;
> > +			ret = -ENODEV;
> > +		else
> > +			ret = sch->lpm ? -EACCES : -ENODEV;
> > +		break;
> >   	}
> >   	default:
> > -		return ccode;
> > +		ret = ccode;
> >   	}
> > +	spin_unlock_irqrestore(sch->lock, flags);
> > +	return ret;
> >   }
> >
> >   static void fsm_notoper(struct vfio_ccw_private *private,  
> 
> 
> I have been working on a patch to solve this problem between others, I 
> provide it soon.
> It is much more intrusive, reworking interrupts and state machine.
> So may be you do not like it.

I'll take a look at your state machine series later, but it is
certainly material for the next release.

[I also have my halt/clear implementation which I wanted to send this
week, but other things have been eating up my bandwidth. Well, the week
is not over yet...]

> If we stay on this patch, even this is quite a long spinlock around ssch 
> and stsch,
> and we need it in the current implementation.

I'd like to queue a small patch like this for the current release which
is also suitable for stable. We can still rework things on top.

> Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>

Thanks!
