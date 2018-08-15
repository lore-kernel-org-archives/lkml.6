Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CBFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D092154D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D092154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeHOX2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:28:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:7364 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeHOX2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:28:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 13:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,244,1531810800"; 
   d="scan'208";a="224930396"
Received: from rpedgeco-hp-z240-tower-workstation.jf.intel.com (HELO rpedgeco-DESK5.jf.intel.com) ([10.54.75.168])
  by orsmga004.jf.intel.com with ESMTP; 15 Aug 2018 13:34:18 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v3 2/3] x86/modules: Increase randomization for modules
Date:   Wed, 15 Aug 2018 13:30:18 -0700
Message-Id: <1534365020-18943-3-git-send-email-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534365020-18943-1-git-send-email-rick.p.edgecombe@intel.com>
References: <1534365020-18943-1-git-send-email-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the behavior of the KASLR logic for allocating memory for the text
sections of loadable modules. It randomizes the location of each module text
section with about 17 bits of entropy in typical use. This is enabled on X86_64
only. For 32 bit, the behavior is unchanged. It refactors existing code around
module randomization in order to cleanly implement this along side the unchanged
32 bit behavior.

The algorithm breaks the module space in two, a random area and a backup area.
It first tries to allocate at a number of randomly located starting pages inside
the random section without purging any lazy free vmap areas and triggering the
associated TLB flush. If this fails, it will try again a number of times
allowing for purges if needed.  Finally if those both fail to find a position it
will allocate in the backup area. The backup area base will be offset in the
same way as the current algorithm does for the base area, 1024 possible
locations.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/pgtable_64_types.h |   7 ++
 arch/x86/kernel/module.c                | 163 +++++++++++++++++++++++++++-----
 2 files changed, 147 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 054765a..c320b7f 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -142,6 +142,13 @@ extern unsigned int ptrs_per_p4d;
 #define MODULES_END		_AC(0xffffffffff000000, UL)
 #define MODULES_LEN		(MODULES_END - MODULES_VADDR)
 
+/*
+ * Dedicate the first part of the module space to a randomized area when KASLR
+ * is in use.  Leave the remaining part for a fallback if we are unable to
+ * allocate in the random area.
+ */
+#define MODULES_RAND_LEN	PAGE_ALIGN((MODULES_LEN/3)*2)
+
 #define ESPFIX_PGD_ENTRY	_AC(-2, UL)
 #define ESPFIX_BASE_ADDR	(ESPFIX_PGD_ENTRY << P4D_SHIFT)
 
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index f58336a..1cb8efa 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -48,34 +48,149 @@ do {							\
 } while (0)
 #endif
 
-#ifdef CONFIG_RANDOMIZE_BASE
+static inline int kaslr_randomize_each_module(void)
+{
+	return kaslr_enabled()
+			&& IS_ENABLED(CONFIG_RANDOMIZE_BASE)
+			&& IS_ENABLED(CONFIG_X86_64);
+}
+
+static inline int kaslr_randomize_base(void)
+{
+	return kaslr_enabled()
+			&& IS_ENABLED(CONFIG_RANDOMIZE_BASE)
+			&& !IS_ENABLED(CONFIG_X86_64);
+}
+
+#ifdef CONFIG_X86_64
+static inline const unsigned long get_modules_rand_len(void)
+{
+	return MODULES_RAND_LEN;
+}
+#else
+static inline const unsigned long get_modules_rand_len(void)
+{
+	BUILD_BUG();
+	return 0;
+}
+#endif
+
 static unsigned long module_load_offset;
+static const unsigned long NR_NO_PURGE = 5000;
+static const unsigned long NR_TRY_PURGE = 5000;
 
 /* Mutex protects the module_load_offset. */
 static DEFINE_MUTEX(module_kaslr_mutex);
 
 static unsigned long int get_module_load_offset(void)
 {
-	if (kaslr_enabled()) {
-		mutex_lock(&module_kaslr_mutex);
-		/*
-		 * Calculate the module_load_offset the first time this
-		 * code is called. Once calculated it stays the same until
-		 * reboot.
-		 */
-		if (module_load_offset == 0)
-			module_load_offset =
-				(get_random_int() % 1024 + 1) * PAGE_SIZE;
-		mutex_unlock(&module_kaslr_mutex);
-	}
+	mutex_lock(&module_kaslr_mutex);
+	/*
+	 * Calculate the module_load_offset the first time this
+	 * code is called. Once calculated it stays the same until
+	 * reboot.
+	 */
+	if (module_load_offset == 0)
+		module_load_offset = (get_random_int() % 1024 + 1) * PAGE_SIZE;
+	mutex_unlock(&module_kaslr_mutex);
+
 	return module_load_offset;
 }
