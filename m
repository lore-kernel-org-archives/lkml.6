Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628D6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DB4206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbfAIPsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:48:04 -0500
Received: from foss.arm.com ([217.140.101.70]:46472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731869AbfAIPsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:48:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A857BA78;
        Wed,  9 Jan 2019 07:48:02 -0800 (PST)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BAF53F5AF;
        Wed,  9 Jan 2019 07:47:59 -0800 (PST)
Subject: Re: [PATCH] ARM: irq: Add IRQ_SET_MASK_OK_DONE handling in
 migrate_one_irq()
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
References: <20190108135805.5535-1-dietmar.eggemann@arm.com>
 <9288fdeb-8eb1-28ca-f950-ccf36d63688a@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1fcb35b7-4105-e4b7-a528-eb48be876edf@arm.com>
Date:   Wed, 9 Jan 2019 16:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9288fdeb-8eb1-28ca-f950-ccf36d63688a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 1/8/19 3:16 PM, Marc Zyngier wrote:
> Hi Dietmar,
> 
> On 08/01/2019 13:58, Dietmar Eggemann wrote:
>> Arm TC2 (multi_v7_defconfig plus CONFIG_ARM_BIG_LITTLE_CPUFREQ=y and
>> CONFIG_ARM_VEXPRESS_SPC_CPUFREQ=y) fails hotplug stress tests.
>>
>> This issue was tracked down to a missing copy of the new affinity
>> cpumask of the vexpress-spc interrupt into struct
>> irq_common_data.affinity when the interrupt is migrated in
>> migrate_one_irq().
>>
>> Commit 0407daceedfe ("irqchip/gic: Return IRQ_SET_MASK_OK_DONE in the
>> set_affinity method") changed the return value of the irq_set_affinity()
>> function of the GIC from IRQ_SET_MASK_OK to IRQ_SET_MASK_OK_DONE.
>>
>> In migrate_one_irq() if the current irq affinity mask and the cpu
>> online mask do not share any CPU, the affinity mask is set to the cpu
>> online mask. In this case (ret == true) and when the irq chip
>> function irq_set_affinity() returns successfully (IRQ_SET_MASK_OK),
>> struct irq_common_data.affinity should also be updated.
>>
>> Add IRQ_SET_MASK_OK_DONE next to IRQ_SET_MASK_OK when checking that the
>> irq chip function irq_set_affinity() returns successfully.
>>
>> Commit 2cb625478f8c ("genirq: Add IRQ_SET_MASK_OK_DONE to support
>> stacked irqchip") only added IRQ_SET_MASK_OK_DONE handling to
>> irq_do_set_affinity() in the irq core and not to the Arm32 irq code.
>>
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> ---
>>
>> The hotplug issue on Arm TC2 happens because the vexpress-spc interrupt
>> (irq=22) is affine to CPU0. This occurs since it is setup early when the
>> cpu_online_mask is still 0.
>> But the problem with the missing copy of the affinity mask should occur
>> with every interrupt which is forced to migrate.
>>
>> With additional debug in irq_setup_affinity():
>>
>> [0.000619] irq_setup_affinity(): irq=17 mask=0 cpu_online_mask=0 set=0-4
>> [0.007065] irq_setup_affinity(): irq=22 mask=0 cpu_online_mask=0 set=0-4
>> [3.372907] irq_setup_affinity(): irq=47 mask=0-4 cpu_online_mask=0-4
>> set=0-4
>>
>> cat /proc/interrupts
>>             CPU0       CPU1       CPU2       CPU3       CPU4
>> 22:        316          0          0          0          0     GIC-0 127
>> Level     vexpress-spc
>>
>> cat /proc/irq/22/smp_affinity_list
>> 0

[...]

> 
> On the arm64 side, we've solved the exact same issue by getting rid of
> this code and using the generic implementation. See 217d453d473c5
> ("arm64: fix a migrating irq bug when hotplug cpu"), which uses
> irq_migrate_all_off_this_cpu instead.
> 
> I'm not sure there is much value in not using the core code in this case.

Thanks for the hint! Much more elegant! I tried the following on TC2 and 
it worked just fine. I'm not aware on any drawbacks of using the generic 
irq migration for Arm32 as well.

-- >8 --

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..26524b75970a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1400,6 +1400,7 @@ config NR_CPUS
  config HOTPLUG_CPU
         bool "Support for hot-pluggable CPUs"
         depends on SMP
+       select GENERIC_IRQ_MIGRATION
         help
           Say Y here to experiment with turning CPUs off and on.  CPUs
           can be controlled through /sys/devices/system/cpu.
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index c883fcbe93b6..46d41140df27 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -25,7 +25,6 @@
  #ifndef __ASSEMBLY__
  struct irqaction;
  struct pt_regs;
-extern void migrate_irqs(void);

  extern void asm_do_IRQ(unsigned int, struct pt_regs *);
  void handle_IRQ(unsigned int, struct pt_regs *);
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 9908dacf9229..844861368cd5 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -31,7 +31,6 @@
  #include <linux/smp.h>
  #include <linux/init.h>
  #include <linux/seq_file.h>
-#include <linux/ratelimit.h>
  #include <linux/errno.h>
  #include <linux/list.h>
  #include <linux/kallsyms.h>
@@ -109,64 +108,3 @@ int __init arch_probe_nr_irqs(void)
         return nr_irqs;
  }
  #endif
-
-#ifdef CONFIG_HOTPLUG_CPU
-static bool migrate_one_irq(struct irq_desc *desc)
-{
-       struct irq_data *d = irq_desc_get_irq_data(desc);
-       const struct cpumask *affinity = irq_data_get_affinity_mask(d);
-       struct irq_chip *c;
-       bool ret = false;
-
-       /*
-        * If this is a per-CPU interrupt, or the affinity does not
-        * include this CPU, then we have nothing to do.
-        */
-       if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), 
affinity))
-               return false;
-
-       if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
-               affinity = cpu_online_mask;
-               ret = true;
-       }
-
-       c = irq_data_get_irq_chip(d);
-       if (!c->irq_set_affinity)
-               pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-       else if (c->irq_set_affinity(d, affinity, false) == 
IRQ_SET_MASK_OK && ret)
-               cpumask_copy(irq_data_get_affinity_mask(d), affinity);
-
-       return ret;
-}
-
-/*
- * The current CPU has been marked offline.  Migrate IRQs off this CPU.
- * If the affinity settings do not allow other CPUs, force them onto any
- * available CPU.
- *
- * Note: we must iterate over all IRQs, whether they have an attached
- * action structure or not, as we need to get chained interrupts too.
- */
-void migrate_irqs(void)
-{
-       unsigned int i;
-       struct irq_desc *desc;
-       unsigned long flags;
-
-       local_irq_save(flags);
-
-       for_each_irq_desc(i, desc) {
-               bool affinity_broken;
-
-               raw_spin_lock(&desc->lock);
-               affinity_broken = migrate_one_irq(desc);
-               raw_spin_unlock(&desc->lock);
-
-               if (affinity_broken)
-                       pr_warn_ratelimited("IRQ%u no longer affine to 
CPU%u\n",
-                               i, smp_processor_id());
-       }
-
-       local_irq_restore(flags);
-}
-#endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3bf82232b1be..1d6f5ea522f4 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -254,7 +254,7 @@ int __cpu_disable(void)
         /*
          * OK - migrate IRQs away from this CPU
          */
-       migrate_irqs();
+       irq_migrate_all_off_this_cpu();

         /*
          * Flush user cache and TLB mappings, and then remove this CPU
