Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeDQKYe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:24:34 -0400
Received: from foss.arm.com ([217.140.101.70]:40600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbeDQKYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:24:32 -0400
Date: Tue, 17 Apr 2018 11:24:24 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>, edubezval@gmail.com,
        kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20180417102424.GA27279@e107981-ln.cambridge.arm.com>
References: <20180416093747.GB4244@vireshk-i7>
 <4abf0d97-d2b8-46ab-3c05-4a11510ac3fe@linaro.org>
 <20180416095006.GC4244@vireshk-i7>
 <b0e7ff16-c947-89a0-6bd9-56ee9a76e7ad@linaro.org>
 <20180416101021.GD4244@vireshk-i7>
 <1c61128a-dea6-b12c-4cd8-ef53a5c8628d@linaro.org>
 <20180416123019.GA9341@e107981-ln.cambridge.arm.com>
 <633cdc63-ce6d-89af-26dd-bdc3a27556ed@linaro.org>
 <20180416142243.GB32565@red-moon>
 <845fafa3-f0ab-2050-fe32-1780dc61b8a8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845fafa3-f0ab-2050-fe32-1780dc61b8a8@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 09:17:36AM +0200, Daniel Lezcano wrote:

[...]

> >>>> Actually there is no impact with the change Sudeep is referring to. It
> >>>> is for ACPI, we are DT based. Confirmed with Jeremy.
> >>>>
> >>>> So AFAICT, it is not a problem.
> >>>
> >>> It is a problem - DT or ACPI alike. Sudeep was referring to the notion
> >>> of "cluster" that has no architectural meaning whatsoever and using
> >>> topology_physical_package_id() to detect a "cluster" was/is/will always
> >>> be the wrong thing to do. The notion of cluster must not appear in the
> >>> kernel at all, it has no architectural meaning. I understand you need
> >>> to group CPUs but that has to be done in a different way, through
> >>> cooling devices, thermal domains or power domains DT/ACPI bindings but
> >>> not by using topology masks.
> >>
> >> I don't get it. What is the cluster concept defined in the ARM
> >> documentation?
> >>
> >> ARM Cortex-A53 MPCore Processor Technical Reference Manual
> >>
> >> 4.5.2. Multiprocessor Affinity Register
> >>
> >> I see the documentation says:
> >>
> >> A cluster with two cores, three cores, ...
> >>
> >> How the kernel can represent that if you kill the
> >> topology_physical_package_id() ?
> > 
> > From an Arm ARM perspective (ARM v8 reference manual), the MPIDR_EL1 has
> > no notion of cluster which means that a cluster is not architecturally
> > defined on Arm systems.
> 
> Sorry, I'm lost :/ You say the MPIDR_EL1 has no notion of cluster but
> the documentation describing this register is all talking about cluster.
> 
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0500g/BABHBJCI.html

I pointed you at the documentation I am referring to. You are referring
to A53 TRM, I am referring to the Arm architecture reference manual that
is the reference for all Arm cores.

> > Currently, as Morten explained today, topology_physical_package_id()
> > is supposed to represent a "cluster" and that's completely wrong
> > because a "cluster" cannot be defined from an architectural perspective.
> > 
> > It was a bodge used as a shortcut, wrongly. We should have never used
> > that API for that purpose and there must be no code in the kernel
> > relying on:
> > 
> > topology_physical_package_id()
> > 
> > to define a cluster; the information you require to group CPUs must
> > come from something else, which is firmware bindings(DT or ACPI) as
> > I mentioned.
> 
> Why not ?

I explained why not :). A cluster is not defined architecturally on Arm
- it is as simple as that and you can't rely on a given MPIDR_EL1
subfield to define what a cluster id is.

> diff --git a/arch/arm64/include/asm/topology.h
> b/arch/arm64/include/asm/topology.h
> index c4f2d50..ac0776d 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -14,7 +14,8 @@ struct cpu_topology {
> 
>  extern struct cpu_topology cpu_topology[NR_CPUS];
> 
> -#define topology_physical_package_id(cpu)
> (cpu_topology[cpu].cluster_id)
> +#define topology_physical_package_id(cpu)      (0)
> +#define topology_physical_cluster_id(cpu)

There is no such a thing (and there is no architecturally defined
package id on Arm either).

> (cpu_topology[cpu].cluster_id)
>  #define topology_core_id(cpu)          (cpu_topology[cpu].core_id)
>  #define topology_core_cpumask(cpu)     (&cpu_topology[cpu].core_sibling)
>  #define topology_sibling_cpumask(cpu)  (&cpu_topology[cpu].thread_sibling)
> 
> 
> > Please speak to Sudeep who will fill you on the reasoning above.
> 
> Yes, Sudeep is next to me but I would prefer to keep the discussion on
> the mailing list so everyone can get the reasoning.

It is not a reasoning - it is the Arm architecture. There is no
architecturally defined cluster id on Arm. The affinity bits in
MPIDR_EL1 must be treated as a unique number that represents a given
core/thread, how the bits are allocated across affinity levels is not
something that you can rely on architecturally - that's why DT/ACPI
topology bindings exist to group cpus in a hierarchical topology.

HTH,
Lorenzo
