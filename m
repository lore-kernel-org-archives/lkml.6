Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeBPVHw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:07:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:23771 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbeBPVHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:07:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="18754917"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 6/9] lib/vsprintf: Deduplicate pointer_string()
Date: Fri, 16 Feb 2018 23:07:08 +0200
Message-Id: <20180216210711.79901-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an exact code at the end of ptr_to_id().
Replace it by calling pointer_string() directly.

This is followup to the commit
  ad67b74d2469 ("printk: hash addresses printed with %p").

Cc: Tobin C. Harding <me@tobin.cc>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 87dbced51b1a..9004bbb3d84d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1367,13 +1367,6 @@ static noinline_for_stack
 char *restricted_pointer(char *buf, char *end, const void *ptr,
 			 struct printf_spec spec)
 {
-	spec.base = 16;
-	spec.flags |= SMALL;
-	if (spec.field_width == -1) {
-		spec.field_width = 2 * sizeof(ptr);
-		spec.flags |= ZEROPAD;
-	}
-
 	switch (kptr_restrict) {
 	case 0:
 		/* Always print %pK values */
@@ -1385,8 +1378,11 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 		 * kptr_restrict==1 cannot be used in IRQ context
 		 * because its test for CAP_SYSLOG would be meaningless.
 		 */
-		if (in_irq() || in_serving_softirq() || in_nmi())
+		if (in_irq() || in_serving_softirq() || in_nmi()) {
+			if (spec.field_width == -1)
+				spec.field_width = 2 * sizeof(ptr);
 			return string(buf, end, "pK-error", spec);
+		}
 
 		/*
 		 * Only print the real pointer value if the current
@@ -1411,7 +1407,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 		break;
 	}
 
-	return number(buf, end, (unsigned long)ptr, spec);
+	return pointer_string(buf, end, ptr, spec);
 }
 
 static noinline_for_stack
@@ -1686,10 +1682,9 @@ early_initcall(initialize_ptr_random);
 static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 {
 	unsigned long hashval;
-	const int default_width = 2 * sizeof(ptr);
 
 	if (unlikely(!have_filled_random_ptr_key)) {
-		spec.field_width = default_width;
+		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
 		return string(buf, end, "(ptrval)", spec);
 	}
@@ -1704,15 +1699,7 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 #else
 	hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
 #endif
-
-	spec.flags |= SMALL;
-	if (spec.field_width == -1) {
-		spec.field_width = default_width;
-		spec.flags |= ZEROPAD;
-	}
-	spec.base = 16;
-
-	return number(buf, end, hashval, spec);
+	return pointer_string(buf, end, (const void *)hashval, spec);
 }
 
 /*
-- 
2.15.1
