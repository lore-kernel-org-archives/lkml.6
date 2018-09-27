Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B52BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E672156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E672156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeI0MnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:43:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:18432 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbeI0MnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:43:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 23:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,309,1534834800"; 
   d="scan'208";a="74048263"
Received: from svm-s2600wft.bj.intel.com ([10.240.193.45])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2018 23:26:34 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, chao.p.peng@intel.com,
        chao.gao@intel.com, isaku.yamahata@intel.com,
        michael.h.kelley@microsoft.com, tianyu.lan@microsoft.com,
        Yi Sun <yi.y.sun@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH v3 2/2] locking/pvqspinlock, hv: Enable PV qspinlock for Hyper-V
Date:   Thu, 27 Sep 2018 14:01:44 +0800
Message-Id: <1538028104-114050-3-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538028104-114050-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1538028104-114050-1-git-send-email-yi.y.sun@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow PV spinlock mechanism to implement the callback functions
to allow the CPU idling and kicking operations on Hyper-V.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
v2->v3:
    - use "Hyper-V: " as the message prefix
      (suggested by Michael Kelley)
    - remove unnecessary header files
      (suggested by Michael Kelley)
    - remove unnecessary check in 'hv_qlock_wait'
      (suggested by Michael Kelley)
    - fix compilation error on different platforms
      (suggested by Thomas Gleixner)
---
 Documentation/admin-guide/kernel-parameters.txt |  5 ++
 arch/x86/hyperv/Makefile                        |  4 ++
 arch/x86/hyperv/hv_spinlock.c                   | 76 +++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h                 |  1 +
 arch/x86/kernel/cpu/mshyperv.c                  | 14 +++++
 5 files changed, 100 insertions(+)
 create mode 100644 arch/x86/hyperv/hv_spinlock.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92eb1f4..0fc8448 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1385,6 +1385,11 @@
 	hvc_iucv_allow=	[S390]	Comma-separated list of z/VM user IDs.
 				If specified, z/VM IUCV HVC accepts connections
 				from listed z/VM user IDs only.
+
+	hv_nopvspin	[X86,HYPER_V]
+			Disables the ticketlock slowpath using HYPER-V PV
+			optimizations.
+
 	keep_bootcon	[KNL]
 			Do not unregister boot console at start. This is only
 			useful for debugging when something happens in the window
diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index b21ee65..1c11f94 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,2 +1,6 @@
 obj-y			:= hv_init.o mmu.o nested.o
 obj-$(CONFIG_X86_64)	+= hv_apic.o
+
+ifdef CONFIG_X86_64
+obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
+endif
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
new file mode 100644
index 0000000..e8fe997
--- /dev/null
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V specific spinlock code.
+ *
+ * Copyright (C) 2018, Intel, Inc.
+ *
+ * Author : Yi Sun <yi.y.sun@intel.com>
+ */
+
+#define pr_fmt(fmt) "Hyper-V: " fmt
+
+#include <linux/spinlock.h>
+
+#include <asm/mshyperv.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/paravirt.h>
+#include <asm/qspinlock.h>
+#include <asm/apic.h>
+
+static bool __initdata hv_pvspin = true;
+
+static void hv_qlock_kick(int cpu)
+{
+	apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
+}
+
+static void hv_qlock_wait(u8 *byte, u8 val)
+{
+	unsigned long msr_val;
+
+	if (READ_ONCE(*byte) != val)
+		return;
+
+	/*
+	 * Read HV_X64_MSR_GUEST_IDLE MSR can trigger the guest's
+	 * transition to the idle power state which can be exited
+	 * by an IPI even if IF flag is disabled.
+	 */
+	rdmsrl(HV_X64_MSR_GUEST_IDLE, msr_val);
+}
+
+/*
+ * Hyper-V does not support this so far.
+ */
+bool hv_vcpu_is_preempted(int vcpu)
+{
+	return false;
+}
+PV_CALLEE_SAVE_REGS_THUNK(hv_vcpu_is_preempted);
+
+void __init hv_init_spinlocks(void)
+{
+	if (!hv_pvspin ||
+	    !apic ||
+	    !(ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) ||
+	    !(ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)) {
+		pr_info("PV spinlocks disabled\n");
+		return;
+	}
+	pr_info("PV spinlocks enabled\n");
+
+	__pv_init_lock_hash();
+	pv_lock_ops.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
+	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	pv_lock_ops.wait = hv_qlock_wait;
+	pv_lock_ops.kick = hv_qlock_kick;
+	pv_lock_ops.vcpu_is_preempted = PV_CALLEE_SAVE(hv_vcpu_is_preempted);
+}
+
+static __init int hv_parse_nopvspin(char *arg)
+{
+	hv_pvspin = false;
+	return 0;
+}
+early_param("hv_nopvspin", hv_parse_nopvspin);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f377044..759cfd2 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -351,6 +351,7 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
+void __init hv_init_spinlocks(void);
 #else
 static inline void hv_apic_init(void) {}
 #endif
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index ad12733..a5cc219 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -199,6 +199,16 @@ static unsigned long hv_get_tsc_khz(void)
 	return freq / 1000;
 }
 
+#if defined(CONFIG_SMP) && IS_ENABLED(CONFIG_HYPERV)
+static void __init hv_smp_prepare_boot_cpu(void)
+{
+	native_smp_prepare_boot_cpu();
+#if defined(CONFIG_X86_64) && defined(CONFIG_PARAVIRT_SPINLOCKS)
+	hv_init_spinlocks();
+#endif
+}
+#endif
+
 static void __init ms_hyperv_init_platform(void)
 {
 	int hv_host_info_eax;
@@ -303,6 +313,10 @@ static void __init ms_hyperv_init_platform(void)
 	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
 		alloc_intr_gate(HYPERV_STIMER0_VECTOR,
 				hv_stimer0_callback_vector);
+
+#if defined(CONFIG_SMP)
+	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
+#endif
 #endif
 }
 
-- 
1.9.1

