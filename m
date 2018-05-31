Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756063AbeEaSCD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:02:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:18555 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755934AbeEaR66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:58:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="60725512"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/15] x86/vdso: Move out the CPU number store
Date: Thu, 31 May 2018 10:58:35 -0700
Message-Id: <1527789525-8857-6-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
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
 arch/x86/entry/vdso/vgetcpu.c  |  2 +-
 arch/x86/entry/vdso/vma.c      | 38 +-------------------------------------
 arch/x86/include/asm/segment.h |  4 ++++
 arch/x86/include/asm/vgtod.h   |  2 --
 arch/x86/kernel/cpu/common.c   | 17 +++++++++++++++++
 arch/x86/kernel/setup_percpu.c | 30 ++++++++++++++++++++++++++----
 6 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index 8ec3d1f..1373281 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -18,7 +18,7 @@ __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
 	p = __getcpu();
 
 	if (cpu)
-		*cpu = p & VGETCPU_CPU_MASK;
+		*cpu = p & PERCPU_CPU_MASK;
 	if (node)
 		*node = p >> 12;
 	return 0;
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
index 8f09012b..648d301 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -225,6 +225,10 @@
 #define GDT_ENTRY_TLS_ENTRIES		3
 #define TLS_SIZE			(GDT_ENTRY_TLS_ENTRIES* 8)
 
+/* Bit size and mask of CPU number stored in the per CPU data */
+#define PERCPU_CPU_SIZE			12
+#define PERCPU_CPU_MASK			0xfff
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
index 38276f5..0be333f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1665,6 +1665,23 @@ void cpu_init(void)
 
 	wrmsrl(MSR_FS_BASE, 0);
 	wrmsrl(MSR_KERNEL_GS_BASE, 0);
+
+	if (static_cpu_has(X86_FEATURE_RDTSCP)) {
+		unsigned long node = 0;
+
+#ifdef CONFIG_NUMA
+		node = early_cpu_to_node(cpu);
+#endif
+
+		/*
+		 * Store cpu number in TSC_AUX. (12 bits for the CPU
+		 * and rest upper bits for the node number)
+		 * It will be loaded in user space by vgetcpu (vDSO)
+		 * and from the paranoid entry to find per-CPU base.
+		 */
+		write_rdtscp_aux((node << PERCPU_CPU_SIZE) | cpu);
+	}
+
 	barrier();
 
 	x86_configure_nx();
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index ea554f8..b26202e 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -155,12 +155,34 @@ static void __init pcpup_populate_pte(unsigned long addr)
 
 static inline void setup_percpu_segment(int cpu)
 {
-#ifdef CONFIG_X86_32
-	struct desc_struct d = GDT_ENTRY_INIT(0x8092, per_cpu_offset(cpu),
-					      0xFFFFF);
+	unsigned long node = 0;
+	struct desc_struct d = { };
+
+#ifdef CONFIG_NUMA
+	node = early_cpu_to_node(cpu);
+#endif
 
-	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PERCPU, &d, DESCTYPE_S);
+	/*
+	 * Store cpu number in limit.
+	 * (12 bits for the CPU and 8 bits for the node number)
+	 * It will be loaded in user space by vgetcpu (vDSO)
+	 * and from the paranoid entry to find per-CPU base.
+	 */
+	d.limit0 = cpu | ((node & 0xf) << PERCPU_CPU_SIZE);
+	d.limit1 = node >> 4;
+	d.type = 5;			/* R0 data, expand down, accessed */
+	d.dpl = 3;			/* Visible to user code */
+	d.s = 1;			/* Not a system segment */
+	d.p = 1;			/* Present */
+	d.d = 1;			/* 32-bit */
+
+	write_gdt_entry(get_cpu_gdt_rw(cpu),
+#ifdef CONFIG_X86_32
+			GDT_ENTRY_PERCPU,
+#else /* 64 bit */
+			GDT_ENTRY_PER_CPU,
 #endif
+			&d, DESCTYPE_S);
 }
 
 void __init setup_per_cpu_areas(void)
-- 
2.7.4
