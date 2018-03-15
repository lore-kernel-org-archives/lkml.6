Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeCONs7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:48:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeCONs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:48:57 -0400
Date: Thu, 15 Mar 2018 14:48:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] x86/hyper-v: allocate and use Virtual Processor
 Assist Pages
Message-ID: <20180315134848.GV4043@hirez.programming.kicks-ass.net>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-5-vkuznets@redhat.com>
 <alpine.DEB.2.21.1803141611300.2481@nanos.tec.linutronix.de>
 <87bmfpbqek.fsf@vitty.brq.redhat.com>
 <alpine.DEB.2.21.1803151240030.1525@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803151240030.1525@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 12:45:03PM +0100, Thomas Gleixner wrote:
> On Thu, 15 Mar 2018, Vitaly Kuznetsov wrote:
> > Thomas Gleixner <tglx@linutronix.de> writes:
> > > On Fri, 9 Mar 2018, Vitaly Kuznetsov wrote:
> > >> @@ -198,6 +218,12 @@ static int hv_cpu_die(unsigned int cpu)
> > >>  	struct hv_reenlightenment_control re_ctrl;
> > >>  	unsigned int new_cpu;
> > >>  
> > >> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> > >> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> > >> +		vfree(hv_vp_assist_page[cpu]);
> > >> +		hv_vp_assist_page[cpu] = NULL;
> > >
> > > So this is freed before the CPU is actually dead. And this runs in
> > > preemtible context. Is the wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0); enough to
> > > prevent eventual users of the assist page on the outgoing CPU from
> > > accessing it?
> > >
> > 
> > After we do wrmsrl() the page is no longer 'magic' so in case eventual
> > users try using it they'll most likely misbehave -- so changing the
> > shutdown order won't help.
> > 
> > The only user of these pages is currently KVM. Can we still have vCPUs
> > running on the outgoing CPU at this point? If case we can we're in
> > trouble and we need to somehow kick them out first.
> 
> The first thing we do in unplug is to mark the CPU inactive, but I'm not
> sure whether that prevents something which was on the CPU before and
> perhaps preempted or is affine to that CPU to be scheduled in
> again. Peter????

I think we can still have tasks running at this point.

AP_ACTIVE (sched_cpu_deactivate) simply takes the CPU out of the active
mask, which guarantees no new tasks will land on the CPU.

We'll then proceed all the way to TEARDOWN_CPU as 'normal', at which
point we'll call stop_machine() which does the old DYING callbacks.

It sounds like we want this done here, although possibly we can't do
vfree() from that context, in which case it needs to store the pointer
and do that from a BP callback (what used to be the OFFLINE callbacks or
something).
