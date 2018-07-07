Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21CAC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753E7224A1
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753E7224A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeGGAfx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 20:35:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:20602 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753937AbeGGAf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 20:35:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 17:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,318,1526367600"; 
   d="scan'208";a="238445485"
Received: from linksys13920.jf.intel.com (HELO rpedgeco-HP-Z240-Tower-Workstation.jf.intel.com) ([10.7.197.56])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2018 17:35:28 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 2/3] x86/modules: Increase randomization for modules
Date:   Fri,  6 Jul 2018 17:35:43 -0700
Message-Id: <1530923744-25687-3-git-send-email-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530923744-25687-1-git-send-email-rick.p.edgecombe@intel.com>
References: <1530923744-25687-1-git-send-email-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the behavior of the KASLR logic for allocating memory for the text
sections of loadable modules. It randomizes the location of each module text
section with about 17 bits of entropy in typical use. This is enabled on X86_64
only. For 32 bit, the behavior is unchanged.

The algorithm evenly breaks the module space in two, a random area and a backup
area. For module text allocations, it first tries to allocate at a number of
randomly located starting pages inside the random section. If this fails, it
will allocate in the backup area. The backup area base will be offset in the
same way as the current algorithm does for the base area, 1024 possible
locations.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/pgtable_64_types.h |   1 +
 arch/x86/kernel/module.c                | 103 ++++++++++++++++++++++++++++++--
 2 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 054765a..56452a0 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -141,6 +141,7 @@ extern unsigned int ptrs_per_p4d;
 /* The module sections ends with the start of the fixmap */
 #define MODULES_END		_AC(0xffffffffff000000, UL)
 #define MODULES_LEN		(MODULES_END - MODULES_VADDR)
+#define MODULES_RAND_LEN	PAGE_ALIGN((MODULES_LEN/3)*2)
 
 #define ESPFIX_PGD_ENTRY	_AC(-2, UL)
 #define ESPFIX_BASE_ADDR	(ESPFIX_PGD_ENTRY << P4D_SHIFT)
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index f58336a..4ffff9f 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -77,6 +77,93 @@ static unsigned long int get_module_load_offset(void)
 }
 #endif
 
+static unsigned long get_module_area_base(void)
+{
+	return MODULES_VADDR + get_module_load_offset();
+}
+
+#if defined(CONFIG_X86_64) && defined(CONFIG_RANDOMIZE_BASE)
+static unsigned long get_module_vmalloc_start(void)
+{
+	if (kaslr_enabled())
+		return MODULES_VADDR + MODULES_RAND_LEN
+						+ get_module_load_offset();
+	else
+		return get_module_area_base();
+}
+
+static void *try_module_alloc(unsigned long addr, unsigned long size,
+					int try_purge)
+{
+	return __vmalloc_node_try_addr(addr, size, GFP_KERNEL,
+						PAGE_KERNEL_EXEC, 0,
+						NUMA_NO_NODE, try_purge,
+						__builtin_return_address(0));
+}
+
+/*
+ * Try to allocate in the random area. First 5000 times without purging, then
+ * 5000 times with purging. If these fail, return NULL.
+ */
+static void *try_module_randomize_each(unsigned long size)
+{
+	void *p = NULL;
+	unsigned int i;
+	unsigned long offset;
+	unsigned long addr;
+	unsigned long end;
+	unsigned long last_lazy_free_blocked = 0;
+	const unsigned long nr_mod_positions = MODULES_RAND_LEN / MODULE_ALIGN;
+	const unsigned long nr_try_purge = 5000;
+	const unsigned long nr_no_purge = 5000;
+
+	if (!kaslr_enabled())
+		return NULL;
+
+	for (i = 0; i < nr_try_purge + nr_no_purge; i++) {
+		offset = (get_random_long() % nr_mod_positions) * MODULE_ALIGN;
+		addr = (unsigned long)MODULES_VADDR + offset;
+		end = addr + size;
+
+		if (end > addr && end < MODULES_END) {
+			if (i < nr_no_purge) {
+				/* First try to avoid having to purge */
+				p = try_module_alloc(addr, size, 0);
+
+				/*
+				 * Save the last value that was blocked by a
+				 * lazy purge area
+				 */
+				if (IS_ERR(p) && PTR_ERR(p) == -EBUSY)
+					last_lazy_free_blocked = addr;
+				else if (p && !IS_ERR(p))
+					return p;
+			} else {
+				/* Give up and allow for purges */
+				if (i == nr_try_purge && last_lazy_free_blocked)
+					addr = last_lazy_free_blocked;
+
+				p = try_module_alloc(addr, size, 1);
+
+				if (p)
+					return p;
+			}
+		}
+	}
+	return NULL;
+}
+#else
+static unsigned long get_module_vmalloc_start(void)
+{
+	return get_module_area_base();
+}
+
+static void *try_module_randomize_each(unsigned long size)
+{
+	return NULL;
+}
+#endif
+
 void *module_alloc(unsigned long size)
 {
 	void *p;
@@ -84,16 +171,20 @@ void *module_alloc(unsigned long size)
 	if (PAGE_ALIGN(size) > MODULES_LEN)
 		return NULL;
 
-	p = __vmalloc_node_range(size, MODULE_ALIGN,
-				    MODULES_VADDR + get_module_load_offset(),
-				    MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+	p = try_module_randomize_each(size);
+
+	if (!p)
+		p = __vmalloc_node_range(size, MODULE_ALIGN,
+						get_module_vmalloc_start(),
+						MODULES_END, GFP_KERNEL,
+						PAGE_KERNEL_EXEC, 0,
+						NUMA_NO_NODE,
+						__builtin_return_address(0));
+
 	if (p && (kasan_module_alloc(p, size) < 0)) {
 		vfree(p);
 		return NULL;
 	}
-
 	return p;
 }
 
-- 
2.7.4

