Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754342AbeD3LwB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:52:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753878AbeD3Lv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:51:58 -0400
Date: Mon, 30 Apr 2018 13:51:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com
Subject: Re: [PATCH v2 5/5] vfio: ccw: add traceponits for interesting error
 paths
Message-ID: <20180430135153.1d108675.cohuck@redhat.com>
In-Reply-To: <20180428055023.GS5428@bjsdjshi@linux.vnet.ibm.com>
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
        <20180423110113.59385-6-bjsdjshi@linux.vnet.ibm.com>
        <20180427121353.4453bdc2.cohuck@redhat.com>
        <20180428055023.GS5428@bjsdjshi@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Apr 2018 13:50:23 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2018-04-27 12:13:53 +0200]:
> 
> > On Mon, 23 Apr 2018 13:01:13 +0200
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> > 
> > typo in subject: s/traceponits/tracepoints/
> >   
> > > From: Halil Pasic <pasic@linux.vnet.ibm.com>
> > > 
> > > Add some tracepoints so we can inspect what is not working as is should.
> > > 
> > > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > ---
> > >  drivers/s390/cio/Makefile         |  1 +
> > >  drivers/s390/cio/vfio_ccw_fsm.c   | 16 +++++++-
> > >  drivers/s390/cio/vfio_ccw_trace.h | 77 +++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 93 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/s390/cio/vfio_ccw_trace.h  
> > 
> >   
> > > @@ -135,6 +142,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> > >  			goto err_out;
> > >  
> > >  		io_region->ret_code = cp_prefetch(&private->cp);
> > > +		trace_vfio_ccw_cp_prefetch(get_schid(private),
> > > +					   io_region->ret_code);
> > >  		if (io_region->ret_code) {
> > >  			cp_free(&private->cp);
> > >  			goto err_out;
> > > @@ -142,11 +151,13 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> > >  
> > >  		/* Start channel program and wait for I/O interrupt. */
> > >  		io_region->ret_code = fsm_io_helper(private);
> > > +		trace_vfio_ccw_fsm_io_helper(get_schid(private),
> > > +					     io_region->ret_code);
> > >  		if (io_region->ret_code) {
> > >  			cp_free(&private->cp);
> > >  			goto err_out;
> > >  		}
> > > -		return;
> > > +		goto out;
> > >  	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> > >  		/* XXX: Handle halt. */
> > >  		io_region->ret_code = -EOPNOTSUPP;
> > > @@ -159,6 +170,9 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> > >  
> > >  err_out:
> > >  	private->state = VFIO_CCW_STATE_IDLE;
> > > +out:
> > > +	trace_vfio_ccw_io_fctl(scsw->cmd.fctl, get_schid(private),
> > > +			       io_region->ret_code);
> > >  }
> > >  
> > >  /*  
> > 
> > I really don't want to bikeshed, especially as some tracepoints are
> > better than no tracepoints, but...
> > 
> > We now trace fctl/schid/ret_code unconditionally (good).
> > 
> > We trace the outcome of cp_prefetch() and fsm_io_helper()
> > unconditionally. We don't, however, trace all things that may go wrong.
> > We have the tracepoint at the end, but it cannot tell us where the
> > error came from. Should we have tracepoints in every place (in this
> > function) that may generate an error? Only if there is an actual error?
> > Are the two enough for common debug scenarios?  
> Trace actual error sounds like a better idea than trace unconditionally
> of these two functions.
> These two are not enough for common debug scenarios. For example, we
> cann't tell if a -EOPNOTSUPP is a orb->tm.b problem, or error code
> returned by cp_init().
> 
> Idea to improve:
> 1. Trace actual error.
> 2. Define a trace event and add error trace for cp_init().

Hm. Going from what I have done in the past when doing printk debugging:

- stick in a message that is always hit, with some information about
  parameters, if it makes sense
- stick in a message "foo happened!" in the error branches
   - or, alternatively, trace the called functions

So tracing on failure only might be more useful? Have all failure paths
under a common knob to turn on/off?

> > Opinions? We can just go ahead with this and improve things later
> > on, I guess.
> >   
> I think it's also fine to do this - better something than nothing. We
> could at least have a code base to be improved to make everybody
> happier in future.

Maybe keep the patch as it is now, except trace the errors only
(keeping the fctl trace point)?

Halil, as you wrote the patch (and I presume you found it helpful):
What is your opinion?
