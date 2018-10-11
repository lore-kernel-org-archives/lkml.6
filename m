Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2170C46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22682087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22682087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeJKQJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:09:11 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:54318 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbeJKQJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:09:10 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id m8ir1y0013XaVaC018irZK; Thu, 11 Oct 2018 10:42:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gAWYU-0000O0-Uj; Thu, 11 Oct 2018 10:42:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gAWYU-0001Bi-Sf; Thu, 11 Oct 2018 10:42:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/3] lib/vsprintf: Prepare for more general use of ptr_to_id()
Date:   Thu, 11 Oct 2018 10:42:47 +0200
Message-Id: <20181011084249.4520-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011084249.4520-1-geert+renesas@glider.be>
References: <20181011084249.4520-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Make the ptr argument const, to avoid adding casts in future
    callers,
  - Move the function and its dependencies up, so it can be called from
    special pointer type formatting routines.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Get rid of the forward declaration for ptr_to_id().
---
 lib/vsprintf.c | 205 +++++++++++++++++++++++++------------------------
 1 file changed, 103 insertions(+), 102 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 095a677f89c02442..b4e4ab274bde2397 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -612,6 +612,109 @@ char *string(char *buf, char *end, const char *s, struct printf_spec spec)
 	return widen_string(buf, len, end, spec);
 }
 
+static noinline_for_stack
+char *pointer_string(char *buf, char *end, const void *ptr,
+		     struct printf_spec spec)
+{
+	spec.base = 16;
+	spec.flags |= SMALL;
+	if (spec.field_width == -1) {
+		spec.field_width = 2 * sizeof(ptr);
+		spec.flags |= ZEROPAD;
+	}
+
+	return number(buf, end, (unsigned long int)ptr, spec);
+}
+
+/* Make pointers available for printing early in the boot sequence. */
+static int debug_boot_weak_hash __ro_after_init;
+
+static int __init debug_boot_weak_hash_enable(char *str)
+{
+	debug_boot_weak_hash = 1;
+	pr_info("debug_boot_weak_hash enabled\n");
+	return 0;
+}
+early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
+
+static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
+static siphash_key_t ptr_key __read_mostly;
+
+static void enable_ptr_key_workfn(struct work_struct *work)
+{
+	get_random_bytes(&ptr_key, sizeof(ptr_key));
+	/* Needs to run from preemptible context */
+	static_branch_disable(&not_filled_random_ptr_key);
+}
+
+static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
+
+static void fill_random_ptr_key(struct random_ready_callback *unused)
+{
+	/* This may be in an interrupt handler. */
+	queue_work(system_unbound_wq, &enable_ptr_key_work);
+}
+
+static struct random_ready_callback random_ready = {
+	.func = fill_random_ptr_key
+};
+
+static int __init initialize_ptr_random(void)
+{
+	int key_size = sizeof(ptr_key);
+	int ret;
+
+	/* Use hw RNG if available. */
+	if (get_random_bytes_arch(&ptr_key, key_size) == key_size) {
+		static_branch_disable(&not_filled_random_ptr_key);
+		return 0;
+	}
+
+	ret = add_random_ready_callback(&random_ready);
+	if (!ret) {
+		return 0;
+	} else if (ret == -EALREADY) {
+		/* This is in preemptible context */
+		enable_ptr_key_workfn(&enable_ptr_key_work);
+		return 0;
+	}
+
+	return ret;
+}
+early_initcall(initialize_ptr_random);
+
+/* Maps a pointer to a 32 bit unique identifier. */
+static char *ptr_to_id(char *buf, char *end, const void *ptr,
+		       struct printf_spec spec)
+{
+	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
+	unsigned long hashval;
+
+	/* When debugging early boot use non-cryptographically secure hash. */
+	if (unlikely(debug_boot_weak_hash)) {
+		hashval = hash_long((unsigned long)ptr, 32);
+		return pointer_string(buf, end, (const void *)hashval, spec);
+	}
+
+	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
+		spec.field_width = 2 * sizeof(ptr);
+		/* string length must be less than default_width */
+		return string(buf, end, str, spec);
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
+	return pointer_string(buf, end, (const void *)hashval, spec);
+}
+
 static noinline_for_stack
 char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_spec spec,
 		  const char *fmt)
@@ -1357,20 +1460,6 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 	return string(buf, end, uuid, spec);
 }
 
-static noinline_for_stack
-char *pointer_string(char *buf, char *end, const void *ptr,
-		     struct printf_spec spec)
-{
-	spec.base = 16;
-	spec.flags |= SMALL;
-	if (spec.field_width == -1) {
-		spec.field_width = 2 * sizeof(ptr);
-		spec.flags |= ZEROPAD;
-	}
-
-	return number(buf, end, (unsigned long int)ptr, spec);
-}
-
 int kptr_restrict __read_mostly;
 
 static noinline_for_stack
@@ -1656,94 +1745,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
-/* Make pointers available for printing early in the boot sequence. */
-static int debug_boot_weak_hash __ro_after_init;
-
-static int __init debug_boot_weak_hash_enable(char *str)
-{
-	debug_boot_weak_hash = 1;
-	pr_info("debug_boot_weak_hash enabled\n");
-	return 0;
-}
-early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
-
-static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
-static siphash_key_t ptr_key __read_mostly;
-
-static void enable_ptr_key_workfn(struct work_struct *work)
-{
-	get_random_bytes(&ptr_key, sizeof(ptr_key));
-	/* Needs to run from preemptible context */
-	static_branch_disable(&not_filled_random_ptr_key);
-}
-
-static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
-
-static void fill_random_ptr_key(struct random_ready_callback *unused)
-{
-	/* This may be in an interrupt handler. */
-	queue_work(system_unbound_wq, &enable_ptr_key_work);
-}
-
-static struct random_ready_callback random_ready = {
-	.func = fill_random_ptr_key
-};
-
-static int __init initialize_ptr_random(void)
-{
-	int key_size = sizeof(ptr_key);
-	int ret;
-
-	/* Use hw RNG if available. */
-	if (get_random_bytes_arch(&ptr_key, key_size) == key_size) {
-		static_branch_disable(&not_filled_random_ptr_key);
-		return 0;
-	}
-
-	ret = add_random_ready_callback(&random_ready);
-	if (!ret) {
-		return 0;
-	} else if (ret == -EALREADY) {
-		/* This is in preemptible context */
-		enable_ptr_key_workfn(&enable_ptr_key_work);
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
-	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
-	unsigned long hashval;
-
-	/* When debugging early boot use non-cryptographically secure hash. */
-	if (unlikely(debug_boot_weak_hash)) {
-		hashval = hash_long((unsigned long)ptr, 32);
-		return pointer_string(buf, end, (const void *)hashval, spec);
-	}
-
-	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
-		spec.field_width = 2 * sizeof(ptr);
-		/* string length must be less than default_width */
-		return string(buf, end, str, spec);
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
-	return pointer_string(buf, end, (const void *)hashval, spec);
-}
-
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
-- 
2.17.1

