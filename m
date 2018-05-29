Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967406AbeE2VwK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:52:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48228 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966304AbeE2VwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:52:07 -0400
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>, austinwc@codeaurora.org,
        tnowicki@caviumnetworks.com, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, Morten.Rasmussen@arm.com,
        vkilari@codeaurora.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        jhugo@codeaurora.org, Al Stone <ahs3@redhat.com>,
        Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>,
        wangxiongfeng2@huawei.com, Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
 <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com>
 <CAMuHMdXgiMeD4uF+j8W+CpNwYYK2W_8xqk_=vGBiW=bUvKeq7w@mail.gmail.com>
 <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com>
 <20180529150823.GD17159@arm.com>
 <CAMuHMdU0yET6+-FfS8e9HJdKB7h0gDn7kzWGpJZV=UiWn5fLkA@mail.gmail.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <a79f5acc-51f2-cd7c-5abf-c7c1df8064a1@arm.com>
Date: Tue, 29 May 2018 16:52:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU0yET6+-FfS8e9HJdKB7h0gDn7kzWGpJZV=UiWn5fLkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/29/2018 10:51 AM, Geert Uytterhoeven wrote:
> Hi Will,
> 
> On Tue, May 29, 2018 at 5:08 PM, Will Deacon <will.deacon@arm.com> wrote:
>> On Tue, May 29, 2018 at 02:18:40PM +0100, Sudeep Holla wrote:
>>> On 29/05/18 12:56, Geert Uytterhoeven wrote:
>>>> On Tue, May 29, 2018 at 1:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>>> On 29/05/18 11:48, Geert Uytterhoeven wrote:
>>>>>> System supend still works fine on systems with big cores only:
>>>>>>
>>>>>>      R-Car H3 ES1.0 (4xCA57 (4xCA53 disabled in firmware))
>>>>>>      R-Car M3-N (2xCA57)
>>>>>>
>>>>>> Reverting this commit fixes the issue for me.
>>>>>
>>>>> I can't find anything that relates to system suspend in these patches
>>>>> unless they are messing with something during CPU hot plug-in back
>>>>> during resume.
>>>>
>>>> It's only the last patch that introduces the breakage.
>>>>
>>>
>>> As specified in the commit log, it won't change any behavior for DT
>>> systems if it's non-NUMA or single node system. So I am still wondering
>>> what could trigger this regression.
>>
>> I wonder if we're somehow giving an uninitialised/invalid NUMA configuration
>> to the scheduler, although I can't see how this would happen.
>>
>> Geert -- if you enable CONFIG_DEBUG_PER_CPU_MAPS=y and apply the diff below
>> do you see anything shouting in dmesg?
> 
> Thanks, but unfortunately it doesn't help.
> I added some debug code to print cpumask, but so far I don't see anything
> suspicious.

I suspect most of the problem is related to the node mask changing at 
unexpected times (particularly cores being removed from the mask). Once 
I understand that more, there may be a simpler patch.

OTOH, I've been testing with this, and with it, I can't seem to 
duplicate the problem with CONFIG_NUMA disabled I found.

diff --git a/arch/arm64/include/asm/topology.h 
b/arch/arm64/include/asm/topology.h
index df48212f767b..7450ef5ed733 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -12,6 +12,7 @@ struct cpu_topology {
         cpumask_t thread_sibling;
         cpumask_t core_sibling;
         cpumask_t llc_siblings;
+       cpumask_t node_siblings; /* maintain a stable node sibling list */
  };

  extern struct cpu_topology cpu_topology[NR_CPUS];
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f3e2e3aec0b0..f4eb80852d78 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -677,8 +677,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
         init_cpu_topology();

         this_cpu = smp_processor_id();
-       store_cpu_topology(this_cpu);
         numa_store_cpu_info(this_cpu);
+       store_cpu_topology(this_cpu);
+

         /*
          * If UP is mandated by "nosmp" (which implies "maxcpus=0"), 
don't set
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 7415c166281f..6819c764537d 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -215,7 +215,7 @@ EXPORT_SYMBOL_GPL(cpu_topology);

  const struct cpumask *cpu_coregroup_mask(int cpu)
  {
-       const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
+       const cpumask_t *core_mask = &cpu_topology[cpu].node_siblings;

         /* Find the smaller of NUMA, core or LLC siblings */
         if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
@@ -233,12 +233,16 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
  static void update_siblings_masks(unsigned int cpuid)
  {
         struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
+       int node = cpu_to_node(cpuid);
         int cpu;

         /* update core and thread sibling masks */
         for_each_possible_cpu(cpu) {
                 cpu_topo = &cpu_topology[cpu];

+               if (cpu_to_node(cpu) == node)
+                       cpumask_set_cpu(cpu, &cpu_topo->node_siblings);
+
                 if (cpuid_topo->llc_id == cpu_topo->llc_id)
                         cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);

@@ -311,6 +315,9 @@ static void __init reset_cpu_topology(void)
                 cpumask_clear(&cpu_topo->llc_siblings);
                 cpumask_set_cpu(cpu, &cpu_topo->llc_siblings);

+               cpumask_clear(&cpu_topo->node_siblings);
+               cpumask_set_cpu(cpu, &cpu_topo->node_siblings);
+
                 cpumask_clear(&cpu_topo->core_sibling);
                 cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
                 cpumask_clear(&cpu_topo->thread_sibling);
-- 
2.14.3
