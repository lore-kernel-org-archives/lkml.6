Return-Path: <morten.rasmussen@arm.com>
X-Google-Smtp-Source: AB8JxZq2VBfY2+xdeVoubIbqnbZL8K7jtT7cMf7b0ThNfDhCqyIW3ftRGDZae76muPCSJGA0RnCf
ARC-Seal: i=1; a=rsa-sha256; t=1525346470; cv=none;
        d=google.com; s=arc-20160816;
        b=qw5h0DzG7zUty5eVvl4K8K0LuqsSDSPS62UyrVvDFx+Ka6KOvx/DZvgV++d4zgwpGU
         LYqeifLSxJbbMAco+g0RzNI96PdpPj4sTxnwdXZ0hq8uLzF76xJVnt7VqztSKLZWL9kw
         fvQ5vHInaWBpJKn2vRyk7SRyP7OIp/IlAb4CiC2azRTBTRZV4bLCvV+VVH1K/odiDe7f
         ZoISc+w7dcgAx05igkb3zyVPquC4WlJ4E0vDNabq99/I9usJvzNf1oY67TfAZYx4E/du
         AvHTz816N/y8kAbAqusJ4CjR+8CSFz0V/MAtj2FOXJN70Bs/WZcsn4tCEGhohg9RJ4T/
         sXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=wOudpEKgiQV79x8oJ2sXTC7v2FSbj6d/l7v26sBNaIA=;
        b=zkffgJec7ovV+aXEbyrYK2IaKS++srqvd4iymN5sAr2CYcbSWyznqVBRXzQp/bEjZ5
         8g/Rn0T18g6BPQeRQ472RhWFOC9fDZnIGzgE44lsmRSUYlkzC0AGomV/s6Wat7K7jbaf
         4ncl+MYdKvXNEydNZRV9yseTbFRil4CYYY1YYMPTEUQXKQbh2L94s3Cs2zyRRzdipyyy
         +Z3HvsFabVuP4V9sMQBflvpce4c7ACJm7r93Jg+J15v9CJ+3zb6Qnx9RnYrqDRV7IOJ3
         h/ejioP7VahSJ46d03aLr7jAwaoGdl7DLDtbUdI3RY66itar8dwt8K760IoBwMjszj04
         rIeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Date: Thu, 3 May 2018 12:20:52 +0100
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
	Mark.Rutland@arm.com, austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com, Catalin.Marinas@arm.com,
	palmer@sifive.com, Will.Deacon@arm.com,
	linux-riscv@lists.infradead.org, vkilari@codeaurora.org,
	Lorenzo.Pieralisi@arm.com, ahs3@redhat.com, lenb@kernel.org,
	john.garry@huawei.com, wangxiongfeng2@huawei.com,
	jhugo@qti.qualcomm.com, Dietmar.Eggemann@arm.com,
	linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org,
	gregkh@linuxfoundation.org, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, timur@qti.qualcomm.com,
	hanjun.guo@linaro.org
