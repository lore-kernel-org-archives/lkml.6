Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE68C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A17C21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfBSQ46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:56:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:58324 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfBSQ46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:56:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 08:56:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="321621624"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 19 Feb 2019 08:56:57 -0800
Received: from [10.254.80.103] (kliang2-mobl1.ccr.corp.intel.com [10.254.80.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9AA82580310;
        Tue, 19 Feb 2019 08:56:56 -0800 (PST)
Subject: Re: [PATCH 05/11] x86 topology: export die_siblings
To:     Len Brown <lenb@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <0d54a56186fb9be7a8f622a4625a41dc600dd7a4.1550545163.git.len.brown@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <59e07a24-dc44-c21b-91d4-ea04e8d0653e@linux.intel.com>
Date:   Tue, 19 Feb 2019 11:56:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0d54a56186fb9be7a8f622a4625a41dc600dd7a4.1550545163.git.len.brown@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2019 10:40 PM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> like core_siblings, except it shows which die are in the same package.
> 
> This is needed for lscpu(1) to correctly display die topology.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>   Documentation/cputopology.txt   | 10 ++++++++++
>   arch/x86/include/asm/smp.h      |  1 +
>   arch/x86/include/asm/topology.h |  1 +
>   arch/x86/kernel/smpboot.c       | 20 ++++++++++++++++++++
>   arch/x86/xen/smp_pv.c           |  1 +
>   drivers/base/topology.c         |  6 ++++++
>   include/linux/topology.h        |  3 +++
>   7 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
> index 287213b4517b..7dd2ae3df233 100644
> --- a/Documentation/cputopology.txt
> +++ b/Documentation/cputopology.txt
> @@ -56,6 +56,16 @@ core_siblings_list:
>   	human-readable list of cpuX's hardware threads within the same
>   	die_id.
>   
> +die_siblings:
> +
> +	internal kernel map of cpuX's hardware threads within the same
> +	physical_package_id.
> +
> +die_siblings_list:
> +
> +	human-readable list of cpuX's hardware threads within the same
> +	physical_package_id.
> +
>   book_siblings:
>   
>   	internal kernel map of cpuX's hardware threads within the same
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 2e95b6c1bca3..39266d193597 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -23,6 +23,7 @@ extern unsigned int num_processors;
>   
>   DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
>   DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
> +DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
>   /* cpus sharing the last level cache: */
>   DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
>   DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 281be6bbc80d..a52a572147ba 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -110,6 +110,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
>   #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
>   
>   #ifdef CONFIG_SMP
> +#define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
>   #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))

Could you please update the document regarding to topology_die_cpumask 
and topology_core_cpumask in Documentation/x86/topology.txt

Thanks,
Kan

>   #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
>   
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 4250a87f57db..42d37e4a1918 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -90,6 +90,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
>   DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
>   EXPORT_PER_CPU_SYMBOL(cpu_core_map);
>   
> +/* representing HT and core and die siblings of each logical CPU */
> +DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
> +EXPORT_PER_CPU_SYMBOL(cpu_die_map);
> +
>   DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
>   
>   /* Per CPU bogomips and other parameters */
> @@ -461,6 +465,12 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>    * multicore group inside a NUMA node.  If this happens, we will
>    * discard the MC level of the topology later.
>    */
> +static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
> +{
> +	if (c->phys_proc_id == o->phys_proc_id)
> +		return true;
> +	return false;
> +}
>   static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>   {
>   	if (c->cpu_die_id == o->cpu_die_id)
> @@ -530,6 +540,7 @@ void set_cpu_sibling_map(int cpu)
>   		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
>   		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
>   		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
> +		cpumask_set_cpu(cpu, topology_die_cpumask(cpu));
>   		c->booted_cores = 1;
>   		return;
>   	}
> @@ -576,8 +587,12 @@ void set_cpu_sibling_map(int cpu)
>   			} else if (i != cpu && !c->booted_cores)
>   				c->booted_cores = cpu_data(i).booted_cores;
>   		}
> +
>   		if (match_die(c, o) && !topology_same_node(c, o))
>   			x86_has_numa_in_package = true;
> +
> +		if ((i == cpu) || (has_mp && match_pkg(c, o)))
> +			link_mask(topology_die_cpumask, cpu, i);
>   	}
>   
>   	threads = cpumask_weight(topology_sibling_cpumask(cpu));
> @@ -1173,6 +1188,7 @@ static __init void disable_smp(void)
>   		physid_set_mask_of_physid(0, &phys_cpu_present_map);
>   	cpumask_set_cpu(0, topology_sibling_cpumask(0));
>   	cpumask_set_cpu(0, topology_core_cpumask(0));
> +	cpumask_set_cpu(0, topology_die_cpumask(0));
>   }
>   
>   /*
> @@ -1268,6 +1284,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
>   	for_each_possible_cpu(i) {
>   		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
>   		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
> +		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
>   		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
>   	}
>   
> @@ -1488,6 +1505,8 @@ static void remove_siblinginfo(int cpu)
>   			cpu_data(sibling).booted_cores--;
>   	}
>   
> +	for_each_cpu(sibling, topology_die_cpumask(cpu))
> +		cpumask_clear_cpu(cpu, topology_die_cpumask(sibling));
>   	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
>   		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
>   	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
> @@ -1495,6 +1514,7 @@ static void remove_siblinginfo(int cpu)
>   	cpumask_clear(cpu_llc_shared_mask(cpu));
>   	cpumask_clear(topology_sibling_cpumask(cpu));
>   	cpumask_clear(topology_core_cpumask(cpu));
> +	cpumask_clear(topology_die_cpumask(cpu));
>   	c->cpu_core_id = 0;
>   	c->booted_cores = 0;
>   	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
> diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
> index 145506f9fdbe..ac13b0be8448 100644
> --- a/arch/x86/xen/smp_pv.c
> +++ b/arch/x86/xen/smp_pv.c
> @@ -251,6 +251,7 @@ static void __init xen_pv_smp_prepare_cpus(unsigned int max_cpus)
>   	for_each_possible_cpu(i) {
>   		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
>   		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
> +		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
>   		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
>   	}
>   	set_cpu_sibling_map(0);
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 50352cf96f85..5b1317ae3262 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -57,6 +57,10 @@ define_siblings_show_func(core_siblings, core_cpumask);
>   static DEVICE_ATTR_RO(core_siblings);
>   static DEVICE_ATTR_RO(core_siblings_list);
>   
> +define_siblings_show_func(die_siblings, die_cpumask);
> +static DEVICE_ATTR_RO(die_siblings);
> +static DEVICE_ATTR_RO(die_siblings_list);
> +
>   #ifdef CONFIG_SCHED_BOOK
>   define_id_show_func(book_id);
>   static DEVICE_ATTR_RO(book_id);
> @@ -81,6 +85,8 @@ static struct attribute *default_attrs[] = {
>   	&dev_attr_thread_siblings_list.attr,
>   	&dev_attr_core_siblings.attr,
>   	&dev_attr_core_siblings_list.attr,
> +	&dev_attr_die_siblings.attr,
> +	&dev_attr_die_siblings_list.attr,
>   #ifdef CONFIG_SCHED_BOOK
>   	&dev_attr_book_id.attr,
>   	&dev_attr_book_siblings.attr,
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 5cc8595dd0e4..47a3e3c08036 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -196,6 +196,9 @@ static inline int cpu_to_mem(int cpu)
>   #ifndef topology_core_cpumask
>   #define topology_core_cpumask(cpu)		cpumask_of(cpu)
>   #endif
> +#ifndef topology_die_cpumask
> +#define topology_die_cpumask(cpu)		cpumask_of(cpu)
> +#endif
>   
>   #ifdef CONFIG_SCHED_SMT
>   static inline const struct cpumask *cpu_smt_mask(int cpu)
> 
