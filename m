Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0316ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCEC208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCEC208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeGMNzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:55:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbeGMNzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:55:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6DDdwDR115888
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Jul 2018 06:39:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6DDdwDv115885;
        Fri, 13 Jul 2018 06:39:58 -0700
Date:   Fri, 13 Jul 2018 06:39:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-afed7bcf9487bb28e2e2b016a195085c07416c0b@git.kernel.org>
Cc:     keescook@chromium.org, will.deacon@arm.com, boqun.feng@gmail.com,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        mark.rutland@arm.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, dsterba@suse.com
Reply-To: dsterba@suse.com, tglx@linutronix.de, peterz@infradead.org,
          mark.rutland@arm.com, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, will.deacon@arm.com, hpa@zytor.com,
          mingo@kernel.org, boqun.feng@gmail.com, keescook@chromium.org
In-Reply-To: <20180711093607.1644-1-mark.rutland@arm.com>
References: <20180711093607.1644-1-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/refcount: Always allow checked forms
Git-Commit-ID: afed7bcf9487bb28e2e2b016a195085c07416c0b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  afed7bcf9487bb28e2e2b016a195085c07416c0b
Gitweb:     https://git.kernel.org/tip/afed7bcf9487bb28e2e2b016a195085c07416c0b
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 11 Jul 2018 10:36:07 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 13 Jul 2018 15:23:25 +0200

locking/refcount: Always allow checked forms

In many cases, it would be useful to be able to use the full
sanity-checked refcount helpers regardless of CONFIG_REFCOUNT_FULL,
as this would help to avoid duplicate warnings where callers try to
sanity-check refcount manipulation.

This patch refactors things such that the full refcount helpers were
always built, as refcount_${op}_checked(), such that they can be used
regardless of CONFIG_REFCOUNT_FULL. This will allow code which *always*
wants a checked refcount to opt-in, avoiding the need to duplicate the
logic for warnings.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180711093607.1644-1-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/refcount.h | 27 +++++++++++++++++-------
 lib/refcount.c           | 53 +++++++++++++++++++++++-------------------------
 2 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index c36addd27dd5..53c5eca24d83 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -43,17 +43,30 @@ static inline unsigned int refcount_read(const refcount_t *r)
 	return atomic_read(&r->refs);
 }
 
+extern __must_check bool refcount_add_not_zero_checked(unsigned int i, refcount_t *r);
+extern void refcount_add_checked(unsigned int i, refcount_t *r);
+
+extern __must_check bool refcount_inc_not_zero_checked(refcount_t *r);
+extern void refcount_inc_checked(refcount_t *r);
+
+extern __must_check bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r);
+
+extern __must_check bool refcount_dec_and_test_checked(refcount_t *r);
+extern void refcount_dec_checked(refcount_t *r);
+
 #ifdef CONFIG_REFCOUNT_FULL
-extern __must_check bool refcount_add_not_zero(unsigned int i, refcount_t *r);
-extern void refcount_add(unsigned int i, refcount_t *r);
 
-extern __must_check bool refcount_inc_not_zero(refcount_t *r);
-extern void refcount_inc(refcount_t *r);
+#define refcount_add_not_zero	refcount_add_not_zero_checked
+#define refcount_add		refcount_add_checked
+
+#define refcount_inc_not_zero	refcount_inc_not_zero_checked
+#define refcount_inc		refcount_inc_checked
+
+#define refcount_sub_and_test	refcount_sub_and_test_checked
 
-extern __must_check bool refcount_sub_and_test(unsigned int i, refcount_t *r);
+#define refcount_dec_and_test	refcount_dec_and_test_checked
+#define refcount_dec		refcount_dec_checked
 
-extern __must_check bool refcount_dec_and_test(refcount_t *r);
-extern void refcount_dec(refcount_t *r);
 #else
 # ifdef CONFIG_ARCH_HAS_REFCOUNT
 #  include <asm/refcount.h>
diff --git a/lib/refcount.c b/lib/refcount.c
index 4bd842f20749..5c4aaefc0682 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -40,10 +40,8 @@
 #include <linux/spinlock.h>
 #include <linux/bug.h>
 
-#ifdef CONFIG_REFCOUNT_FULL
-
 /**
- * refcount_add_not_zero - add a value to a refcount unless it is 0
+ * refcount_add_not_zero_checked - add a value to a refcount unless it is 0
  * @i: the value to add to the refcount
  * @r: the refcount
  *
@@ -60,7 +58,7 @@
  *
  * Return: false if the passed refcount is 0, true otherwise
  */
-bool refcount_add_not_zero(unsigned int i, refcount_t *r)
+bool refcount_add_not_zero_checked(unsigned int i, refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -81,10 +79,10 @@ bool refcount_add_not_zero(unsigned int i, refcount_t *r)
 
 	return true;
 }
