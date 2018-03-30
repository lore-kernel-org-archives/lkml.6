Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeC3Rdk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:33:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:45018 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3Rdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:33:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,382,1517904000";
   d="scan'208";a="187367952"
Date: Fri, 30 Mar 2018 10:34:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86,sched: allow topologies where NUMA nodes share an
 LLC
Message-ID: <20180330173406.GA1149@alison-desk.jf.intel.com>
References: <20180329000024.GA16648@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329000024.GA16648@alison-desk.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 05:00:24PM -0700, Alison Schofield wrote:
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
> 
> This patch eliminates a warning that looks like this:
> 
> 	sched: CPU #3's llc-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.
>

Let's see if I'm getting a better grasp of this:

My goal here is to suppress that WARNING message from topology_sane(). 
(We have a customer who is seeing the WARNING and would like it to go away)

The sysfs exported info for SNC's is 'not precise'. It reports the entire
LLC as available. This 'non precise' data existed before this patch and
exists after this patch. This is a problem, agreed.

PeterZ:

At first I thought you were saying that this patch itself broke the
sysfs info. I experimented with that and found no differences in sysfs
info before/after the patch and with SNC on/off. That makes me think
you are saying that we should not say this topology is 'Allowed' when
the sysfs data is wrong. (ie. That WARNING serves a purpose)

If you did indeed mean that the patch breaks the sysfs data, please
point me real close! ie. How does it change the cache-mask as exposed
to userspace?

All:

Here are 3 alternatives: 

1) Keep patch code basically the same and improve the comments & commit,
   being very explicit about the sysfs info issue.

2) Change the way the LLC-size is reported.
   Enumerate "two separate, half-sized LLCs shared only by the slice when
   SNC mode is on."

3) Do not export the sysfs info that is wrong. Userspace cannot make bad
   decisions based upon it.

Can we do 1) now and then follow with 2) or 3)?

Thanks for all the reviews/comments,
alisons
