Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E677FC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9465E24EB1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9465E24EB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeFXLlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 07:41:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44853 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeFXLlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 07:41:20 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX3OQ-0004Kp-Jw; Sun, 24 Jun 2018 13:41:18 +0200
Date:   Sun, 24 Jun 2018 13:41:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 updates for 4.18
Message-ID: <alpine.DEB.2.21.1806241331240.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A set of fixes for x86:

 - Make Xen PV guest deal with speculative store bypass correctly
 
 - Address more fallout from the 5-Level pagetable handling. Undo an
   __initdata annotation to avoid section mismatch and malfunction when
   post init code would touch the freed variable.

 - Handle exception fixup in math_error() before calling notify_die(). The
   reverse call order incorrectly triggers notify_die() listeners for
   soemthing which is handled correctly at the site which issues the
   floating point instruction.

 - Fix an off by one in the LLC topology calculation on AMD

 - Handle non standard memory block sizes gracefully un UV platforms

 - Plug a memory leak in the microcode loader

 - Sanitize the purgatory build magic

 - Add the x86 specific device tree bindings directory to the x86
   MAINTAINER file patterns.

Thanks,

	tglx

------------------>
Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for x86 device tree bindings

Juergen Gross (1):
      x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths

Kirill A. Shutemov (2):
      Revert "x86/mm: Mark __pgtable_l5_enabled __initdata"
      x86/mm: Fix 'no5lvl' handling

Masahiro Yamada (2):
      Revert "kexec/purgatory: Add clean-up for purgatory directory"
      x86/build: Remove unnecessary preparation for purgatory

Siarhei Liakh (1):
      x86: Call fixup_exception() before notify_die() in math_error()

Suravee Suthikulpanit (1):
      x86/CPU/AMD: Fix LLC ID bit-shift calculation

Zhenzhong Duan (1):
      x86/microcode/intel: Fix memleak in save_microcode_patch()

mike.travis@hpe.com (3):
      x86/platform/UV: Add adjustable set memory block size function
      x86/platform/UV: Use new set memory block size function
      x86/platform/UV: Add kernel parameter to set memory block size


 MAINTAINERS                           |  1 +
 arch/x86/Makefile                     |  6 ----
 arch/x86/kernel/apic/x2apic_uv_x.c    | 60 +++++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/cacheinfo.c       |  2 +-
 arch/x86/kernel/cpu/common.c          |  3 ++
 arch/x86/kernel/cpu/microcode/intel.c |  5 ++-
 arch/x86/kernel/head64.c              |  2 +-
 arch/x86/kernel/traps.c               | 14 ++++----
 arch/x86/mm/init_64.c                 | 20 +++++++++---
 arch/x86/xen/smp_pv.c                 |  5 +++
 include/linux/memory.h                |  1 +
 11 files changed, 97 insertions(+), 22 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..5e33d27e9171 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15572,6 +15572,7 @@ M:	x86@kernel.org
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 S:	Maintained
+F:	Documentation/devicetree/bindings/x86/
 F:	Documentation/x86/
 F:	arch/x86/
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f0a6ea22429d..a08e82856563 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -258,11 +258,6 @@ archscripts: scripts_basic
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
 
-archprepare:
-ifeq ($(CONFIG_KEXEC_FILE),y)
-	$(Q)$(MAKE) $(build)=arch/x86/purgatory arch/x86/purgatory/kexec-purgatory.c
-endif
-
 ###
 # Kernel objects
 
@@ -327,7 +322,6 @@ archclean:
 	$(Q)rm -rf $(objtree)/arch/x86_64
 	$(Q)$(MAKE) $(clean)=$(boot)
 	$(Q)$(MAKE) $(clean)=arch/x86/tools
-	$(Q)$(MAKE) $(clean)=arch/x86/purgatory
 
 define archhelp
   echo  '* bzImage      - Compressed kernel image (arch/x86/boot/bzImage)'
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index efaf2d4f9c3c..d492752f79e1 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/reboot.h>
+#include <linux/memory.h>
 
 #include <asm/uv/uv_mmrs.h>
 #include <asm/uv/uv_hub.h>
@@ -392,6 +393,51 @@ extern int uv_hub_info_version(void)
 }
 EXPORT_SYMBOL(uv_hub_info_version);
 
