Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969279AbeEXNed (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:34:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44914 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965784AbeEXNe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:34:29 -0400
Subject: Re: [PATCH 04/14] arm64: Add ARCH_WORKAROUND_2 probing
To: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-5-marc.zyngier@arm.com>
 <6c3e7b31-0bb6-353b-1b82-7ebdf3be1323@arm.com>
 <20180524113933.GA8689@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <ee08702a-f525-7c0a-38b8-50941285df29@arm.com>
Date: Thu, 24 May 2018 14:34:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524113933.GA8689@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/18 12:39, Will Deacon wrote:
> On Thu, May 24, 2018 at 10:58:43AM +0100, Suzuki K Poulose wrote:
>> On 22/05/18 16:06, Marc Zyngier wrote:
>>> As for Spectre variant-2, we rely on SMCCC 1.1 to provide the
>>> discovery mechanism for detecting the SSBD mitigation.
>>>
>>> A new capability is also allocated for that purpose, and a
>>> config option.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>>
>>> +static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>>> +				    int scope)
>>> +{
>>> +	struct arm_smccc_res res;
>>> +	bool supported = true;
>>> +
>>> +	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
>>> +
>>> +	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
>>> +		return false;
>>> +
>>> +	/*
>>> +	 * The probe function return value is either negative
>>> +	 * (unsupported or mitigated), positive (unaffected), or zero
>>> +	 * (requires mitigation). We only need to do anything in the
>>> +	 * last case.
>>> +	 */
>>> +	switch (psci_ops.conduit) {
>>> +	case PSCI_CONDUIT_HVC:
>>> +		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
>>> +				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
>>> +		if ((int)res.a0 != 0)
>>> +			supported = false;
>>> +		break;
>>> +
>>> +	case PSCI_CONDUIT_SMC:
>>> +		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
>>> +				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
>>> +		if ((int)res.a0 != 0)
>>> +			supported = false;
>>> +		break;
>>> +
>>> +	default:
>>> +		supported = false;
>>> +	}
>>> +
>>> +	if (supported) {
>>> +		__this_cpu_write(arm64_ssbd_callback_required, 1);
>>> +		do_ssbd(true);
>>> +	}
>>
>>
>> Marc,
>>
>> As discussed, we have minor issue with the "corner case". If a CPU
>> is hotplugged in which requires the mitigation, after the system has
>> finalised the cap to "not available", the CPU could go ahead and
>> do the "work around" as above, while not effectively doing anything
>> about it at runtime for KVM guests (as thats the only place where
>> we rely on the CAP being set).
>>
>> But, yes this is real corner case. There is no easy way to solve it
>> other than
>>
>> 1) Allow late modifications to CPU hwcaps
>>
>> OR
>>
>> 2) Penalise the fastpath to always check per-cpu setting.
> 
> Shouldn't we just avoid bring up CPUs that require the mitigation after
> we've finalised the capability to say that it's not required? Assuming this
> is just another issue with maxcpus=, then I don't much care for it.
Ah! Sorry, yes we do kill the CPU. But it is just that it will set the
ssbd_callback_required flag and issue the do_ssbd(), which is not an issue.

Yes this can only be triggered by maxcpus=.

Suzuki
