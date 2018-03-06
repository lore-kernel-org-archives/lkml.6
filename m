Return-Path: <morten.rasmussen@arm.com>
X-Google-Smtp-Source: AG47ELuAmojyacF6bnu4hfTvjIZRCFPE0Du3NZyow2iaugoZT3lqDPx2Pj0gQtEyWehwUvkO9OQD
ARC-Seal: i=1; a=rsa-sha256; t=1520352448; cv=none;
        d=google.com; s=arc-20160816;
        b=0OBVU1D3rzD6n5hcutQyOceQBMgKxEsggg/Km2YLlKg4TU3/2IpjuCKp6vh8/9AehQ
         Xll/VzY7CVAqaYnA7Kz5XOycE4FtzWsQS83AbS561uzJRU9poXNoWdWJPexkCIAoyK3C
         i+Bd6qq2gG30jCA4Wt4BPK/JqLG+BxMqbukebip6XuvRxq4aQR6UyGsLNyp3IMf2XMyV
         W5CQi+GljGUzExJQUWeqUtTvI0w8vtLSZWkloWLhQ8btUOAy2FuYJ2nImF2sMauhnqIJ
         6J0HNPSmHYv8HqaVIJyUAj3sKvBOLPSI4dHULN9cEZNRMIDuLJc4ruoaMdk3BH+E1l9F
         vdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=6nliUdveeZ4rCwdefE0mtBAnBLllV8PgrPx4+ioULkA=;
        b=CegJiK0SuZhLJO+smYrE1rDdQFaU+zhkOf8zhmUo90V869+rlqlj4KWAuM661M+J2p
         zAM9zVjdViIOzp8+qHEs3yLm62AA0cylKIV7Fym1gZg56gUTWF4y5ftRKEs2yBG0+tpD
         PfmUOkAWOkK8WzgOqnD9vURIgJVuh00YyeLJRcq0ClnTya4TI1gkWVEoq9spIpSg/u0C
         5xizivDyVNlhQJC2aD2aLBsV3xyA5ikIbhRuTvXlvobmbJsy+vOI67wI3DH5kxBcmMID
         gJkfslLISjreG1PSRqmHSaWhbu+5S8e+WeUHYzlFT7EzHpddIYGi8WTprhH5n07RknC1
         dLgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Date: Tue, 6 Mar 2018 16:07:21 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com, lorenzo.pieralisi@arm.com,
	hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com,
	catalin.marinas@arm.com, gregkh@linuxfoundation.org,
	mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org, ahs3@redhat.com, dietmar.eggemann@arm.com,
	palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com,
	austinwc@codeaurora.org, tnowicki@caviumnetworks.com
