Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F160ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C9B21532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C9B21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbeIVS1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 14:27:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41583 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbeIVS1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 14:27:36 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g3h6s-0000R5-PI; Sat, 22 Sep 2018 14:34:07 +0200
Subject: [GIT pull] x86 fixes for 4.19
Message-ID: <153761963611.16056.12017890608218706382.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <153761963611.16056.1920566642543692525.tglx@nanos.tec.linutronix.de>
Date:   Sat, 22 Sep 2018 14:34:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A set of fixes for x86:

  - Resolve the kvmclock regression on AMD systems with memory encryption
    enabled. The rework of the kvmclock memory allocation during early boot
    results in encrypted storage, which is not shareable with the
    hypervisor. Create a new section for this data which is mapped
    unencrypted and take care that the later allocations for shared
    kvmclock memory is unencrypted as well.

  - Fix the build regression in the paravirt code introduced by the recent
    spectre v2 updates.

  - Ensure that the initial static page tables cover the fixmap space
    correctly so early console always works. This worked so far by chance,
    but recent modifications to the fixmap layout can - depending on kernel
    configuration - move the relevant entries to a different place which is
    not covered by the initial static page tables.

  - Address the regressions and issues which got introduced with the recent
    extensions to the Intel Recource Director Technology code.

  - Update maintainer entries to document reality

Thanks,

	tglx

------------------>
Brijesh Singh (2):
      x86/mm: Add .bss..decrypted section to hold shared variables
      x86/kvm: Use __bss_decrypted attribute in shared variables

Dan Carpenter (1):
      x86/paravirt: Fix some warning messages

Feng Tang (1):
      x86/mm: Expand static page table for fixmap space

Fenghua Yu (1):
      x86/intel_rdt: Add Reinette as co-maintainer for RDT

Reinette Chatre (8):
      x86/intel_rdt: Fix size reporting of MBA resource
      x86/intel_rdt: Global closid helper to support future fixes
      x86/intel_rdt: Fix invalid mode warning when multiple resources are managed
      x86/intel_rdt: Fix unchecked MSR access
      x86/intel_rdt: Do not allow pseudo-locking of MBA resource
      x86/intel_rdt: Fix incorrect loop end condition
      x86/intel_rdt: Fix exclusive mode handling of MBA resource
      x86/intel_rdt: Fix incorrect loop end condition

Thomas Gleixner (2):
      MAINTAINERS: Add Borislav to the x86 maintainers
      MAINTAINERS: Add X86 MM entry

Xiaochen Shen (1):
      x86/intel_rdt: Fix data type in parsing callbacks


 MAINTAINERS                                 | 11 ++++++
 arch/x86/include/asm/fixmap.h               | 10 ++++++
 arch/x86/include/asm/mem_encrypt.h          |  7 ++++
 arch/x86/include/asm/pgtable_64.h           |  3 +-
 arch/x86/kernel/cpu/intel_rdt.h             | 17 ++++++---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 27 ++++++++-------
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 53 ++++++++++++++++++++++++-----
 arch/x86/kernel/head64.c                    | 20 ++++++++++-
 arch/x86/kernel/head_64.S                   | 16 ++++++---
 arch/x86/kernel/kvmclock.c                  | 52 ++++++++++++++++++++++++++--
 arch/x86/kernel/paravirt.c                  |  4 +--
 arch/x86/kernel/vmlinux.lds.S               | 19 +++++++++++
 arch/x86/mm/init.c                          |  4 +++
 arch/x86/mm/mem_encrypt.c                   | 24 +++++++++++++
 arch/x86/mm/pgtable.c                       |  9 +++++
 arch/x86/xen/mmu_pv.c                       |  8 +++--
 16 files changed, 245 insertions(+), 39 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ece30f15777..80a311252b04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12260,6 +12260,7 @@ F:	Documentation/networking/rds.txt
 
 RDT - RESOURCE ALLOCATION
 M:	Fenghua Yu <fenghua.yu@intel.com>
+M:	Reinette Chatre <reinette.chatre@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	arch/x86/kernel/cpu/intel_rdt*
@@ -15913,6 +15914,7 @@ F:	net/x25/
 X86 ARCHITECTURE (32-BIT AND 64-BIT)
 M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Ingo Molnar <mingo@redhat.com>
