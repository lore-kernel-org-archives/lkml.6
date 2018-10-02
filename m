Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C592C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B24E2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oKyiDapa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B24E2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJCCCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:02:44 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42528 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeJCCCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538507872; x=1570043872;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=E1KOn4rciIRPi9bZ8v8PX8BwS1VpD/6J0Pz4Ku6iQ0s=;
  b=oKyiDapaKanPQM/qISw+880MujxvXgSi25WssNxDqlGEIFN7q5WmpMq9
   PPOmi1s/qf864Ha3vZHqTHV3o27B603QYX8RW9+wipNFbG20pO8hXgW3z
   361IBTqjDjXzJ+JeoeutKHO7lFAXIqHxEKhjN5/7Ifv7jRyLxlu5siGId
   qlncdrgecbPz7ILAdGyA6dMupsC/te2ZhJXUnmSEq1aVd2KDUudq5nM3h
   E4xKTE3OZ5MTXCUC3SXLEJ/izs+HOkOOXNrjo/vH4u/lB9dyr7vdA3ozo
   RzPs9mVGVw3a+u4RmsVoe2Bonk4SeqOLWv8o4ub6w7qG3ldfA0o5Q9lJ+
   g==;
X-IronPort-AV: E=Sophos;i="5.54,332,1534780800"; 
   d="scan'208";a="92733061"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 03:17:52 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Oct 2018 12:03:32 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2018 12:17:52 -0700
Subject: Re: [PATCH v3] RISC-V: Show IPI stats
To:     Palmer Dabbelt <palmer@sifive.com>,
        "anup@brainfault.org" <anup@brainfault.org>
Cc:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <mhng-db76292c-f906-4cc7-abe6-de6dac888c78@palmer-si-x1c4>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <7c46ba56-dfed-0088-ab85-12309ea20580@wdc.com>
Date:   Tue, 2 Oct 2018 12:17:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <mhng-db76292c-f906-4cc7-abe6-de6dac888c78@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/18 9:42 AM, Palmer Dabbelt wrote:
> On Fri, 28 Sep 2018 23:26:05 PDT (-0700), anup@brainfault.org wrote:
>> This patch provides arch_show_interrupts() implementation to
>> show IPI stats via /proc/interrupts.
>>
>> Now the contents of /proc/interrupts" will look like below:
>>             CPU0       CPU1       CPU2       CPU3
>>    8:         17          7          6         14  SiFive PLIC   8  virtio0
>>   10:         10         10          9         11  SiFive PLIC  10  ttyS0
>> IPI0:       170        673        251         79  Rescheduling interrupts
>> IPI1:         1         12         27          1  Function call interrupts
>>
>> Signed-off-by: Anup Patel <anup@brainfault.org>
>>
>> Changes since v2:
>>   - Remove use of IPI_CALL_WAKEUP because it's being removed
>>
>> Changes since v1:
>>   - Add stub inline show_ipi_stats() function for !CONFIG_SMP
>>   - Make ipi_names[] dynamically sized at compile time
>>   - Minor beautification of ipi_names[] using tabs
> 
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> 
> This is going in through Atish's patch set.
> 

Sent.

