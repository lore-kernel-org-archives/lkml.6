Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2BFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F585214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="B+pFZc5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F585214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeLEKLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:11:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57788 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbeLEKLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:11:42 -0500
Received: from zn.tnic (p200300EC2BC0990051FFCFE3F32718FA.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:9900:51ff:cfe3:f327:18fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9EB01EC02AE;
        Wed,  5 Dec 2018 11:11:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544004700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=D0kAQifcv1AJd7CeN0yhNS24jm0RukjKB6/AnaurMlQ=;
        b=B+pFZc5SpeirodWABVyvghVXt7SqVWm+ZKnzVAVspVwd5k1yZRMYjQq2dAMo4MSa9Nc2JK
        vs0XOoSJ6GqcRv64Kv0DEtUiBUgwTR3QAe7z/UAhtA4SfTbcWQLdc25NfBkM7XTzIs5M07
        NW7NHw25r/cIPcYWGrbUcEyyagbmWWc=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Banman <andrew.banman@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Travis <mike.travis@hpe.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
Subject: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Date:   Wed,  5 Dec 2018 11:11:31 +0100
Message-Id: <20181205101131.28996-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... with the goal of eventually enabling -Wmissing-prototypes by
default. At least on x86.

Make functions static where possible, otherwise add prototypes or make
them visible through includes.

asm/trace/ changes courtesy of Steven Rostedt <rostedt@goodmis.org>.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Banman <andrew.banman@hpe.com>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yi Wang <wang.yi59@zte.com.cn>
Cc: linux-acpi@vger.kernel.org
---
 arch/x86/include/asm/setup.h             | 3 +++
 arch/x86/include/asm/trace/exceptions.h  | 1 +
 arch/x86/include/asm/trace/irq_vectors.h | 1 +
 arch/x86/include/asm/traps.h             | 5 +++++
 arch/x86/kernel/apic/apic.c              | 1 +
 arch/x86/kernel/apic/apic_flat_64.c      | 7 ++++---
 arch/x86/kernel/apic/vector.c            | 1 +
 arch/x86/kernel/apic/x2apic_uv_x.c       | 4 ++--
 arch/x86/kernel/asm-offsets.c            | 3 ++-
 arch/x86/kernel/cpu/amd.c                | 1 +
 arch/x86/kernel/cpu/aperfmperf.c         | 1 +
 arch/x86/kernel/cpu/bugs.c               | 2 ++
 arch/x86/kernel/cpu/cacheinfo.c          | 1 +
 arch/x86/kernel/cpu/scattered.c          | 3 ++-
 arch/x86/kernel/cpu/topology.c           | 2 ++
 arch/x86/kernel/fpu/xstate.c             | 2 +-
 arch/x86/kernel/kprobes/common.h         | 2 ++
 arch/x86/kernel/sysfb_efi.c              | 3 +++
 arch/x86/kernel/tracepoint.c             | 1 +
 include/acpi/cppc_acpi.h                 | 3 +++
 include/linux/kprobes.h                  | 3 +++
 21 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ae13bc974416..ed8ec011a9fd 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -46,6 +46,9 @@ extern unsigned long saved_video_mode;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
+extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
+extern unsigned long __startup_secondary_64(void);
+extern int early_make_pgtable(unsigned long address);
 
 #ifdef CONFIG_X86_INTEL_MID
 extern void x86_intel_mid_early_setup(void);
diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm/trace/exceptions.h
index 69615e387973..e0e6d7f21399 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/arch/x86/include/asm/trace/exceptions.h
@@ -45,6 +45,7 @@ DEFINE_PAGE_FAULT_EVENT(page_fault_user);
 DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
 
 #undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_PATH .
 #define TRACE_INCLUDE_FILE exceptions
 #endif /*  _TRACE_PAGE_FAULT_H */
diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 0af81b590a0c..33b9d0f0aafe 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -389,6 +389,7 @@ TRACE_EVENT(vector_free_moved,
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_PATH .
 #define TRACE_INCLUDE_FILE irq_vectors
 #endif /*  _TRACE_IRQ_VECTORS_H */
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 5fcdf5687406..7d6f3f3fad78 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -113,6 +113,11 @@ asmlinkage void smp_threshold_interrupt(struct pt_regs *regs);
 asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
 #endif
 
+void smp_apic_timer_interrupt(struct pt_regs *regs);
+void smp_spurious_interrupt(struct pt_regs *regs);
+void smp_error_interrupt(struct pt_regs *regs);
+asmlinkage void smp_irq_move_cleanup_interrupt(void);
+
 extern void ist_enter(struct pt_regs *regs);
 extern void ist_exit(struct pt_regs *regs);
 extern void ist_begin_non_atomic(struct pt_regs *regs);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 32b2b7a41ef5..b7bcdd781651 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -44,6 +44,7 @@
 #include <asm/mpspec.h>
 #include <asm/i8259.h>
 #include <asm/proto.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/io_apic.h>
 #include <asm/desc.h>
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index e84c9eb4e5b4..0005c284a5c5 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -8,6 +8,7 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
+#include <linux/acpi.h>
 #include <linux/errno.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
@@ -16,13 +17,13 @@
 #include <linux/ctype.h>
 #include <linux/hardirq.h>
 #include <linux/export.h>
+
 #include <asm/smp.h>
-#include <asm/apic.h>
 #include <asm/ipi.h>
+#include <asm/apic.h>
+#include <asm/apic_flat_64.h>
 #include <asm/jailhouse_para.h>
 
-#include <linux/acpi.h>
-
 static struct apic apic_physflat;
 static struct apic apic_flat;
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 652e7ffa9b9d..3173e07d3791 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <asm/irqdomain.h>
 #include <asm/hw_irq.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/i8259.h>
 #include <asm/desc.h>
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 391f358ebb4c..a555da094157 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1079,7 +1079,7 @@ late_initcall(uv_init_heartbeat);
 #endif /* !CONFIG_HOTPLUG_CPU */
 
 /* Direct Legacy VGA I/O traffic to designated IOH */
-int uv_set_vga_state(struct pci_dev *pdev, bool decode, unsigned int command_bits, u32 flags)
+static int uv_set_vga_state(struct pci_dev *pdev, bool decode, unsigned int command_bits, u32 flags)
 {
 	int domain, bus, rc;
 
@@ -1148,7 +1148,7 @@ static void get_mn(struct mn *mnp)
 	mnp->m_shift = mnp->m_val ? 64 - mnp->m_val : 0;
 }
 
-void __init uv_init_hub_info(struct uv_hub_info_s *hi)
+static void __init uv_init_hub_info(struct uv_hub_info_s *hi)
 {
 	union uvh_node_id_u node_id;
 	struct mn mn;
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 72adf6c335dc..168543d077d7 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -29,7 +29,8 @@
 # include "asm-offsets_64.c"
 #endif
 
-void common(void) {
+static void __used common(void)
+{
 	BLANK();
 	OFFSET(TASK_threadsp, task_struct, thread.sp);
 #ifdef CONFIG_STACKPROTECTOR
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index eeea634bee0a..69f6bbb41be0 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -15,6 +15,7 @@
 #include <asm/smp.h>
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
+#include <asm/debugreg.h>
 
 #ifdef CONFIG_X86_64
 # include <asm/mmconfig.h>
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 7eba34df54c3..804c49493938 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -12,6 +12,7 @@
 #include <linux/ktime.h>
 #include <linux/math64.h>
 #include <linux/percpu.h>
+#include <linux/cpufreq.h>
 #include <linux/smp.h>
 
 #include "cpu.h"
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 500278f5308e..923e954a0075 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -32,6 +32,8 @@
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
 
+#include "cpu.h"
+
 static void __init spectre_v2_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index dc1b9342e9c4..c4d1023fb0ab 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 
 #include <asm/cpufeature.h>
+#include <asm/cacheinfo.h>
 #include <asm/amd_nb.h>
 #include <asm/smp.h>
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 772c219b6889..389168fa6e24 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -5,9 +5,10 @@
 #include <linux/cpu.h>
 
 #include <asm/pat.h>
+#include <asm/apic.h>
 #include <asm/processor.h>
 
-#include <asm/apic.h>
+#include "cpu.h"
 
 struct cpuid_bit {
 	u16 feature;
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 71ca064e3794..8f6c784141d1 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -10,6 +10,8 @@
 #include <asm/pat.h>
 #include <asm/processor.h>
 
+#include "cpu.h"
+
 /* leaf 0xb SMT level */
 #define SMT_LEVEL	0
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 87a57b7642d3..cd3956fc8158 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -811,7 +811,7 @@ void fpu__resume_cpu(void)
  *
  * Note: does not work for compacted buffers.
  */
-void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
+static void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
 {
 	int feature_nr = fls64(xstate_feature_mask) - 1;
 
diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
index 2b949f4fd4d8..f0fc628c4bb7 100644
--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -91,6 +91,8 @@ extern int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn);
 extern void synthesize_reljump(void *dest, void *from, void *to);
 extern void synthesize_relcall(void *dest, void *from, void *to);
 
+extern void *trampoline_handler(struct pt_regs *regs);
+
 #ifdef	CONFIG_OPTPROBES
 extern int setup_detour_execution(struct kprobe *p, struct pt_regs *regs, int reenter);
 extern unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsigned long addr);
diff --git a/arch/x86/kernel/sysfb_efi.c b/arch/x86/kernel/sysfb_efi.c
index 623965e86b65..fa51723571c8 100644
--- a/arch/x86/kernel/sysfb_efi.c
+++ b/arch/x86/kernel/sysfb_efi.c
@@ -19,12 +19,15 @@
 
 #include <linux/dmi.h>
 #include <linux/err.h>
+#include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/screen_info.h>
 #include <video/vga.h>
+
+#include <asm/efi.h>
 #include <asm/sysfb.h>
 
 enum {
diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index 2e85f4dcf77b..496748ed266a 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -11,6 +11,7 @@
 #include <asm/hw_irq.h>
 #include <asm/desc.h>
 #include <asm/trace/exceptions.h>
+#include <asm/trace/irq_vectors.h>
 
 DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index cf59e6210d27..4f34734e7f36 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -142,5 +142,8 @@ extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern int acpi_get_psd_map(struct cppc_cpudata **);
 extern unsigned int cppc_get_transition_latency(int cpu);
+extern bool cpc_ffh_supported(void);
+extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
+extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 
 #endif /* _CPPC_ACPI_H*/
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e909413e4e38..91d19d6a2892 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -379,6 +379,9 @@ int enable_kprobe(struct kprobe *kp);
 
 void dump_kprobe(struct kprobe *kp);
 
+void __weak *alloc_insn_page(void);
+void __weak free_insn_page(void *page);
+
 #else /* !CONFIG_KPROBES: */
 
 static inline int kprobes_built_in(void)
-- 
2.19.1

