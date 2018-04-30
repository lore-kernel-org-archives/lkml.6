Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeD3N6s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:58:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752868AbeD3N6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:58:47 -0400
Date: Mon, 30 Apr 2018 15:58:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 02/10] vfio: ccw: Transform FSM functions to return
 state
Message-ID: <20180430155843.698cf635.cohuck@redhat.com>
In-Reply-To: <047dd088-6cba-c1fa-2295-05d31d7f4f2d@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-3-git-send-email-pmorel@linux.vnet.ibm.com>
        <20180424072550.GW12194@bjsdjshi@linux.vnet.ibm.com>
        <047dd088-6cba-c1fa-2295-05d31d7f4f2d@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 10:22:15 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 24/04/2018 09:25, Dong Jia Shi wrote:
> > * Pierre Morel <pmorel@linux.vnet.ibm.com> [2018-04-19 16:48:05 +0200]:
> >  
> >> We change the FSM functions to return the next state,
> >> and adapt the fsm_func_t function type.  
> > I think I'd need to read the rest patches to understand why we need this
> > one, but no hurt to write some ideas that I noticed at my first glance.
> > See below please.
> >  
> >> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >> ---
> >>   drivers/s390/cio/vfio_ccw_fsm.c     | 24 ++++++++++++++++--------
> >>   drivers/s390/cio/vfio_ccw_private.h |  5 +++--
> >>   2 files changed, 19 insertions(+), 10 deletions(-)

> >> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> >> index 78a66d9..f526b18 100644
> >> --- a/drivers/s390/cio/vfio_ccw_private.h
> >> +++ b/drivers/s390/cio/vfio_ccw_private.h
> >> @@ -83,13 +83,14 @@ enum vfio_ccw_event {
> >>   /*
> >>    * Action called through jumptable.
> >>    */
> >> -typedef void (fsm_func_t)(struct vfio_ccw_private *, enum vfio_ccw_event);
> >> +typedef int (fsm_func_t)(struct vfio_ccw_private *, enum vfio_ccw_event);
> >>   extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
> >>
> >>   static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
> >>   				     int event)
> >>   {
> >> -	vfio_ccw_jumptable[private->state][event](private, event);
> >> +	private->state = vfio_ccw_jumptable[private->state][event](private,
> >> +								   event);  
> > Since here it assigns new value to private->state, there is no need to
> > do that inside each fsm_func?  
> Absolutely.
> I just kept the previous code, just adding the return private->state in 
> the functions
> in this patch.
> merging the state and the return value is done in a later patch.
> If you prefer I can do it in this patch.

I think we should revisit this later. It's hard to judge this patch on
its own.
