Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeBHMdB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:33:01 -0500
Received: from foss.arm.com ([217.140.101.70]:34468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbeBHMdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:33:00 -0500
Subject: Re: [PATCH v2 16/20] arm64: Handle shared capability entries
To: Dave Martin <Dave.Martin@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-17-suzuki.poulose@arm.com>
 <20180207103934.GG5862@e103592.cambridge.arm.com>
 <831ad839-3c68-fc1e-d578-f951b46ed6ed@arm.com>
 <20180208120114.GX5862@e103592.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c10b7441-4643-4277-c6fc-a205f3687673@arm.com>
Date: Thu, 8 Feb 2018 12:32:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208120114.GX5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/18 12:01, Dave Martin wrote:
> On Thu, Feb 08, 2018 at 10:53:52AM +0000, Suzuki K Poulose wrote:
>> On 07/02/18 10:39, Dave Martin wrote:
>>> On Wed, Jan 31, 2018 at 06:28:03PM +0000, Suzuki K Poulose wrote:
>>>> Some capabilities have different criteria for detection and associated
>>>> actions based on the matching criteria, even though they all share the
>>>> same capability bit. So far we have used multiple entries with the same
>>>> capability bit to handle this. This is prone to errors, as the
>>>> cpu_enable is invoked for each entry, irrespective of whether the
>>>> detection rule applies to the CPU or not. And also this complicates
>>>> other helpers, e.g, __this_cpu_has_cap.
>>>>
>>>> This patch adds a wrapper entry to cover all the possible variations
>>>> of a capability and ensures :
>>>>   1) The capabilitiy is set when at least one of the entry detects
>>>>   2) Action is only taken for the entries that detects.
>>>
>>> I guess this means that where we have a single cpu_enable() method
>>> but complex match criteria that require multiple entries, then that
>>> cpu_enable() method might get called multiple times on a given CPU.
>>
>> A CPU executes cpu_enable() only for the "matching" entries in the list,
>> unlike earlier. So as long as there is a single entry "matching" the given
>> CPU, the cpu_enable() will not be duplicated. May be we *should* mandate
>> that a CPU cannot be matched by multiple entries.
>>
>>>
>>> Could be worth a comment if cpu_enable() methods must be robust
>>> against this.
> 
> Could we say something like:
> 
> "Where a single capability has multiple entries, mutiple cpu_enable()
> methods may be called if more than one entry matches.  Where this is
> not desired, care should be taken to ensure that the entries are
> mutually exclusive: for example, two entries for a single capability
> that match on MIDR should be configured to match MIDR ranges that do
> not overlap."
> 
> This is more verbose than I would like however.  Maybe there's a simpler
> way to say it.

If we're not also talking about a capability having mutually exclusive 
enable methods (it doesn't seem so, but I'm not necessarily 100% clear), 
how about:

"If a cpu_enable() method is associated with multiple matches for a 
single capability, care should be taken that either the match criteria 
are mutually exclusive, or that the method is robust against being 
called multiple times."

?

Robin.

>>>> This avoids explicit checks in the call backs. The only constraint
>>>> here is that, all the entries should have the same "type".
>>>>
>>>> Cc: Dave Martin <dave.martin@arm.com>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>   arch/arm64/include/asm/cpufeature.h |  1 +
>>>>   arch/arm64/kernel/cpu_errata.c      | 53 ++++++++++++++++++++++++++++++++-----
>>>>   arch/arm64/kernel/cpufeature.c      |  7 +++--
>>>>   3 files changed, 50 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>>>> index 462c35d1a38c..b73247c27f00 100644
>>>> --- a/arch/arm64/include/asm/cpufeature.h
>>>> +++ b/arch/arm64/include/asm/cpufeature.h
>>>> @@ -290,6 +290,7 @@ struct arm64_cpu_capabilities {
>>>>   			bool sign;
>>>>   			unsigned long hwcap;
>>>>   		};
>>>> +		const struct arm64_cpu_capabilities *cap_list;
>>>
>>> Should desc, capability, def_scope and/or cpu_enable match for every cap
>>> in such a group?
>>
>> As mentioned above, the "type" field should match, which implies scope
>> must match. The code ignores the scope, capability and desc of the individual
>> entries in the list. They should be shared by the parent entry.
>>
>> cpu_enable could be duplicated as long as a CPU is not matched by multiple
>> entries.
>>
>>>
>>> I'd expected something maybe like this:
>>>
>>> struct arm64_cpu_capabilities {
>>> 	const char *desc;
>>> 	u16 capability;
>>> 	struct arm64_capability_match {
>>> 		bool (*matches)(const struct arm64_cpu_capabilities *, int);
>>> 		int (*cpu_enable)(void);
>>> 		union {
>>> 			struct { ... midr ... };
>>> 			struct { ... sysreg ... };
>>> 			const struct arm64_capability_match *list;
>>> 		};
>>>>   	};
>>>>   };
>>
>> Yes, thats makes it more explicit. However, it makes the "matches()"
>> complicated, as we have to change the prototype for matches to accept
>> struct arm64_capability_match *, to point to the right "matches" for
>> items in the list. And that makes a bit more of an invasive change, where
>> each matches() would then loose a way to get to the "capabilities" entry,
>> as they could be called with either the "match" in the top level or
>> the one in the list.
> 
> Yes, that's true.  matches() could take a pointer to the cap struct
> _and_ the relevant match entry, but I'm not sure it's worth it.  In any
> case, my previous objection below doesn't make as much sense as I
> thought.
> 
>>>>   		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>> index 65a8e5cc600c..13e30c1b1e99 100644
>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>> @@ -1181,9 +1181,8 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
>>>>   		return false;
>>>>   	for (caps = cap_array; caps->matches; caps++)
>>>> -		if (caps->capability == cap &&
>>>> -		    caps->matches(caps, SCOPE_LOCAL_CPU))
>>>> -			return true;
>>>> +		if (caps->capability == cap)
>>>> +			return caps->matches(caps, SCOPE_LOCAL_CPU);
>>>
>>> If we went for my capability { cap; match criteria or list; } approach,
>>> would it still be necessary to iterate over the whole list here?
>>
>> Sorry, I couldn't follow this. With this patch, we already stop scanning
>> the list as soon as we find the first entry. It is upto "the entry" to run
>> individual match criteria to decide.
> 
> Ah, I'm talking nonsense here.  Patch 6 iterates over the entire
> capability list via the call to __this_cpu_has_cap() in
> __verify_local_cpu_caps(), but this patch now changes the behaviour so
> that this doesn't happen any more.
> 
> The only other users of this_cpu_has_cap() don't have the right cap
> pointer already, so a scan over the whole list is required in those
> cases -- and anyway, those look like fast paths (RAS exceptions).
> 
> [...]
> 
> Cheers
> ---Dave
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
