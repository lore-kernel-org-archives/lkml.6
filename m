Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELtZBykHUEHR9DMng0iX23VQHwktsN4ZQ6nv5H9ILPRF92G0QsricAS/2ZIYj6N+KxwCiofD
ARC-Seal: i=1; a=rsa-sha256; t=1520176041; cv=none;
        d=google.com; s=arc-20160816;
        b=up2rtiVr1s427r65RT1uZVHFON2awrlu9PS22oF07hveKg1V95bFnU2WtJYc9p9WiW
         maLANXXvA+bYxz5/1sOLMlMBwlOM4977Ai9MUltM3nQ3vF5mM4FStL94QyAKcoP+AxCa
         MtMks4lDJhpdCh9xBBXB5ApJDb4WWnmehBgtR5MdjRaJ9AgEwtANJTIoWJ0SGv9zdE3i
         caQS7sivaNa5G6VEk5kcTGDzcBh95lPzsaN/RUCC6vnynCuNmoBrbS9Pv8eqlC8b+hn0
         Z+MH2OHul6Y3dcbH5nqVO4Lg7TMOujP/HyLejYYAH0oDZoA+Zs64tsM778SIAQBcLmz7
         e+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=4FK347teec8lGxL20JiQkVWiawu/McFGRJV0hFZAWoY=;
        b=H5DMA4ixcMYVSn/7L67u+VkAzK/lCKJveuNmObJbh6N5jkM2KqWSQ6uD8KXpxF9hw6
         N7u2Ybn5EFHYhjg/kmBfWhqdWHcn0ZF5SabNkrElwQrlGquEg/kE310KzPeBDBGG/MuM
         Bh0+QXb3fp9lY19DNkxkf/U8/wPGn8TdCeKs42l9RibqySdaiwatxZtQoDOSB3+PQREM
         eSqdTIetc525+EHP7ky4S52t/kpmf4F85c/9Wbgo4A0iiejSPG2L97oGWZs/CDYNxIvf
         mKbuDmMFF1NHGxZWdrXAlHuSBQ4xGh6rodLaG4w+K9r4J8TUVrO1kLHfdna9eeFvkVWm
         3bTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Sun, 4 Mar 2018 16:07:18 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
    David Woodhouse <dwmw@amazon.co.uk>, Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT pull] xp6/pti updates for 4.16
Message-ID: <alpine.DEB.2.21.1803041603000.2394@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594020112740787417?=
X-GMAIL-MSGID: =?utf-8?q?1594020112740787417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linus,

please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

Three fixes related to melted spectrum:

 - Sync the cpu_entry_area page table to initial_page_table on 32
   bit. Otherwise suspend/resume fails because resume uses
   initial_page_table and triggers a triple fault when accessing the cpu
   entry area.

 - Zero the SPEC_CTL MRS on XEN before suspend to address a shortcoming in
   the hypervisor.

 - Fix another switch table detection issue in objtool

Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      objtool: Fix another switch table detection issue

Juergen Gross (1):
      x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend

Thomas Gleixner (1):
      x86/cpu_entry_area: Sync cpu_entry_area to initial_page_table


 arch/x86/include/asm/pgtable_32.h |  1 +
 arch/x86/include/asm/pgtable_64.h |  1 +
 arch/x86/kernel/setup.c           | 17 +++++------------
 arch/x86/kernel/setup_percpu.c    | 17 ++++-------------
 arch/x86/mm/cpu_entry_area.c      |  6 ++++++
 arch/x86/mm/init_32.c             | 15 +++++++++++++++
 arch/x86/xen/suspend.c            | 16 ++++++++++++++++
 tools/objtool/check.c             |  6 +++++-
 8 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index e55466760ff8..b3ec519e3982 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -32,6 +32,7 @@ extern pmd_t initial_pg_pmd[];
 static inline void pgtable_cache_init(void) { }
 static inline void check_pgt_cache(void) { }
 void paging_init(void);
