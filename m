Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA752C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4365E21473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FGGVm70j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4365E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbeHPU1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:27:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:39230 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbeHPU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534440438; x=1565976438;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=W3OnGLAzr/UzwfRcA3UswDkiZyVKI0TpY2TEIbwjTxI=;
  b=FGGVm70jUTGvBt5K5qswNqpaO6cxdfcJQdiZDo+wfUSAqPPxROSR5B05
   YqMgQ+Ecdq2Pew5iZxq9zY/P4KhxNnIRv/Jr9JuMnyreao3BSyh1rksEh
   5ONfvNF5bsa8cKm0c+LPlQ7CoE64QDPESGXDAX8mtsUbBqGeVWOXzt/wZ
   DuTHMIa0nWJSSoq2LTSW85Dbxl/l/2+MsZMFGnPpmSveZuzW++LvciHXM
   f63BpHJ64OY3mftzgivL/1C1Q0BwxnHgSzDNMExZmtbGzxuaHCkyHdDDh
   95ojsiQLmUR0SV4khXzrFQSBnuh4OMTuKZe5SjUR06KfRQ6kO9UlZvhDR
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,247,1531756800"; 
   d="scan'208";a="89253176"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2018 01:27:18 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 16 Aug 2018 10:14:39 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Aug 2018 10:27:17 -0700
Subject: Re: [RFC PATCH 2/5] RISC-V: Use Linux logical cpu number instead of
 hartid
To:     Anup Patel <anup@brainfault.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-3-git-send-email-atish.patra@wdc.com>
 <CAAhSdy0O7qid67J2pvyc3sFHsOPA-PFpiSKrHBB1tRDb678bAQ@mail.gmail.com>
 <adf9579e-62e1-e778-10f0-5e55c5b48406@wdc.com>
 <CAAhSdy2WXSeg7eWM0Jj7bN6KN6KC+WHqetZTSx4ATrfEcRk6Bg@mail.gmail.com>
 <f45cd8bd-0b79-9e01-595d-5d0d19ab543e@wdc.com>
 <CAAhSdy0GLqwWohBjGD_Q+s95wXJKge-6MCf4a1TkMoDS3ezEAg@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <004f66f0-4e65-d787-145a-bbf0c6f19763@wdc.com>