-EXPORT_SYMBOL(refcount_add_not_zero);
+EXPORT_SYMBOL(refcount_add_not_zero_checked);
 
 /**
- * refcount_add - add a value to a refcount
+ * refcount_add_checked - add a value to a refcount
  * @i: the value to add to the refcount
  * @r: the refcount
  *
@@ -99,14 +97,14 @@ EXPORT_SYMBOL(refcount_add_not_zero);
  * cases, refcount_inc(), or one of its variants, should instead be used to
  * increment a reference count.
  */
-void refcount_add(unsigned int i, refcount_t *r)
+void refcount_add_checked(unsigned int i, refcount_t *r)
 {
-	WARN_ONCE(!refcount_add_not_zero(i, r), "refcount_t: addition on 0; use-after-free.\n");
+	WARN_ONCE(!refcount_add_not_zero_checked(i, r), "refcount_t: addition on 0; use-after-free.\n");
 }
-EXPORT_SYMBOL(refcount_add);
+EXPORT_SYMBOL(refcount_add_checked);
 
 /**
- * refcount_inc_not_zero - increment a refcount unless it is 0
+ * refcount_inc_not_zero_checked - increment a refcount unless it is 0
  * @r: the refcount to increment
  *
  * Similar to atomic_inc_not_zero(), but will saturate at UINT_MAX and WARN.
@@ -117,7 +115,7 @@ EXPORT_SYMBOL(refcount_add);
  *
  * Return: true if the increment was successful, false otherwise
  */
-bool refcount_inc_not_zero(refcount_t *r)
+bool refcount_inc_not_zero_checked(refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -136,10 +134,10 @@ bool refcount_inc_not_zero(refcount_t *r)
 
 	return true;
 }
-EXPORT_SYMBOL(refcount_inc_not_zero);
+EXPORT_SYMBOL(refcount_inc_not_zero_checked);
 
 /**
- * refcount_inc - increment a refcount
+ * refcount_inc_checked - increment a refcount
  * @r: the refcount to increment
  *
  * Similar to atomic_inc(), but will saturate at UINT_MAX and WARN.
@@ -150,14 +148,14 @@ EXPORT_SYMBOL(refcount_inc_not_zero);
  * Will WARN if the refcount is 0, as this represents a possible use-after-free
  * condition.
  */
-void refcount_inc(refcount_t *r)
+void refcount_inc_checked(refcount_t *r)
 {
-	WARN_ONCE(!refcount_inc_not_zero(r), "refcount_t: increment on 0; use-after-free.\n");
+	WARN_ONCE(!refcount_inc_not_zero_checked(r), "refcount_t: increment on 0; use-after-free.\n");
 }
-EXPORT_SYMBOL(refcount_inc);
+EXPORT_SYMBOL(refcount_inc_checked);
 
 /**
- * refcount_sub_and_test - subtract from a refcount and test if it is 0
+ * refcount_sub_and_test_checked - subtract from a refcount and test if it is 0
  * @i: amount to subtract from the refcount
  * @r: the refcount
  *
@@ -176,7 +174,7 @@ EXPORT_SYMBOL(refcount_inc);
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
-bool refcount_sub_and_test(unsigned int i, refcount_t *r)
+bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -194,10 +192,10 @@ bool refcount_sub_and_test(unsigned int i, refcount_t *r)
 
 	return !new;
 }
-EXPORT_SYMBOL(refcount_sub_and_test);
+EXPORT_SYMBOL(refcount_sub_and_test_checked);
 
 /**
- * refcount_dec_and_test - decrement a refcount and test if it is 0
+ * refcount_dec_and_test_checked - decrement a refcount and test if it is 0
  * @r: the refcount
  *
  * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
@@ -209,14 +207,14 @@ EXPORT_SYMBOL(refcount_sub_and_test);
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
-bool refcount_dec_and_test(refcount_t *r)
+bool refcount_dec_and_test_checked(refcount_t *r)
 {
-	return refcount_sub_and_test(1, r);
+	return refcount_sub_and_test_checked(1, r);
 }
-EXPORT_SYMBOL(refcount_dec_and_test);
+EXPORT_SYMBOL(refcount_dec_and_test_checked);
 
 /**
- * refcount_dec - decrement a refcount
+ * refcount_dec_checked - decrement a refcount
  * @r: the refcount
  *
  * Similar to atomic_dec(), it will WARN on underflow and fail to decrement
@@ -225,12 +223,11 @@ EXPORT_SYMBOL(refcount_dec_and_test);
  * Provides release memory ordering, such that prior loads and stores are done
  * before.
  */
-void refcount_dec(refcount_t *r)
+void refcount_dec_checked(refcount_t *r)
 {
-	WARN_ONCE(refcount_dec_and_test(r), "refcount_t: decrement hit 0; leaking memory.\n");
+	WARN_ONCE(refcount_dec_and_test_checked(r), "refcount_t: decrement hit 0; leaking memory.\n");
 }
-EXPORT_SYMBOL(refcount_dec);
-#endif /* CONFIG_REFCOUNT_FULL */
+EXPORT_SYMBOL(refcount_dec_checked);
 
 /**
  * refcount_dec_if_one - decrement a refcount if it is 1