+void sync_initial_page_table(void);
 
 /*
  * Define this if things work differently on an i386 and an i486:
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 81462e9a34f6..1149d2112b2e 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -28,6 +28,7 @@ extern pgd_t init_top_pgt[];
 #define swapper_pg_dir init_top_pgt
 
 extern void paging_init(void);
+static inline void sync_initial_page_table(void) { }
 
 #define pte_ERROR(e)					\
 	pr_err("%s:%d: bad pte %p(%016lx)\n",		\
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1ae67e982af7..4c616be28506 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1204,20 +1204,13 @@ void __init setup_arch(char **cmdline_p)
 
 	kasan_init();
 
-#ifdef CONFIG_X86_32
-	/* sync back kernel address range */
-	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			KERNEL_PGD_PTRS);
-
 	/*
-	 * sync back low identity map too.  It is used for example
-	 * in the 32-bit EFI stub.
+	 * Sync back kernel address range.
+	 *
+	 * FIXME: Can the later sync in setup_cpu_entry_areas() replace
+	 * this call?
 	 */
-	clone_pgd_range(initial_page_table,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
-#endif
+	sync_initial_page_table();
 
 	tboot_probe();
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 497aa766fab3..ea554f812ee1 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -287,24 +287,15 @@ void __init setup_per_cpu_areas(void)
 	/* Setup cpu initialized, callin, callout masks */
 	setup_cpu_local_masks();
 
-#ifdef CONFIG_X86_32
 	/*
 	 * Sync back kernel address range again.  We already did this in
 	 * setup_arch(), but percpu data also needs to be available in
 	 * the smpboot asm.  We can't reliably pick up percpu mappings
 	 * using vmalloc_fault(), because exception dispatch needs
 	 * percpu data.
+	 *
+	 * FIXME: Can the later sync in setup_cpu_entry_areas() replace
+	 * this call?
 	 */
-	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			KERNEL_PGD_PTRS);
-
-	/*
-	 * sync back low identity map too.  It is used for example
-	 * in the 32-bit EFI stub.
-	 */
-	clone_pgd_range(initial_page_table,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
-#endif
+	sync_initial_page_table();
 }
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index b9283cc27622..476d810639a8 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -163,4 +163,10 @@ void __init setup_cpu_entry_areas(void)
 
 	for_each_possible_cpu(cpu)
 		setup_cpu_entry_area(cpu);
+
+	/*
+	 * This is the last essential update to swapper_pgdir which needs
+	 * to be synchronized to initial_page_table on 32bit.
+	 */
+	sync_initial_page_table();
 }
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 79cb066f40c0..396e1f0151ac 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -453,6 +453,21 @@ static inline void permanent_kmaps_init(pgd_t *pgd_base)
 }
 #endif /* CONFIG_HIGHMEM */
 
+void __init sync_initial_page_table(void)
+{
+	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			KERNEL_PGD_PTRS);
+
+	/*
+	 * sync back low identity map too.  It is used for example
+	 * in the 32-bit EFI stub.
+	 */
+	clone_pgd_range(initial_page_table,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
+}
+
 void __init native_pagetable_init(void)
 {
 	unsigned long pfn, va;
diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index d9f96cc5d743..1d83152c761b 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
 #include <linux/tick.h>
+#include <linux/percpu-defs.h>
 
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
 #include <xen/grant_table.h>
 #include <xen/events.h>
 
+#include <asm/cpufeatures.h>
+#include <asm/msr-index.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/page.h>
 #include <asm/fixmap.h>
@@ -15,6 +18,8 @@
 #include "mmu.h"
 #include "pmu.h"
 
+static DEFINE_PER_CPU(u64, spec_ctrl);
+
 void xen_arch_pre_suspend(void)
 {
 	xen_save_time_memory_area();
@@ -35,6 +40,9 @@ void xen_arch_post_suspend(int cancelled)
 
 static void xen_vcpu_notify_restore(void *data)
 {
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL))
+		wrmsrl(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
+
 	/* Boot processor notified via generic timekeeping_resume() */
 	if (smp_processor_id() == 0)
 		return;
@@ -44,7 +52,15 @@ static void xen_vcpu_notify_restore(void *data)
 
 static void xen_vcpu_notify_suspend(void *data)
 {
+	u64 tmp;
+
 	tick_suspend_local();
+
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
+		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
+		this_cpu_write(spec_ctrl, tmp);
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	}
 }
 
 void xen_arch_resume(void)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 472e64e95891..46c1d239cc1b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -925,7 +925,11 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		if (find_symbol_containing(file->rodata, text_rela->addend))
 			continue;
 
-		return find_rela_by_dest(file->rodata, text_rela->addend);
+		rodata_rela = find_rela_by_dest(file->rodata, text_rela->addend);
+		if (!rodata_rela)
+			continue;
+
+		return rodata_rela;
 	}
 
 	return NULL;
