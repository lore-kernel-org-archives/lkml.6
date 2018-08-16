Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92998C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33121214C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xclg4pJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33121214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbeHPINt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 04:13:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41004 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeHPINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 04:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534396682; x=1565932682;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+A3Tp9CZjFjVC1BMc+dlztRpvUnYD33l+lEXaluQXrA=;
  b=Xclg4pJQkhp6+dWFnovBSyg8Ud+kF7DLLHuBEoRWCL99X5QjXmF5ev3l
   b42CQnDdZmRYhBLJBcKni7FbFEcZdO4Sg8+1LFnlDyd9OED6iYqo3RFo7
   6urJFg1StWGjnMktRC+qBTlZhiOdi0g4KjKSibT+uF68ZCr9BBbJfPBqI
   DADJVMO+B9N+y4Ig22ATkUvKqGPK5uDB9/8HrVnzrvUqin1fN8HqKPkNQ
   UnXU1Jdiw30BUODiV5LvafytW+8dQNDK+Ey6i8twrzQ1kZUvGLteUU5Gw
   cOKpvwwe5q8PSNrN/73aySXeEq5zD3IxXT2Aj0b3RXEhDS+tuJXiIAhad
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,246,1531756800"; 
   d="scan'208";a="89191687"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2018 13:18:02 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 15 Aug 2018 22:05:24 -0700
Received: from 570dpc2.ad.shared (HELO [10.86.59.225]) ([10.86.59.225])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2018 22:18:02 -0700
Subject: Re: [RFC PATCH 1/5] RISC-V: Add logical CPU indexing for RISC-V
To:     Anup Patel <anup@brainfault.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-2-git-send-email-atish.patra@wdc.com>
 <CAAhSdy1Legi9jzYnkN2am3QKLw7Y8tpbUfmJVA0gBRB4nPnXjA@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <7bc075fc-7039-62d8-c708-1c36233b7126@wdc.com>
Date:   Wed, 15 Aug 2018 22:17:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy1Legi9jzYnkN2am3QKLw7Y8tpbUfmJVA0gBRB4nPnXjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/18 9:06 PM, Anup Patel wrote:
> On Thu, Aug 16, 2018 at 5:26 AM, Atish Patra <atish.patra@wdc.com> wrote:
>> Currently, both linux cpu id and hardware cpu id are same.
>> This is not recommended as it will lead to discontinuous cpu
>> indexing in Linux. Moreover, kdump kernel will run from CPU0
>> which would be absent if we follow existing scheme.
>>
>> Implement a logical mapping between Linux cpu id and hardware
>> cpuid to decouple these two. Always mark the boot processor as
>> cpu0 and all other cpus get the logical cpu id based on their
>> booting order.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/include/asm/smp.h | 17 ++++++++++++++++-
>>   arch/riscv/kernel/setup.c    |  2 ++
>>   arch/riscv/kernel/smp.c      | 19 +++++++++++++++++++
>>   3 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
>> index 36016845..0763337b 100644
>> --- a/arch/riscv/include/asm/smp.h
>> +++ b/arch/riscv/include/asm/smp.h
>> @@ -22,6 +22,12 @@
>>   #include <linux/cpumask.h>
>>   #include <linux/irqreturn.h>
>>
>> +/*
>> + * Mapping between linux logical cpu index and hartid.
>> + */
>> +extern u64 __cpu_logical_map[NR_CPUS];
>> +#define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
>> +
>>   #ifdef CONFIG_SMP
>>
>>   /* SMP initialization hook for setup_arch */
>> @@ -33,6 +39,8 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
>>   /* Hook for the generic smp_call_function_single() routine. */
>>   void arch_send_call_function_single_ipi(int cpu);
>>
>> +int riscv_hartid_to_cpuid(int hartid);
>> +void cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>>   /*
>>    * This is particularly ugly: it appears we can't actually get the definition
>>    * of task_struct here, but we need access to the CPU this task is running on.
>> @@ -41,6 +49,13 @@ void arch_send_call_function_single_ipi(int cpu);
>>    */
>>   #define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
>>
>> -#endif /* CONFIG_SMP */
>> +#else
>> +
>> +static inline int riscv_hartid_to_cpuid(int hartid) { return 0 ; }
>> +static inline void cpuid_to_hartid_mask(const struct cpumask *in,
>> +                                      struct cpumask *out) {
>> +       cpumask_set_cpu(cpu_logical_map(0), out);
>> +}
>>
>> +#endif /* CONFIG_SMP */
>>   #endif /* _ASM_RISCV_SMP_H */
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index db20dc63..e21ed481 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -82,6 +82,8 @@ EXPORT_SYMBOL(empty_zero_page);
>>   /* The lucky hart to first increment this variable will boot the other cores */
>>   atomic_t hart_lottery;
>>
>> +u64 __cpu_logical_map[NR_CPUS];
> 
> If hardware IDs are always machine word size then its better to use
> "unsigned long" in-place of u64.
> 

Good point. Thanks.

> The __cpu_logical_map[] should be zero initially because zero is a
> valid hardware ID. Better set all entries to -1 by assigning { -1 } to the
> array.
> 

ok. I will introduce INVALID_HART_ID (=-1) and initialize with that.

> Also, I feel  __cpu_logical_map[] should be part of smp.c instead of
> setup.c. Any particular reason for having it in setup.c?
> 

currently smp.c is only compiled in if CONFIG_SMP. That's why I kept it 
in setup.c


Regards,
Atish
>> +
>>   #ifdef CONFIG_BLK_DEV_INITRD
>>   static void __init setup_initrd(void)
>>   {
>> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
>> index 906fe21e..d55379ee 100644
>> --- a/arch/riscv/kernel/smp.c
>> +++ b/arch/riscv/kernel/smp.c
>> @@ -38,7 +38,26 @@ enum ipi_message_type {
>>          IPI_MAX
>>   };
>>
>> +int riscv_hartid_to_cpuid(int hartid)
>> +{
>> +       int i = -1;
>> +
>> +       for (i = 0; i < NR_CPUS; i++)
>> +               if (cpu_logical_map(i) == hartid)
>> +                       return i;
>> +
>> +       pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
>> +       BUG();
>> +       return i;
>> +}
>>
>> +void cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
> 
> May be rename cpuid_to_hartid_mask() to riscv_cpuid_to_hartid_mask()
> for consistency.
> 
>> +{
>> +       int cpu;
>> +
>> +       for_each_cpu(cpu, in)
>> +               cpumask_set_cpu(cpu_logical_map(cpu), out);
>> +}
>>   /* Unsupported */
>>   int setup_profiling_timer(unsigned int multiplier)
>>   {
>> --
>> 2.7.4
>>
> 

