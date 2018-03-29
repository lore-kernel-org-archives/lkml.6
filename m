Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbeC2Nrp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:47:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34920 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbeC2Nro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:47:44 -0400
Date: Thu, 29 Mar 2018 15:47:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alison Schofield <alison.schofield@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86,sched: allow topologies where NUMA nodes share an
 LLC
Message-ID: <20180329134723.GA4043@hirez.programming.kicks-ass.net>
References: <20180329000024.GA16648@alison-desk.jf.intel.com>
 <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 03:16:12PM +0200, Thomas Gleixner wrote:
> On Wed, 28 Mar 2018, Alison Schofield wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Intel's Skylake Server CPUs have a different LLC topology than previous
> > generations. When in Sub-NUMA-Clustering (SNC) mode, the package is
> > divided into two "slices", each containing half the cores, half the LLC,
> > and one memory controller and each slice is enumerated to Linux as a
> > NUMA node. This is similar to how the cores and LLC were arranged
> > for the Cluster-On-Die (CoD) feature.
> > 
> > CoD allowed the same cache line to be present in each half of the LLC.
> > But, with SNC, each line is only ever present in *one* slice. This
> > means that the portion of the LLC *available* to a CPU depends on the
> > data being accessed:
> > 
> >     Remote socket: entire package LLC is shared
> >     Local socket->local slice: data goes into local slice LLC
> >     Local socket->remote slice: data goes into remote-slice LLC. Slightly
> >                     		higher latency than local slice LLC.
> > 
> > The biggest implication from this is that a process accessing all
> > NUMA-local memory only sees half the LLC capacity.
> > 
> > The CPU describes its cache hierarchy with the CPUID instruction. One
> > of the CPUID leaves enumerates the "logical processors sharing this
> > cache". This information is used for scheduling decisions so that tasks
> > move more freely between CPUs sharing the cache.
> > 
> > But, the CPUID for the SNC configuration discussed above enumerates
> > the LLC as being shared by the entire package. This is not 100%
> > precise because the entire cache is not usable by all accesses. But,
> > it *is* the way the hardware enumerates itself, and this is not likely
> > to change.
> > 
> > This breaks the sane_topology() check in the smpboot.c code because
> > this topology is considered not-sane. To fix this, add a vendor and
> > model specific check to never call topology_sane() for these systems.
> > Also, just like "Cluster-on-Die" we throw out the "coregroup"
> > sched_domain_topology_level and use NUMA information from the SRAT
> > alone.
> > 
> > This is OK at least on the hardware we are immediately concerned about
> > because the LLC sharing happens at both the slice and at the package
> > level, which are also NUMA boundaries.
> 
> So that addresses the scheduler interaction, but it still leaves the
> information in the sysfs files unchanged. See cpu/intel_cacheinfo.c.  There
> are applications which use that information so it should be correct.

Not unchanged, it actually breaks it. The patch doesn't consider the
user visible impact of the mask changes at all, and that is a problem.

The issue is that HPC workloads care about cache-size-per-cpu measure,
and the way they go about obtaining that is reading the cache-size and
dividing it by the h-weight of the cache-mask.

Now the patch does in fact change the cache-mask as exposed to
userspace, it however does _NOT_ change the cache-size. This means that
anybody using the values from sysfs to compute size/weight, now gets
double the value they ought to get.

So either is must not change the llc-mask, or also change the llc-size.

Further I think Dave argued that we should not change the llc-size,
because while SNC presents a subset of the cache to local CPUs, for
remote data the whole cache is still available, again something some
applications might rely on.

Which then leads to the conclusion that the current:

> +             /* Do not use LLC for scheduler decisions: */
> +             return false;

is wrong. Also, that comment is *completely* wrong, since the return
value has *nothing* to do with scheduler decisions what so ever, you
affected that by setting:

> +             x86_has_numa_in_package = true;


So please, try again.
