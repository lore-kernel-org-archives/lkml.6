Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZpzt0cjva1aaF6i8qep+/jLEZO+YMBpoKNxxXZ3PEymcmZyWLPk0q5X0RI/ZWLYiCpLm9nb
ARC-Seal: i=1; a=rsa-sha256; t=1525300377; cv=none;
        d=google.com; s=arc-20160816;
        b=lBKEu9Y/1+QkOMLpW5xG7IVDeiAWs9RIo+BKDkv/2js8lZJ3OSIkDgebBp610bmUSJ
         k6ucpOBO31nH8/VCeEu70PY3LDQN0QnEMrIXEenQncPPbSI0tKwKkFoluL2crDw311of
         V181b4FUMVraL3Vu7T0nQOhr+y5o0ePL/gV1ZPq6A+JYzHyOGET8xqhK9xi9iWUp6P/V
         W16KIM8uW2sP3zbpkLEGCi8RWNkTuzj3Av7CZs8dkepDUh4Zsq6PzTUpR01uEKfcs4Sq
         0rA1hDUGErZmjKBE36sc4sTZapOwzgx41UiSCAcp1vBPwYyrGlALGBEGqWt2o27sgOiU
         Cc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=zM7cg/RMMqxRR77f1MxBkiATQ929ErAhPXV/B1iWwbQ=;
        b=HsSztFMNeYkx/EgSUMgdpy+rDreizz29KElOwfWYogdjZsu5TyekMrNicu0xILrR0V
         mFXau3IKjlpv2AZKApJd7jXoYb9wc2qpBWS5OyDzGNz/wxuyb21K5Nd5/ciZKf5ZisR5
         8CYXEkYwbU9I9+D8SI9iugQXaqfJZZBWepW9Awh5bZZZIWj/o3WSe4NNiAiLEdMXaKYe
         5oUtpPu2BOI8DJHs6Ay7cVW7x/szcXiJ3uOMiyqKsXoQmixA2mgDCyApEbFYZzSmxBGh
         Fa6fwRduRCIirJO0lmoxTOj1Ql6NnZ0BwvQqiZrYm6nnMF/+y67dxgI6xtoZtXXcmseQ
         v9Ew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Subject: Re: [PATCH v8 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
To: Morten Rasmussen <morten.rasmussen@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, Mark.Rutland@arm.com,
 austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
 Catalin.Marinas@arm.com, palmer@sifive.com, Will.Deacon@arm.com,
 linux-riscv@lists.infradead.org, vkilari@codeaurora.org,
 Lorenzo.Pieralisi@arm.com, ahs3@redhat.com, lenb@kernel.org,
 john.garry@huawei.com, wangxiongfeng2@huawei.com, jhugo@qti.qualcomm.com,
 Dietmar.Eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, timur@qti.qualcomm.com, hanjun.guo@linaro.org
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-14-jeremy.linton@arm.com>
 <62677b95-faf5-4908-abc9-428ef39ea912@arm.com>
 <20180502114916.GW4589@e105550-lin.cambridge.arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <f3ec56a3-6352-5098-2e78-60f76a8b15b7@arm.com>
Date: Wed, 2 May 2018 17:32:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180502114916.GW4589@e105550-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766330955487456?=
X-GMAIL-MSGID: =?utf-8?q?1599393368418261271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/02/2018 06:49 AM, Morten Rasmussen wrote:
> On Tue, May 01, 2018 at 03:33:33PM +0100, Sudeep Holla wrote:
>>
>>
>> On 26/04/18 00:31, Jeremy Linton wrote:
>>> Now that we have an accurate view of the physical topology
>>> we need to represent it correctly to the scheduler. Generally MC
>>> should equal the LLC in the system, but there are a number of
>>> special cases that need to be dealt with.
>>>
>>> In the case of NUMA in socket, we need to assure that the sched
>>> domain we build for the MC layer isn't larger than the DIE above it.
>>> Similarly for LLC's that might exist in cross socket interconnect or
>>> directory hardware we need to assure that MC is shrunk to the socket
>>> or NUMA node.
>>>
>>> This patch builds a sibling mask for the LLC, and then picks the
>>> smallest of LLC, socket siblings, or NUMA node siblings, which
>>> gives us the behavior described above. This is ever so slightly
>>> different than the similar alternative where we look for a cache
>>> layer less than or equal to the socket/NUMA siblings.
>>>
>>> The logic to pick the MC layer affects all arm64 machines, but
>>> only changes the behavior for DT/MPIDR systems if the NUMA domain
>>> is smaller than the core siblings (generally set to the cluster).
>>> Potentially this fixes a possible bug in DT systems, but really
>>> it only affects ACPI systems where the core siblings is correctly
>>> set to the socket siblings. Thus all currently available ACPI
>>> systems should have MC equal to LLC, including the NUMA in socket
>>> machines where the LLC is partitioned between the NUMA nodes.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   arch/arm64/include/asm/topology.h |  2 ++
>>>   arch/arm64/kernel/topology.c      | 32 +++++++++++++++++++++++++++++++-
>>>   2 files changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
>>> index 6b10459e6905..df48212f767b 100644
>>> --- a/arch/arm64/include/asm/topology.h
>>> +++ b/arch/arm64/include/asm/topology.h
>>> @@ -8,8 +8,10 @@ struct cpu_topology {
>>>   	int thread_id;
>>>   	int core_id;
>>>   	int package_id;
>>> +	int llc_id;
>>>   	cpumask_t thread_sibling;
>>>   	cpumask_t core_sibling;
>>> +	cpumask_t llc_siblings;
>>>   };
>>>   
>>>   extern struct cpu_topology cpu_topology[NR_CPUS];
>>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>>> index bd1aae438a31..20b4341dc527 100644
>>> --- a/arch/arm64/kernel/topology.c
>>> +++ b/arch/arm64/kernel/topology.c
>>> @@ -13,6 +13,7 @@
>>>   
>>>   #include <linux/acpi.h>
>>>   #include <linux/arch_topology.h>
>>> +#include <linux/cacheinfo.h>
>>>   #include <linux/cpu.h>
>>>   #include <linux/cpumask.h>
>>>   #include <linux/init.h>
>>> @@ -214,7 +215,19 @@ EXPORT_SYMBOL_GPL(cpu_topology);
>>>   
>>>   const struct cpumask *cpu_coregroup_mask(int cpu)
>>>   {
>>> -	return &cpu_topology[cpu].core_sibling;
>>> +	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
>>> +
>>> +	/* Find the smaller of NUMA, core or LLC siblings */
>>> +	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
>>> +		/* not numa in package, lets use the package siblings */
>>> +		core_mask = &cpu_topology[cpu].core_sibling;
>>> +	}
>>> +	if (cpu_topology[cpu].llc_id != -1) {
>>> +		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
>>> +			core_mask = &cpu_topology[cpu].llc_siblings;
>>> +	}
>>> +
>>> +	return core_mask;
>>>   }
>>>   
>>>   static void update_siblings_masks(unsigned int cpuid)
>>> @@ -226,6 +239,9 @@ static void update_siblings_masks(unsigned int cpuid)
>>>   	for_each_possible_cpu(cpu) {
>>>   		cpu_topo = &cpu_topology[cpu];
>>>   
>>> +		if (cpuid_topo->llc_id == cpu_topo->llc_id)
>>> +			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
>>> +
>>
>> Would this not result in cpuid_topo->llc_siblings = cpu_possible_mask
>> on DT systems where llc_id is not set/defaults to -1 and still pass the
>> condition. Does it make sense to add additional -1 check ?
> 
> I don't think mask will be used by the current code if llc_id == -1 as
> the user does the check. Is it better to have the mask empty than
> default to cpu_possible_mask? If we require all users to implement a
> check it shouldn't matter.
> 

Right.

There is also the other way of thinking about it, which is if you remove 
the if llc_id == -1 check in cpu_coregroup_mask() does it make more 
sense to have llc_siblings default equal all the cores, or just the one 
being requested?
