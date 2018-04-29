Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeD2PSZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 11:18:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34103 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753451AbeD2PSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 11:18:23 -0400
Date: Sun, 29 Apr 2018 17:18:21 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 updates for 4.17
Message-ID: <alpine.DEB.2.21.1804291708190.1595@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

Another set of x86 related updates:

 - Fix the long broken x32 version of the IPC user space headers which was
   noticed by Arnd Bergman in course of his ongoing y2038 work. GLIBC seems
   to have non broken private copies of these headers so this went unnoticed.

 - Two microcode fixlets which address some more fallout from the recent
   modifications in that area:

     - Unconditionally save the microcode patch, which was only saved when
       CPU_HOTPLUG was enabled causing failures in the late loading mechanism
       
     - Make the later loader synchronization finally work under all
       circumstances. It was exiting early and causing timeout failures due
       to a missing synchronization point.

 - Do not use mwait_play_dead() on AMD systems to prevent excessive power
   consumption as the CPU cannot go into deep power states from there.

 - Address an annoying sparse warning due to lost type qualifiers of the
   vmemmap and vmalloc base address constants.

 - Prevent reserving crash kernel region on Xen PV as this leads to the
   wrong perception that crash kernels actually work there which is not the
   case. Xen PV has its own crash mechanism handled by the hypervisor.

 - Add missing TLB cpuid values to the table to make the printout on
   certain machines correct.

 - Enumerate the new CLDEMOTE instruction

 - Fix an incorrect SPDX identifier

 - Remove stale macros

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      x86/ipc: Fix x32 version of shmid64_ds and msqid64_ds

Borislav Petkov (2):
      x86/microcode/intel: Save microcode patch unconditionally
      x86/microcode: Do not exit early from __reload_late()

Dou Liyang (2):
      x86/vector: Remove the macro VECTOR_OFFSET_START
      x86/vector: Remove the unused macro FPU_IRQ

Fenghua Yu (1):
      x86/cpufeatures: Enumerate cldemote instruction

Jiri Kosina (1):
      x86/mm: Make vmemmap and vmalloc base address constants unsigned long

Petr Tesarik (1):
      x86/setup: Do not reserve a crash kernel region if booted on Xen PV

Thomas Gleixner (1):
      x86/jailhouse: Fix incorrect SPDX identifier

Yazen Ghannam (1):
      x86/smpboot: Don't use mwait_play_dead() on AMD systems

jacek.tomaka@poczta.fm (1):
      x86/cpu/intel: Add missing TLB cpuid values


 arch/x86/include/asm/cpufeatures.h      |  1 +
 arch/x86/include/asm/irq_vectors.h      |  7 ------
 arch/x86/include/asm/jailhouse_para.h   |  2 +-
 arch/x86/include/asm/pgtable_64_types.h |  8 +++----
 arch/x86/include/uapi/asm/msgbuf.h      | 31 ++++++++++++++++++++++++
 arch/x86/include/uapi/asm/shmbuf.h      | 42 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c             |  3 +++
 arch/x86/kernel/cpu/microcode/core.c    |  6 ++---
 arch/x86/kernel/cpu/microcode/intel.c   |  2 --
 arch/x86/kernel/jailhouse.c             |  2 +-
 arch/x86/kernel/setup.c                 |  6 +++++
 arch/x86/kernel/smpboot.c               |  2 ++
 12 files changed, 93 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d554c11e01ff..578793e97431 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -320,6 +320,7 @@
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
+#define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 404c5fdff859..548d90bbf919 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -34,11 +34,6 @@
  * (0x80 is the syscall vector, 0x30-0x3f are for ISA)
  */
 #define FIRST_EXTERNAL_VECTOR		0x20
-/*
- * We start allocating at 0x21 to spread out vectors evenly between
- * priority levels. (0x80 is the syscall vector)
- */
-#define VECTOR_OFFSET_START		1
 
 /*
  * Reserve the lowest usable vector (and hence lowest priority)  0x20 for
@@ -119,8 +114,6 @@
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif
 
-#define FPU_IRQ				  13
-
 /*
  * Size the maximum number of interrupts.
  *
diff --git a/arch/x86/include/asm/jailhouse_para.h b/arch/x86/include/asm/jailhouse_para.h
index b885a961a150..a34897aef2c2 100644
--- a/arch/x86/include/asm/jailhouse_para.h
+++ b/arch/x86/include/asm/jailhouse_para.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL2.0 */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 /*
  * Jailhouse paravirt detection
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index d5c21a382475..adb47552e6bb 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -105,14 +105,14 @@ extern unsigned int ptrs_per_p4d;
 #define LDT_PGD_ENTRY		(pgtable_l5_enabled ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
 #define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
 
-#define __VMALLOC_BASE_L4	0xffffc90000000000
-#define __VMALLOC_BASE_L5 	0xffa0000000000000
+#define __VMALLOC_BASE_L4	0xffffc90000000000UL
+#define __VMALLOC_BASE_L5 	0xffa0000000000000UL
 
 #define VMALLOC_SIZE_TB_L4	32UL
 #define VMALLOC_SIZE_TB_L5	12800UL
 
-#define __VMEMMAP_BASE_L4	0xffffea0000000000
-#define __VMEMMAP_BASE_L5	0xffd4000000000000
+#define __VMEMMAP_BASE_L4	0xffffea0000000000UL
+#define __VMEMMAP_BASE_L5	0xffd4000000000000UL
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 # define VMALLOC_START		vmalloc_base
diff --git a/arch/x86/include/uapi/asm/msgbuf.h b/arch/x86/include/uapi/asm/msgbuf.h
index 809134c644a6..90ab9a795b49 100644
--- a/arch/x86/include/uapi/asm/msgbuf.h
+++ b/arch/x86/include/uapi/asm/msgbuf.h
@@ -1 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_X64_MSGBUF_H
+#define __ASM_X64_MSGBUF_H
+
+#if !defined(__x86_64__) || !defined(__ILP32__)
 #include <asm-generic/msgbuf.h>
+#else
+/*
+ * The msqid64_ds structure for x86 architecture with x32 ABI.
+ *
+ * On x86-32 and x86-64 we can just use the generic definition, but
+ * x32 uses the same binary layout as x86_64, which is differnet
+ * from other 32-bit architectures.
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	__kernel_time_t msg_stime;	/* last msgsnd time */
+	__kernel_time_t msg_rtime;	/* last msgrcv time */
+	__kernel_time_t msg_ctime;	/* last change time */
+	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
+	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
+	__kernel_ulong_t msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	__kernel_ulong_t __unused4;
+	__kernel_ulong_t __unused5;
+};
+
+#endif
+
+#endif /* __ASM_GENERIC_MSGBUF_H */
diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
index 83c05fc2de38..644421f3823b 100644
--- a/arch/x86/include/uapi/asm/shmbuf.h
+++ b/arch/x86/include/uapi/asm/shmbuf.h
@@ -1 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_X86_SHMBUF_H
+#define __ASM_X86_SHMBUF_H
+
+#if !defined(__x86_64__) || !defined(__ILP32__)
 #include <asm-generic/shmbuf.h>