+/* Default UV memory block size is 2GB */
+static unsigned long mem_block_size = (2UL << 30);
+
+/* Kernel parameter to specify UV mem block size */
+static int parse_mem_block_size(char *ptr)
+{
+	unsigned long size = memparse(ptr, NULL);
+
+	/* Size will be rounded down by set_block_size() below */
+	mem_block_size = size;
+	return 0;
+}
+early_param("uv_memblksize", parse_mem_block_size);
+
+static __init int adj_blksize(u32 lgre)
+{
+	unsigned long base = (unsigned long)lgre << UV_GAM_RANGE_SHFT;
+	unsigned long size;
+
+	for (size = mem_block_size; size > MIN_MEMORY_BLOCK_SIZE; size >>= 1)
+		if (IS_ALIGNED(base, size))
+			break;
+
+	if (size >= mem_block_size)
+		return 0;
+
+	mem_block_size = size;
+	return 1;
+}
+
+static __init void set_block_size(void)
+{
+	unsigned int order = ffs(mem_block_size);
+
+	if (order) {
+		/* adjust for ffs return of 1..64 */
+		set_memory_block_size_order(order - 1);
+		pr_info("UV: mem_block_size set to 0x%lx\n", mem_block_size);
+	} else {
+		/* bad or zero value, default to 1UL << 31 (2GB) */
+		pr_err("UV: mem_block_size error with 0x%lx\n", mem_block_size);
+		set_memory_block_size_order(31);
+	}
+}
+
 /* Build GAM range lookup table: */
 static __init void build_uv_gr_table(void)
 {
@@ -1180,23 +1226,30 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
 					<< UV_GAM_RANGE_SHFT);
 		int order = 0;
 		char suffix[] = " KMGTPE";
+		int flag = ' ';
 
 		while (size > 9999 && order < sizeof(suffix)) {
 			size /= 1024;
 			order++;
 		}
 
+		/* adjust max block size to current range start */
+		if (gre->type == 1 || gre->type == 2)
+			if (adj_blksize(lgre))
+				flag = '*';
+
 		if (!index) {
 			pr_info("UV: GAM Range Table...\n");
-			pr_info("UV:  # %20s %14s %5s %4s %5s %3s %2s\n", "Range", "", "Size", "Type", "NASID", "SID", "PN");
+			pr_info("UV:  # %20s %14s %6s %4s %5s %3s %2s\n", "Range", "", "Size", "Type", "NASID", "SID", "PN");
 		}
