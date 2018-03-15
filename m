Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeCON5O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:57:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53544 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeCON5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:57:13 -0400
Date: Thu, 15 Mar 2018 14:57:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] x86/hyper-v: allocate and use Virtual Processor
 Assist Pages
In-Reply-To: <20180315134848.GV4043@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1803151455060.1525@nanos.tec.linutronix.de>
References: <20180309140249.2840-1-vkuznets@redhat.com> <20180309140249.2840-5-vkuznets@redhat.com> <alpine.DEB.2.21.1803141611300.2481@nanos.tec.linutronix.de> <87bmfpbqek.fsf@vitty.brq.redhat.com> <alpine.DEB.2.21.1803151240030.1525@nanos.tec.linutronix.de>
 <20180315134848.GV4043@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Peter Zijlstra wrote:
> On Thu, Mar 15, 2018 at 12:45:03PM +0100, Thomas Gleixner wrote:
> > On Thu, 15 Mar 2018, Vitaly Kuznetsov wrote:
> > > The only user of these pages is currently KVM. Can we still have vCPUs
> > > running on the outgoing CPU at this point? If case we can we're in
> > > trouble and we need to somehow kick them out first.
> > 
> > The first thing we do in unplug is to mark the CPU inactive, but I'm not
> > sure whether that prevents something which was on the CPU before and
> > perhaps preempted or is affine to that CPU to be scheduled in
> > again. Peter????
> 
> I think we can still have tasks running at this point.
> 
> AP_ACTIVE (sched_cpu_deactivate) simply takes the CPU out of the active
> mask, which guarantees no new tasks will land on the CPU.
> 
> We'll then proceed all the way to TEARDOWN_CPU as 'normal', at which
> point we'll call stop_machine() which does the old DYING callbacks.
> 
> It sounds like we want this done here, although possibly we can't do
> vfree() from that context, in which case it needs to store the pointer
> and do that from a BP callback (what used to be the OFFLINE callbacks or
> something).

So the wrmsr() wants to be in the dying range. The vfree() is questionable
anyway because the re-onlining of that CPU will just allocate it again. So
it could very well stay around.

Thanks,

	tglx
