Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeBHR7P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:59:15 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38360 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752555AbeBHR7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:59:12 -0500
Subject: Re: [PATCH v2 17/20] arm64: bp hardening: Allow late CPUs to enable
 work around
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-18-suzuki.poulose@arm.com>
 <20180207103942.GH5862@e103592.cambridge.arm.com>
 <b4705fa2-39aa-9fea-78c4-03ac5eb48a49@arm.com>
 <bea7947f-79e1-53e5-30ec-3f28bda46e5a@arm.com>
 <3b922643-ab97-e012-4268-c830b1bdaf10@arm.com>
Message-ID: <77efc8b3-48c1-fbaf-ce11-15123755262a@arm.com>
Date: Thu, 8 Feb 2018 17:59:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <3b922643-ab97-e012-4268-c830b1bdaf10@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/18 16:58, Suzuki K Poulose wrote:
> On 08/02/18 12:26, Marc Zyngier wrote:
>> On 08/02/18 12:19, Suzuki K Poulose wrote:
>>> On 07/02/18 10:39, Dave Martin wrote:
>>>> On Wed, Jan 31, 2018 at 06:28:04PM +0000, Suzuki K Poulose wrote:
>>>>> We defend against branch predictor training based exploits by
>>>>> taking specific actions (based on the CPU model) to invalidate
>>>>> the Branch predictor buffer (BPB). This is implemented by per-CPU
>>>>> ptr, which installs the specific actions for the CPU model.
>>>>>
>>>>> The core code can handle the following cases where:
>>>>>    1) some CPUs doesn't need any work around
>>>>>    2) a CPU can install the work around, when it is brought up,
>>>>>       irrespective of how late that happens.
>>>
>>> With the recent patches from Marc to expose this information to KVM
>>> guests, it looks like allowing a late CPU to turn this on is not going
>>> to be a good idea. We unconditionally set the capability even
>>> when we don't need the mitigation. So I am not really sure if
>>> we should go ahead with this patch. I am open to suggestions
>>>
>>> Marc,
>>>
>>> What do you think ?
>>
>> By the time we bring in that CPU that requires some level of mitigation,
>> we may be running a guest already, and we've told that guest that no
>> mitigation was required. If we bring in that CPU, we break that promise,
>> and the guest becomes vulnerable without knowing about it.
>>
>> The same thing is valid for userspace once we expose the status of the
>> mitigation in /sys, just like x86 does. If we transition from not
>> vulnerable to vulnerable (or even mitigated), we have lied to userspace.
>>
>> In either case, I don't think breaking this contract is acceptable.
> 
> Thanks Marc, I have dropped this patch from the series.

On a second thought, should we allow this if the KVM is not configured in ?

Cheers
Suzuki