-		pr_info("UV: %2d: 0x%014lx-0x%014lx %5lu%c %3d   %04x  %02x %02x\n",
+		pr_info("UV: %2d: 0x%014lx-0x%014lx%c %5lu%c %3d   %04x  %02x %02x\n",
 			index++,
 			(unsigned long)lgre << UV_GAM_RANGE_SHFT,
 			(unsigned long)gre->limit << UV_GAM_RANGE_SHFT,
-			size, suffix[order],
+			flag, size, suffix[order],
 			gre->type, gre->nasid, gre->sockid, gre->pnode);
 
+		/* update to next range start */
 		lgre = gre->limit;
 		if (sock_min > gre->sockid)
 			sock_min = gre->sockid;
@@ -1427,6 +1480,7 @@ static void __init uv_system_init_hub(void)
 
 	build_socket_tables();
 	build_uv_gr_table();
+	set_block_size();
 	uv_init_hub_info(&hub_info);
 	uv_possible_blades = num_possible_nodes();
 	if (!_node_to_pnode)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 38354c66df81..0c5fcbd998cf 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -671,7 +671,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 			num_sharing_cache = ((eax >> 14) & 0xfff) + 1;
 
 		if (num_sharing_cache) {
-			int bits = get_count_order(num_sharing_cache) - 1;
+			int bits = get_count_order(num_sharing_cache);
 
 			per_cpu(cpu_llc_id, cpu) = c->apicid >> bits;
 		}
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0df7151cfef4..eb4cb3efd20e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1,3 +1,6 @@
+/* cpu_feature_enabled() cannot be used this early */
+#define USE_EARLY_PGTABLE_L5
+
 #include <linux/bootmem.h>
 #include <linux/linkage.h>
 #include <linux/bitops.h>
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1c2cfa0644aa..97ccf4c3b45b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -190,8 +190,11 @@ static void save_microcode_patch(void *data, unsigned int size)
 			p = memdup_patch(data, size);
 			if (!p)
 				pr_err("Error allocating buffer %p\n", data);
-			else
+			else {
 				list_replace(&iter->plist, &p->plist);
+				kfree(iter->data);
+				kfree(iter);
+			}
 		}
 	}
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a21d6ace648e..8047379e575a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -44,7 +44,7 @@ static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
-unsigned int __pgtable_l5_enabled __initdata;
+unsigned int __pgtable_l5_enabled __ro_after_init;
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a535dd64de63..e6db475164ed 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -835,16 +835,18 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 	char *str = (trapnr == X86_TRAP_MF) ? "fpu exception" :
 						"simd exception";
 
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, SIGFPE) == NOTIFY_STOP)
-		return;
 	cond_local_irq_enable(regs);
 
 	if (!user_mode(regs)) {
-		if (!fixup_exception(regs, trapnr)) {
-			task->thread.error_code = error_code;
-			task->thread.trap_nr = trapnr;
+		if (fixup_exception(regs, trapnr))
+			return;
+
+		task->thread.error_code = error_code;
+		task->thread.trap_nr = trapnr;
+
+		if (notify_die(DIE_TRAP, str, regs, error_code,
+					trapnr, SIGFPE) != NOTIFY_STOP)
 			die(str, regs, error_code);
-		}
 		return;
 	}
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 045f492d5f68..a688617c727e 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1350,16 +1350,28 @@ int kern_addr_valid(unsigned long addr)
 /* Amount of ram needed to start using large blocks */
 #define MEM_SIZE_FOR_LARGE_BLOCK (64UL << 30)
 
+/* Adjustable memory block size */
+static unsigned long set_memory_block_size;
+int __init set_memory_block_size_order(unsigned int order)
+{
+	unsigned long size = 1UL << order;
+
+	if (size > MEM_SIZE_FOR_LARGE_BLOCK || size < MIN_MEMORY_BLOCK_SIZE)
+		return -EINVAL;
+
+	set_memory_block_size = size;
+	return 0;
+}
+
 static unsigned long probe_memory_block_size(void)
 {
 	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
 	unsigned long bz;
 
-	/* If this is UV system, always set 2G block size */
-	if (is_uv_system()) {
-		bz = MAX_BLOCK_SIZE;
+	/* If memory block size has been set, then use it */
+	bz = set_memory_block_size;
+	if (bz)
 		goto done;
-	}
 
 	/* Use regular block if RAM is smaller than MEM_SIZE_FOR_LARGE_BLOCK */
 	if (boot_mem_end < MEM_SIZE_FOR_LARGE_BLOCK) {
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 2e20ae2fa2d6..e3b18ad49889 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -32,6 +32,7 @@
 #include <xen/interface/vcpu.h>
 #include <xen/interface/xenpmu.h>
 
+#include <asm/spec-ctrl.h>
 #include <asm/xen/interface.h>
 #include <asm/xen/hypercall.h>
 
@@ -70,6 +71,8 @@ static void cpu_bringup(void)
 	cpu_data(cpu).x86_max_cores = 1;
 	set_cpu_sibling_map(cpu);
 
+	speculative_store_bypass_ht_init();
+
 	xen_setup_cpu_clockevents();
 
 	notify_cpu_starting(cpu);
@@ -250,6 +253,8 @@ static void __init xen_pv_smp_prepare_cpus(unsigned int max_cpus)
 	}
 	set_cpu_sibling_map(0);
 
+	speculative_store_bypass_ht_init();
+
 	xen_pmu_init(0);
 
 	if (xen_smp_intr_init(0) || xen_smp_intr_init_pv(0))
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 31ca3e28b0eb..a6ddefc60517 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -38,6 +38,7 @@ struct memory_block {
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
 unsigned long memory_block_size_bytes(void);
+int set_memory_block_size_order(unsigned int order);
 
 /* These states are exposed to userspace as text strings in sysfs */
 #define	MEM_ONLINE		(1<<0) /* exposed to userspace */
