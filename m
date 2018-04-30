Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbeD3P24 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:28:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753256AbeD3P2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:28:54 -0400
Date: Mon, 30 Apr 2018 17:28:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 03/10] vfio: ccw: new SCH_EVENT event
Message-ID: <20180430172851.2cb3d550.cohuck@redhat.com>
In-Reply-To: <20180426065954.GP5428@bjsdjshi@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-4-git-send-email-pmorel@linux.vnet.ibm.com>
        <20180426065954.GP5428@bjsdjshi@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018 14:59:54 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Pierre Morel <pmorel@linux.vnet.ibm.com> [2018-04-19 16:48:06 +0200]:
> 
> > The Sub channel event callback is threaded using workqueues.
> > The work uses the FSM introducing the VFIO_CCW_EVENT_SCH_EVENT
> > event.
> > The update of the SCHIB is now done inside the FSM function.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > ---
> >  drivers/s390/cio/vfio_ccw_drv.c     | 33 +++++++++++++--------------------
> >  drivers/s390/cio/vfio_ccw_fsm.c     | 23 +++++++++++++++++++++++
> >  drivers/s390/cio/vfio_ccw_private.h |  3 +++
> >  3 files changed, 39 insertions(+), 20 deletions(-)
> > 

> > @@ -171,28 +181,11 @@ static void vfio_ccw_sch_shutdown(struct subchannel *sch)
> >  static int vfio_ccw_sch_event(struct subchannel *sch, int process)
> >  {
> >  	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
> > -	unsigned long flags;
> > 
> > -	spin_lock_irqsave(sch->lock, flags);
> >  	if (!device_is_registered(&sch->dev))
> > -		goto out_unlock;
> > -
> > -	if (work_pending(&sch->todo_work))
> > -		goto out_unlock;  
> Just realized that this has a bug in the orignal implementation. For
> error out this should return -EAGAIN. We'd need a separated fix on
> this.

Indeed. Will you send a patch, or should I hack something up?

> 
> > -
> > -	if (cio_update_schib(sch)) {
> > -		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
> > -		goto out_unlock;
> > -	}
> > -
> > -	private = dev_get_drvdata(&sch->dev);
> > -	if (private->state == VFIO_CCW_STATE_NOT_OPER) {
> > -		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
> > -				 VFIO_CCW_STATE_STANDBY;
> > -	}  
> This hunk was toatally removed, and this is fine because?
> 
> > -
> > -out_unlock:
> > -	spin_unlock_irqrestore(sch->lock, flags);
> > +		return -1;  
> -1 is not a valid code.

-ENODEV looks more fitting, if we decide to go with this rework.

> 
> > +	WARN_ON(work_pending(&private->event_work));
> > +	queue_work(vfio_ccw_work_q, &private->event_work);
> > 
> >  	return 0;
> >  }

I'm wondering why this should always be done via a workqueue. It seems
the other subchannel types try to do as much as possible immediately?

(And returning -EAGAIN already triggers the css code to schedule
another call later.)
