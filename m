Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeESL2D (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:28:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41479 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeESL2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:28:00 -0400
Date: Sat, 19 May 2018 04:27:52 -0700
From: "tip-bot for K. Y. Srinivasan" <tipbot@zytor.com>
Message-ID: <tip-6b48cb5f8347bc0153ff1d7b075db92e6723ffdb@git.kernel.org>
Cc: kys@microsoft.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: mikelley@microsoft.com, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, kys@microsoft.com
In-Reply-To: <20180516215334.6547-1-kys@linuxonhyperv.com>
References: <20180516215334.6547-1-kys@linuxonhyperv.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] X86/Hyper-V: Enlighten APIC access
Git-Commit-ID: 6b48cb5f8347bc0153ff1d7b075db92e6723ffdb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6b48cb5f8347bc0153ff1d7b075db92e6723ffdb
Gitweb:     https://git.kernel.org/tip/6b48cb5f8347bc0153ff1d7b075db92e6723ffdb
Author:     K. Y. Srinivasan <kys@microsoft.com>
AuthorDate: Wed, 16 May 2018 14:53:30 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 13:23:17 +0200

X86/Hyper-V: Enlighten APIC access

Hyper-V supports MSR based APIC access; implement
the enlightenment.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: olaf@aepfle.de
Cc: sthemmin@microsoft.com
Cc: gregkh@linuxfoundation.org
Cc: jasowang@redhat.com
Cc: Michael.H.Kelley@microsoft.com
Cc: hpa@zytor.com
Cc: apw@canonical.com
Cc: devel@linuxdriverproject.org
Cc: vkuznets@redhat.com
Link: https://lkml.kernel.org/r/20180516215334.6547-1-kys@linuxonhyperv.com

---
 arch/x86/hyperv/Makefile        |   2 +-
 arch/x86/hyperv/hv_apic.c       | 104 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c       |   5 +-
 arch/x86/include/asm/mshyperv.h |   4 +-
 4 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 367a8203cfcf..00ce4df01a09 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1 +1 @@
-obj-y		:= hv_init.o mmu.o
+obj-y		:= hv_init.o mmu.o hv_apic.o
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
new file mode 100644
index 000000000000..ca20e31d311c
--- /dev/null
+++ b/arch/x86/hyperv/hv_apic.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V specific APIC code.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : K. Y. Srinivasan <kys@microsoft.com>
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
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/clockchips.h>
+#include <linux/hyperv.h>
+#include <linux/slab.h>
+#include <linux/cpuhotplug.h>
+#include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
+
+#ifdef CONFIG_X86_64
+#if IS_ENABLED(CONFIG_HYPERV)
+
+static u64 hv_apic_icr_read(void)
+{
+	u64 reg_val;
+
+	rdmsrl(HV_X64_MSR_ICR, reg_val);
+	return reg_val;
+}
+
+static void hv_apic_icr_write(u32 low, u32 id)
+{
+	u64 reg_val;
+
+	reg_val = SET_APIC_DEST_FIELD(id);
+	reg_val = reg_val << 32;
+	reg_val |= low;
+
+	wrmsrl(HV_X64_MSR_ICR, reg_val);
+}
+
+static u32 hv_apic_read(u32 reg)
+{
+	u32 reg_val, hi;
+
+	switch (reg) {
+	case APIC_EOI:
+		rdmsr(HV_X64_MSR_EOI, reg_val, hi);
+		return reg_val;
+	case APIC_TASKPRI:
+		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
+		return reg_val;
+
+	default:
+		return native_apic_mem_read(reg);
+	}
+}
+
+static void hv_apic_write(u32 reg, u32 val)
+{
+	switch (reg) {
+	case APIC_EOI:
+		wrmsr(HV_X64_MSR_EOI, val, 0);
+		break;
+	case APIC_TASKPRI:
+		wrmsr(HV_X64_MSR_TPR, val, 0);
+		break;
+	default:
+		native_apic_mem_write(reg, val);
+	}
+}
+
+static void hv_apic_eoi_write(u32 reg, u32 val)
+{
+	wrmsr(HV_X64_MSR_EOI, val, 0);
+}
+
+void __init hv_apic_init(void)
+{
+	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
+		pr_info("Hyper-V: Using MSR based APIC access\n");
+		apic_set_eoi_write(hv_apic_eoi_write);
+		apic->read      = hv_apic_read;
+		apic->write     = hv_apic_write;
+		apic->icr_write = hv_apic_icr_write;
+		apic->icr_read  = hv_apic_icr_read;
+	}
+}
+
+#endif /* CONFIG_HYPERV */
+#endif /* CONFIG_X86_64 */
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index cfecc2272f2d..71e50fc2b7ef 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -242,8 +242,9 @@ static int hv_cpu_die(unsigned int cpu)
  *
  * 1. Setup the hypercall page.
  * 2. Register Hyper-V specific clocksource.
+ * 3. Setup Hyper-V specific APIC entry points.
  */
-void hyperv_init(void)
+void __init hyperv_init(void)
 {
 	u64 guest_id, required_msrs;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
@@ -298,6 +299,8 @@ void hyperv_init(void)
 
 	hyper_alloc_mmu();
 
+	hv_apic_init();
+
 	/*
 	 * Register Hyper-V specific clocksource.
 	 */
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index b90e79610cf7..162977b82e2e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -258,7 +258,7 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
 	return hv_vp_index[cpu_number];
 }
 
-void hyperv_init(void);
+void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
 void hyper_alloc_mmu(void);
 void hyperv_report_panic(struct pt_regs *regs, long err);
@@ -269,6 +269,7 @@ void hyperv_reenlightenment_intr(struct pt_regs *regs);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
+void hv_apic_init(void);
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline bool hv_is_hyperv_initialized(void) { return false; }
@@ -277,6 +278,7 @@ static inline void hyperv_setup_mmu_ops(void) {}
 static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
 static inline void clear_hv_tscchange_cb(void) {}
 static inline void hyperv_stop_tsc_emulation(void) {};
+static inline void hv_apic_init(void) {}
 static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 {
 	return NULL;