Regards,
Atish
>>
>> ---
>>   arch/riscv/include/asm/smp.h |  9 +++++++++
>>   arch/riscv/kernel/irq.c      |  8 ++++++++
>>   arch/riscv/kernel/smp.c      | 39 +++++++++++++++++++++++++++++-------
>>   3 files changed, 49 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
>> index fce312ce3516..5278ae8f1346 100644
>> --- a/arch/riscv/include/asm/smp.h
>> +++ b/arch/riscv/include/asm/smp.h
>> @@ -25,8 +25,13 @@
>>   extern unsigned long __cpuid_to_hardid_map[NR_CPUS];
>>   #define cpuid_to_hardid_map(cpu)    __cpuid_to_hardid_map[cpu]
>>
>> +struct seq_file;
>> +
>>   #ifdef CONFIG_SMP
>>
>> +/* print IPI stats */
>> +void show_ipi_stats(struct seq_file *p, int prec);
>> +
>>   /* SMP initialization hook for setup_arch */
>>   void __init setup_smp(void);
>>
>> @@ -47,6 +52,10 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>>
>>   #else
>>
>> +static inline void show_ipi_stats(struct seq_file *p, int prec)
>> +{
>> +}
>> +
>>   static inline int riscv_hartid_to_cpuid(int hartid)
>>   {
>>   	return 0;
>> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
>> index ca4593317e45..48e6b7db83a1 100644
>> --- a/arch/riscv/kernel/irq.c
>> +++ b/arch/riscv/kernel/irq.c
>> @@ -8,6 +8,8 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/irqchip.h>
>>   #include <linux/irqdomain.h>
>> +#include <linux/seq_file.h>
>> +#include <asm/smp.h>
>>
>>   /*
>>    * Possible interrupt causes:
>> @@ -24,6 +26,12 @@
>>    */
>>   #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
>>
>> +int arch_show_interrupts(struct seq_file *p, int prec)
>> +{
>> +	show_ipi_stats(p, prec);
>> +	return 0;
>> +}
>> +
>>   asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs)
>>   {
>>   	struct pt_regs *old_regs = set_irq_regs(regs);
>> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
>> index 89d95866f562..686fa7a427ff 100644
>> --- a/arch/riscv/kernel/smp.c
>> +++ b/arch/riscv/kernel/smp.c
>> @@ -22,22 +22,24 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/smp.h>
>>   #include <linux/sched.h>
>> +#include <linux/seq_file.h>
>>
>>   #include <asm/sbi.h>
>>   #include <asm/tlbflush.h>
>>   #include <asm/cacheflush.h>
>>
>> -/* A collection of single bit ipi messages.  */
>> -static struct {
>> -	unsigned long bits ____cacheline_aligned;
>> -} ipi_data[NR_CPUS] __cacheline_aligned;
>> -
>>   enum ipi_message_type {
>>   	IPI_RESCHEDULE,
>>   	IPI_CALL_FUNC,
>>   	IPI_MAX
>>   };
>>
>> +/* A collection of single bit ipi messages.  */
>> +static struct {
>> +	unsigned long stats[IPI_MAX] ____cacheline_aligned;
>> +	unsigned long bits ____cacheline_aligned;
>> +} ipi_data[NR_CPUS] __cacheline_aligned;
>> +
>>   int riscv_hartid_to_cpuid(int hartid)
>>   {
>>   	int i = -1;
>> @@ -67,6 +69,7 @@ int setup_profiling_timer(unsigned int multiplier)
>>   void riscv_software_interrupt(void)
>>   {
>>   	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
>> +	unsigned long *stats = ipi_data[smp_processor_id()].stats;
>>
>>   	/* Clear pending IPI */
>>   	csr_clear(sip, SIE_SSIE);
>> @@ -81,11 +84,15 @@ void riscv_software_interrupt(void)
>>   		if (ops == 0)
>>   			return;
>>
>> -		if (ops & (1 << IPI_RESCHEDULE))
>> +		if (ops & (1 << IPI_RESCHEDULE)) {
>> +			stats[IPI_RESCHEDULE]++;
>>   			scheduler_ipi();
>> +		}
>>
>> -		if (ops & (1 << IPI_CALL_FUNC))
>> +		if (ops & (1 << IPI_CALL_FUNC)) {
>> +			stats[IPI_CALL_FUNC]++;
>>   			generic_smp_call_function_interrupt();
>> +		}
>>
>>   		BUG_ON((ops >> IPI_MAX) != 0);
>>
>> @@ -111,6 +118,24 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
>>   	sbi_send_ipi(cpumask_bits(&hartid_mask));
>>   }
>>
>> +static const char *ipi_names[] = {
>> +	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
>> +	[IPI_CALL_FUNC]		= "Function call interrupts",
>> +};
>> +
>> +void show_ipi_stats(struct seq_file *p, int prec)
>> +{
>> +	unsigned int cpu, i;
>> +
>> +	for (i = 0; i < IPI_MAX; i++) {
>> +		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
>> +			   prec >= 4 ? " " : "");
>> +		for_each_online_cpu(cpu)
>> +			seq_printf(p, "%10lu ", ipi_data[cpu].stats[i]);
>> +		seq_printf(p, " %s\n", ipi_names[i]);
>> +	}
>> +}
>> +
>>   void arch_send_call_function_ipi_mask(struct cpumask *mask)
>>   {
>>   	send_ipi_message(mask, IPI_CALL_FUNC);
> 

