Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZoAwjKI/9dc0GotN9z0sak0gRbxlbBrOMQLUXEH5iiWI02mfKhThZTmtPa9Wjqk5PBdT67/
ARC-Seal: i=1; a=rsa-sha256; t=1525300456; cv=none;
        d=google.com; s=arc-20160816;
        b=TunaJ85agadx6B4MkGPW0whY8SYmNdNd/5gySWpHavoNMoGAttnLfwlA2CclXdpVCl
         WPQ03nTE1GOTVCBLyd7T+0hVFv/pz4I5a9urWxRNLRu7lTTP2AA0f/FyruxkbCgQ0ANf
         XRd9QrbeT8sxLoDw6qeADs5IU6SBAmvvv5CCS/pYsYfEOvfYznczTuAQ0wOaMIfw8qBO
         znEOu5QOQ7IKLBhdPeWTgQua5Zd1jmzlc20/+b6GuXFIs6hKapyTR0xCpvxrrbqoW+kQ
         RMLaY3b+gT+X+BhyjmGJrbFjoHmmqceGqHWWmfx9iDYNd8k/t/+yxxvzXN567lWVVhhr
         ZAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=y7/gVt8SNcJEdqtb/pcMwkt/pZSNocCi5k3isLKE/I0=;
        b=QURMaywvO/RAuvRuy0eKIClxBADtk+mdewKsUGQADTdk2VrROUgpTaWo8uW0HVGoq4
         zIv7j1LteW/LYCirLneT0+CLRM9pN8FK9UY9YCRT1OkuTqcHi9Rl7Qcoj/PVoAIEViZp
         IEIfllDonAyhngpFSF8mQK9zPshuJhCS+wEDUOdv8nJB3ruhpjaMkIHfVNiDJCjXsKzL
         /zWY5IEpAPwt9pB3/ehkvn0lrWvsVkHEJNnN3AONBCWcEwWxkWfyiwLZfU7CpjqiLXMO
         ffOALZ8ZGkD5qEDlP2JqD03/4HYghDVtjsJTbqB2sqEhs2Tuk+bdksxDfuGsM08vE+RI
         Sijw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Subject: Re: [PATCH v8 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
 Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
 ard.biesheuvel@linaro.org
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-14-jeremy.linton@arm.com>
 <62677b95-faf5-4908-abc9-428ef39ea912@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <ed84bec0-ad34-4536-9b99-3a7e752ee44a@arm.com>
Date: Wed, 2 May 2018 17:34:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <62677b95-faf5-4908-abc9-428ef39ea912@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766330955487456?=
X-GMAIL-MSGID: =?utf-8?q?1599393452252916169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Thanks for taking a look at this.

On 05/01/2018 09:33 AM, Sudeep Holla wrote:
> 
> 
> On 26/04/18 00:31, Jeremy Linton wrote:
>> Now that we have an accurate view of the physical topology
>> we need to represent it correctly to the scheduler. Generally MC
>> should equal the LLC in the system, but there are a number of
>> special cases that need to be dealt with.
>>
>> In the case of NUMA in socket, we need to assure that the sched
>> domain we build for the MC layer isn't larger than the DIE above it.
>> Similarly for LLC's that might exist in cross socket interconnect or
>> directory hardware we need to assure that MC is shrunk to the socket
>> or NUMA node.
>>
>> This patch builds a sibling mask for the LLC, and then picks the
>> smallest of LLC, socket siblings, or NUMA node siblings, which
>> gives us the behavior described above. This is ever so slightly
>> different than the similar alternative where we look for a cache
>> layer less than or equal to the socket/NUMA siblings.
>>
>> The logic to pick the MC layer affects all arm64 machines, but
>> only changes the behavior for DT/MPIDR systems if the NUMA domain
>> is smaller than the core siblings (generally set to the cluster).
>> Potentially this fixes a possible bug in DT systems, but really
>> it only affects ACPI systems where the core siblings is correctly
>> set to the socket siblings. Thus all currently available ACPI
>> systems should have MC equal to LLC, including the NUMA in socket
>> machines where the LLC is partitioned between the NUMA nodes.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/include/asm/topology.h |  2 ++
>>   arch/arm64/kernel/topology.c      | 32 +++++++++++++++++++++++++++++++-
>>   2 files changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
>> index 6b10459e6905..df48212f767b 100644
>> --- a/arch/arm64/include/asm/topology.h
>> +++ b/arch/arm64/include/asm/topology.h
>> @@ -8,8 +8,10 @@ struct cpu_topology {
>>   	int thread_id;
>>   	int core_id;
>>   	int package_id;
>> +	int llc_id;
>>   	cpumask_t thread_sibling;
>>   	cpumask_t core_sibling;
>> +	cpumask_t llc_siblings;
>>   };
>>   
>>   extern struct cpu_topology cpu_topology[NR_CPUS];
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index bd1aae438a31..20b4341dc527 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -13,6 +13,7 @@
>>   
>>   #include <linux/acpi.h>
>>   #include <linux/arch_topology.h>
>> +#include <linux/cacheinfo.h>
>>   #include <linux/cpu.h>
>>   #include <linux/cpumask.h>
>>   #include <linux/init.h>
>> @@ -214,7 +215,19 @@ EXPORT_SYMBOL_GPL(cpu_topology);
>>   
>>   const struct cpumask *cpu_coregroup_mask(int cpu)
>>   {
>> -	return &cpu_topology[cpu].core_sibling;
>> +	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
>> +
>> +	/* Find the smaller of NUMA, core or LLC siblings */
>> +	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
>> +		/* not numa in package, lets use the package siblings */
>> +		core_mask = &cpu_topology[cpu].core_sibling;
>> +	}
>> +	if (cpu_topology[cpu].llc_id != -1) {
>> +		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
>> +			core_mask = &cpu_topology[cpu].llc_siblings;
>> +	}
>> +
>> +	return core_mask;
>>   }
>>   
>>   static void update_siblings_masks(unsigned int cpuid)
>> @@ -226,6 +239,9 @@ static void update_siblings_masks(unsigned int cpuid)
>>   	for_each_possible_cpu(cpu) {
>>   		cpu_topo = &cpu_topology[cpu];
>>   
>> +		if (cpuid_topo->llc_id == cpu_topo->llc_id)
>> +			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
>> +
> 
> Would this not result in cpuid_topo->llc_siblings = cpu_possible_mask
> on DT systems where llc_id is not set/defaults to -1 and still pass the
> condition. Does it make sense to add additional -1 check ?
(see comment in Morton's thread)

> 
>>   		if (cpuid_topo->package_id != cpu_topo->package_id)
>>   			continue;
>>   
>> @@ -291,6 +307,10 @@ static void __init reset_cpu_topology(void)
>>   		cpu_topo->core_id = 0;
>>   		cpu_topo->package_id = -1;
>>   
>> +		cpu_topo->llc_id = -1;
>> +		cpumask_clear(&cpu_topo->llc_siblings);
>> +		cpumask_set_cpu(cpu, &cpu_topo->llc_siblings);
>> +
>>   		cpumask_clear(&cpu_topo->core_sibling);
>>   		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
>>   		cpumask_clear(&cpu_topo->thread_sibling);
>> @@ -311,6 +331,8 @@ static int __init parse_acpi_topology(void)
>>   	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
>>   
>>   	for_each_possible_cpu(cpu) {
>> +		int i;
>> +
>>   		topology_id = find_acpi_cpu_topology(cpu, 0);
>>   		if (topology_id < 0)
>>   			return topology_id;
>> @@ -325,6 +347,14 @@ static int __init parse_acpi_topology(void)
>>   		}
>>   		topology_id = find_acpi_cpu_topology_package(cpu);
>>   		cpu_topology[cpu].package_id = topology_id;
>> +
>> +		i = acpi_find_last_cache_level(cpu);
>> +
>> +		if (i > 0) {
>> +			topology_id = find_acpi_cpu_cache_topology(cpu, i);
>> +			if (topology_id > 0)
>> +				cpu_topology[cpu].llc_id = topology_id;
>> +		}
> 
> [nit] s/topology_id/cache_id/ or s/topology_id/cache_topology_id/ ?

Sure.

> 
> Otherwise looks fine to me. You can add with above things fixed.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 

Thanks,
