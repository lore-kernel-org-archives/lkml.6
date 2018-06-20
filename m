Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D01C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE6720874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE6720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933712AbeFTWJ6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:09:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:19370 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933578AbeFTWJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:09:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 15:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="66312716"
Received: from linksys13920.jf.intel.com (HELO rpedgeco-HP-Z240-Tower-Workstation.jf.intel.com) ([10.7.197.56])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2018 15:09:32 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Cc:     kristen.c.accardi@intel.com, dave.hansen@intel.com,
        arjan.van.de.ven@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 2/3] x86/modules: Increase randomization for modules
Date:   Wed, 20 Jun 2018 15:09:29 -0700
Message-Id: <1529532570-21765-3-git-send-email-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the behavior of the KASLR logic for allocating memory for the text
sections of loadable modules. It randomizes the location of each module text
section with about 18 bits of entropy in typical use. This is enabled on X86_64
only. For 32 bit, the behavior is unchanged.

The algorithm evenly breaks the module space in two, a random area and a backup
area. For module text allocations, it first tries to allocate up to 10 randomly
located starting pages inside the random section. If this fails, it will
allocate in the backup area. The backup area base will be offset in the same
way as the current algorithm does for the base area, 1024 possible locations.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/pgtable_64_types.h |  1 +
 arch/x86/kernel/module.c                | 80 ++++++++++++++++++++++++++++++---
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 054765a..a98708a 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -141,6 +141,7 @@ extern unsigned int ptrs_per_p4d;
 /* The module sections ends with the start of the fixmap */
 #define MODULES_END		_AC(0xffffffffff000000, UL)
 #define MODULES_LEN		(MODULES_END - MODULES_VADDR)
+#define MODULES_RAND_LEN	(MODULES_LEN/2)
 
 #define ESPFIX_PGD_ENTRY	_AC(-2, UL)
 #define ESPFIX_BASE_ADDR	(ESPFIX_PGD_ENTRY << P4D_SHIFT)
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index f58336a..833ea81 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -77,6 +77,71 @@ static unsigned long int get_module_load_offset(void)
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
+static void *try_module_alloc(unsigned long addr, unsigned long size)
+{
+	return __vmalloc_node_try_addr(addr, size, GFP_KERNEL,
+						PAGE_KERNEL_EXEC, 0,
+						NUMA_NO_NODE,
+						__builtin_return_address(0));
+}
+
+/*
+ * Try to allocate in 10 random positions starting in the random part of the
+ * module space. If these fail, return NULL.
+ */
+static void *try_module_randomize_each(unsigned long size)
+{
+	void *p = NULL;
+	unsigned int i;
+	unsigned long offset;
+	unsigned long addr;
+	unsigned long end;
+	const unsigned long nr_mod_positions = MODULES_RAND_LEN / MODULE_ALIGN;
+
+	if (!kaslr_enabled())
+		return NULL;
+
+	for (i = 0; i < 10; i++) {
+		offset = (get_random_long() % nr_mod_positions) * MODULE_ALIGN;
+		addr = (unsigned long)MODULES_VADDR + offset;
+		end = addr + size;
+
+		if (end > addr && end < MODULES_END) {
+			p = try_module_alloc(addr, size);
+
+			if (p)
+				return p;
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
@@ -84,11 +149,16 @@ void *module_alloc(unsigned long size)
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
-- 
2.7.4

