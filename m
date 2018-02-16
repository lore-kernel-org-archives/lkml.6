Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeBPT2N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:28:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:32804 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbeBPT2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:28:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="20758557"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Tobin C. Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/7] lib/vsprintf: Deduplicate pointer_string()
Date: Fri, 16 Feb 2018 21:28:01 +0200
Message-Id: <20180216192806.68914-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
References: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
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
 lib/vsprintf.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..b6d254723828 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1697,10 +1697,9 @@ early_initcall(initialize_ptr_random);
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
@@ -1715,15 +1714,7 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
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
