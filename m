Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeCUOKC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:10:02 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54388 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbeCUOKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:10:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Wed, 21 Mar 2018 15:09:58 +0100
From: Stefan Agner <stefan@agner.ch>
To: Robin Murphy <robin.murphy@arm.com>, swarren@nvidia.com,
        thierry.reding@gmail.com, digetx@gmail.com
Cc: linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de,
        nicolas.pitre@linaro.org, keescook@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, Bernhard.Rosenkranzer@linaro.org
Subject: Re: [PATCH 3/5] ARM: trusted_foundations: do not use naked function
In-Reply-To: <124e16c9-b8ca-9c7e-ade5-b033eed76e14@arm.com>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-4-stefan@agner.ch>
 <124e16c9-b8ca-9c7e-ade5-b033eed76e14@arm.com>
Message-ID: <302cfd1a4324e064cd4f189e4e0ffc21@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.2018 13:13, Robin Murphy wrote:
> On 20/03/18 23:02, Stefan Agner wrote:
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
>> Additionally also make sure all callee-saved registers get saved
>> as it has been done before.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>   arch/arm/firmware/trusted_foundations.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
>> index 3fb1b5a1dce9..426d732e6591 100644
>> --- a/arch/arm/firmware/trusted_foundations.c
>> +++ b/arch/arm/firmware/trusted_foundations.c
>> @@ -31,21 +31,23 @@
>>     static unsigned long cpu_boot_addr;
>>   -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>   {
>> +	register u32 r0 asm("r0") = type;
>> +	register u32 r1 asm("r1") = arg1;
>> +	register u32 r2 asm("r2") = arg2;
>> +
>>   	asm volatile(
>>   		".arch_extension	sec\n\t"
>> -		"stmfd	sp!, {r4 - r11, lr}\n\t"
>>   		__asmeq("%0", "r0")
>>   		__asmeq("%1", "r1")
>>   		__asmeq("%2", "r2")
>>   		"mov	r3, #0\n\t"
>>   		"mov	r4, #0\n\t"
>>   		"smc	#0\n\t"
>> -		"ldmfd	sp!, {r4 - r11, pc}"
>>   		:
>> -		: "r" (type), "r" (arg1), "r" (arg2)
>> -		: "memory");
>> +		: "r" (r0), "r" (r1), "r" (r2)
>> +		: "memory", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10");
> 
> I may be missing a subtlety, but it looks like we no longer have a
> guarantee that r11 will be caller-saved as it was previously. I don't
> know the Trusted Foundations ABI to say whether that matters or not,
> but if it is the case that it never needed preserving anyway, that
> might be worth calling out in the commit message.

Adding r11 (fp) to the clobber list causes an error when using gcc and
CONFIG_FRAME_POINTER=y:
arch/arm/firmware/trusted_foundations.c: In function ‘tf_generic_smc’:
arch/arm/firmware/trusted_foundations.c:51:1: error: fp cannot be used
in asm here

Not sure what ABI Trusted Foundations follow.

[adding Stephen, Thierry and Dmitry]
Maybe someone more familiar with NVIDIA Tegra SoCs can help?

When CONFIG_FRAME_POINTER=y fp gets saved anyway. So we could add r11 to
clobber list ifndef CONFIG_FRAME_POINTER...

--
Stefan

> 
> Robin.
> 
>>   }
>>     static int tf_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
>>