Subject: Re: [PATCH v7 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
Message-ID: <20180306160721.GJ4589@e105550-lin.cambridge.arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-14-jeremy.linton@arm.com>
 <20180301155216.GI4589@e105550-lin.cambridge.arm.com>
 <5d6bf4cf-2f6d-d123-f17f-d47d8e74c16c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6bf4cf-2f6d-d123-f17f-d47d8e74c16c@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684162193428124?=
X-GMAIL-MSGID: =?utf-8?q?1594205088689380498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 02:18:47PM -0600, Jeremy Linton wrote:
> Hi,
> 
> 
> First, thanks for taking a look at this.
> 
> On 03/01/2018 09:52 AM, Morten Rasmussen wrote:
> >Hi Jeremy,
> >
> >On Wed, Feb 28, 2018 at 04:06:19PM -0600, Jeremy Linton wrote:
> >>Now that we have an accurate view of the physical topology
> >>we need to represent it correctly to the scheduler. In the
> >>case of NUMA in socket, we need to assure that the sched domain
> >>we build for the MC layer isn't larger than the DIE above it.
> >
> >MC shouldn't be larger than any of the NUMA domains either.
> 
> Right, that is one of the things this patch is assuring..
> 
> >
> >>To do this correctly, we should really base that on the cache
> >>topology immediately below the NUMA node (for NUMA in socket) >> or below the physical package for normal NUMA configurations.
> >
> >That means we wouldn't support multi-die NUMA nodes?
> 
> You mean a bottom level NUMA domain that crosses multiple sockets/dies? That
> should work. This patch is picking the widest cache layer below the smallest
> of the package or numa grouping. What actually happens depends on the
> topology. Given a case where there are multiple dies in a socket, and the
> numa domain is at the socket level the MC is going to reflect the caching
> topology immediately below the socket. In the case of multiple dies, with a
> cache that crosses them in socket, then the MC is basically going to be the
> socket, otherwise if the widest cache is per die, or some narrower grouping
> (cluster?) then that is what ends up in the MC. (this is easier with some
> pictures)

That is more or less what I meant. I think I got confused with the role
of "DIE" level, i.e. that top non-NUMA level, in this. The DIE level
cpumask spans exactly the NUMA node, so IIUC we have three scenarios:

1. Multi-die/socket/physical package NUMA node
   Top non-NUMA level (DIE) spans multiple packages. Bottom NUMA level
   spans multiple multi-package nodes. The MC mask reflects the last-level
   cache within the NUMA node which is most likely per-die or per-cluster
   (inside each die).

2. physical package == NUMA node
   The top non-NUMA (DIE) mask is the same as the core sibling mask.
   If there is cache spanning the entire node, the scheduler topology
   will eliminate a layer (DIE?), so bottom NUMA level would be right on
   top of MC spanning multiple physical packages. If there is no
   node-wide last level cache, DIE is preserved and MC matches the span
   of the last level cache.

3. numa-in-package
   Top non-NUMA (DIE) mask is not reflecting the actual die, but is
   reflecting the NUMA node. MC has a span equal to the largest share
   cache span smaller than or equal to the the NUMA node. If it is
   equal, DIE level is eliminated, otherwise DIE is preserved, but
   doesn't really represent die. Bottom non-NUMA level spans multiple
   in-package NUMA nodes.

As you said, multi-die nodes should work. However, I'm not sure if
shrinking MC to match a cache could cause us trouble, or if it should
just be shrunk to be the smaller of the node mask and core siblings.
Unless you have a node-wide last level cache DIE level won't be
eliminated in scenario 2 and 3, and could cause trouble. For
numa-in-package, you can end up with a DIE level inside the node where
the default flags don't favour aggressive spreading of tasks. The same
could be the case for per-package nodes (scenario 2).

Don't we end up redefining physical package to be last level cache
instead of using the PPTT flag for scenario 2 and 3?

I think DIE level should be eliminated for scenario 2 and 3 like it is
for x86.

[...]

> >>This patch creates a set of early cache_siblings masks, then
> >>when the scheduler requests the coregroup mask we pick the
> >>smaller of the physical package siblings, or the numa siblings
> >>and locate the largest cache which is an entire subset of
> >>those siblings. If we are unable to find a proper subset of
> >>cores then we retain the original behavior and return the
> >>core_sibling list.
> >
> >IIUC, for numa-in-package it is a strict requirement that there is a
> >cache that span the entire NUMA node? For example, having a NUMA node
> >consisting of two clusters with per-cluster caches only wouldn't be
> >supported?
> 
> Everything is supported, the MC is reflecting the cache topology. We just
> use the physical/numa topology to help us pick which layer of cache topology
> lands in the MC. (unless of course we fail to find a PPTT/cache topology, in
> which case we fallback to the old behavior of the core_siblings which can
> reflect the MPIDR/etc).

I see. For this example we would end up with a "DIE" level and two MC
domains inside each node whether we have the PPTT table and cache
topology or not. I'm just wondering if everyone would be happy with
basing MC on last level cache instead of the smaller of physical package
and NUMA node.

> >>+{
> >>+	/* first determine if we are a NUMA in package */
> >>+	const cpumask_t *node_mask = cpumask_of_node(cpu_to_node(cpu));
> >>+	int indx;
> >>+
> >>+	if (!cpumask_subset(node_mask, &cpu_topology[cpu].core_sibling)) {
> >>+		/* not numa in package, lets use the package siblings */
> >>+		node_mask = &cpu_topology[cpu].core_sibling;
> >>+	}
> >>+
> >>+	/*
> >>+	 * node_mask should represent the smallest package/numa grouping
> >>+	 * lets search for the largest cache smaller than the node_mask.
> >>+	 */
> >>+	for (indx = 0; indx < MAX_CACHE_CHECKS; indx++) {
> >>+		cpumask_t *cache_sibs = &cpu_topology[cpu].cache_siblings[indx];
> >>+
> >>+		if (cpu_topology[cpu].cache_id[indx] < 0)
> >>+			continue;
> >>+
> >>+		if (cpumask_subset(cache_sibs, node_mask))
> >>+			cpu_topology[cpu].cache_level = indx;
> >
> >I don't this guarantees that the cache level we found matches exactly
> >the NUMA node. Taking the two cluster NUMA node example from above, we
> >would set cache_level to point at the per-cluster cache as it is a
> >subset of the NUMA node but it would only span half of the node. Or am I
> >missing something?
> 
> I think you got it. If the system is a traditional ARM system with shared
> L2's at the cluster level and it doesn't have any L3's/etc and the NUMA node
> crosses multiple clusters then you get the cluster L2 grouping in the MC.
> 
> I think this is what we want. Particularly, since the newer/larger machines
> do have L3+'s contained within their sockets or numa domains, so you end up
> with that as the MC.

Okay, thanks for confirming.

> 
> 
> >
> >>+	}
> >>+}
> >>+
> >>  const struct cpumask *cpu_coregroup_mask(int cpu)
> >>  {
> >>+	int *llc = &cpu_topology[cpu].cache_level;
> >>+
> >>+	if (*llc == -1)
> >>+		find_llc_topology_for_cpu(cpu);
> >>+
> >>+	if (*llc != -1)
> >>+		return &cpu_topology[cpu].cache_siblings[*llc];
> >>+
> >>  	return &cpu_topology[cpu].core_sibling;

If we don't have any of the cache_sibling masks set up, i.e. we don't
have the cache topology, we would keep looking for it every time
cpu_coregroup_mask() is called. I'm not sure how extensively it is used,
but it could have a performance impact?


> >>  }
> >>@@ -221,6 +255,7 @@ static void update_siblings_masks(unsigned int cpuid)
> >>  {
> >>  	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> >>  	int cpu;
> >>+	int idx;
> >>  	/* update core and thread sibling masks */
> >>  	for_each_possible_cpu(cpu) {
> >>@@ -229,6 +264,16 @@ static void update_siblings_masks(unsigned int cpuid)
> >>  		if (cpuid_topo->package_id != cpu_topo->package_id)
> >>  			continue;
> >>+		for (idx = 0; idx < MAX_CACHE_CHECKS; idx++) {
> >>+			cpumask_t *lsib;
> >>+			int cput_id = cpuid_topo->cache_id[idx];
> >>+
> >>+			if (cput_id == cpu_topo->cache_id[idx]) {
> >>+				lsib = &cpuid_topo->cache_siblings[idx];
> >>+				cpumask_set_cpu(cpu, lsib);
> >>+			}
> >
> >Shouldn't the cache_id validity be checked here? I don't think it breaks
> >anything though.
> 
> It could be, but since its explicitly looking for unified caches its likely
> that some of the levels are invalid. Invalid levels get ignored later on so
> we don't really care if they are valid here.
> 
> >
> >Overall, I think this is more or less in line with the MC domain
> >shrinking I just mentioned in the v6 discussion. It is mostly the corner
> >cases and assumption about the system topology I'm not sure about.
> 
> I think its the corner cases i'm taking care of. The simple fix in v6 is to
> take the smaller of core_siblings or node_siblings, but that ignores cases
> with split L3s (or the L2 only example above). The idea here is to assure
> that MC is following a cache topology. In my mind, it is more a question of
> how that is picked. The other way I see to do this, is with a PX domain flag
> in the PPTT. We could then pick the core grouping one below that flag. Doing
> it that way affords the firmware vendors a lever they can pull to optimize a
> given machine for the linux scheduler behavior.

Okay. I think these assumptions/choices should be spelled out somewhere,
either as comments or in the commit message. As said above, I'm not sure
if the simple approach is better or not.

Using the cache span to define the MC level with a numa-in-cluster
switch like some Intel platform seems to have, you could two core being
MC siblings with numa-in-package disabled and them not being siblings
with numa-in-package enabled unless you reconfigure the span of the
caches too and remember to update the ACPI cache topology.

Regarding firmware levers, we don't want vendors to optimize for Linux
scheduler behaviour, but a mechanism to detect how closely related cores
are could make selecting the right mask for MC level easier. As I see
it, we basically have to choose between MC being cache boundary based or
physical package based. This patch implements the former, the simple
solution (core_siblings mask or node_siblings mask) implements the
latter.

Morten