+#else
+/*
+ * The shmid64_ds structure for x86 architecture with x32 ABI.
+ *
+ * On x86-32 and x86-64 we can just use the generic definition, but
+ * x32 uses the same binary layout as x86_64, which is differnet
+ * from other 32-bit architectures.
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_time_t		shm_atime;	/* last attach time */
+	__kernel_time_t		shm_dtime;	/* last detach time */
+	__kernel_time_t		shm_ctime;	/* last change time */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	__kernel_ulong_t	shm_nattch;	/* no. of current attaches */
+	__kernel_ulong_t	__unused4;
+	__kernel_ulong_t	__unused5;
+};
+
+struct shminfo64 {
+	__kernel_ulong_t	shmmax;
+	__kernel_ulong_t	shmmin;
+	__kernel_ulong_t	shmmni;
+	__kernel_ulong_t	shmseg;
+	__kernel_ulong_t	shmall;
+	__kernel_ulong_t	__unused1;
+	__kernel_ulong_t	__unused2;
+	__kernel_ulong_t	__unused3;
+	__kernel_ulong_t	__unused4;
+};
+
+#endif
+
+#endif /* __ASM_X86_SHMBUF_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index b9693b80fc21..60d1897041da 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -835,6 +835,9 @@ static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
 	{ 0x63, TLB_DATA_1G,		4,	" TLB_DATA 1 GByte pages, 4-way set associative" },
+	{ 0x6b, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 8-way associative" },
+	{ 0x6c, TLB_DATA_2M_4M,		128,	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
+	{ 0x6d, TLB_DATA_1G,		16,	" TLB_DATA 1 GByte pages, fully associative" },
 	{ 0x76, TLB_INST_2M_4M,		8,	" TLB_INST 2-MByte or 4-MByte pages, fully associative" },
 	{ 0xb0, TLB_INST_4K,		128,	" TLB_INST 4 KByte pages, 4-way set associative" },
 	{ 0xb1, TLB_INST_2M_4M,		4,	" TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries" },
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 10c4fc2c91f8..77e201301528 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -564,14 +564,12 @@ static int __reload_late(void *info)
 	apply_microcode_local(&err);
 	spin_unlock(&update_lock);
 
+	/* siblings return UCODE_OK because their engine got updated already */
 	if (err > UCODE_NFOUND) {
 		pr_warn("Error reloading microcode on CPU %d\n", cpu);
-		return -1;
-	/* siblings return UCODE_OK because their engine got updated already */
+		ret = -1;
 	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
 		ret = 1;
-	} else {
-		return ret;
 	}
 
 	/*
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 32b8e5724f96..1c2cfa0644aa 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -485,7 +485,6 @@ static void show_saved_mc(void)
  */
 static void save_mc_for_early(u8 *mc, unsigned int size)
 {
-#ifdef CONFIG_HOTPLUG_CPU
 	/* Synchronization during CPU hotplug. */
 	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
 
@@ -495,7 +494,6 @@ static void save_mc_for_early(u8 *mc, unsigned int size)
 	show_saved_mc();
 
 	mutex_unlock(&x86_cpu_microcode_mutex);
-#endif
 }
 
 static bool load_builtin_intel_microcode(struct cpio_data *cp)
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index fa183a131edc..a15fe0e92cf9 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Jailhouse paravirt_ops implementation
  *
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6285697b6e56..5c623dfe39d1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -50,6 +50,7 @@
 #include <linux/init_ohci1394_dma.h>
 #include <linux/kvm_para.h>
 #include <linux/dma-contiguous.h>
+#include <xen/xen.h>
 
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -534,6 +535,11 @@ static void __init reserve_crashkernel(void)
 		high = true;
 	}
 
+	if (xen_pv_domain()) {
+		pr_info("Ignoring crashkernel for a Xen PV domain\n");
+		return;
+	}
+
 	/* 0 means: find the address automatically */
 	if (crash_base <= 0) {
 		/*
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 45175b81dd5b..0f1cbb042f49 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1571,6 +1571,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