+M:	Borislav Petkov <bp@alien8.de>
 R:	"H. Peter Anvin" <hpa@zytor.com>
 M:	x86@kernel.org
 L:	linux-kernel@vger.kernel.org
@@ -15941,6 +15943,15 @@ M:	Borislav Petkov <bp@alien8.de>
 S:	Maintained
 F:	arch/x86/kernel/cpu/microcode/*
 
+X86 MM
+M:	Dave Hansen <dave.hansen@linux.intel.com>
+M:	Andy Lutomirski <luto@kernel.org>
+M:	Peter Zijlstra <peterz@infradead.org>
+L:	linux-kernel@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
+S:	Maintained
+F:	arch/x86/mm/
+
 X86 PLATFORM DRIVERS
 M:	Darren Hart <dvhart@infradead.org>
 M:	Andy Shevchenko <andy@infradead.org>
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index e203169931c7..6390bd8c141b 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -14,6 +14,16 @@
 #ifndef _ASM_X86_FIXMAP_H
 #define _ASM_X86_FIXMAP_H
 
+/*
+ * Exposed to assembly code for setting up initial page tables. Cannot be
+ * calculated in assembly code (fixmap entries are an enum), but is sanity
+ * checked in the actual fixmap C code to make sure that the fixmap is
+ * covered fully.
+ */
+#define FIXMAP_PMD_NUM	2
+/* fixmap starts downwards from the 507th entry in level2_fixmap_pgt */
+#define FIXMAP_PMD_TOP	507
+
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 #include <asm/acpi.h>
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index c0643831706e..616f8e637bc3 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -48,10 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
+void __init mem_encrypt_free_decrypted_mem(void);
 
 bool sme_active(void);
 bool sev_active(void);
 
+#define __bss_decrypted __attribute__((__section__(".bss..decrypted")))
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
@@ -77,6 +80,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
+#define __bss_decrypted
+
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 /*
@@ -88,6 +93,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 #define __sme_pa(x)		(__pa(x) | sme_me_mask)
 #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
 
+extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index ce2b59047cb8..9c85b54bf03c 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -14,6 +14,7 @@
 #include <asm/processor.h>
 #include <linux/bitops.h>
 #include <linux/threads.h>
+#include <asm/fixmap.h>
 
 extern p4d_t level4_kernel_pgt[512];
 extern p4d_t level4_ident_pgt[512];
@@ -22,7 +23,7 @@ extern pud_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pmd_t level2_fixmap_pgt[512];
 extern pmd_t level2_ident_pgt[512];
-extern pte_t level1_fixmap_pgt[512];
+extern pte_t level1_fixmap_pgt[512 * FIXMAP_PMD_NUM];
 extern pgd_t init_top_pgt[];
 
 #define swapper_pg_dir init_top_pgt
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 4e588f36228f..285eb3ec4200 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -382,6 +382,11 @@ static inline bool is_mbm_event(int e)
 		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
+struct rdt_parse_data {
+	struct rdtgroup		*rdtgrp;
+	char			*buf;
+};
+
 /**
  * struct rdt_resource - attributes of an RDT resource
  * @rid:		The index of the resource
@@ -423,16 +428,19 @@ struct rdt_resource {
 	struct rdt_cache	cache;
 	struct rdt_membw	membw;
 	const char		*format_str;
-	int (*parse_ctrlval)	(void *data, struct rdt_resource *r,
-				 struct rdt_domain *d);
+	int (*parse_ctrlval)(struct rdt_parse_data *data,
+			     struct rdt_resource *r,
+			     struct rdt_domain *d);
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
 	unsigned long		fflags;
 };
 
-int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d);
-int parse_bw(void *_buf, struct rdt_resource *r,  struct rdt_domain *d);
+int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
+	      struct rdt_domain *d);
+int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+	     struct rdt_domain *d);
 
 extern struct mutex rdtgroup_mutex;
 
@@ -536,6 +544,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
+int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index af358ca05160..0f53049719cd 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -64,19 +64,19 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(void *_buf, struct rdt_resource *r, struct rdt_domain *d)
+int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+	     struct rdt_domain *d)
 {
-	unsigned long data;
-	char *buf = _buf;
+	unsigned long bw_val;
 
 	if (d->have_new_ctrl) {
 		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
 
-	if (!bw_validate(buf, &data, r))
+	if (!bw_validate(data->buf, &bw_val, r))
 		return -EINVAL;
-	d->new_ctrl = data;
+	d->new_ctrl = bw_val;
 	d->have_new_ctrl = true;
 
 	return 0;
@@ -123,18 +123,13 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 	return true;
 }
 
-struct rdt_cbm_parse_data {
-	struct rdtgroup		*rdtgrp;
-	char			*buf;
-};
-
 /*
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
+int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
+	      struct rdt_domain *d)
 {
-	struct rdt_cbm_parse_data *data = _data;
 	struct rdtgroup *rdtgrp = data->rdtgrp;
 	u32 cbm_val;
 
@@ -195,11 +190,17 @@ int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
 static int parse_line(char *line, struct rdt_resource *r,
 		      struct rdtgroup *rdtgrp)
 {
-	struct rdt_cbm_parse_data data;
+	struct rdt_parse_data data;
 	char *dom = NULL, *id;
 	struct rdt_domain *d;
 	unsigned long dom_id;
 
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
+	    r->rid == RDT_RESOURCE_MBA) {
+		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
+		return -EINVAL;
+	}
+
 next:
 	if (!line || line[0] == '\0')
 		return 0;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b799c00bef09..1b8e86a5d5e1 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -97,6 +97,12 @@ void rdt_last_cmd_printf(const char *fmt, ...)
  *   limited as the number of resources grows.
  */
 static int closid_free_map;
