Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754622AbeBGTEe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:04:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754062AbeBGTEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:04:33 -0500
Subject: Re: [v6,3/3] x86/smpboot: Fix __max_logical_packages estimate
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel <xen-devel@lists.xen.org>
References: <20171114124257.22013-4-prarit@redhat.com>
 <370a7ab2-8f57-b99b-428b-d0b1dfe401e7@invisiblethingslab.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Piotr Luc <piotr.luc@intel.com>, Kan Liang <kan.liang@intel.com>,
        Borislav Petkov <bp@suse.de>, Stephane Eranian <eranian@google.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        He Chen <he.chen@linux.intel.com>,
        Mathias Krause <minipli@googlemail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
From: Prarit Bhargava <prarit@redhat.com>
Message-ID: <6fdee802-bf24-7fbb-c95a-a6e0d840fbde@redhat.com>
Date: Wed, 7 Feb 2018 14:04:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <370a7ab2-8f57-b99b-428b-d0b1dfe401e7@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2018 01:44 PM, Simon Gaiser wrote:
> Prarit Bhargava:
>> A system booted with a small number of cores enabled per package
>> panics because the estimate of __max_logical_packages is too low.
>> This occurs when the total number of active cores across all packages
>> is less than the maximum core count for a single package.
>>
>> ie) On a 4 package system with 20 cores/package where only 4 cores
>> are enabled on each package, the value of __max_logical_packages is
>> calculated as DIV_ROUND_UP(16 / 20) = 1 and not 4.
>>
>> Calculate __max_logical_packages after the cpu enumeration has completed.
>> Use the boot cpu's data to extrapolate the number of packages.
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Piotr Luc <piotr.luc@intel.com>
>> Cc: Kan Liang <kan.liang@intel.com>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: Stephane Eranian <eranian@google.com>
>> Cc: Prarit Bhargava <prarit@redhat.com>
>> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: He Chen <he.chen@linux.intel.com>
>> Cc: Mathias Krause <minipli@googlemail.com>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kernel/smpboot.c | 55 +++++++++--------------------------------------
>>  1 file changed, 10 insertions(+), 45 deletions(-)
>>
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index 838d36ff7ba6..2e3c5a394e79 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -308,12 +308,6 @@ int topology_update_package_map(unsigned int pkg, unsigned int cpu)
>>  	if (new >= 0)
>>  		goto found;
>>  
>> -	if (logical_packages >= __max_logical_packages) {
>> -		pr_warn("Package %u of CPU %u exceeds BIOS package data %u.\n",
>> -			logical_packages, cpu, __max_logical_packages);
>> -		return -ENOSPC;
>> -	}
>> -
>>  	new = logical_packages++;
>>  	if (new != pkg)
>>  		pr_info("CPU %u Converting physical %u to logical package %u\n",
>> @@ -323,44 +317,6 @@ int topology_update_package_map(unsigned int pkg, unsigned int cpu)
>>  	return 0;
>>  }
>>  
>> -static void __init smp_init_package_map(struct cpuinfo_x86 *c, unsigned int cpu)
>> -{
>> -	unsigned int ncpus;
>> -
>> -	/*
>> -	 * Today neither Intel nor AMD support heterogenous systems. That
>> -	 * might change in the future....
>> -	 *
>> -	 * While ideally we'd want '* smp_num_siblings' in the below @ncpus
>> -	 * computation, this won't actually work since some Intel BIOSes
>> -	 * report inconsistent HT data when they disable HT.
>> -	 *
>> -	 * In particular, they reduce the APIC-IDs to only include the cores,
>> -	 * but leave the CPUID topology to say there are (2) siblings.
>> -	 * This means we don't know how many threads there will be until
>> -	 * after the APIC enumeration.
>> -	 *
>> -	 * By not including this we'll sometimes over-estimate the number of
>> -	 * logical packages by the amount of !present siblings, but this is
>> -	 * still better than MAX_LOCAL_APIC.
>> -	 *
>> -	 * We use total_cpus not nr_cpu_ids because nr_cpu_ids can be limited
>> -	 * on the command line leading to a similar issue as the HT disable
>> -	 * problem because the hyperthreads are usually enumerated after the
>> -	 * primary cores.
>> -	 */
>> -	ncpus = boot_cpu_data.x86_max_cores;
>> -	if (!ncpus) {
>> -		pr_warn("x86_max_cores == zero !?!?");
>> -		ncpus = 1;
>> -	}
>> -
>> -	__max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
>> -	pr_info("Max logical packages: %u\n", __max_logical_packages);
>> -
>> -	topology_update_package_map(c->phys_proc_id, cpu);
>> -}
>> -
>>  void __init smp_store_boot_cpu_info(void)
>>  {
>>  	int id = 0; /* CPU 0 */
>> @@ -368,7 +324,7 @@ void __init smp_store_boot_cpu_info(void)
>>  
>>  	*c = boot_cpu_data;
>>  	c->cpu_index = id;
>> -	smp_init_package_map(c, id);
>> +	topology_update_package_map(c->phys_proc_id, id);
>>  	cpu_data(id).set = 1;
>>  }
>>  
>> @@ -1371,7 +1327,16 @@ void __init native_smp_prepare_boot_cpu(void)
>>  
>>  void __init native_smp_cpus_done(unsigned int max_cpus)
>>  {
>> +	int ncpus;
>> +
>>  	pr_debug("Boot done\n");
>> +	/*
>> +	 * Today neither Intel nor AMD support heterogenous systems so
>> +	 * extrapolate the boot cpu's data to all packages.
>> +	 */
>> +	ncpus = cpu_data(0).booted_cores * smp_num_siblings;
>> +	__max_logical_packages = DIV_ROUND_UP(nr_cpu_ids, ncpus);
>> +	pr_info("Max logical packages: %u\n", __max_logical_packages);
>>  
>>  	if (x86_has_numa_in_package)
>>  		set_sched_topology(x86_numa_in_package_topology);
> 
> This breaks booting as Xen PV domain for me. The problem seems to be
> that native_smp_cpus_done() is never called on a PV domain. So
> __max_logical_packages is uninitialized and this leads to a NULL
> pointer dereference in coretemp.
> 

I'll see if I can figure out a way to test that.  Does 947134d9b00f
("x86/smpboot: Do not use smp_num_siblings in __max_logical_packages
calculation") help?

P.