Date:   Thu, 16 Aug 2018 10:26:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0GLqwWohBjGD_Q+s95wXJKge-6MCf4a1TkMoDS3ezEAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/18 11:03 PM, Anup Patel wrote:
> On Thu, Aug 16, 2018 at 11:22 AM, Atish Patra <atish.patra@wdc.com> wrote:
>> On 8/15/18 10:45 PM, Anup Patel wrote:
>>>
>>> On Thu, Aug 16, 2018 at 10:53 AM, Atish Patra <atish.patra@wdc.com> wrote:
>>>>
>>>> On 8/15/18 9:24 PM, Anup Patel wrote:
>>>>>
>>>>>
>>>>> On Thu, Aug 16, 2018 at 5:26 AM, Atish Patra <atish.patra@wdc.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> Setup the cpu_logical_map during boot. Moreover, every SBI call
>>>>>> and PLIC context are based on the physical hartid. Use the logical
>>>>>> cpu to hartid mapping to pass correct hartid to respective functions.
>>>>>>
>>>>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>>>>> ---
>>>>>>     arch/riscv/include/asm/tlbflush.h | 17 +++++++++++++----
>>>>>>     arch/riscv/kernel/cpu.c           |  4 +++-
>>>>>>     arch/riscv/kernel/setup.c         | 10 ++++++++++
>>>>>>     arch/riscv/kernel/smp.c           | 24 +++++++++++++++---------
>>>>>>     arch/riscv/kernel/smpboot.c       | 30
>>>>>> ++++++++++++++++++------------
>>>>>>     drivers/clocksource/riscv_timer.c | 12 ++++++++----
>>>>>>     drivers/irqchip/irq-sifive-plic.c | 11 +++++++----
>>>>>>     7 files changed, 74 insertions(+), 34 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/riscv/include/asm/tlbflush.h
>>>>>> b/arch/riscv/include/asm/tlbflush.h
>>>>>> index 85c2d8ba..ecfd9b0e 100644
>>>>>> --- a/arch/riscv/include/asm/tlbflush.h
>>>>>> +++ b/arch/riscv/include/asm/tlbflush.h
>>>>>> @@ -16,6 +16,7 @@
>>>>>>     #define _ASM_RISCV_TLBFLUSH_H
>>>>>>
>>>>>>     #include <linux/mm_types.h>
>>>>>> +#include <asm/smp.h>
>>>>>>
>>>>>>     /*
>>>>>>      * Flush entire local TLB.  'sfence.vma' implicitly fences with the
>>>>>> instruction
>>>>>> @@ -49,13 +50,21 @@ static inline void flush_tlb_range(struct
>>>>>> vm_area_struct *vma,
>>>>>>
>>>>>>     #include <asm/sbi.h>
>>>>>>
>>>>>> -#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
>>>>>> +static inline void remote_sfence_vma(struct cpumask *cmask, unsigned
>>>>>> long start,
>>>>>> +                                    unsigned long size)
>>>>>> +{
>>>>>> +       struct cpumask hmask;
>>>>>> +
>>>>>> +       cpuid_to_hartid_mask(cmask, &hmask);
>>>>>> +       sbi_remote_sfence_vma(hmask.bits, start, size);
>>>>>> +}
>>>>>> +
>>>>>> +#define flush_tlb_all() remote_sfence_vma(NULL, 0, -1)
>>>>>>     #define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
>>>>>>     #define flush_tlb_range(vma, start, end) \
>>>>>> -       sbi_remote_sfence_vma(mm_cpumask((vma)->vm_mm)->bits, \
>>>>>> -                             start, (end) - (start))
>>>>>> +       remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) -
>>>>>> (start))
>>>>>>     #define flush_tlb_mm(mm) \
>>>>>> -       sbi_remote_sfence_vma(mm_cpumask(mm)->bits, 0, -1)
>>>>>> +       remote_sfence_vma(mm_cpumask(mm), 0, -1)
>>>>>>
>>>>>>     #endif /* CONFIG_SMP */
>>>>>>
>>>>>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>>>>>> index ca6c81e5..f8a18ace 100644
>>>>>> --- a/arch/riscv/kernel/cpu.c
>>>>>> +++ b/arch/riscv/kernel/cpu.c
>>>>>> @@ -14,6 +14,7 @@
>>>>>>     #include <linux/init.h>
>>>>>>     #include <linux/seq_file.h>
>>>>>>     #include <linux/of.h>
>>>>>> +#include <asm/smp.h>
>>>>>>
>>>>>>     /* Return -1 if not a valid hart */
>>>>>>     int riscv_of_processor_hart(struct device_node *node)
>>>>>> @@ -79,7 +80,8 @@ static void c_stop(struct seq_file *m, void *v)
>>>>>>     static int c_show(struct seq_file *m, void *v)
>>>>>>     {
>>>>>>            unsigned long hart_id = (unsigned long)v - 1;
>>>>>> -       struct device_node *node = of_get_cpu_node(hart_id, NULL);
>>>>>> +       struct device_node *node =
>>>>>> of_get_cpu_node(cpu_logical_map(hart_id),
>>>>>> +                                                  NULL);
>>>>>
>>>>>
>>>>>
>>>>> The hart_id is misleading name here. It should be cpu_id. Please replace
>>>>> all instances of hart_id with cpu_id and where hard ID is to be
>>>>> displayed
>>>>> use cpu_logical_map(cpu_id).
>>>>>
>>>> Correct. Thanks for catching it. I will fix it in v2.
>>>>
>>>>
>>>>>>            const char *compat, *isa, *mmu;
>>>>>>
>>>>>>            seq_printf(m, "hart\t: %lu\n", hart_id);
>>>>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>>>>> index e21ed481..97b586f8 100644
>>>>>> --- a/arch/riscv/kernel/setup.c
>>>>>> +++ b/arch/riscv/kernel/setup.c
>>>>>> @@ -84,6 +84,16 @@ atomic_t hart_lottery;
>>>>>>
>>>>>>     u64 __cpu_logical_map[NR_CPUS];
>>>>>>
>>>>>> +void __init smp_setup_processor_id(void)
>>>>>> +{
>>>>>> +       int cpu = smp_processor_id();
>>>>>> +
>>>>>> +       cpu_logical_map(0) = cpu;
>>>>>
>>>>>
>>>>>
>>>>> I think this should be:
>>>>> cpu_logical_map(cpu) = hart_id;
>>>>>
>>>>> Here hart_id for boot CPU will be value of a0 register passed at
>>>>> boot-time.
>>>>>
>>>> I will change the variable name to hart_id. The assembly code in head.S
>>>> have
>>>> already stored hart id in thread info structure. So smp_processor_id()
>>>> and
>>>> hart id would be the same.
>>>>
>>>>
>>>
>>> I guess this means that for boot CPU, cpuid == hartid
>>>
>>
>> No. I set the cpuid 0 for boot cpu by doing this.
>>
>> +       /* Change the boot cpu ID in thread_info */
>> +       current->thread_info.cpu = 0;
>>
>>> This is very confusing because other places I see CPU0 is the boot CPU.
>>>
>>
>> CPU0 is the boot cpu.
>>>
>>> I think assembly code in head.S should store 0 in thread info for boot
>>> CPU.
>>>
>> If we do that, we loose track of boot cpu hartid. We have to store it
>> somewhere else to update the cpu_logical_map(0). Isn't it ?
> 
> We can have variable of machine word size declared in assembly
> named "boot_cpu_hart_id" which will hold the hart ID of boot CPU.
> 
> No need to update thread_info.cpu on boot CPU. In fact, set
> thread_info.cpu to 0 in head.S itself.
> 

Hmm. That will work too. Thanks.

Atish
> Regards,
> Anup
> 

