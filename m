Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeEVCpG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 22:45:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3767 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751601AbeEVCpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 22:45:04 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40188472"
Subject: Re: [PATCH] x86/idt: Simplify the idt_setup_apic_and_irq_gates()
To: Thomas Gleixner <tglx@linutronix.de>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <hpa@zytor.com>
References: <20180426054452.32308-1-douly.fnst@cn.fujitsu.com>
 <alpine.DEB.2.21.1805191424560.1599@nanos.tec.linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <e756f124-0690-ccdc-6dbd-9e1e68aef771@cn.fujitsu.com>
Date: Tue, 22 May 2018 10:44:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805191424560.1599@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 354574B3EF2E.A927A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

At 05/19/2018 08:32 PM, Thomas Gleixner wrote:
> On Thu, 26 Apr 2018, Dou Liyang wrote:
> 
>> The vectors between FIRST_SYSTEM_VECTOR and NR_VECTORS are special IRQ
>> vectors used by the SMP architecture. But, if X86_LOCAL_APIC=n, it will
>> not be used, and the FIRST_SYSTEM_VECTOR is equal to NR_VECTORS.
> 
> Correct, but that function has nothing to do with FIRST_SYSTEM_VECTOR.
> 

Oops, sorry, when I reread, my changelog even made me misunderstand.
the patch hided it.

     void __init idt_setup_apic_and_irq_gates(void)
     ...
         for_each_clear_bit_from(i, system_vectors, FIRST_SYSTEM_VECTOR)
                                                    ^^^^^^^^^^^^^^^^^^^
     ...
         for_each_clear_bit_from(i, system_vectors, NR_VECTORS)

What I want to say is:

   In the APIC=n system, the FIRST_SYSTEM_VECTOR is equal to
   NR_VECTORS, So all entries has been set by

     for_each_clear_bit_from(i, system_vectors, FIRST_SYSTEM_VECTOR)
        ...

   the following setup code for APIC=n is redundant. Just setup gates for
   APIC=y.

If it is OK, I will send v2.

Thanks,

	dou

>> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
>> index 2c3a1b4294eb..8b4174890706 100644
>> --- a/arch/x86/kernel/idt.c
>> +++ b/arch/x86/kernel/idt.c
>> @@ -317,15 +317,16 @@ void __init idt_setup_apic_and_irq_gates(void)
>>   		set_intr_gate(i, entry);
>>   	}
>>   
>> -	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
>> +	/*
>> +	 * If X86_LOCAL_APIC=n, the FIRST_SYSTEM_VECTOR is equal to NR_VECTORS
>> +	 * Just consider the X86_LOCAL_APIC=y case
>> +	 */
>>   #ifdef CONFIG_X86_LOCAL_APIC
>> +	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
>>   		set_bit(i, system_vectors);
>>   		set_intr_gate(i, spurious_interrupt);
>> -#else
>> -		entry = irq_entries_start + 8 * (i - FIRST_EXTERNAL_VECTOR);
>> -		set_intr_gate(i, entry);
>> -#endif
>>   	}
>> +#endif
> 
> That change breaks the LOCAL_APIC=n case in a subtle way. What the function
> does is to set _ALL_ entries starting from FIRST_EXTERNAL_VECTOR up to
> NR_VECTORS in the IDT to a known target, except those which are already
> occupied by a system vector.
> 
> So for APIC=y this sets them to: spurious vector and for APIC=n it sets it
> to the corresppnding vector entry. You remove the latter...
>  > Thanks,
> 
> 	tglx
> 
> 
> 
> 