+static int closid_free_map_len;
+
+int closids_supported(void)
+{
+	return closid_free_map_len;
+}
 
 static void closid_init(void)
 {
@@ -111,6 +117,7 @@ static void closid_init(void)
 
 	/* CLOSID 0 is always reserved for the default group */
 	closid_free_map &= ~1;
+	closid_free_map_len = rdt_min_closid;
 }
 
 static int closid_alloc(void)
@@ -802,7 +809,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 		sw_shareable = 0;
 		exclusive = 0;
 		seq_printf(seq, "%d=", dom->id);
-		for (i = 0; i < r->num_closid; i++, ctrl++) {
+		for (i = 0; i < closids_supported(); i++, ctrl++) {
 			if (!closid_allocated(i))
 				continue;
 			mode = rdtgroup_mode_by_closid(i);
@@ -989,7 +996,7 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 
 	/* Check for overlap with other resource groups */
 	ctrl = d->ctrl_val;
-	for (i = 0; i < r->num_closid; i++, ctrl++) {
+	for (i = 0; i < closids_supported(); i++, ctrl++) {
 		ctrl_b = (unsigned long *)ctrl;
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
@@ -1024,16 +1031,27 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
 	int closid = rdtgrp->closid;
 	struct rdt_resource *r;
+	bool has_cache = false;
 	struct rdt_domain *d;
 
 	for_each_alloc_enabled_rdt_resource(r) {
+		if (r->rid == RDT_RESOURCE_MBA)
+			continue;
+		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
 			if (rdtgroup_cbm_overlaps(r, d, d->ctrl_val[closid],
-						  rdtgrp->closid, false))
+						  rdtgrp->closid, false)) {
+				rdt_last_cmd_puts("schemata overlaps\n");
 				return false;
+			}
 		}
 	}
 
+	if (!has_cache) {
+		rdt_last_cmd_puts("cannot be exclusive without CAT/CDP\n");
+		return false;
+	}
+
 	return true;
 }
 
@@ -1085,7 +1103,6 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 		rdtgrp->mode = RDT_MODE_SHAREABLE;
 	} else if (!strcmp(buf, "exclusive")) {
 		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
-			rdt_last_cmd_printf("schemata overlaps\n");
 			ret = -EINVAL;
 			goto out;
 		}
@@ -1155,8 +1172,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	struct rdt_resource *r;
 	struct rdt_domain *d;
 	unsigned int size;
