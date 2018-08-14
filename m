Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95863C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ECA21653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37ECA21653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390229AbeHNUaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:30:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59172 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390186AbeHNUaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:11 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0CA9FDA1;
        Tue, 14 Aug 2018 17:32:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.17 83/97] x86: Dont include linux/irq.h from asm/hardirq.h
Date:   Tue, 14 Aug 2018 19:17:35 +0200
Message-Id: <20180814171436.299722238@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolai Stange <nstange@suse.de>

commit 447ae316670230d7d29430e2cbf1f5db4f49d14c upstream

The next patch in this series will have to make the definition of
irq_cpustat_t available to entering_irq().

Inclusion of asm/hardirq.h into asm/apic.h would cause circular header
dependencies like

  asm/smp.h
    asm/apic.h
      asm/hardirq.h
        linux/irq.h
          linux/topology.h
            linux/smp.h
              asm/smp.h

or

  linux/gfp.h
    linux/mmzone.h
      asm/mmzone.h
        asm/mmzone_64.h
          asm/smp.h
            asm/apic.h
              asm/hardirq.h
                linux/irq.h
                  linux/irqdesc.h
                    linux/kobject.h
                      linux/sysfs.h
                        linux/kernfs.h
                          linux/idr.h
                            linux/gfp.h

and others.

This causes compilation errors because of the header guards becoming
effective in the second inclusion: symbols/macros that had been defined
before wouldn't be available to intermediate headers in the #include chain
anymore.

A possible workaround would be to move the definition of irq_cpustat_t
into its own header and include that from both, asm/hardirq.h and
asm/apic.h.

However, this wouldn't solve the real problem, namely asm/harirq.h
unnecessarily pulling in all the linux/irq.h cruft: nothing in
asm/hardirq.h itself requires it. Also, note that there are some other
archs, like e.g. arm64, which don't have that #include in their
asm/hardirq.h.

Remove the linux/irq.h #include from x86' asm/hardirq.h.

Fix resulting compilation errors by adding appropriate #includes to *.c
files as needed.

Note that some of these *.c files could be cleaned up a bit wrt. to their
set of #includes, but that should better be done from separate patches, if
at all.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/dmi.h                                   |    2 +-
 arch/x86/include/asm/hardirq.h                               |    1 -
 arch/x86/include/asm/kvm_host.h                              |    1 +
 arch/x86/kernel/apic/apic.c                                  |    1 +
 arch/x86/kernel/apic/io_apic.c                               |    1 +
 arch/x86/kernel/apic/msi.c                                   |    1 +
 arch/x86/kernel/apic/vector.c                                |    1 +
 arch/x86/kernel/fpu/core.c                                   |    1 +
 arch/x86/kernel/hpet.c                                       |    1 +
 arch/x86/kernel/i8259.c                                      |    1 +
 arch/x86/kernel/idt.c                                        |    1 +
 arch/x86/kernel/irq.c                                        |    1 +
 arch/x86/kernel/irq_32.c                                     |    1 +
 arch/x86/kernel/irq_64.c                                     |    1 +
 arch/x86/kernel/irqinit.c                                    |    1 +
 arch/x86/kernel/smpboot.c                                    |    1 +
 arch/x86/kernel/time.c                                       |    1 +
 arch/x86/mm/pti.c                                            |    1 +
 arch/x86/platform/intel-mid/device_libs/platform_mrfld_wdt.c |    1 +
 arch/x86/xen/enlighten.c                                     |    1 +
 drivers/gpu/drm/i915/i915_pmu.c                              |    1 +
 drivers/gpu/drm/i915/intel_lpe_audio.c                       |    1 +
 drivers/pci/host/pci-hyperv.c                                |    2 ++
 23 files changed, 23 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/dmi.h
+++ b/arch/x86/include/asm/dmi.h
@@ -4,8 +4,8 @@
 
 #include <linux/compiler.h>
 #include <linux/init.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/setup.h>
 
 static __always_inline __init void *dmi_alloc(unsigned len)
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -3,7 +3,6 @@
 #define _ASM_X86_HARDIRQ_H
 
 #include <linux/threads.h>
-#include <linux/irq.h>
 
 typedef struct {
 	u16	     __softirq_pending;
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -17,6 +17,7 @@
 #include <linux/tracepoint.h>
 #include <linux/cpumask.h>
 #include <linux/irq_work.h>
+#include <linux/irq.h>
 
 #include <linux/kvm.h>
 #include <linux/kvm_para.h>
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -56,6 +56,7 @@
 #include <asm/hypervisor.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/irq_regs.h>
 
 unsigned int num_processors;
 
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -33,6 +33,7 @@
 
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -12,6 +12,7 @@
  */
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/dmar.h>
 #include <linux/hpet.h>
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/compiler.h>
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -10,6 +10,7 @@
 #include <asm/fpu/signal.h>
 #include <asm/fpu/types.h>
 #include <asm/traps.h>
+#include <asm/irq_regs.h>
 
 #include <linux/hardirq.h>
 #include <linux/pkeys.h>
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1,6 +1,7 @@
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/export.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/timex.h>
 #include <linux/random.h>
 #include <linux/init.h>
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -8,6 +8,7 @@
 #include <asm/traps.h>
 #include <asm/proto.h>
 #include <asm/desc.h>
+#include <asm/hw_irq.h>
 
 struct idt_data {
 	unsigned int	vector;
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -10,6 +10,7 @@
 #include <linux/ftrace.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/irq.h>
 
 #include <asm/apic.h>
 #include <asm/io_apic.h>
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -11,6 +11,7 @@
 
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel_stat.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -11,6 +11,7 @@
 
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/delay.h>
 #include <linux/ftrace.h>
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/timex.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -80,6 +80,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/spec-ctrl.h>
+#include <asm/hw_irq.h>
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -12,6 +12,7 @@
 
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/i8253.h>
 #include <linux/time.h>
 #include <linux/export.h>
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -45,6 +45,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
+#include <asm/sections.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)     "Kernel/User page tables isolation: " fmt
--- a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_wdt.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_mrfld_wdt.c
@@ -18,6 +18,7 @@
 #include <asm/intel-mid.h>
 #include <asm/intel_scu_ipc.h>
 #include <asm/io_apic.h>
+#include <asm/hw_irq.h>
 
 #define TANGIER_EXT_TIMER0_MSI 12
 
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -3,6 +3,7 @@
 #endif
 #include <linux/cpu.h>
 #include <linux/kexec.h>
+#include <linux/slab.h>
 
 #include <xen/features.h>
 #include <xen/page.h>
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -24,6 +24,7 @@
 
 #include <linux/perf_event.h>
 #include <linux/pm_runtime.h>
+#include <linux/irq.h>
 
 #include "i915_drv.h"
 #include "i915_pmu.h"
--- a/drivers/gpu/drm/i915/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/intel_lpe_audio.c
@@ -62,6 +62,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -43,6 +43,8 @@
 #include <linux/delay.h>
 #include <linux/semaphore.h>
 #include <linux/irqdomain.h>
+#include <linux/irq.h>
+
 #include <asm/irqdomain.h>
 #include <asm/apic.h>
 #include <linux/msi.h>