Subject: Re: [PATCH v8 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
Message-ID: <20180503112052.GA28409@work-enc>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-14-jeremy.linton@arm.com>
 <62677b95-faf5-4908-abc9-428ef39ea912@arm.com>
 <20180502114916.GW4589@e105550-lin.cambridge.arm.com>
 <f3ec56a3-6352-5098-2e78-60f76a8b15b7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ec56a3-6352-5098-2e78-60f76a8b15b7@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766330955487456?=
X-GMAIL-MSGID: =?utf-8?q?1599441700946259482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 05:32:54PM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 05/02/2018 06:49 AM, Morten Rasmussen wrote:
> >On Tue, May 01, 2018 at 03:33:33PM +0100, Sudeep Holla wrote:
> >>
> >>
> >>On 26/04/18 00:31, Jeremy Linton wrote:
> >>>Now that we have an accurate view of the physical topology
> >>>we need to represent it correctly to the scheduler. Generally MC
> >>>should equal the LLC in the system, but there are a number of
> >>>special cases that need to be dealt with.
> >>>
> >>>In the case of NUMA in socket, we need to assure that the sched
> >>>domain we build for the MC layer isn't larger than the DIE above it.
> >>>Similarly for LLC's that might exist in cross socket interconnect or
> >>>directory hardware we need to assure that MC is shrunk to the socket
> >>>or NUMA node.
> >>>
> >>>This patch builds a sibling mask for the LLC, and then picks the
> >>>smallest of LLC, socket siblings, or NUMA node siblings, which
> >>>gives us the behavior described above. This is ever so slightly
> >>>different than the similar alternative where we look for a cache
> >>>layer less than or equal to the socket/NUMA siblings.
> >>>
> >>>The logic to pick the MC layer affects all arm64 machines, but
> >>>only changes the behavior for DT/MPIDR systems if the NUMA domain
> >>>is smaller than the core siblings (generally set to the cluster).
> >>>Potentially this fixes a possible bug in DT systems, but really
> >>>it only affects ACPI systems where the core siblings is correctly
> >>>set to the socket siblings. Thus all currently available ACPI
> >>>systems should have MC equal to LLC, including the NUMA in socket
> >>>machines where the LLC is partitioned between the NUMA nodes.
> >>>
> >>>Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >>>---
> >>>  arch/arm64/include/asm/topology.h |  2 ++
> >>>  arch/arm64/kernel/topology.c      | 32 +++++++++++++++++++++++++++++++-
> >>>  2 files changed, 33 insertions(+), 1 deletion(-)
> >>>
> >>>diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> >>>index 6b10459e6905..df48212f767b 100644
> >>>--- a/arch/arm64/include/asm/topology.h
> >>>+++ b/arch/arm64/include/asm/topology.h
> >>>@@ -8,8 +8,10 @@ struct cpu_topology {
> >>>  	int thread_id;
> >>>  	int core_id;
> >>>  	int package_id;
> >>>+	int llc_id;
> >>>  	cpumask_t thread_sibling;
> >>>  	cpumask_t core_sibling;
> >>>+	cpumask_t llc_siblings;
> >>>  };
> >>>  extern struct cpu_topology cpu_topology[NR_CPUS];
> >>>diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> >>>index bd1aae438a31..20b4341dc527 100644
> >>>--- a/arch/arm64/kernel/topology.c
> >>>+++ b/arch/arm64/kernel/topology.c
> >>>@@ -13,6 +13,7 @@
> >>>  #include <linux/acpi.h>
> >>>  #include <linux/arch_topology.h>
> >>>+#include <linux/cacheinfo.h>
> >>>  #include <linux/cpu.h>
> >>>  #include <linux/cpumask.h>
> >>>  #include <linux/init.h>
> >>>@@ -214,7 +215,19 @@ EXPORT_SYMBOL_GPL(cpu_topology);
> >>>  const struct cpumask *cpu_coregroup_mask(int cpu)
> >>>  {
> >>>-	return &cpu_topology[cpu].core_sibling;
> >>>+	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
> >>>+
> >>>+	/* Find the smaller of NUMA, core or LLC siblings */
> >>>+	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
> >>>+		/* not numa in package, lets use the package siblings */
> >>>+		core_mask = &cpu_topology[cpu].core_sibling;
> >>>+	}
> >>>+	if (cpu_topology[cpu].llc_id != -1) {
> >>>+		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
> >>>+			core_mask = &cpu_topology[cpu].llc_siblings;
> >>>+	}
> >>>+
> >>>+	return core_mask;
> >>>  }
> >>>  static void update_siblings_masks(unsigned int cpuid)
> >>>@@ -226,6 +239,9 @@ static void update_siblings_masks(unsigned int cpuid)
> >>>  	for_each_possible_cpu(cpu) {
> >>>  		cpu_topo = &cpu_topology[cpu];
> >>>+		if (cpuid_topo->llc_id == cpu_topo->llc_id)
> >>>+			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
> >>>+
> >>
> >>Would this not result in cpuid_topo->llc_siblings = cpu_possible_mask
> >>on DT systems where llc_id is not set/defaults to -1 and still pass the
> >>condition. Does it make sense to add additional -1 check ?
> >
> >I don't think mask will be used by the current code if llc_id == -1 as
> >the user does the check. Is it better to have the mask empty than
> >default to cpu_possible_mask? If we require all users to implement a
> >check it shouldn't matter.
> >
> 
> Right.
> 
> There is also the other way of thinking about it, which is if you remove the
> if llc_id == -1 check in cpu_coregroup_mask() does it make more sense to
> have llc_siblings default equal all the cores, or just the one being
> requested?

Since we define cpu_coregroup_mask() to be the smallest of LLC, package,
and NUMA node, letting it default to just one cpu would change/break the
topology on non-PPTT systems. Wouldn't it?

If we want to drop the check llc_siblings should be default to either
core_siblings or cpumask_of_node(). But I don't really see the point as
any user of llc_siblings that really care about where the LLC is
would have to check if llc_sibling is just assigned a default value or
it is indeed representing the LLC. I'm fine with just expecting the user
to check llc_id to see if the llc_sibling mask is valid or not.
