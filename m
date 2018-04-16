Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeDPP4k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:56:40 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:42010 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeDPP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:56:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Mon, 16 Apr 2018 17:56:34 +0200
From: Stefan Agner <stefan@agner.ch>
To: Stephen Warren <swarren@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux@armlinux.org.uk,
        ard.biesheuvel@linaro.org, arnd@arndb.de, nicolas.pitre@linaro.org,
        marc.zyngier@arm.com, behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 3/6] ARM: trusted_foundations: do not use naked
 function
In-Reply-To: <f627177c-f813-9e10-ade5-c7654375639b@gmail.com>
References: <20180325180959.28008-1-stefan@agner.ch>
 <20180325180959.28008-4-stefan@agner.ch>
 <704c863a-0b5a-6396-d7da-f0ed17b7cca2@gmail.com>
 <263337af-7541-be9e-3db6-6cb987fd08fb@arm.com>
 <f627177c-f813-9e10-ade5-c7654375639b@gmail.com>
Message-ID: <cf9b916103c0dba1e67682efc69f5bae@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.2018 14:16, Dmitry Osipenko wrote:
> On 27.03.2018 14:54, Robin Murphy wrote:
>> On 26/03/18 22:20, Dmitry Osipenko wrote:
>>> On 25.03.2018 21:09, Stefan Agner wrote:
>>>> As documented in GCC naked functions should only use Basic asm
>>>> syntax. The Extended asm or mixture of Basic asm and "C" code is
>>>> not guaranteed. Currently this works because it was hard coded
>>>> to follow and check GCC behavior for arguments and register
>>>> placement.
>>>>
>>>> Furthermore with clang using parameters in Extended asm in a
>>>> naked function is not supported:
>>>>    arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
>>>>            references not allowed in naked functions
>>>>                  : "r" (type), "r" (arg1), "r" (arg2)
>>>>                         ^
>>>>
>>>> Use a regular function to be more portable. This aligns also with
>>>> the other smc call implementations e.g. in qcom_scm-32.c and
>>>> bcm_kona_smc.c.
>>>>
>>>> Cc: Dmitry Osipenko <digetx@gmail.com>
>>>> Cc: Stephen Warren <swarren@nvidia.com>
>>>> Cc: Thierry Reding <treding@nvidia.com>
>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>> ---
>>>> Changes in v2:
>>>> - Keep stmfd/ldmfd to avoid potential ABI issues
>>>>
>>>>   arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
>>>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm/firmware/trusted_foundations.c
>>>> b/arch/arm/firmware/trusted_foundations.c
>>>> index 3fb1b5a1dce9..689e6565abfc 100644
>>>> --- a/arch/arm/firmware/trusted_foundations.c
>>>> +++ b/arch/arm/firmware/trusted_foundations.c
>>>> @@ -31,21 +31,25 @@
>>>>     static unsigned long cpu_boot_addr;
>>>>   -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>>> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>>>   {
>>>> +    register u32 r0 asm("r0") = type;
>>>> +    register u32 r1 asm("r1") = arg1;
>>>> +    register u32 r2 asm("r2") = arg2;
>>>> +
>>>>       asm volatile(
>>>>           ".arch_extension    sec\n\t"
>>>> -        "stmfd    sp!, {r4 - r11, lr}\n\t"
>>>> +        "stmfd    sp!, {r4 - r11}\n\t"
>>>>           __asmeq("%0", "r0")
>>>>           __asmeq("%1", "r1")
>>>>           __asmeq("%2", "r2")
>>>>           "mov    r3, #0\n\t"
>>>>           "mov    r4, #0\n\t"
>>>>           "smc    #0\n\t"
>>>> -        "ldmfd    sp!, {r4 - r11, pc}"
>>>> +        "ldmfd    sp!, {r4 - r11}\n\t"
>>>>           :
>>>> -        : "r" (type), "r" (arg1), "r" (arg2)
>>>> -        : "memory");
>>>> +        : "r" (r0), "r" (r1), "r" (r2)
>>>> +        : "memory", "r3", "r12", "lr");
>>>
>>> Although seems "lr" won't be affected by SMC invocation because it should be
>>> banked and hence could be omitted entirely from the code. Maybe somebody could
>>> confirm this.
>> Strictly per the letter of the architecture, the SMC could be trapped to Hyp
>> mode, and a hypervisor might clobber LR_usr in the process of forwarding the
>> call to the firmware secure monitor (since Hyp doesn't have a banked LR of its
>> own). Admittedly there are probably no real systems with the appropriate
>> hardware/software combination to hit that, but on the other hand if this gets
>> inlined where the compiler has already created a stack frame then an LR clobber
>> is essentially free, so I reckon we're better off keeping it for reassurance.
>> This isn't exactly a critical fast path anyway.
> 
> Okay, thank you for the clarification.

So it seems this change is fine?

Stephen, you picked up changes for this driver before, is this patch
going through your tree?

--
Stefan
