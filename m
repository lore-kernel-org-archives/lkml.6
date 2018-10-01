Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A87C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CD621477
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jR1Qe7kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CD621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeJAXVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:21:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35116 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeJAXVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:21:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so9653317pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=joTFncqOhr/5ceRUNjE9Oyw+p4mkklFna4saanIGUr0=;
        b=jR1Qe7kpM2bPlFjcayPpef2qaSv493wDBvaItSgQsC1IN60cavGYjmWWYnj2nZRBon
         TPE52pnPtBrpVvgZK7umoAFE9ducwk0S7e3/AxAGVAJ6PgnfCvvZrJMguwVIUXENKiVS
         Ewy5M+ehtgNcGYLjBnwGJa/pxWzkhSn7agfvmcBvX2q72SQndlC7YWOOyn4YOrS+4hmJ
         l5jELd0EJRmqI1ECYExl5AsCUtcdhOIrYUnqcB6w7q4s7wOUQ+fQacgw+9yvwi9OU8Gf
         YCDu67pknZINgwS2N3PlSgVi7Q3yVq1IyScKv8sEtqIMi/c4ChBqXXs/eycrOs+7oppz
         v6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=joTFncqOhr/5ceRUNjE9Oyw+p4mkklFna4saanIGUr0=;
        b=P0Pk1HzjRqHvwmxk9OyJRYUbzVzLKdnNw06NVzUBydpkEdjfOpPYzYW1qF6PrxwSJ4
         6BQByqJsYuSR5Y/RbQ7/4xrf3M1ygxMInlSKJ4SaYWPKD4cQTuGDWj+4x7RCjpss2wUX
         JwLnpvnFcWE5yLugojovC2QkJpKbDkEaxmQXy3dWt+xjBQ7gO82vMrnC8e23GfoIH74V
         yZssQUGquXxsoPIey5+HDMGQet8LhFskFwCu5yB891UnIjXpAEvg4DY77jtYH7mhpEYX
         tvCd2siDotaqrQo8Nqa4HKpCmzQOCQHID1QhlFIZxGITKr6jyRtOEhhM/y47b+P2ArYL
         gJUg==
X-Gm-Message-State: ABuFfohlOTJrgnXhJuGPLacBsIpP23RelAof34V7Tj3iCmlCM1L/ff/B
        KHj34IAJoeSQzGn22pup5cgYGA==
X-Google-Smtp-Source: ACcGV63gGBuNO9SdnT1fdrnVTvXsBkzWsZvRkTQo7QBoKhAooAUBdAoyyfDTIYQzF2Qz4m+MrqXb4A==
X-Received: by 2002:a63:4e11:: with SMTP id c17-v6mr10925725pgb.6.1538412162731;
        Mon, 01 Oct 2018 09:42:42 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e9-v6sm4601457pgs.92.2018.10.01.09.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 09:42:41 -0700 (PDT)
Date:   Mon, 01 Oct 2018 09:42:41 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Oct 2018 09:41:40 PDT (-0700)
Subject:     Re: [PATCH v3] RISC-V: Show IPI stats
In-Reply-To: <20180929062605.12888-1-anup@brainfault.org>
CC:     aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org, Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-db76292c-f906-4cc7-abe6-de6dac888c78@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 23:26:05 PDT (-0700), anup@brainfault.org wrote:
> This patch provides arch_show_interrupts() implementation to
> show IPI stats via /proc/interrupts.
>
> Now the contents of /proc/interrupts" will look like below:
>            CPU0       CPU1       CPU2       CPU3
>   8:         17          7          6         14  SiFive PLIC   8  virtio0
>  10:         10         10          9         11  SiFive PLIC  10  ttyS0
> IPI0:       170        673        251         79  Rescheduling interrupts
> IPI1:         1         12         27          1  Function call interrupts
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
>
> Changes since v2:
>  - Remove use of IPI_CALL_WAKEUP because it's being removed
>
> Changes since v1:
>  - Add stub inline show_ipi_stats() function for !CONFIG_SMP
>  - Make ipi_names[] dynamically sized at compile time
>  - Minor beautification of ipi_names[] using tabs

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

This is going in through Atish's patch set.

