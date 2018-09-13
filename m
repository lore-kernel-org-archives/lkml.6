Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1E2C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DCD204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qL/1DdeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DCD204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeIMXFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:05:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24012 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeIMXFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536861318; x=1568397318;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3E4/ATHJLOh+b1ScgrMNZVQ+6bBG79IYeG801uLNeVw=;
  b=qL/1DdeMJtvQ143vgbjOk1HjCSnPbbdaTcwC29lYem4WdQz6gEByBmRO
   Z/gKtop77wRaJCB4NniziHafyfFV+5IUzh7W+EY/Rm+kSj0iMa/eAaOw7
   9tKTlFjFaQHECt5DDbwC5EfP6SzfoA8jDz4CjNJ/GQDhomMWblmlw9hUY
   Szbr951MgSNHZTybr4+hC5iaQa/9Lnr0kAHLOGtXqrV8Gj5KzpVB9vmCk
   PxZ7KhszmcCgWvtEFQrPU3UYwwuORtCr13E5f9wwYv39wFN78N6jAhGEU
   k+7cvIHkiKvk3V8pHqQj8sOVyD8kHdsw1mdn1s8L+8T/Pv76dVs5Gch+1
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,370,1531756800"; 
   d="scan'208";a="89709051"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2018 01:51:56 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Sep 2018 10:38:16 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Sep 2018 10:51:56 -0700
Subject: Re: [PATCH v2] RISC-V: Show IPI stats
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180912143734.21205-1-anup@brainfault.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <feb149b3-d046-0074-c59a-c3c7c8c48f04@wdc.com>
Date:   Thu, 13 Sep 2018 10:51:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912143734.21205-1-anup@brainfault.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/18 7:37 AM, Anup Patel wrote:
> This patch provides arch_show_interrupts() implementation to
> show IPI stats via /proc/interrupts.
> 
> Now the contents of /proc/interrupts" will look like below:
>             CPU0       CPU1       CPU2       CPU3
>    8:         17          7          6         14  SiFive PLIC   8  virtio0
>   10:         10         10          9         11  SiFive PLIC  10  ttyS0
> IPI0:       170        673        251         79  Rescheduling interrupts
> IPI1:         1         12         27          1  Function call interrupts
> IPI2:         0          0          0          0  CPU wake-up interrupts
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
> 
> Changes since v1:
>   - Add stub inline show_ipi_stats() function for !CONFIG_SMP
>   - Make ipi_names[] dynamically sized at compile time
>   - Minor beautification of ipi_names[] using tabs
> 
>   arch/riscv/include/asm/smp.h |  9 +++++++++
>   arch/riscv/kernel/irq.c      |  8 ++++++++
>   arch/riscv/kernel/smp.c      | 30 ++++++++++++++++++++++++++++--
>   3 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 8145b8657d20..37e909c04f47 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -36,6 +36,8 @@ static inline bool can_hotplug_cpu(void)
>   static inline void arch_send_call_wakeup_ipi(int cpu) { }
>   #endif
>   
> +struct seq_file;
> +
>   #ifdef CONFIG_SMP
>   
>   enum ipi_message_type {
> @@ -48,6 +50,9 @@ enum ipi_message_type {
>   void send_ipi_message(const struct cpumask *to_whom,
>   		      enum ipi_message_type operation);
>   
> +/* print IPI stats */
> +void show_ipi_stats(struct seq_file *p, int prec);
> +
>   /* SMP initialization hook for setup_arch */
>   void __init setup_smp(void);
>   
> @@ -75,6 +80,10 @@ void boot_sec_cpu(void);
>   
>   #else
>   
> +static inline void show_ipi_stats(struct seq_file *p, int prec)
> +{
> +}
> +
>   static inline int riscv_hartid_to_cpuid(int hartid)
>   {
>   	return 0;
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index 7e14b0d9a71d..96202139ade5 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -8,6 +8,8 @@
>   #include <linux/interrupt.h>
>   #include <linux/irqchip.h>
>   #include <linux/irqdomain.h>
> +#include <linux/seq_file.h>
> +#include <asm/smp.h>
>   
>   /*
>    * Possible interrupt causes:
> @@ -24,6 +26,12 @@
>    */
>   #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
>   
> +int arch_show_interrupts(struct seq_file *p, int prec)
> +{
> +	show_ipi_stats(p, prec);
> +	return 0;
> +}
> +
>   asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
>   {
>   	struct pt_regs *old_regs = set_irq_regs(regs);
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 629456bb6122..70fd1351d6d9 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -22,6 +22,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/smp.h>
>   #include <linux/sched.h>
> +#include <linux/seq_file.h>
>   
>   #include <asm/sbi.h>
>   #include <asm/tlbflush.h>
> @@ -29,6 +30,7 @@
>   
>   /* A collection of single bit ipi messages.  */
>   static struct {
> +	unsigned long stats[IPI_MAX] ____cacheline_aligned;
>   	unsigned long bits ____cacheline_aligned;
>   } ipi_data[NR_CPUS] __cacheline_aligned;
>   
> @@ -61,6 +63,7 @@ int setup_profiling_timer(unsigned int multiplier)
>   void riscv_software_interrupt(void)
>   {
>   	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
> +	unsigned long *stats = ipi_data[smp_processor_id()].stats;
>   
>   	/* Clear pending IPI */
>   	csr_clear(sip, SIE_SSIE);
> @@ -75,11 +78,15 @@ void riscv_software_interrupt(void)
>   		if (ops == 0)
>   			return;
>   
> -		if (ops & (1 << IPI_RESCHEDULE))
> +		if (ops & (1 << IPI_RESCHEDULE)) {
> +			stats[IPI_RESCHEDULE]++;
>   			scheduler_ipi();
> +		}
>   
> -		if (ops & (1 << IPI_CALL_FUNC))
> +		if (ops & (1 << IPI_CALL_FUNC)) {
> +			stats[IPI_CALL_FUNC]++;
>   			generic_smp_call_function_interrupt();
> +		}
>   
>   		BUG_ON((ops >> IPI_MAX) != 0);
>   
> @@ -105,6 +112,25 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
>   	sbi_send_ipi(cpumask_bits(&hartid_mask));
>   }
>   
> +static const char *ipi_names[] = {
> +	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
> +	[IPI_CALL_FUNC]		= "Function call interrupts",
> +	[IPI_CALL_WAKEUP]	= "CPU wake-up interrupts",

There were some concerns about cpu hotplug patch which introduced 
IPI_CALL_WAKEUP. I have dropped it as of now from my series. I will send 
it as a separate patch. So we may want to add IPI_CALL_WAKEUP along with 
cpu hotplug patch which makes more sense to me.

Other than that, LGTM.

Regards,
Atish
> +};
> +
> +void show_ipi_stats(struct seq_file *p, int prec)
> +{
> +	unsigned int cpu, i;
> +
> +	for (i = 0; i < IPI_MAX; i++) {
> +		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
> +			   prec >= 4 ? " " : "");
> +		for_each_online_cpu(cpu)
> +			seq_printf(p, "%10lu ", ipi_data[cpu].stats[i]);
> +		seq_printf(p, " %s\n", ipi_names[i]);
> +	}
> +}
> +
>   void arch_send_call_function_ipi_mask(struct cpumask *mask)
>   {
>   	send_ipi_message(mask, IPI_CALL_FUNC);
> 

