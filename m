Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeCUIWx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:22:53 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:46495 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeCUIWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:22:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Mar 2018 09:22:47 +0100
From: Stefan Agner <stefan@agner.ch>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: ard.biesheuvel@linaro.org, arnd@arndb.de, nicolas.pitre@linaro.org,
        marc.zyngier@arm.com, behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] bus: arm-cci: use asm unreachable
In-Reply-To: <20180320233046.GL2743@n2100.armlinux.org.uk>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-2-stefan@agner.ch>
 <20180320233046.GL2743@n2100.armlinux.org.uk>
Message-ID: <23ba28a09df84e723cd38bfc16dfca56@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.2018 00:30, Russell King - ARM Linux wrote:
> On Wed, Mar 21, 2018 at 12:02:02AM +0100, Stefan Agner wrote:
>> Mixing asm and C code is not recommended in a naked function by
>> gcc and leads to an error when using clang:
>>   drivers/bus/arm-cci.c:2107:2: error: non-ASM statement in naked
>>   function is not supported
>>         unreachable();
>>         ^
>>
>> Instead of using the unreachable() macro use the assember variant
>> ASM_UNREACHABLE.  This will no longer emit __builtin_unreachable(),
>> but since the function is naked and its return type is void it seems
>> not to have aversive effects.
> 
> I think that unreachable() there is rather silly - this function
> *does* return, and the comments say as much.  Just delete the silly
> "unreachable()", there's no need to put an ASM_UNREACHABLE in there.
> 
> The function is not declared as not returning, and nothing in this
> file uses it anyway - it's called from the mcpm code, which also
> _does_ expect this function to return (if it doesn't, then we're
> basically saying the CPU that called it is dead.)
> 

Hm, that makes sense. Will just drop unreachable() in the next revision.

Thanks for reviewing!

--
Stefan

>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/bus/arm-cci.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
>> index 5426c04fe24b..ee9da86fec47 100644
>> --- a/drivers/bus/arm-cci.c
>> +++ b/drivers/bus/arm-cci.c
>> @@ -2084,6 +2084,7 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>>
>>  "	mov	r0, #0 \n"
>>  "	bx	lr \n"
>> +	ASM_UNREACHABLE
>>
>>  "	.align	2 \n"
>>  "5:	.word	cpu_port - . \n"
>> @@ -2103,8 +2104,6 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>>  	[sizeof_struct_cpu_port] "i" (sizeof(struct cpu_port)),
>>  	[sizeof_struct_ace_port] "i" (sizeof(struct cci_ace_port)),
>>  	[offsetof_port_phys] "i" (offsetof(struct cci_ace_port, phys)) );
>> -
>> -	unreachable();
>>  }
>>
>>  /**
>> --
>> 2.16.2
>>
