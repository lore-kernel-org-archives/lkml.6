Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeCEQaC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:30:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:9033 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752562AbeCEQ03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:26:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="39349292"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC, PATCH 08/22] mm: Introduce __GFP_ENCRYPT
Date: Mon,  5 Mar 2018 19:25:56 +0300
Message-Id: <20180305162610.37510-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds new gfp flag to indicate that we're allocating encrypted
page.

Architectural code may need to do special preparation for encrypted
pages such as flushing cache to avoid aliasing.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/gfp.h            | 12 ++++++++++++
 include/linux/mm.h             |  2 ++
 include/trace/events/mmflags.h |  1 +
 mm/Kconfig                     |  3 +++
 mm/page_alloc.c                |  3 +++
 tools/perf/builtin-kmem.c      |  1 +
 6 files changed, 22 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 1a4582b44d32..43a93ca11c3c 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -24,6 +24,11 @@ struct vm_area_struct;
 #define ___GFP_HIGH		0x20u
 #define ___GFP_IO		0x40u
 #define ___GFP_FS		0x80u
+#ifdef CONFIG_ARCH_WANTS_GFP_ENCRYPT
+#define ___GFP_ENCYPT		0x100u
+#else
+#define ___GFP_ENCYPT		0
+#endif
 #define ___GFP_NOWARN		0x200u
 #define ___GFP_RETRY_MAYFAIL	0x400u
 #define ___GFP_NOFAIL		0x800u
@@ -188,6 +193,13 @@ struct vm_area_struct;
 #define __GFP_NOFAIL	((__force gfp_t)___GFP_NOFAIL)
 #define __GFP_NORETRY	((__force gfp_t)___GFP_NORETRY)
 
+/*
+ * Allocate encrypted page.
+ *
+ * Architectural code may need to do special preparation for encrypted pages
+ * such as flushing cache to avoid aliasing.
+ */
+#define __GFP_ENCRYPT	((__force gfp_t)___GFP_ENCYPT)
 /*
  * Action modifiers
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42adb1a..6791eccdb740 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1966,6 +1966,8 @@ extern void mem_init_print_info(const char *str);
 
 extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
 
+extern void prep_encrypt_page(struct page *page, gfp_t gfp, unsigned int order);
+
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void __free_reserved_page(struct page *page)
 {
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index dbe1bb058c09..43cc3f7170bc 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -32,6 +32,7 @@
 	{(unsigned long)__GFP_ATOMIC,		"__GFP_ATOMIC"},	\
 	{(unsigned long)__GFP_IO,		"__GFP_IO"},		\
 	{(unsigned long)__GFP_FS,		"__GFP_FS"},		\
+	{(unsigned long)__GFP_ENCRYPT,		"__GFP_ENCRYPT"},	\
 	{(unsigned long)__GFP_NOWARN,		"__GFP_NOWARN"},	\
 	{(unsigned long)__GFP_RETRY_MAYFAIL,	"__GFP_RETRY_MAYFAIL"},	\
 	{(unsigned long)__GFP_NOFAIL,		"__GFP_NOFAIL"},	\
diff --git a/mm/Kconfig b/mm/Kconfig
index c782e8fb7235..e08583c0498e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -149,6 +149,9 @@ config NO_BOOTMEM
 config MEMORY_ISOLATION
 	bool
 
+config ARCH_WANTS_GFP_ENCRYPT
+	bool
+
 #
 # Only be set on architectures that have completely implemented memory hotplug
 # feature. If you are not sure, don't touch it.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb416723538f..8d049445b827 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1829,6 +1829,9 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 		set_page_pfmemalloc(page);
 	else
 		clear_page_pfmemalloc(page);
+
+	if (gfp_flags & __GFP_ENCRYPT)
+		prep_encrypt_page(page, gfp_flags, order);
 }
 
 /*
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index ae11e4c3516a..1eeb2425cb01 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -641,6 +641,7 @@ static const struct {
 	{ "__GFP_ATOMIC",		"_A" },
 	{ "__GFP_IO",			"I" },
 	{ "__GFP_FS",			"F" },
+	{ "__GFP_ENCRYPT",		"E" },
 	{ "__GFP_NOWARN",		"NWR" },
 	{ "__GFP_RETRY_MAYFAIL",	"R" },
 	{ "__GFP_NOFAIL",		"NF" },
-- 
2.16.1
