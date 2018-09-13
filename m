Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF3C61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D5421477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D5421477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIMOqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:46:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:49364 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbeIMOqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:46:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 02:37:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,368,1531810800"; 
   d="scan'208";a="90093148"
Received: from svm-s2600wft.bj.intel.com ([10.240.193.45])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2018 02:37:50 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelly@microsoft.com,
        tianyu.lan@microsoft.com, Yi Sun <yi.y.sun@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v1 2/3] locking/pvqspinlock, hv: Enable PV qspinlock for Hyper-V
Date:   Thu, 13 Sep 2018 17:13:24 +0800
Message-Id: <1536830005-37260-3-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow PV spinlock mechanism to implement the callback functions
to allow the CPU idling and kicking operations on Hyper-V.

HVCALL_NOTIFY_LONG_SPIN_WAIT is a hypercall used by a guest OS to
notify the hypervisor that the calling virtual processor is attempting
to acquire a resource that is potentially held by another virtual
processor within the same partition. This scheduling hint improves the
scalability of partitions with more than one virtual processor.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 arch/x86/hyperv/Makefile        |  2 +-
 arch/x86/hyperv/hv_spinlock.c   | 99 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h |  3 ++
 arch/x86/kernel/smpboot.c       |  2 +
 4 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/hyperv/hv_spinlock.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index b21ee65..5b6937c 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,2 +1,2 @@
 obj-y			:= hv_init.o mmu.o nested.o
-obj-$(CONFIG_X86_64)	+= hv_apic.o
+obj-$(CONFIG_X86_64)	+= hv_apic.o hv_spinlock.o
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
new file mode 100644
index 0000000..134c89f
--- /dev/null
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V specific spinlock code.
+ *
+ * Copyright (C) 2018, Intel, Inc.
+ *
+ * Author : Yi Sun <yi.y.sun@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ */
+
+#include <linux/kernel_stat.h>
+#include <linux/spinlock.h>
+#include <linux/debugfs.h>
+#include <linux/log2.h>
+#include <linux/gfp.h>
+
+#include <asm/mshyperv.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/paravirt.h>
+#include <asm/qspinlock.h>
+#include <asm/apic.h>
+
+static bool hv_pvspin = true;
+static u32 spin_wait_info = 0;
+
+static void hv_notify_long_spin_wait(void)
+{
+	u64 input = spin_wait_info | 0x00000000ffffffff;
+
+	spin_wait_info++;
+	hv_do_fast_hypercall8(HVCALL_NOTIFY_LONG_SPIN_WAIT, input);
+}
+
+static void hv_qlock_kick(int cpu)
+{
+	spin_wait_info--;
+	apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
+}
+
+/*
+ * Halt the current CPU & release it back to the host
+ */
+static void hv_qlock_wait(u8 *byte, u8 val)
+{
+	unsigned long msr_val;
+
+	if (READ_ONCE(*byte) != val)
+		return;
+
+	hv_notify_long_spin_wait();
+
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
+		pr_warn("hv: PV spinlocks disabled\n");
+		return;
+	}
+	pr_info("hv: PV spinlocks enabled\n");
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
index f377044..ac36ea9 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -355,6 +355,8 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 static inline void hv_apic_init(void) {}
 #endif
 
+void __init hv_init_spinlocks(void);
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline bool hv_is_hyperv_initialized(void) { return false; }
@@ -368,6 +370,7 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 	return NULL;
 }
 static inline int hyperv_flush_guest_mapping(u64 as) { return -1; }
+void __init hv_init_spinlocks(void) {}
 #endif /* CONFIG_HYPERV */
 
 #ifdef CONFIG_HYPERV_TSCPAGE
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f02ecaf..8bf08ba 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -81,6 +81,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/spec-ctrl.h>
 #include <asm/hw_irq.h>
+#include <asm/mshyperv.h>
 
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
@@ -1335,6 +1336,7 @@ void __init native_smp_prepare_boot_cpu(void)
 	/* already set me in cpu_online_mask in boot_cpu_init() */
 	cpumask_set_cpu(me, cpu_callout_mask);
 	cpu_set_state_online(me);
+	hv_init_spinlocks();
 }
 
 void __init calculate_max_logical_packages(void)
-- 
1.9.1

