Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01910C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17BA2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17BA2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeJPTDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:03:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:17625 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeJPTDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:03:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 04:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="271724689"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2018 04:13:53 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, Joe Perches <joe@perches.com>
Subject: [PATCH] lib: Fix ia64 bootloader linkage
Date:   Tue, 16 Oct 2018 14:13:40 +0300
Message-Id: <20181016111340.8046-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <201810161649.o89WBjtC%fengguang.wu@intel.com>
References: <201810161649.o89WBjtC%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild robot reports that since commit ce76d938dd98 ("lib: Add memcat_p():
paste 2 pointer arrays together") the ia64/hp/sim/boot fails to link:

> LD      arch/ia64/hp/sim/boot/bootloader
> lib/string.o: In function `__memcat_p':
> string.c:(.text+0x1f22): undefined reference to `__kmalloc'
> string.c:(.text+0x1ff2): undefined reference to `__kmalloc'
> make[1]: *** [arch/ia64/hp/sim/boot/Makefile:37: arch/ia64/hp/sim/boot/bootloader] Error 1

The reason is, the above commit, via __memcat_p(), adds a call to
__kmalloc to string.o, which happens to be used in the bootloader, but
there's no kmalloc or slab or anything.

Since the linker would only pull in objects that contain referenced
symbols, moving __memcat_p() to a different compilation unit solves the
problem.

Fixes: ce76d938dd98 ("lib: Add memcat_p(): paste 2 pointer arrays together")
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Joe Perches <joe@perches.com>
---
 lib/Makefile        |  2 +-
 lib/memcat_p.c      | 34 ++++++++++++++++++++++++++++++++++
 lib/string.c        | 30 ------------------------------
 lib/test_memcat_p.c |  2 +-
 4 files changed, 36 insertions(+), 32 deletions(-)
 create mode 100644 lib/memcat_p.c

diff --git a/lib/Makefile b/lib/Makefile
index c2588a2d7b1e..40e79f88c3cd 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -24,7 +24,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
-	 nmi_backtrace.o nodemask.o win_minmax.o
+	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_MMU) += ioremap.o
diff --git a/lib/memcat_p.c b/lib/memcat_p.c
new file mode 100644
index 000000000000..b810fbc66962
--- /dev/null
+++ b/lib/memcat_p.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/slab.h>
+
+/*
+ * Merge two NULL-terminated pointer arrays into a newly allocated
+ * array, which is also NULL-terminated. Nomenclature is inspired by
+ * memset_p() and memcat() found elsewhere in the kernel source tree.
+ */
+void **__memcat_p(void **a, void **b)
+{
+	void **p = a, **new;
+	int nr;
+
+	/* count the elements in both arrays */
+	for (nr = 0, p = a; *p; nr++, p++)
+		;
+	for (p = b; *p; nr++, p++)
+		;
+	/* one for the NULL-terminator */
+	nr++;
+
+	new = kmalloc_array(nr, sizeof(void *), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	/* nr -> last index; p points to NULL in b[] */
+	for (nr--; nr >= 0; nr--, p = p == b ? &a[nr] : p - 1)
+		new[nr] = *p;
+
+	return new;
+}
+EXPORT_SYMBOL_GPL(__memcat_p);
+
diff --git a/lib/string.c b/lib/string.c
index 453f35994eb6..38e4ca08e757 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -891,36 +891,6 @@ void *memscan(void *addr, int c, size_t size)
 EXPORT_SYMBOL(memscan);
 #endif
 
-/*
- * Merge two NULL-terminated pointer arrays into a newly allocated
- * array, which is also NULL-terminated. Nomenclature is inspired by
- * memset_p() and memcat() found elsewhere in the kernel source tree.
- */
-void **__memcat_p(void **a, void **b)
-{
-	void **p = a, **new;
-	int nr;
-
-	/* count the elements in both arrays */
-	for (nr = 0, p = a; *p; nr++, p++)
-		;
-	for (p = b; *p; nr++, p++)
-		;
-	/* one for the NULL-terminator */
-	nr++;
-
-	new = kmalloc_array(nr, sizeof(void *), GFP_KERNEL);
-	if (!new)
-		return NULL;
-
-	/* nr -> last index; p points to NULL in b[] */
-	for (nr--; nr >= 0; nr--, p = p == b ? &a[nr] : p - 1)
-		new[nr] = *p;
-
-	return new;
-}
-EXPORT_SYMBOL_GPL(__memcat_p);
-
 #ifndef __HAVE_ARCH_STRSTR
 /**
  * strstr - Find the first substring in a %NUL terminated string
diff --git a/lib/test_memcat_p.c b/lib/test_memcat_p.c
index 2b163a749ecb..849c477d49d0 100644
--- a/lib/test_memcat_p.c
+++ b/lib/test_memcat_p.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Test cases for memcat_p() in lib/string.c
+ * Test cases for memcat_p() in lib/memcat_p.c
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-- 
2.19.1

