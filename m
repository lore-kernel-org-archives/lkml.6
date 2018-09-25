Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BA4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0A8206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0A8206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeIZC3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:29:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:22184 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeIZC3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:29:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 13:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="77230187"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.152])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2018 13:20:12 -0700
Subject: [PATCH v5 2/4] mm: Provide kernel parameter to allow disabling page
 init poisoning
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, dave.hansen@intel.com, jglisse@redhat.com,
        rppt@linux.vnet.ibm.com, dan.j.williams@intel.com,
        logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Date:   Tue, 25 Sep 2018 13:20:12 -0700
Message-ID: <20180925201921.3576.84239.stgit@localhost.localdomain>
In-Reply-To: <20180925200551.3576.18755.stgit@localhost.localdomain>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with a large amount of memory it can take a significant amount
of time to initialize all of the page structs with the PAGE_POISON_PATTERN
value. I have seen it take over 2 minutes to initialize a system with
over 12TB of RAM.

In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
the boot time returned to something much more reasonable as the
arch_add_memory call completed in milliseconds versus seconds. However in
doing that I had to disable all of the other VM debugging on the system.

In order to work around a kernel that might have CONFIG_DEBUG_VM enabled on
a system that has a large amount of memory I have added a new kernel
parameter named "vm_debug" that can be set to "-" in order to disable it.

Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---

v3: Switched from kernel config option to parameter
v4: Added comment to parameter handler to record when option is disabled
    Updated parameter description based on feedback from Michal Hocko
    Fixed GB vs TB typo in patch description.
    Switch to vm_debug option similar to slub_debug
v5: Rebased on latest linux-next

 Documentation/admin-guide/kernel-parameters.txt |   12 ++++++
 include/linux/page-flags.h                      |    8 ++++
 mm/debug.c                                      |   46 +++++++++++++++++++++++
 mm/memblock.c                                   |    5 +--
 mm/sparse.c                                     |    4 +-
 5 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42d9150047f2..d9ad70ccbdc2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4811,6 +4811,18 @@
 			This is actually a boot loader parameter; the value is
 			passed to the kernel using a special protocol.
 
+	vm_debug[=options]	[KNL] Available with CONFIG_DEBUG_VM=y.
+			May slow down system boot speed, especially when
+			enabled on systems with a large amount of memory.
+			All options are enabled by default, and this
+			interface is meant to allow for selectively
+			enabling or disabling specific virtual memory
+			debugging features.
+
+			Available options are:
+			  P	Enable page structure init time poisoning
+			  -	Disable all of the above options
+
 	vmalloc=nn[KMG]	[KNL,BOOT] Forces the vmalloc area to have an exact
 			size of <nn>. This can be used to increase the
 			minimum size (128MB on x86). It can also be used to
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4d99504f6496..934f91ef3f54 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -163,6 +163,14 @@ static inline int PagePoisoned(const struct page *page)
 	return page->flags == PAGE_POISON_PATTERN;
 }
 
+#ifdef CONFIG_DEBUG_VM
+void page_init_poison(struct page *page, size_t size);
+#else
+static inline void page_init_poison(struct page *page, size_t size)
+{
+}
+#endif
+
 /*
  * Page flags policies wrt compound pages
  *
diff --git a/mm/debug.c b/mm/debug.c
index bd10aad8539a..cdacba12e09a 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -13,6 +13,7 @@
 #include <trace/events/mmflags.h>
 #include <linux/migrate.h>
 #include <linux/page_owner.h>
+#include <linux/ctype.h>
 
 #include "internal.h"
 
@@ -175,4 +176,49 @@ void dump_mm(const struct mm_struct *mm)
 	);
 }
 
+static bool page_init_poisoning __read_mostly = true;
+
+static int __init setup_vm_debug(char *str)
+{
+	bool __page_init_poisoning = true;
+
+	/*
+	 * Calling vm_debug with no arguments is equivalent to requesting
+	 * to enable all debugging options we can control.
+	 */
+	if (*str++ != '=' || !*str)
+		goto out;
+
+	__page_init_poisoning = false;
+	if (*str == '-')
+		goto out;
+
+	while (*str) {
+		switch (tolower(*str)) {
+		case'p':
+			__page_init_poisoning = true;
+			break;
+		default:
+			pr_err("vm_debug option '%c' unknown. skipped\n",
+			       *str);
+		}
+
+		str++;
+	}
+out:
+	if (page_init_poisoning && !__page_init_poisoning)
+		pr_warn("Page struct poisoning disabled by kernel command line option 'vm_debug'\n");
+
+	page_init_poisoning = __page_init_poisoning;
+
+	return 1;
+}
+__setup("vm_debug", setup_vm_debug);
+
+void page_init_poison(struct page *page, size_t size)
+{
+	if (page_init_poisoning)
+		memset(page, PAGE_POISON_PATTERN, size);
+}
+EXPORT_SYMBOL_GPL(page_init_poison);
 #endif		/* CONFIG_DEBUG_VM */
diff --git a/mm/memblock.c b/mm/memblock.c
index 32e5c62ee142..b0ebca546ba1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1503,10 +1503,9 @@ void * __init memblock_alloc_try_nid_raw(
 
 	ptr = memblock_alloc_internal(size, align,
 					   min_addr, max_addr, nid);
-#ifdef CONFIG_DEBUG_VM
 	if (ptr && size > 0)
-		memset(ptr, PAGE_POISON_PATTERN, size);
-#endif
+		page_init_poison(ptr, size);
+
 	return ptr;
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index c0788e3d8513..ab2ac45e0440 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -696,13 +696,11 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
 		goto out;
 	}
 
-#ifdef CONFIG_DEBUG_VM
 	/*
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	memset(memmap, PAGE_POISON_PATTERN, sizeof(struct page) * PAGES_PER_SECTION);
-#endif
+	page_init_poison(memmap, sizeof(struct page) * PAGES_PER_SECTION);
 
 	section_mark_present(ms);
 	sparse_init_one_section(ms, section_nr, memmap, usemap);

