Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELv5eWnZUBwTdOmaNV0hN7pqbj3McPb4JEWENCV5bIq3NO+T5Ka0e9pu3yf3OerP4Sz9EJvl
ARC-Seal: i=1; a=rsa-sha256; t=1520439593; cv=none;
        d=google.com; s=arc-20160816;
        b=Uuqd98XT8v0xpeBYMJFEqgOEQqJjHrn0GFsD0agTiWniKbdFYhlUQeuS8aCI0nsIUl
         2itr8mxJCOz6LZCZdbcQ5HdMIGpyKw4hCgHS5kbAGYrF4uc0R4hrbNJlI8WQZRi4Sd/S
         +Zpf0vlgxUWftxJjk+9lqwlRC6qzKfloEcAUX4j7K1cJ+BBPp1FYTb4T6/fTHhQU8k9j
         2cLylc+88tOjqDVU2zWCUEpLcgeE/pm4Q5V1oJfMOtAhSI73IwZAjzNHZPQa7gc0uvnM
         IV5R3CTIv6DLn+VQvt/gprhsvkqQv/qnvbqV1wmGfkUPzuoW6CtVo8vHVJk0OmL8uOry
         wFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=fFu/DsgyZk6EC0j8hbQvG8m4rIO1xC+CTnEBc3AaoLM=;
        b=EUMXV5UtpziXAS/8tkQRFlFIKUNqnSDnbgjsvZBJhnqA35dCpZBspTVVAzE0owBRB1
         kDHbXPWsSRhPVafxKQ5nRTlHE7SedNGNA3QtYOCAqPO8tf66dha6K8+3EvXCa9PYuT9X
         8w7X0ZY402FjI06Mly3X7/XXWr1nGEfTQNXLzqEIjnqUZGyeEf0nzYR/a9S8M26/WAaO
         twssZVEmSdCyV5e2C4rrGtGyKDj2hwLE48LF7egTj/LHuPKhZ8bsBAIA3qZ/qAqS4l6l
         8PYHNrYuRax85RJ9vxeLT88yy7VpfTlrzXVJk0cJsqhcajuvKNvSJip/XAlcS3XrT4Hu
         jvbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Subject: Re: [PATCH v7 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mark.rutland@arm.com, vkilari@codeaurora.org, lorenzo.pieralisi@arm.com,
 catalin.marinas@arm.com, tnowicki@caviumnetworks.com,
 gregkh@linuxfoundation.org, will.deacon@arm.com, dietmar.eggemann@arm.com,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, ahs3@redhat.com,
 linux-acpi@vger.kernel.org, palmer@sifive.com, hanjun.guo@linaro.org,
 sudeep.holla@arm.com, austinwc@codeaurora.org,
 linux-riscv@lists.infradead.org, john.garry@huawei.com,
 wangxiongfeng2@huawei.com, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-14-jeremy.linton@arm.com>
 <20180301155216.GI4589@e105550-lin.cambridge.arm.com>
 <5d6bf4cf-2f6d-d123-f17f-d47d8e74c16c@arm.com>
 <20180306160721.GJ4589@e105550-lin.cambridge.arm.com>
 <8ac3567c-9fd8-4b0c-121c-287a027b5156@arm.com>
 <20180307130623.GK4589@e105550-lin.cambridge.arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <4e7fd404-fb7b-ee38-4a78-8ee091ae07cf@arm.com>
Date: Wed, 7 Mar 2018 10:19:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180307130623.GK4589@e105550-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684162193428124?=
X-GMAIL-MSGID: =?utf-8?q?1594296467761028754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 03/07/2018 07:06 AM, Morten Rasmussen wrote:
> On Tue, Mar 06, 2018 at 04:22:18PM -0600, Jeremy Linton wrote:
>>>>>> To do this correctly, we should really base that on the cache
>>>>>> topology immediately below the NUMA node (for NUMA in socket) >> or below the physical package for normal NUMA configurations.
>>>>>
>>>>> That means we wouldn't support multi-die NUMA nodes?
>>>>
>>>> You mean a bottom level NUMA domain that crosses multiple sockets/dies? That
>>>> should work. This patch is picking the widest cache layer below the smallest
>>>> of the package or numa grouping. What actually happens depends on the
>>>> topology. Given a case where there are multiple dies in a socket, and the
>>>> numa domain is at the socket level the MC is going to reflect the caching
>>>> topology immediately below the socket. In the case of multiple dies, with a
>>>> cache that crosses them in socket, then the MC is basically going to be the
>>>> socket, otherwise if the widest cache is per die, or some narrower grouping
>>>> (cluster?) then that is what ends up in the MC. (this is easier with some
>>>> pictures)
>>>
>>> That is more or less what I meant. I think I got confused with the role
>>> of "DIE" level, i.e. that top non-NUMA level, in this. The DIE level
>>> cpumask spans exactly the NUMA node, so IIUC we have three scenarios:
>>>
>>> 1. Multi-die/socket/physical package NUMA node
>>>     Top non-NUMA level (DIE) spans multiple packages. Bottom NUMA level
>>>     spans multiple multi-package nodes. The MC mask reflects the last-level
>>>     cache within the NUMA node which is most likely per-die or per-cluster
>>>     (inside each die).
>>>
>>> 2. physical package == NUMA node
>>>     The top non-NUMA (DIE) mask is the same as the core sibling mask.
>>>     If there is cache spanning the entire node, the scheduler topology
>>>     will eliminate a layer (DIE?), so bottom NUMA level would be right on
>>>     top of MC spanning multiple physical packages. If there is no
>>>     node-wide last level cache, DIE is preserved and MC matches the span
>>>     of the last level cache.
>>>
>>> 3. numa-in-package
>>>     Top non-NUMA (DIE) mask is not reflecting the actual die, but is
>>>     reflecting the NUMA node. MC has a span equal to the largest share
>>>     cache span smaller than or equal to the the NUMA node. If it is
>>>     equal, DIE level is eliminated, otherwise DIE is preserved, but
>>>     doesn't really represent die. Bottom non-NUMA level spans multiple
>>>     in-package NUMA nodes.
>>>
>>> As you said, multi-die nodes should work. However, I'm not sure if
>>> shrinking MC to match a cache could cause us trouble, or if it should
>>> just be shrunk to be the smaller of the node mask and core siblings.
>>
>> Shrinking to the smaller of the numa or package is fairly trivial change,
>> I'm good with that change too.. I discounted it because there might be an
>> advantage in case 2 if the internal hardware is actually a case 3 (or just
>> multiple rings/whatever each with a L3). In those cases the firmware vendor
>> could play around with whatever representation serves them the best.
> 
> Agreed. Distributed last level caches and interconnect speeds makes it
> virtually impossible to define MC in a way that works well for everyone
> based on the topology information we have at hand.
> 
>>
>>> Unless you have a node-wide last level cache DIE level won't be
>>> eliminated in scenario 2 and 3, and could cause trouble. For
>>> numa-in-package, you can end up with a DIE level inside the node where
>>> the default flags don't favour aggressive spreading of tasks. The same
>>> could be the case for per-package nodes (scenario 2).
>>>
>>> Don't we end up redefining physical package to be last level cache
>>> instead of using the PPTT flag for scenario 2 and 3?
>>
>> I'm not sure I understand, core_siblings isn't changing (its still per
>> package). Only the MC mapping which normally is just core_siblings. For all
>> intents right now this patch is the same as v6, except for the
>> numa-in-package where the MC domain is being shrunk to the node siblings.
>> I'm just trying to setup the code for potential future cases where the LLC
>> isn't equal to the node or package.
> 
> Right, core_siblings remains the same. The scheduler topology just looks
> a bit odd as we can have core_siblings spanning the full true physical
> package and have DIE level as a subset of that with an MC level where
> the MC siblings is a much smaller subset of cpus than core_siblings.
> 
> IOW, it would lead to having one topology used by the scheduler and
> another used by the users of topology_core_cpumask() (which is not
> many I think).
> 
> Is there a good reason for diverging instead of adjusting the
> core_sibling mask? On x86 the core_siblings mask is defined by the last
> level cache span so they don't have this issue.

I'm overwhelmingly convinced we are doing the right thing WRT the core 
siblings at the moment. Its exported to user space, and the general 
understanding is that its a socket. Even with numa in package/on die if 
you run lscpu, lstopo, etc... They all understand the system topology 
correctly doing it this way (AFAIK).
> 
> Yes. IIUC, MC is always equal to package or node on x86. They don't have
> DIE in their numa-in-package topology as MC is equal to the node.
> 
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>>   const struct cpumask *cpu_coregroup_mask(int cpu)
>>>>>>   {
>>>>>> +	int *llc = &cpu_topology[cpu].cache_level;
>>>>>> +
>>>>>> +	if (*llc == -1)
>>>>>> +		find_llc_topology_for_cpu(cpu);
>>>>>> +
>>>>>> +	if (*llc != -1)
>>>>>> +		return &cpu_topology[cpu].cache_siblings[*llc];
>>>>>> +
>>>>>>   	return &cpu_topology[cpu].core_sibling;
>>>
>>> If we don't have any of the cache_sibling masks set up, i.e. we don't
>>> have the cache topology, we would keep looking for it every time
>>> cpu_coregroup_mask() is called. I'm not sure how extensively it is used,
>>> but it could have a performance impact?
>>
>> Its only called when cores come online/offline (AFAIK).
> 
> Yes, it seems to only be used for sched_domain building. That can happen
> as part of creating/modifying cpusets as well, but I guess the overhead
> is less critical for all these case.
> 
>>
>>>
>>>
>>>>>>   }
>>>>>> @@ -221,6 +255,7 @@ static void update_siblings_masks(unsigned int cpuid)
>>>>>>   {
>>>>>>   	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
>>>>>>   	int cpu;
>>>>>> +	int idx;
>>>>>>   	/* update core and thread sibling masks */
>>>>>>   	for_each_possible_cpu(cpu) {
>>>>>> @@ -229,6 +264,16 @@ static void update_siblings_masks(unsigned int cpuid)
>>>>>>   		if (cpuid_topo->package_id != cpu_topo->package_id)
>>>>>>   			continue;
>>>>>> +		for (idx = 0; idx < MAX_CACHE_CHECKS; idx++) {
>>>>>> +			cpumask_t *lsib;
>>>>>> +			int cput_id = cpuid_topo->cache_id[idx];
>>>>>> +
>>>>>> +			if (cput_id == cpu_topo->cache_id[idx]) {
>>>>>> +				lsib = &cpuid_topo->cache_siblings[idx];
>>>>>> +				cpumask_set_cpu(cpu, lsib);
>>>>>> +			}
>>>>>
>>>>> Shouldn't the cache_id validity be checked here? I don't think it breaks
>>>>> anything though.
>>>>
>>>> It could be, but since its explicitly looking for unified caches its likely
>>>> that some of the levels are invalid. Invalid levels get ignored later on so
>>>> we don't really care if they are valid here.
>>>>
>>>>>
>>>>> Overall, I think this is more or less in line with the MC domain
>>>>> shrinking I just mentioned in the v6 discussion. It is mostly the corner
>>>>> cases and assumption about the system topology I'm not sure about.
>>>>
>>>> I think its the corner cases i'm taking care of. The simple fix in v6 is to
>>>> take the smaller of core_siblings or node_siblings, but that ignores cases
>>>> with split L3s (or the L2 only example above). The idea here is to assure
>>>> that MC is following a cache topology. In my mind, it is more a question of
>>>> how that is picked. The other way I see to do this, is with a PX domain flag
>>>> in the PPTT. We could then pick the core grouping one below that flag. Doing
>>>> it that way affords the firmware vendors a lever they can pull to optimize a
>>>> given machine for the linux scheduler behavior.
>>>
>>> Okay. I think these assumptions/choices should be spelled out somewhere,
>>> either as comments or in the commit message. As said above, I'm not sure
>>> if the simple approach is better or not.
>>>
>>> Using the cache span to define the MC level with a numa-in-cluster
>>> switch like some Intel platform seems to have, you could two core being
>>> MC siblings with numa-in-package disabled and them not being siblings
>>> with numa-in-package enabled unless you reconfigure the span of the
>>> caches too and remember to update the ACPI cache topology.
>>>
>>> Regarding firmware levers, we don't want vendors to optimize for Linux
>>> scheduler behaviour, but a mechanism to detect how closely related cores
>>> are could make selecting the right mask for MC level easier. As I see
>>> it, we basically have to choose between MC being cache boundary based or
>>> physical package based. This patch implements the former, the simple
>>> solution (core_siblings mask or node_siblings mask) implements the
>>> latter.
>>
>> Basically, right now (AFAIK) the result is the same because the few machines
>> I have access to have cache layers immediately below those boundaries which
>> are the same size as the package/die.
> 
> Agreed, I'm more worried about what vendors will built in the future.

Yes, and that is why I posted this rather than the code below, because I 
was leaving vendors a way to compensate for less regular machines.

> 
>> I'm ok with tossing this patch in favor of something like:
>>
>> const struct cpumask *cpu_coregroup_mask(int cpu)
>> {
>>     const cpumask_t *node_mask = cpumask_of_node(cpu_to_node(cpu));
>>     if (!cpumask_subset(node_mask, &cpu_topology[cpu].core_sibling)) 	
>>     {
>>        /* not numa in package, lets use the package siblings */
>>        return &cpu_topology[cpu].core_sibling;
>>     }
>>     return node_mask;
>> }
> 
> I would prefer this simpler solution as it should eliminate DIE level
> for all numa-in-package configurations. Although, I think we should consider
> just shrinking the core_sibling mask instead of having a difference MC
> mask (cpu_coregroup_mask). Do you see any problems in doing that?I'm 
My strongest opinion is leaning toward core_siblings being correct as it 
stands. How the scheduler deals with that is less clear. I will toss the 
above as a separate patch, and we can forget this one. I see dropping 
DIE as a larger patch set defining an arch specific scheduler topology 
and tweaking the individual scheduler level/flags/tuning. OTOH, unless 
there is something particularly creative there, I don't see how to avoid 
NUMA domains pushing deeper into the cache/system topology. Which means 
filling the MC layer (and possible others) similarly to the above snippit.


> 
>> Mostly, because I want to merge the PPTT parts, and I only added this to
>> clear the NUMA in package borken....
> 
> Understood. Whatever choice we make now to fix it will be with us
> potentially forever. So unless we have really good reason to do things
> differently, I would prefer to follow what other architectures do. I
> think the simple solution is closest to what x86 does.

Sure, that sounds familiar... ;)
