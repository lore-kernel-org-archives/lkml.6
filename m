Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeCZOYP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:24:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41634 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbeCZOYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:24:14 -0400
Subject: Re: [PATCH 2/3] drivers/irqchip: update supports_deactivate static
 key to modern api
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: peterz@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, Davidlohr Bueso <dbueso@suse.de>
References: <20180325191056.24598-1-dave@stgolabs.net>
 <20180325191056.24598-3-dave@stgolabs.net>
 <671202a1-4080-0104-abd8-4718c53dd61e@arm.com>
 <20180326135456.a6z6tvbx2kdqbopr@linux-n805>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <56064180-053b-2987-d10e-7e5f36c579a1@arm.com>
Date: Mon, 26 Mar 2018 15:24:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326135456.a6z6tvbx2kdqbopr@linux-n805>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/18 14:54, Davidlohr Bueso wrote:
> On Mon, 26 Mar 2018, Marc Zyngier wrote:
> 
>>>  static struct gic_chip_data gic_data __read_mostly;
>>> -static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
>>> +DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>>
>> When you combine this...
>>
>> [...]
>>
>>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>>> index ac2e62d613d1..9b7630cee56c 100644
>>> --- a/drivers/irqchip/irq-gic.c
>>> +++ b/drivers/irqchip/irq-gic.c
>>> @@ -121,7 +121,7 @@ static DEFINE_RAW_SPINLOCK(cpu_map_lock);
>>>  #define NR_GIC_CPU_IF 8
>>>  static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
>>>
>>> -static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
>>> +DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>>
>> ...with that, bad things happen:
>>
>> drivers/irqchip/irq-gic-v3.o:(.data+0x278): multiple definition of `supports_deactivate_key'
>> drivers/irqchip/irq-gic.o:(.data+0x18): first defined here
>> Makefile:1032: recipe for target 'vmlinux' failed
>> make: *** [vmlinux] Error 1
> 
> Hmm both were (cross) compile tested, I'll have a look.

Odd. I don't see how you can avoid this failure at link time...

	M.
-- 
Jazz is not dead. It just smells funny...