-#else
-static unsigned long int get_module_load_offset(void)
+
+static unsigned long get_module_vmalloc_start(void)
 {
-	return 0;
+	if (kaslr_randomize_each_module())
+		return MODULES_VADDR + get_modules_rand_len()
+					+ get_module_load_offset();
+	else if (kaslr_randomize_base())
+		return MODULES_VADDR + get_module_load_offset();
+
+	return MODULES_VADDR;
+}
+
+static void *try_module_alloc(unsigned long addr, unsigned long size,
+					int try_purge)
+{
+	const unsigned long vm_flags = 0;
+
+	return __vmalloc_node_try_addr(addr, size, GFP_KERNEL, PAGE_KERNEL_EXEC,
+					vm_flags, NUMA_NO_NODE, try_purge,
+					__builtin_return_address(0));
+}
+
+/*
+ * Find a random address to try that wont obviosly not fit. Random areas are
+ * allowed to overflow into the backup area
+ */
+static unsigned long get_rand_module_addr(unsigned long size)
+{
+	unsigned long nr_max_pos = (MODULES_LEN - size) / MODULE_ALIGN + 1;
+	unsigned long nr_rnd_pos = get_modules_rand_len() / MODULE_ALIGN;
+	unsigned long nr_pos = min(nr_max_pos, nr_rnd_pos);
+
+	unsigned long module_position_nr = get_random_long() % nr_pos;
+	unsigned long offset = module_position_nr * MODULE_ALIGN;
+
+	return MODULES_VADDR + offset;
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
+	unsigned long last_lazy_free_blocked = 0;
+
+	/* This will have a gaurd page */
+	unsigned long real_size = PAGE_ALIGN(size) + PAGE_SIZE;
+
+	if (!kaslr_randomize_each_module())
+		return NULL;
+
+	/* Make sure there is at least one address that might fit. */
+	if (real_size < PAGE_ALIGN(size) || real_size > MODULES_LEN)
+		return NULL;
+
+	/* Try to find a spot that doesn't need a lazy purge */
+	for (i = 0; i < NR_NO_PURGE; i++) {
+		unsigned long addr = get_rand_module_addr(real_size);
+
+		/* First try to avoid having to purge */
+		p = try_module_alloc(addr, real_size, 0);
+
+		/*
+		 * Save the last value that was blocked by a
+		 * lazy purge area.
+		 */
+		if (IS_ERR(p) && PTR_ERR(p) == -EUCLEAN)
+			last_lazy_free_blocked = addr;
+		else if (!IS_ERR(p))
+			return p;
+	}
+
+	/* Try the most recent spot that could be used after a lazy purge */
+	if (last_lazy_free_blocked) {
+		p = try_module_alloc(last_lazy_free_blocked, real_size, 1);
+
+		if (!IS_ERR(p))
+			return p;
+	}
+
+	/* Look for more spots and allow lazy purges */
+	for (i = 0; i < NR_TRY_PURGE; i++) {
+		unsigned long addr = get_rand_module_addr(real_size);
+
+		/* Give up and allow for purges */
+		p = try_module_alloc(addr, real_size, 1);
+
+		if (!IS_ERR(p))
+			return p;
+	}
+	return NULL;
 }
-#endif
 
 void *module_alloc(unsigned long size)
 {
@@ -84,16 +199,18 @@ void *module_alloc(unsigned long size)
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
+				get_module_vmalloc_start(), MODULES_END,
+				GFP_KERNEL, PAGE_KERNEL_EXEC, 0,
+				NUMA_NO_NODE, __builtin_return_address(0));
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