-	bool sep = false;
-	u32 cbm;
+	bool sep;
+	u32 ctrl;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -1174,6 +1191,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	}
 
 	for_each_alloc_enabled_rdt_resource(r) {
+		sep = false;
 		seq_printf(s, "%*s:", max_name_width, r->name);
 		list_for_each_entry(d, &r->domains, list) {
 			if (sep)
@@ -1181,8 +1199,13 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
-				cbm = d->ctrl_val[rdtgrp->closid];
-				size = rdtgroup_cbm_to_size(r, d, cbm);
+				ctrl = (!is_mba_sc(r) ?
+						d->ctrl_val[rdtgrp->closid] :
+						d->mbps_val[rdtgrp->closid]);
+				if (r->rid == RDT_RESOURCE_MBA)
+					size = ctrl;
+				else
+					size = rdtgroup_cbm_to_size(r, d, ctrl);
 			}
 			seq_printf(s, "%d=%u", d->id, size);
 			sep = true;
@@ -2336,12 +2359,18 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 	u32 *ctrl;
 
 	for_each_alloc_enabled_rdt_resource(r) {
+		/*
+		 * Only initialize default allocations for CBM cache
+		 * resources
+		 */
+		if (r->rid == RDT_RESOURCE_MBA)
+			continue;
 		list_for_each_entry(d, &r->domains, list) {
 			d->have_new_ctrl = false;
 			d->new_ctrl = r->cache.shareable_bits;
 			used_b = r->cache.shareable_bits;
 			ctrl = d->ctrl_val;
-			for (i = 0; i < r->num_closid; i++, ctrl++) {
+			for (i = 0; i < closids_supported(); i++, ctrl++) {
 				if (closid_allocated(i) && i != closid) {
 					mode = rdtgroup_mode_by_closid(i);
 					if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
@@ -2373,6 +2402,12 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 	}
 
 	for_each_alloc_enabled_rdt_resource(r) {
+		/*
+		 * Only initialize default allocations for CBM cache
+		 * resources
+		 */
+		if (r->rid == RDT_RESOURCE_MBA)
+			continue;
 		ret = update_domains(r, rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("failed to initialize allocations\n");
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379e575a..ddee1f0870c4 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -35,6 +35,7 @@
 #include <asm/bootparam_utils.h>
 #include <asm/microcode.h>
 #include <asm/kasan.h>
+#include <asm/fixmap.h>
 
 /*
  * Manage page tables very early on.
@@ -112,6 +113,7 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
+	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -165,7 +167,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pud[511] += load_delta;
 
 	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
-	pmd[506] += load_delta;
+	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
+		pmd[i] += load_delta;
 
 	/*
 	 * Set up the identity mapping for the switchover.  These
@@ -234,6 +237,21 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* Encrypt the kernel and related (if SME is active) */
 	sme_encrypt_kernel(bp);
 
+	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (mem_encrypt_active()) {
+		vaddr = (unsigned long)__start_bss_decrypted;
+		vaddr_end = (unsigned long)__end_bss_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
 	/*
 	 * Return the SME encryption mask (if SME is active) to be used as a
 	 * modifier for the initial pgdir entry programmed into CR3.
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 15ebc2fc166e..a3618cf04cf6 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -24,6 +24,7 @@
 #include "../entry/calling.h"
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/fixmap.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -445,13 +446,20 @@ NEXT_PAGE(level2_kernel_pgt)
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
 
 NEXT_PAGE(level2_fixmap_pgt)
-	.fill	506,8,0
-	.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
-	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
-	.fill	5,8,0
+	.fill	(512 - 4 - FIXMAP_PMD_NUM),8,0
+	pgtno = 0
+	.rept (FIXMAP_PMD_NUM)
+	.quad level1_fixmap_pgt + (pgtno << PAGE_SHIFT) - __START_KERNEL_map \
+		+ _PAGE_TABLE_NOENC;
+	pgtno = pgtno + 1
+	.endr
+	/* 6 MB reserved space + a 2MB hole */
+	.fill	4,8,0
 
 NEXT_PAGE(level1_fixmap_pgt)
+	.rept (FIXMAP_PMD_NUM)
 	.fill	512,8,0
+	.endr
 
 #undef PMDS
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1e6764648af3..013fe3d21dbb 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -28,6 +28,7 @@
 #include <linux/sched/clock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/set_memory.h>
 
 #include <asm/hypervisor.h>
 #include <asm/mem_encrypt.h>
@@ -61,9 +62,10 @@ early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
 	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
 
 static struct pvclock_vsyscall_time_info
-			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __aligned(PAGE_SIZE);
-static struct pvclock_wall_clock wall_clock;
+			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
+static struct pvclock_wall_clock wall_clock __bss_decrypted;
 static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
+static struct pvclock_vsyscall_time_info *hvclock_mem;
 
 static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
 {
@@ -236,6 +238,45 @@ static void kvm_shutdown(void)
 	native_machine_shutdown();
 }
 
+static void __init kvmclock_init_mem(void)
+{
+	unsigned long ncpus;
+	unsigned int order;
+	struct page *p;
+	int r;
+
+	if (HVC_BOOT_ARRAY_SIZE >= num_possible_cpus())
+		return;
+
+	ncpus = num_possible_cpus() - HVC_BOOT_ARRAY_SIZE;
+	order = get_order(ncpus * sizeof(*hvclock_mem));
+
+	p = alloc_pages(GFP_KERNEL, order);
+	if (!p) {
+		pr_warn("%s: failed to alloc %d pages", __func__, (1U << order));
+		return;
+	}
+
+	hvclock_mem = page_address(p);
+
+	/*
+	 * hvclock is shared between the guest and the hypervisor, must
+	 * be mapped decrypted.
+	 */
+	if (sev_active()) {
+		r = set_memory_decrypted((unsigned long) hvclock_mem,
+					 1UL << order);
+		if (r) {
+			__free_pages(p, order);
+			hvclock_mem = NULL;
+			pr_warn("kvmclock: set_memory_decrypted() failed. Disabling\n");
+			return;
+		}
+	}
+
+	memset(hvclock_mem, 0, PAGE_SIZE << order);
+}
+
 static int __init kvm_setup_vsyscall_timeinfo(void)
 {
 #ifdef CONFIG_X86_64
@@ -250,6 +291,9 @@ static int __init kvm_setup_vsyscall_timeinfo(void)
 
 	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
 #endif
+
+	kvmclock_init_mem();
+
 	return 0;
 }
 early_initcall(kvm_setup_vsyscall_timeinfo);
@@ -269,8 +313,10 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	/* Use the static page for the first CPUs, allocate otherwise */
 	if (cpu < HVC_BOOT_ARRAY_SIZE)
 		p = &hv_clock_boot[cpu];
+	else if (hvclock_mem)
+		p = hvclock_mem + cpu - HVC_BOOT_ARRAY_SIZE;
 	else
-		p = kzalloc(sizeof(*p), GFP_KERNEL);
+		return -ENOMEM;
 
 	per_cpu(hv_clock_per_cpu, cpu) = p;
 	return p ? 0 : -ENOMEM;
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index afdb303285f8..8dc69d82567e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -91,7 +91,7 @@ unsigned paravirt_patch_call(void *insnbuf,
 
 	if (len < 5) {
 #ifdef CONFIG_RETPOLINE
-		WARN_ONCE("Failing to patch indirect CALL in %ps\n", (void *)addr);
+		WARN_ONCE(1, "Failing to patch indirect CALL in %ps\n", (void *)addr);
 #endif
 		return len;	/* call too long for patch site */
 	}
@@ -111,7 +111,7 @@ unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
 
 	if (len < 5) {
 #ifdef CONFIG_RETPOLINE
-		WARN_ONCE("Failing to patch indirect JMP in %ps\n", (void *)addr);
+		WARN_ONCE(1, "Failing to patch indirect JMP in %ps\n", (void *)addr);
 #endif
 		return len;	/* call too long for patch site */
 	}
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8bde0a419f86..5dd3317d761f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -65,6 +65,23 @@ jiffies_64 = jiffies;
 #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
 
+/*
+ * This section contains data which will be mapped as decrypted. Memory
+ * encryption operates on a page basis. Make this section PMD-aligned
+ * to avoid splitting the pages while mapping the section early.
+ *
+ * Note: We use a separate section so that only this section gets
+ * decrypted to avoid exposing more than we wish.
+ */
+#define BSS_DECRYPTED						\
+	. = ALIGN(PMD_SIZE);					\
+	__start_bss_decrypted = .;				\
+	*(.bss..decrypted);					\
+	. = ALIGN(PAGE_SIZE);					\
+	__start_bss_decrypted_unused = .;			\
+	. = ALIGN(PMD_SIZE);					\
+	__end_bss_decrypted = .;				\
+
 #else
 
 #define X86_ALIGN_RODATA_BEGIN
@@ -74,6 +91,7 @@ jiffies_64 = jiffies;
 
 #define ALIGN_ENTRY_TEXT_BEGIN
 #define ALIGN_ENTRY_TEXT_END
+#define BSS_DECRYPTED
 
 #endif
 
@@ -355,6 +373,7 @@ SECTIONS
 		__bss_start = .;
 		*(.bss..page_aligned)
 		*(.bss)
+		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
 		__bss_stop = .;
 	}
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7a8fc26c1115..faca978ebf9d 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -815,10 +815,14 @@ void free_kernel_image_pages(void *begin, void *end)
 		set_memory_np_noalias(begin_ul, len_pages);
 }
 
+void __weak mem_encrypt_free_decrypted_mem(void) { }
+
 void __ref free_initmem(void)
 {
 	e820__reallocate_tables();
 
+	mem_encrypt_free_decrypted_mem();
+
 	free_kernel_image_pages(&__init_begin, &__init_end);
 }
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index b2de398d1fd3..006f373f54ab 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -348,6 +348,30 @@ bool sev_active(void)
 EXPORT_SYMBOL(sev_active);
 
 /* Architecture __weak replacement functions */
+void __init mem_encrypt_free_decrypted_mem(void)
+{
+	unsigned long vaddr, vaddr_end, npages;
+	int r;
+
+	vaddr = (unsigned long)__start_bss_decrypted_unused;
+	vaddr_end = (unsigned long)__end_bss_decrypted;
+	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
+
+	/*
+	 * The unused memory range was mapped decrypted, change the encryption
+	 * attribute from decrypted to encrypted before freeing it.
+	 */
+	if (mem_encrypt_active()) {
+		r = set_memory_encrypted(vaddr, npages);
+		if (r) {
+			pr_warn("failed to free unused decrypted pages\n");
+			return;
+		}
+	}
+
+	free_init_pages("unused decrypted", vaddr, vaddr_end);
+}
+
 void __init mem_encrypt_init(void)
 {
 	if (!sme_me_mask)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ae394552fb94..089e78c4effd 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -637,6 +637,15 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
 {
 	unsigned long address = __fix_to_virt(idx);
 
+#ifdef CONFIG_X86_64
+       /*
+	* Ensure that the static initial page tables are covering the
+	* fixmap completely.
+	*/
+	BUILD_BUG_ON(__end_of_permanent_fixed_addresses >
+		     (FIXMAP_PMD_NUM * PTRS_PER_PTE));
+#endif
+
 	if (idx >= __end_of_fixed_addresses) {
 		BUG();
 		return;
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2fe5c9b1816b..dd461c0167ef 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1907,7 +1907,7 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	/* L3_k[511] -> level2_fixmap_pgt */
 	convert_pfn_mfn(level3_kernel_pgt);
 
-	/* L3_k[511][506] -> level1_fixmap_pgt */
+	/* L3_k[511][508-FIXMAP_PMD_NUM ... 507] -> level1_fixmap_pgt */
 	convert_pfn_mfn(level2_fixmap_pgt);
 
 	/* We get [511][511] and have Xen's version of level2_kernel_pgt */
@@ -1952,7 +1952,11 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	set_page_prot(level2_ident_pgt, PAGE_KERNEL_RO);
 	set_page_prot(level2_kernel_pgt, PAGE_KERNEL_RO);
 	set_page_prot(level2_fixmap_pgt, PAGE_KERNEL_RO);
-	set_page_prot(level1_fixmap_pgt, PAGE_KERNEL_RO);
+
+	for (i = 0; i < FIXMAP_PMD_NUM; i++) {
+		set_page_prot(level1_fixmap_pgt + i * PTRS_PER_PTE,
+			      PAGE_KERNEL_RO);
+	}
 
 	/* Pin down new L4 */
 	pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE,

