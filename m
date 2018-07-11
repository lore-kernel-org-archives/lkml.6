Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FC9C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEABF2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEABF2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbeGKJjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:39:39 -0400
Received: from foss.arm.com ([217.140.101.70]:60070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeGKJjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:39:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 348FFED1;
        Wed, 11 Jul 2018 02:36:14 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B08CD3F318;
        Wed, 11 Jul 2018 02:36:12 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, dsterba@suse.com,
        keescook@chromium.org
Cc:     boqun.feng@gmail.com, mark.rutland@arm.com, mingo@kernel.org,
        peterz@infradead.org, will.deacon@arm.com
Subject: [PATCHv2] refcount: always allow checked forms
Date:   Wed, 11 Jul 2018 10:36:07 +0100
Message-Id: <20180711093607.1644-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many cases, it would be useful to be able to use the full
sanity-checked refcount helpers regardless of CONFIG_REFCOUNT_FULL, as
this would help to avoid duplicate warnings where callers try to
sanity-check refcount manipulation.

This patch refactors things such that the full refcount helpers were
always built, as refcount_${op}_checked(), such that they can be used
regardless of CONFIG_REFCOUNT_FULL. This will allow code which *always*
wants a checked refcount to opt-in, avoiding the need to duplicate the
logic for warnings.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Sterba <dsterba@suse.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 include/linux/refcount.h | 27 +++++++++++++++++-------
 lib/refcount.c           | 53 +++++++++++++++++++++++-------------------------
 2 files changed, 45 insertions(+), 35 deletions(-)

Since v1 [1]:
* Fix refcount_inc_checked() name
* Accumulate acks

Kees, per your reply [2], I'm assuming that either you or David will end up
picking this up as part of a series usingthe checked forms.

Mark.

[1] https://lkml.kernel.org/r/20180703100102.16615-1-mark.rutland@arm.com
[2] https://lkml.kernel.org/r/CAGXu5jLATGcq_mgetUurBriCaPmBQmBwxVW7aa9fAKM2XeSjHw@mail.gmail.com

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index a685da2c4522..b505f75ccf68 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -42,17 +42,30 @@ static inline unsigned int refcount_read(const refcount_t *r)
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
index d3b81cefce91..c042e0c90462 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -38,10 +38,8 @@
 #include <linux/refcount.h>
 #include <linux/bug.h>
 
-#ifdef CONFIG_REFCOUNT_FULL
-
 /**
- * refcount_add_not_zero - add a value to a refcount unless it is 0
+ * refcount_add_not_zero_checked - add a value to a refcount unless it is 0
  * @i: the value to add to the refcount
  * @r: the refcount
  *
@@ -58,7 +56,7 @@
  *
  * Return: false if the passed refcount is 0, true otherwise
  */
-bool refcount_add_not_zero(unsigned int i, refcount_t *r)
+bool refcount_add_not_zero_checked(unsigned int i, refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -79,10 +77,10 @@ bool refcount_add_not_zero(unsigned int i, refcount_t *r)
 
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
@@ -97,14 +95,14 @@ EXPORT_SYMBOL(refcount_add_not_zero);
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
@@ -115,7 +113,7 @@ EXPORT_SYMBOL(refcount_add);
  *
  * Return: true if the increment was successful, false otherwise
  */
-bool refcount_inc_not_zero(refcount_t *r)
+bool refcount_inc_not_zero_checked(refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -134,10 +132,10 @@ bool refcount_inc_not_zero(refcount_t *r)
 
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
@@ -148,14 +146,14 @@ EXPORT_SYMBOL(refcount_inc_not_zero);
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
@@ -174,7 +172,7 @@ EXPORT_SYMBOL(refcount_inc);
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
-bool refcount_sub_and_test(unsigned int i, refcount_t *r)
+bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -192,10 +190,10 @@ bool refcount_sub_and_test(unsigned int i, refcount_t *r)
 
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
@@ -207,14 +205,14 @@ EXPORT_SYMBOL(refcount_sub_and_test);
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
@@ -223,12 +221,11 @@ EXPORT_SYMBOL(refcount_dec_and_test);
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
-- 
2.11.0

