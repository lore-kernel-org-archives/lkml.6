Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeFAXg4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 19:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeFAXgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 19:36:53 -0400
Date: Sat, 2 Jun 2018 08:36:48 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Josef Bacik <jbacik@fb.com>, James Hogan <jhogan@kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will.deacon@arm.com>,
        x86@kernel.org
Subject: Re: [PATCH -tip v4 24/27] bpf: error-inject: kprobes: Clear
 current_kprobe and enable preempt in kprobe
Message-Id: <20180602083648.fc40ce260c2cafb9a0d31aaa@kernel.org>
In-Reply-To: <1527763450.f65xiu4yuz.naveen@linux.ibm.com>
References: <152749074878.15132.16693721906742461289.stgit@devbox>
        <152749149794.15132.15817377604536829521.stgit@devbox>
        <1527763450.f65xiu4yuz.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 16:25:38 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > Clear current_kprobe and enable preemption in kprobe
> > even if pre_handler returns !0.
> > 
> > This simplifies function override using kprobes.
> > 
> > Jprobe used to require to keep the preemption disabled and
> > keep current_kprobe until it returned to original function
> > entry. For this reason kprobe_int3_handler() and similar
> > arch dependent kprobe handers checks pre_handler result
> > and exit without enabling preemption if the result is !0.
> > 
> > After removing the jprobe, Kprobes does not need to
> > keep preempt disabled even if user handler returns !0
> > anymore.
> 
> I think the reason jprobes did it that way is to address architecture 
> specific requirements when changing a function. So, without that 
> infrastructure, I am not sure if we will be able to claim support for 
> over-riding functions with kprobes. I am not sure if we want to claim 
> that, but this is something we need to be clear on.

Really? as far as I can see, there seems no such architecture.
The keeping preempt disabled is corresponding to keeping current_kprobe
since the current_kprobe is per-cpu. This means if it is preempted
before hitting break_handler and changed cpu core, we missed to
handle current_kprobe and goes to panic. But if we don't need
such "break back" (removing break_handler), we don't need to
keep current_kprobe (because it is not handled afterwards).

Anyway, changing function execution path is a "one-way" change.
We don't have a chance to fixup that disabled preemption and current_kprobe
after returning to the new function. So current error-inject clears
current_kprobe and enable preemption before returning !0 from its
kprobe pre_handler.

This is just moving such needless operation from user-pre_handler to
kprobes itself. 

> For powerpc, the current function override in error-inject works fine 
> since the new function does nothing. But, if anyone wants to do more 
> work in the replacement function, it won't work with the current 
> approach.

If you are considering about TOC change etc. yes, it depends on
the archtecture. As far as I know IA64 and powerpc will not allow
to support changing execution path without special care.
Other "flat and simple" function call architectures like x86, arm
can change execution path without special care. 

Anyway that is not related to this change. This is just a
cleanup in total, something like re-balancing the operation.

> > But since the function override handler in error-inject
> > and bpf is also returns !0 if it overrides a function,
> > to balancing the preempt count, it enables preemption
> > and reset current kprobe by itself.
> > 
> > That is a bad design that is very buggy. This fixes
> > such unbalanced preempt-count and current_kprobes setting
> > in kprobes, bpf and error-inject.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/arc/kernel/kprobes.c          |    5 +++--
> >  arch/arm/probes/kprobes/core.c     |   10 +++++-----
> >  arch/arm64/kernel/probes/kprobes.c |   10 +++++-----
> >  arch/ia64/kernel/kprobes.c         |   13 ++++---------
> >  arch/mips/kernel/kprobes.c         |    4 ++--
> >  arch/powerpc/kernel/kprobes.c      |    7 +++++--
> 
> I think you should also update arch/powerpc/kernel/kprobes-ftrace.c

Ah, good catch!! I'll fix that.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
