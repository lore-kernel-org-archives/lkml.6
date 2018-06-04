Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbeFDTYv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:24:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:40504 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeFDTYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:24:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="64240696"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] x86/vdso: Move out the CPU number store
Date: Mon,  4 Jun 2018 12:24:29 -0700
Message-Id: <1528140269-26205-7-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528140269-26205-1-git-send-email-chang.seok.bae@intel.com>
References: <1528140269-26205-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU (and node) number will be written, as early enough,
to the segment limit of per CPU data and TSC_AUX MSR entry.
The information has been retrieved by vgetcpu in user space
and will be also loaded from the paranoid entry, when
FSGSBASE enabled. So, it is moved out from vDSO to the CPU
initialization path where IST setup is serialized.

Now, redundant setting of the segment in entry/vdso/vma.c
was removed; a substantial code removal. It removes a
hotplug notifier, makes a facility useful to both the kernel
and userspace unconditionally available much sooner, and
unification with i386. (Thanks to HPA for suggesting the
cleanup)

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vgetcpu.c  |  4 ++--
 arch/x86/entry/vdso/vma.c      | 38 +-------------------------------------
 arch/x86/include/asm/segment.h | 29 +++++++++++++++++++++++++++--
 arch/x86/include/asm/vgtod.h   |  2 --
 arch/x86/kernel/cpu/common.c   |  5 +++++
 arch/x86/kernel/setup_percpu.c | 17 +++++++++++++----
 6 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index 8ec3d1f..3284069 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -18,9 +18,9 @@ __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
 	p = __getcpu();
 
 	if (cpu)
-		*cpu = p & VGETCPU_CPU_MASK;
+		*cpu = lsl_tscp_to_cpu(p);
 	if (node)
-		*node = p >> 12;
+		*node = lsl_tscp_to_node(p);
 	return 0;
 }
 
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5b8b556..3f9d43f 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -332,40 +332,6 @@ static __init int vdso_setup(char *s)
 	return 0;
 }
 __setup("vdso=", vdso_setup);
-#endif
-
-#ifdef CONFIG_X86_64
-static void vgetcpu_cpu_init(void *arg)
-{
-	int cpu = smp_processor_id();
-	struct desc_struct d = { };
-	unsigned long node = 0;
-#ifdef CONFIG_NUMA
-	node = cpu_to_node(cpu);
-#endif
-	if (static_cpu_has(X86_FEATURE_RDTSCP))
-		write_rdtscp_aux((node << 12) | cpu);
-
-	/*
-	 * Store cpu number in limit so that it can be loaded
-	 * quickly in user space in vgetcpu. (12 bits for the CPU
-	 * and 8 bits for the node)
-	 */
-	d.limit0 = cpu | ((node & 0xf) << 12);
-	d.limit1 = node >> 4;
-	d.type = 5;		/* RO data, expand down, accessed */
-	d.dpl = 3;		/* Visible to user code */
-	d.s = 1;		/* Not a system segment */
-	d.p = 1;		/* Present */
-	d.d = 1;		/* 32-bit */
-
-	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PER_CPU, &d, DESCTYPE_S);
-}
-
-static int vgetcpu_online(unsigned int cpu)
-{
-	return smp_call_function_single(cpu, vgetcpu_cpu_init, NULL, 1);
-}
 
 static int __init init_vdso(void)
 {
@@ -375,9 +341,7 @@ static int __init init_vdso(void)
 	init_vdso_image(&vdso_image_x32);
 #endif
 
-	/* notifier priority > KVM */
-	return cpuhp_setup_state(CPUHP_AP_X86_VDSO_VMA_ONLINE,
-				 "x86/vdso/vma:online", vgetcpu_online, NULL);
+	return 0;
 }
 subsys_initcall(init_vdso);
 #endif /* CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 8f09012b..596112c 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -187,7 +187,7 @@
 #define GDT_ENTRY_TLS_MAX		14
 
 /* Abused to load per CPU data from limit */
-#define GDT_ENTRY_PER_CPU		15
+#define GDT_ENTRY_PERCPU		15
 
 /*
  * Number of entries in the GDT table:
@@ -207,7 +207,7 @@
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
 #define __USER32_DS			__USER_DS
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
-#define __PER_CPU_SEG			(GDT_ENTRY_PER_CPU*8 + 3)
+#define __PER_CPU_SEG			(GDT_ENTRY_PERCPU*8 + 3)
 
 #endif
 
@@ -225,6 +225,31 @@
 #define GDT_ENTRY_TLS_ENTRIES		3
 #define TLS_SIZE			(GDT_ENTRY_TLS_ENTRIES* 8)
 
+/* Bit size and mask of CPU number stored in the per CPU data (and TSC_AUX) */
+#define LSL_TSCP_CPU_SIZE		12
+#define LSL_TSCP_CPU_MASK		0xfff
+
+#ifndef __ASSEMBLY__
+
+/* Helper functions to store/load CPU and node numbers */
+
+static inline unsigned long make_lsl_tscp(int cpu, unsigned long node)
+{
+	return ((node << LSL_TSCP_CPU_SIZE) | cpu);
+}
+
+static inline unsigned int lsl_tscp_to_cpu(unsigned long x)
+{
+	return (x & LSL_TSCP_CPU_MASK);
+}
+
+static inline unsigned int lsl_tscp_to_node(unsigned long x)
+{
+	return (x >> LSL_TSCP_CPU_SIZE);
+}
+
+#endif
+
 #ifdef __KERNEL__
 
 /*
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index fb856c9..1cc9d30 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -79,8 +79,6 @@ static inline void gtod_write_end(struct vsyscall_gtod_data *s)
 
 #ifdef CONFIG_X86_64
 
-#define VGETCPU_CPU_MASK 0xfff
-
 static inline unsigned int __getcpu(void)
 {
 	unsigned int p;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 38276f5..c7b54f0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1665,6 +1665,11 @@ void cpu_init(void)
 
 	wrmsrl(MSR_FS_BASE, 0);
 	wrmsrl(MSR_KERNEL_GS_BASE, 0);
+#ifdef CONFIG_NUMA
+	write_rdtscp_aux(make_lsl_tscp(cpu, early_cpu_to_node(cpu)));
+#else
+	write_rdtscp_aux(make_lsl_tscp(cpu, 0));
+#endif
 	barrier();
 
 	x86_configure_nx();
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index ea554f8..e716e94 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -155,12 +155,21 @@ static void __init pcpup_populate_pte(unsigned long addr)
 
 static inline void setup_percpu_segment(int cpu)
 {
-#ifdef CONFIG_X86_32
-	struct desc_struct d = GDT_ENTRY_INIT(0x8092, per_cpu_offset(cpu),
-					      0xFFFFF);
+#ifdef CONFIG_NUMA
+	unsigned long node = early_cpu_to_node(cpu);
+#else
+	unsigned long node = 0;
+#endif
+	struct desc_struct d = GDT_ENTRY_INIT(0x0, per_cpu_offset(cpu),
+			   make_lsl_tscp(cpu, node));
+
+	d.type = 5;	/* R0 data, expand down, accessed */
+	d.dpl = 3;	/* Visible to user code */
+	d.s = 1;	/* Not a system segment */
+	d.p = 1;	/* Present */
+	d.d = 1;	/* 32-bit */
 
 	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PERCPU, &d, DESCTYPE_S);
-#endif
 }
 
 void __init setup_per_cpu_areas(void)
-- 
2.7.4
