Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeDPS57 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:57:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42314 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753077AbeDPS55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:57:57 -0400
Date: Mon, 16 Apr 2018 20:57:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] x86,sched: allow topologies where NUMA nodes share an
 LLC
Message-ID: <20180416185723.GC29072@pd.tnic>
References: <20180407002130.GA18984@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180407002130.GA18984@alison-desk.jf.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 05:21:30PM -0700, Alison Schofield wrote:
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
> The userspace visible impact of all the above is that the sysfs info
> reports the entire LLC as being available to the entire package. As
> noted above, this is not true for local socket accesses. This patch
> does not correct the sysfs info. It is the same, pre and post patch.
> 
> This patch continues to allow this SNC topology and it does so without
> complaint. It eliminates a warning that looks like this:
> 
> 	sched: CPU #3's llc-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.
> 
> The warning is coming from the sane_topology check() in smpboot.c.

s/sane_topology check()/topology_sane() check/

> To fix this, add a vendor and model specific check to never call
> topology_sane() for these systems. Also, just like "Cluster-on-Die"
> we throw out the "coregroup" sched_domain_topology_level and use
> NUMA information from the SRAT alone.
> 
> This is OK at least on the hardware we are immediately concerned about
> because the LLC sharing happens at both the slice and at the package
> level, which are also NUMA boundaries.

I wish everyone would write commit messages like this. Very good and
nicely written explanation!

> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Cc: brice.goglin@gmail.com
> Cc: Ingo Molnar <mingo@kernel.org>
> ---

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
