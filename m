Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeCVLsj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:48:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36108 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751908AbeCVLsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:48:37 -0400
Subject: Re: [PATCH 3/5] ARM: trusted_foundations: do not use naked function
To: Stefan Agner <stefan@agner.ch>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
        Dmitry Osipenko <digetx@gmail.com>, swarren@nvidia.com,
        thierry.reding@gmail.com, Alexandre Courbot <acourbot@chromium.org>,
        nicolas.pitre@linaro.org, keescook@chromium.org, arnd@arndb.de,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, Bernhard.Rosenkranzer@linaro.org
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-4-stefan@agner.ch>
 <124e16c9-b8ca-9c7e-ade5-b033eed76e14@arm.com>
 <302cfd1a4324e064cd4f189e4e0ffc21@agner.ch>
 <03de5241-fb69-9097-5020-f9843482318d@gmail.com>
 <1dd52edb-412c-2d26-7e6a-d567695a89fe@wwwdotorg.org>
 <d8b3053d-eeae-4dbc-75e5-b2e07ea58f3d@arm.com>
 <d8adef8767543f8cd0d88546a1940a66@agner.ch>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <bd09fb3a-b8d5-995c-3a0c-271468f51d4e@arm.com>
Date: Thu, 22 Mar 2018 11:48:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d8adef8767543f8cd0d88546a1940a66@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/18 21:41, Stefan Agner wrote:
> On 21.03.2018 18:16, Robin Murphy wrote:
>> On 21/03/18 16:40, Stephen Warren wrote:
>>> On 03/21/2018 09:26 AM, Dmitry Osipenko wrote:
>>>> On 21.03.2018 17:09, Stefan Agner wrote:
>>>>> On 21.03.2018 13:13, Robin Murphy wrote:
>>>>>> On 20/03/18 23:02, Stefan Agner wrote:
>>>>>>> As documented in GCC naked functions should only use Basic asm
>>>>>>> syntax. The Extended asm or mixture of Basic asm and "C" code is
>>>>>>> not guaranteed. Currently this works because it was hard coded
>>>>>>> to follow and check GCC behavior for arguments and register
>>>>>>> placement.
>>>>>>>
>>>>>>> Furthermore with clang using parameters in Extended asm in a
>>>>>>> naked function is not supported:
>>>>>>>      arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
>>>>>>>              references not allowed in naked functions
>>>>>>>                    : "r" (type), "r" (arg1), "r" (arg2)
>>>>>>>                           ^
>>>>>>>
>>>>>>> Use a regular function to be more portable. This aligns also with
>>>>>>> the other smc call implementations e.g. in qcom_scm-32.c and
>>>>>>> bcm_kona_smc.c.
>>>>>>>
>>>>>>> Additionally also make sure all callee-saved registers get saved
>>>>>>> as it has been done before.
>>>>>>>
>>>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>>>>> ---
>>>>>>>     arch/arm/firmware/trusted_foundations.c | 12 +++++++-----
>>>>>>>     1 file changed, 7 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
>>>>>>> index 3fb1b5a1dce9..426d732e6591 100644
>>>>>>> --- a/arch/arm/firmware/trusted_foundations.c
>>>>>>> +++ b/arch/arm/firmware/trusted_foundations.c
>>>>>>> @@ -31,21 +31,23 @@
>>>>>>>       static unsigned long cpu_boot_addr;
>>>>>>>     -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>>>>>> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>>>>>>     {
>>>>>>> +    register u32 r0 asm("r0") = type;
>>>>>>> +    register u32 r1 asm("r1") = arg1;
>>>>>>> +    register u32 r2 asm("r2") = arg2;
>>>>>>> +
>>>>>>>         asm volatile(
>>>>>>>             ".arch_extension    sec\n\t"
>>>>>>> -        "stmfd    sp!, {r4 - r11, lr}\n\t"
>>>>>>>             __asmeq("%0", "r0")
>>>>>>>             __asmeq("%1", "r1")
>>>>>>>             __asmeq("%2", "r2")
>>>>>>>             "mov    r3, #0\n\t"
>>>>>>>             "mov    r4, #0\n\t"
>>>>>>>             "smc    #0\n\t"
>>>>>>> -        "ldmfd    sp!, {r4 - r11, pc}"
>>>>>>>             :
>>>>>>> -        : "r" (type), "r" (arg1), "r" (arg2)
>>>>>>> -        : "memory");
>>>>>>> +        : "r" (r0), "r" (r1), "r" (r2)
>>>>>>> +        : "memory", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10");
>>>>>>
>>>>>> I may be missing a subtlety, but it looks like we no longer have a
>>>>>> guarantee that r11 will be caller-saved as it was previously. I don't
>>>>>> know the Trusted Foundations ABI to say whether that matters or not,
>>>>>> but if it is the case that it never needed preserving anyway, that
>>>>>> might be worth calling out in the commit message.
>>>>>
>>>>> Adding r11 (fp) to the clobber list causes an error when using gcc and
>>>>> CONFIG_FRAME_POINTER=y:
>>>>> arch/arm/firmware/trusted_foundations.c: In function ‘tf_generic_smc’:
>>>>> arch/arm/firmware/trusted_foundations.c:51:1: error: fp cannot be used
>>>>> in asm here
>>>>>
>>>>> Not sure what ABI Trusted Foundations follow.
>>>>>
>>>>> [adding Stephen, Thierry and Dmitry]
>>>>> Maybe someone more familiar with NVIDIA Tegra SoCs can help?
>>>>>
>>>>> When CONFIG_FRAME_POINTER=y fp gets saved anyway. So we could add r11 to
>>>>> clobber list ifndef CONFIG_FRAME_POINTER...
>>>>
>>>> I have no idea about TF ABI either. Looking at the downstream kernel code, r4 -
>>>> r12 should be saved. I've CC'd Alexandre as he is the author of the original
>>>> patch and may still remember the details.
>>>>
>>>> I'm also wondering why original code doesn't have r3 in the clobber list and why
>>>> r3 is set to '0', downstream sets it to the address of SP and on return from SMC
>>>> r3 contains the address of SP which should be restored. I'm now wondering how
>>>> SMC calling worked for me at all on T30, maybe it didn't..
>>>
>>> I don't know what the ABI for ATF is. I assume it's documented in the ATF, PSCI, or similar specification, or ATF source code. Hence, I don't know whether ATF restores fp/r11.
>>
>> Oops, I think we're starting to diverge here - "ATF" (as in "Arm
>> Trusted Firmware") does implement the ARM SMCCC, which more or less
>> just follows the regular procedure call standard in terms of register
>> saving. The "TF" in question here is "Trusted Foundations" from
>> Trusted Logic (who apparently don't exist any more) which is
>> explicitly called out in the header as having its own nonstandard
>> calling convention. I guess newer Tegras are using the former, whereas
>> the older ones used the latter.
>>
> 
> What do you mean by "called out in the header as having its own
> nonstandard"?

Specifically, the comment in arch/arm/include/asm/trusted_foundations.h 
which says:

   "The calls are completely specific to Trusted Foundations, and do
    *not* follow the SMC calling convention or the PSCI standard."

> It is unclear what ABI is used, I just inferred from the fact that
> register have been saved before that it might use a nonstandard calling
> convention.
> 
> Tegra 4i/TK1 and newer seem to use something called Trusted Little
> Kernel.
> 
>>> My guess is that r3/r4 are set to 0 because they're defined as inputs by the SMC/ATF ABI, yet nothing the kernel does needed that many parameters, so they're hard-coded to 0 (to ensure they're set to something predictable) rather than also being parameters to tf_generic_smc().
>>>
>>> The original code used to save/restore a lot of registers, including r11/fp. Can't we side-step the issue of including/not-including r11/fp in the clobber list by not removing those stmfd/ldmfd assembly instructions?
>>
>> That might be reasonable - fiddling with a C function's stack inside
>> an asm is a bit grim, but for this case I can't see that it would mess
>> with unwinding etc. or otherwise go wrong any more than the existing
>> code, and I doubt the slight efficiency hit from having to change the
>> "pop the LR straight into the PC" idiom matters much.
> 
> Sounds reasonable, I guess in that case we can also omit all the
> additional register in the clobber list.

Yeah, you should only need to specify clobbers for any registers which 
are neither used as arguments nor explicitly preserved - looking at the 
layout of the code, it seems unlikely that the compiler would have 
anything live in r3 or r12 across the call (since the scope for inlining 
is pretty trivial), but there's no harm in being strictly correct :)

Robin.