>
> ---
>  arch/riscv/include/asm/smp.h |  9 +++++++++
>  arch/riscv/kernel/irq.c      |  8 ++++++++
>  arch/riscv/kernel/smp.c      | 39 +++++++++++++++++++++++++++++-------
>  3 files changed, 49 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index fce312ce3516..5278ae8f1346 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -25,8 +25,13 @@
>  extern unsigned long __cpuid_to_hardid_map[NR_CPUS];
>  #define cpuid_to_hardid_map(cpu)    __cpuid_to_hardid_map[cpu]
>
> +struct seq_file;
> +
>  #ifdef CONFIG_SMP
>
> +/* print IPI stats */
> +void show_ipi_stats(struct seq_file *p, int prec);
> +
>  /* SMP initialization hook for setup_arch */
>  void __init setup_smp(void);
>
> @@ -47,6 +52,10 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>
>  #else
>
> +static inline void show_ipi_stats(struct seq_file *p, int prec)
> +{
> +}
> +
>  static inline int riscv_hartid_to_cpuid(int hartid)
>  {
>  	return 0;
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index ca4593317e45..48e6b7db83a1 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -8,6 +8,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/irqchip.h>
>  #include <linux/irqdomain.h>
> +#include <linux/seq_file.h>
> +#include <asm/smp.h>
>
>  /*
>   * Possible interrupt causes:
> @@ -24,6 +26,12 @@
>   */
>  #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
>
> +int arch_show_interrupts(struct seq_file *p, int prec)
> +{
> +	show_ipi_stats(p, prec);
> +	return 0;
> +}
> +
>  asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs)
>  {
>  	struct pt_regs *old_regs = set_irq_regs(regs);
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 89d95866f562..686fa7a427ff 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -22,22 +22,24 @@
>  #include <linux/interrupt.h>
>  #include <linux/smp.h>
>  #include <linux/sched.h>
> +#include <linux/seq_file.h>
>
>  #include <asm/sbi.h>
>  #include <asm/tlbflush.h>
>  #include <asm/cacheflush.h>
>
> -/* A collection of single bit ipi messages.  */
> -static struct {
> -	unsigned long bits ____cacheline_aligned;
> -} ipi_data[NR_CPUS] __cacheline_aligned;
> -
>  enum ipi_message_type {
>  	IPI_RESCHEDULE,
>  	IPI_CALL_FUNC,
>  	IPI_MAX
>  };
>
> +/* A collection of single bit ipi messages.  */
> +static struct {
> +	unsigned long stats[IPI_MAX] ____cacheline_aligned;
> +	unsigned long bits ____cacheline_aligned;
> +} ipi_data[NR_CPUS] __cacheline_aligned;
> +
>  int riscv_hartid_to_cpuid(int hartid)
>  {
>  	int i = -1;
> @@ -67,6 +69,7 @@ int setup_profiling_timer(unsigned int multiplier)
>  void riscv_software_interrupt(void)
>  {
>  	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
> +	unsigned long *stats = ipi_data[smp_processor_id()].stats;
>
>  	/* Clear pending IPI */
>  	csr_clear(sip, SIE_SSIE);
> @@ -81,11 +84,15 @@ void riscv_software_interrupt(void)
>  		if (ops == 0)
>  			return;
>
> -		if (ops & (1 << IPI_RESCHEDULE))
> +		if (ops & (1 << IPI_RESCHEDULE)) {
> +			stats[IPI_RESCHEDULE]++;
>  			scheduler_ipi();
> +		}
>
> -		if (ops & (1 << IPI_CALL_FUNC))
> +		if (ops & (1 << IPI_CALL_FUNC)) {
> +			stats[IPI_CALL_FUNC]++;
>  			generic_smp_call_function_interrupt();
> +		}
>
>  		BUG_ON((ops >> IPI_MAX) != 0);
>
> @@ -111,6 +118,24 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
>  	sbi_send_ipi(cpumask_bits(&hartid_mask));
>  }
>
> +static const char *ipi_names[] = {
> +	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
> +	[IPI_CALL_FUNC]		= "Function call interrupts",
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
>  void arch_send_call_function_ipi_mask(struct cpumask *mask)
>  {
>  	send_ipi_message(mask, IPI_CALL_FUNC);
