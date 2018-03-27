Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeC0LzD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:55:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53526 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751122AbeC0LzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:55:02 -0400
Subject: Re: [PATCH v2 3/6] ARM: trusted_foundations: do not use naked
 function
To: Dmitry Osipenko <digetx@gmail.com>, Stefan Agner <stefan@agner.ch>,
        linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de
Cc: nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Warren <swarren@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <20180325180959.28008-1-stefan@agner.ch>
 <20180325180959.28008-4-stefan@agner.ch>
 <704c863a-0b5a-6396-d7da-f0ed17b7cca2@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <263337af-7541-be9e-3db6-6cb987fd08fb@arm.com>
Date: Tue, 27 Mar 2018 12:54:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <704c863a-0b5a-6396-d7da-f0ed17b7cca2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/18 22:20, Dmitry Osipenko wrote:
> On 25.03.2018 21:09, Stefan Agner wrote:
>> As documented in GCC naked functions should only use Basic asm
>> syntax. The Extended asm or mixture of Basic asm and "C" code is
>> not guaranteed. Currently this works because it was hard coded
>> to follow and check GCC behavior for arguments and register
>> placement.
>>
>> Furthermore with clang using parameters in Extended asm in a
>> naked function is not supported:
>>    arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
>>            references not allowed in naked functions
>>                  : "r" (type), "r" (arg1), "r" (arg2)
>>                         ^
>>
>> Use a regular function to be more portable. This aligns also with
>> the other smc call implementations e.g. in qcom_scm-32.c and
>> bcm_kona_smc.c.
>>
>> Cc: Dmitry Osipenko <digetx@gmail.com>
>> Cc: Stephen Warren <swarren@nvidia.com>
>> Cc: Thierry Reding <treding@nvidia.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Changes in v2:
>> - Keep stmfd/ldmfd to avoid potential ABI issues
>>
>>   arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
>> index 3fb1b5a1dce9..689e6565abfc 100644
>> --- a/arch/arm/firmware/trusted_foundations.c
>> +++ b/arch/arm/firmware/trusted_foundations.c
>> @@ -31,21 +31,25 @@
>>   
>>   static unsigned long cpu_boot_addr;
>>   
>> -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>   {
>> +	register u32 r0 asm("r0") = type;
>> +	register u32 r1 asm("r1") = arg1;
>> +	register u32 r2 asm("r2") = arg2;
>> +
>>   	asm volatile(
>>   		".arch_extension	sec\n\t"
>> -		"stmfd	sp!, {r4 - r11, lr}\n\t"
>> +		"stmfd	sp!, {r4 - r11}\n\t"
>>   		__asmeq("%0", "r0")
>>   		__asmeq("%1", "r1")
>>   		__asmeq("%2", "r2")
>>   		"mov	r3, #0\n\t"
>>   		"mov	r4, #0\n\t"
>>   		"smc	#0\n\t"
>> -		"ldmfd	sp!, {r4 - r11, pc}"
>> +		"ldmfd	sp!, {r4 - r11}\n\t"
>>   		:
>> -		: "r" (type), "r" (arg1), "r" (arg2)
>> -		: "memory");
>> +		: "r" (r0), "r" (r1), "r" (r2)
>> +		: "memory", "r3", "r12", "lr");
> 
> Although seems "lr" won't be affected by SMC invocation because it should be
> banked and hence could be omitted entirely from the code. Maybe somebody could
> confirm this.
Strictly per the letter of the architecture, the SMC could be trapped to 
Hyp mode, and a hypervisor might clobber LR_usr in the process of 
forwarding the call to the firmware secure monitor (since Hyp doesn't 
have a banked LR of its own). Admittedly there are probably no real 
systems with the appropriate hardware/software combination to hit that, 
but on the other hand if this gets inlined where the compiler has 
already created a stack frame then an LR clobber is essentially free, so 
I reckon we're better off keeping it for reassurance. This isn't exactly 
a critical fast path anyway.

Robin.
