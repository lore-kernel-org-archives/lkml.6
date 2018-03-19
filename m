Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933371AbeCSJVw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:21:52 -0400
Received: from foss.arm.com ([217.140.101.70]:50320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933106AbeCSJVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:21:45 -0400
Subject: Re: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
To: =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: maxime.ripard@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        quentin.schulz@bootlin.com, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-11-mylene.josserand@bootlin.com>
 <6329fbb6-13a1-41fe-f6cf-f2f0d4b2e5f9@arm.com>
 <20180318200715.363f3135@dell-desktop.home>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <f3545b1c-fc75-e4bc-87a9-da28c48e4b14@arm.com>
Date: Mon, 19 Mar 2018 09:21:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318200715.363f3135@dell-desktop.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mylène,

On 18/03/18 19:07, Mylène Josserand wrote:
> Hello Mark,
> 
> Please, excuse me for this late answer and thank you for the review!

No worries.

> 
> On Wed, 7 Mar 2018 12:18:33 +0000
> Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
>> On 23/02/18 13:37, Mylène Josserand wrote:
>>> On Cortex-A7, the CNTVOFF register from arch timer is uninitialized.  
>>
>> Only on A7? Is that specific to your platform?
> 
> I do not really know other Allwinner's platforms about this subject. At
> least, the sun9i-a80 which is a Cortex-a15/a7 does not need that but it
> is necessary for sun8i-a83t which is a cortex-a7. Maybe, Chen-Yu or
> Maxime could help us on it.

My point was that having an uninitialized CNTVOFF is hardly a property
of Cortex-A7. The same behaviour exists on all CPUs that implement the
arch timers. What you have here is more a property of the platform, and
its lack of firmware support.

>>
>>> It should be done by the bootloader but it is currently not the case,
>>> even for boot CPU because this SoC is booting in secure mode.
>>> It leads to an random offset value meaning that each CPU will have a
>>> different time, which isn't working very well.
>>>
>>> Add assembly code used for boot CPU and secondary CPU cores to make
>>> sure that the CNTVOFF register is initialized.
>>>
>>> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
>>> ---
>>>  arch/arm/mach-sunxi/headsmp.S | 21 +++++++++++++++++++++
>>>  arch/arm/mach-sunxi/sunxi.c   |  4 ++++
>>>  2 files changed, 25 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
>>> index d5c97e945e69..605896251927 100644
>>> --- a/arch/arm/mach-sunxi/headsmp.S
>>> +++ b/arch/arm/mach-sunxi/headsmp.S
>>> @@ -65,9 +65,30 @@ ENTRY(sunxi_mc_smp_cluster_cache_enable)
>>>  	first: .word sunxi_mc_smp_first_comer - .
>>>  ENDPROC(sunxi_mc_smp_cluster_cache_enable)
>>>  
>>> +ENTRY(sunxi_init_cntvoff)
>>> +	/*
>>> +	 * CNTVOFF has to be initialized either from non-secure Hypervisor
>>> +	 * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
>>> +	 * then it should be handled by the secure code
>>> +	 */
>>> +	cps	#MON_MODE
>>> +	mrc	p15, 0, r1, c1, c1, 0		/* Get Secure Config */
>>> +	orr	r0, r1, #1
>>> +	mcr	p15, 0, r0, c1, c1, 0		/* Set Non Secure bit */
>>> +	instr_sync  
>>
>> Since these CPUs are all ARMv7, you can use isb directly. Nobody wants
>> to see more of the CP15 barriers.
> 
> Okay, thanks, I will update that.
> 
>>
>>> +	mov	r0, #0
>>> +	mcrr	p15, 4, r0, r0, c14		/* CNTVOFF = 0 */
>>> +	instr_sync
>>> +	mcr	p15, 0, r1, c1, c1, 0		/* Set Secure bit */
>>> +	instr_sync
>>> +	cps	#SVC_MODE
>>> +	ret	lr  
>>
>> Given that this code is identical to the shmobile hack, it'd be good to
>> make it common, one way or another.
> 
> Sure, I will try that.
> May you have some hints to give me on how to implement it?

You could move it to arch/arm/common, for example.

> 
>>
>>> +ENDPROC(sunxi_init_cntvoff)
>>> +
>>>  #ifdef CONFIG_SMP
>>>  ENTRY(sunxi_boot)
>>>  	bl	sunxi_mc_smp_cluster_cache_enable
>>> +	bl	sunxi_init_cntvoff
>>>  	b	secondary_startup
>>>  ENDPROC(sunxi_boot)
>>>  
>>> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
>>> index 5e9602ce1573..4bb041492b54 100644
>>> --- a/arch/arm/mach-sunxi/sunxi.c
>>> +++ b/arch/arm/mach-sunxi/sunxi.c
>>> @@ -37,8 +37,12 @@ static const char * const sun6i_board_dt_compat[] = {
>>>  };
>>>  
>>>  extern void __init sun6i_reset_init(void);
>>> +extern void sunxi_init_cntvoff(void);
>>> +
>>>  static void __init sun6i_timer_init(void)
>>>  {
>>> +	sunxi_init_cntvoff();
>>> +  
>>
>> It is slightly odd that some CPUs get initialized from the early asm
>> code, and some others do a detour via some C code. I'm sure this could
>> be made to work
> 
> Renesa's code was also doing that so I thought it could be ok to do
> it.

It is not that it isn't OK, it is just a slightly bizarre construct.

> Without this code in this timer_init function, it fails to initialize
> cntvoff correctly:
> http://code.bulix.org/i9fhc9-302612?raw
> 
> How should I implement that?

I would make it part of a path that all CPUs have to hit at bring-up
time. You already have such a path in your SMP init code, so why not
take advantage of that, making it completely uniform across the board?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
