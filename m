Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeC2NQr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:16:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53698 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeC2NQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:16:46 -0400
Date: Thu, 29 Mar 2018 15:16:12 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alison Schofield <alison.schofield@intel.com>
cc: Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86,sched: allow topologies where NUMA nodes share
 an LLC
In-Reply-To: <20180329000024.GA16648@alison-desk.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
References: <20180329000024.GA16648@alison-desk.jf.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, Alison Schofield wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Intel's Skylake Server CPUs have a different LLC topology than previous
> generations. When in Sub-NUMA-Clustering (SNC) mode, the package is
> divided into two "slices", each containing half the cores, half the LLC,
> and one memory controller and each slice is enumerated to Linux as a
> NUMA node. This is similar to how the cores and LLC were arranged
> for the Cluster-On-Die (CoD) feature.
> 
> CoD allowed the same cache line to be present in each half of the LLC.
> But, with SNC, each line is only ever present in *one* slice. This
> means that the portion of the LLC *available* to a CPU depends on the
> data being accessed:
> 
>     Remote socket: entire package LLC is shared
>     Local socket->local slice: data goes into local slice LLC
>     Local socket->remote slice: data goes into remote-slice LLC. Slightly
>                     		higher latency than local slice LLC.
> 
> The biggest implication from this is that a process accessing all
> NUMA-local memory only sees half the LLC capacity.
> 
> The CPU describes its cache hierarchy with the CPUID instruction. One
> of the CPUID leaves enumerates the "logical processors sharing this
> cache". This information is used for scheduling decisions so that tasks
> move more freely between CPUs sharing the cache.
> 
> But, the CPUID for the SNC configuration discussed above enumerates
> the LLC as being shared by the entire package. This is not 100%
> precise because the entire cache is not usable by all accesses. But,
> it *is* the way the hardware enumerates itself, and this is not likely
> to change.
> 
> This breaks the sane_topology() check in the smpboot.c code because
> this topology is considered not-sane. To fix this, add a vendor and
> model specific check to never call topology_sane() for these systems.
> Also, just like "Cluster-on-Die" we throw out the "coregroup"
> sched_domain_topology_level and use NUMA information from the SRAT
> alone.
> 
> This is OK at least on the hardware we are immediately concerned about
> because the LLC sharing happens at both the slice and at the package
> level, which are also NUMA boundaries.

So that addresses the scheduler interaction, but it still leaves the
information in the sysfs files unchanged. See cpu/intel_cacheinfo.c.  There
are applications which use that information so it should be correct.

Thanks,

	tglx
