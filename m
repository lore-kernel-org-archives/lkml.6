Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeDDI7b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:59:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:34527 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeDDI71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:59:27 -0400
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 1/9] vsprintf: Shuffle ptr_to_id() code
Date: Wed,  4 Apr 2018 10:58:35 +0200
Message-Id: <20180404085843.16050-2-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180404085843.16050-1-pmladek@suse.com>
References: <20180404085843.16050-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just moves ptr_to_id() implementation up in the source
file. We will want to call it earlier.

This patch does not change the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 134 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 67 insertions(+), 67 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..c0c677c6a833 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -602,6 +602,73 @@ char *string(char *buf, char *end, const char *s, struct printf_spec spec)
 	return widen_string(buf, len, end, spec);
 }
 
+static bool have_filled_random_ptr_key __read_mostly;
+static siphash_key_t ptr_key __read_mostly;
+
+static void fill_random_ptr_key(struct random_ready_callback *unused)
+{
+	get_random_bytes(&ptr_key, sizeof(ptr_key));
+	/*
+	 * have_filled_random_ptr_key==true is dependent on get_random_bytes().
+	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
+	 * after get_random_bytes() returns.
+	 */
+	smp_mb();
+	WRITE_ONCE(have_filled_random_ptr_key, true);
+}
+
+static struct random_ready_callback random_ready = {
+	.func = fill_random_ptr_key
+};
+
+static int __init initialize_ptr_random(void)
+{
+	int ret = add_random_ready_callback(&random_ready);
+
+	if (!ret) {
+		return 0;
+	} else if (ret == -EALREADY) {
+		fill_random_ptr_key(&random_ready);
+		return 0;
+	}
+
+	return ret;
+}
+early_initcall(initialize_ptr_random);
+
+/* Maps a pointer to a 32 bit unique identifier. */
+static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
+{
+	unsigned long hashval;
+	const int default_width = 2 * sizeof(ptr);
+
+	if (unlikely(!have_filled_random_ptr_key)) {
+		spec.field_width = default_width;
+		/* string length must be less than default_width */
+		return string(buf, end, "(ptrval)", spec);
+	}
+
+#ifdef CONFIG_64BIT
+	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
+	/*
+	 * Mask off the first 32 bits, this makes explicit that we have
+	 * modified the address (and 32 bits is plenty for a unique ID).
+	 */
+	hashval = hashval & 0xffffffff;
+#else
+	hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
+#endif
+
+	spec.flags |= SMALL;
+	if (spec.field_width == -1) {
+		spec.field_width = default_width;
+		spec.flags |= ZEROPAD;
+	}
+	spec.base = 16;
+
+	return number(buf, end, hashval, spec);
+}
+
 static noinline_for_stack
 char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_spec spec,
 		  const char *fmt)
@@ -1659,73 +1726,6 @@ char *pointer_string(char *buf, char *end, const void *ptr,
 	return number(buf, end, (unsigned long int)ptr, spec);
 }
 
-static bool have_filled_random_ptr_key __read_mostly;
-static siphash_key_t ptr_key __read_mostly;
-
-static void fill_random_ptr_key(struct random_ready_callback *unused)
-{
-	get_random_bytes(&ptr_key, sizeof(ptr_key));
-	/*
-	 * have_filled_random_ptr_key==true is dependent on get_random_bytes().
-	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
-	 * after get_random_bytes() returns.
-	 */
-	smp_mb();
-	WRITE_ONCE(have_filled_random_ptr_key, true);
-}
-
-static struct random_ready_callback random_ready = {
-	.func = fill_random_ptr_key
-};
-
-static int __init initialize_ptr_random(void)
-{
-	int ret = add_random_ready_callback(&random_ready);
-
-	if (!ret) {
-		return 0;
-	} else if (ret == -EALREADY) {
-		fill_random_ptr_key(&random_ready);
-		return 0;
-	}
-
-	return ret;
-}
-early_initcall(initialize_ptr_random);
-
-/* Maps a pointer to a 32 bit unique identifier. */
-static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
-{
-	unsigned long hashval;
-	const int default_width = 2 * sizeof(ptr);
-
-	if (unlikely(!have_filled_random_ptr_key)) {
-		spec.field_width = default_width;
-		/* string length must be less than default_width */
-		return string(buf, end, "(ptrval)", spec);
-	}
-
-#ifdef CONFIG_64BIT
-	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
-	/*
-	 * Mask off the first 32 bits, this makes explicit that we have
-	 * modified the address (and 32 bits is plenty for a unique ID).
-	 */
-	hashval = hashval & 0xffffffff;
-#else
-	hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
-#endif
-
-	spec.flags |= SMALL;
-	if (spec.field_width == -1) {
-		spec.field_width = default_width;
-		spec.flags |= ZEROPAD;
-	}
-	spec.base = 16;
-
-	return number(buf, end, hashval, spec);
-}
-
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
-- 
2.13.6
