Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE753C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93063214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfBDI7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:59:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46495 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDI7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:59:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148xUm2358476
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:59:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148xUmr358473;
        Mon, 4 Feb 2019 00:59:30 -0800
Date:   Mon, 4 Feb 2019 00:59:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Elena Reshetova <tipbot@zytor.com>
Message-ID: <tip-47b8f3ab9c49daa824af848f9e02889662d8638f@git.kernel.org>
Cc:     tglx@linutronix.de, will.deacon@arm.com, hpa@zytor.com,
        mingo@kernel.org, andrea.parri@amarulasolutions.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        elena.reshetova@intel.com, torvalds@linux-foundation.org
Reply-To: mingo@kernel.org, elena.reshetova@intel.com,
          torvalds@linux-foundation.org, akpm@linux-foundation.org,
          peterz@infradead.org, paulmck@linux.vnet.ibm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, will.deacon@arm.com,
          andrea.parri@amarulasolutions.com, tglx@linutronix.de
In-Reply-To: <1548847131-27854-2-git-send-email-elena.reshetova@intel.com>
References: <1548847131-27854-2-git-send-email-elena.reshetova@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] refcount_t: Add ACQUIRE ordering on success for
 dec(sub)_and_test() variants
Git-Commit-ID: 47b8f3ab9c49daa824af848f9e02889662d8638f
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

Commit-ID:  47b8f3ab9c49daa824af848f9e02889662d8638f
Gitweb:     https://git.kernel.org/tip/47b8f3ab9c49daa824af848f9e02889662d8638f
Author:     Elena Reshetova <elena.reshetova@intel.com>
AuthorDate: Wed, 30 Jan 2019 13:18:51 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 09:03:31 +0100

refcount_t: Add ACQUIRE ordering on success for dec(sub)_and_test() variants

This adds an smp_acquire__after_ctrl_dep() barrier on successful
decrease of refcounter value from 1 to 0 for refcount_dec(sub)_and_test
variants and therefore gives stronger memory ordering guarantees than
prior versions of these functions.

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: dvyukov@google.com
Cc: keescook@chromium.org
Cc: stern@rowland.harvard.edu
Link: https://lkml.kernel.org/r/1548847131-27854-2-git-send-email-elena.reshetova@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/core-api/refcount-vs-atomic.rst | 24 +++++++++++++++++++++---
 arch/x86/include/asm/refcount.h               | 22 ++++++++++++++++++----
 lib/refcount.c                                | 18 +++++++++++++-----
 3 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
index 322851bada16..976e85adffe8 100644
--- a/Documentation/core-api/refcount-vs-atomic.rst
+++ b/Documentation/core-api/refcount-vs-atomic.rst
@@ -54,6 +54,13 @@ must propagate to all other CPUs before the release operation
 (A-cumulative property). This is implemented using
 :c:func:`smp_store_release`.
 
+An ACQUIRE memory ordering guarantees that all post loads and
+stores (all po-later instructions) on the same CPU are
+completed after the acquire operation. It also guarantees that all
+po-later stores on the same CPU must propagate to all other CPUs
+after the acquire operation executes. This is implemented using
+:c:func:`smp_acquire__after_ctrl_dep`.
+
 A control dependency (on success) for refcounters guarantees that
 if a reference for an object was successfully obtained (reference
 counter increment or addition happened, function returned true),
@@ -119,13 +126,24 @@ Memory ordering guarantees changes:
    result of obtaining pointer to the object!
 
 
-case 5) - decrement-based RMW ops that return a value
------------------------------------------------------
+case 5) - generic dec/sub decrement-based RMW ops that return a value
+---------------------------------------------------------------------
 
 Function changes:
 
  * :c:func:`atomic_dec_and_test` --> :c:func:`refcount_dec_and_test`
  * :c:func:`atomic_sub_and_test` --> :c:func:`refcount_sub_and_test`
+
+Memory ordering guarantees changes:
+
+ * fully ordered --> RELEASE ordering + ACQUIRE ordering on success
+
+
+case 6) other decrement-based RMW ops that return a value
+---------------------------------------------------------
+
+Function changes:
+
  * no atomic counterpart --> :c:func:`refcount_dec_if_one`
  * ``atomic_add_unless(&var, -1, 1)`` --> ``refcount_dec_not_one(&var)``
 
@@ -136,7 +154,7 @@ Memory ordering guarantees changes:
 .. note:: :c:func:`atomic_add_unless` only provides full order on success.
 
 
-case 6) - lock-based RMW
+case 7) - lock-based RMW
 ------------------------
 
 Function changes:
diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index dbaed55c1c24..232f856e0db0 100644
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -67,16 +67,30 @@ static __always_inline void refcount_dec(refcount_t *r)
 static __always_inline __must_check
 bool refcount_sub_and_test(unsigned int i, refcount_t *r)
 {
-	return GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
+	bool ret = GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
 					 REFCOUNT_CHECK_LT_ZERO,
 					 r->refs.counter, e, "er", i, "cx");
+
+	if (ret) {
+		smp_acquire__after_ctrl_dep();
+		return true;
+	}
+
+	return false;
 }
 
 static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
-	return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
-					REFCOUNT_CHECK_LT_ZERO,
-					r->refs.counter, e, "cx");
+	bool ret = GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
+					 REFCOUNT_CHECK_LT_ZERO,
+					 r->refs.counter, e, "cx");
+
+	if (ret) {
+		smp_acquire__after_ctrl_dep();
+		return true;
+	}
+
+	return false;
 }
 
 static __always_inline __must_check
diff --git a/lib/refcount.c b/lib/refcount.c
index ebcf8cd49e05..6e904af0fb3e 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -33,6 +33,9 @@
  * Note that the allocator is responsible for ordering things between free()
  * and alloc().
  *
+ * The decrements dec_and_test() and sub_and_test() also provide acquire
+ * ordering on success.
+ *
  */
 
 #include <linux/mutex.h>
@@ -164,8 +167,8 @@ EXPORT_SYMBOL(refcount_inc_checked);
  * at UINT_MAX.
  *
  * Provides release memory ordering, such that prior loads and stores are done
- * before, and provides a control dependency such that free() must come after.
- * See the comment on top.
+ * before, and provides an acquire ordering on success such that free()
+ * must come after.
  *
  * Use of this function is not recommended for the normal reference counting
  * use case in which references are taken and released one at a time.  In these
@@ -190,7 +193,12 @@ bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
 
 	} while (!atomic_try_cmpxchg_release(&r->refs, &val, new));
 
-	return !new;
+	if (!new) {
+		smp_acquire__after_ctrl_dep();
+		return true;
+	}
+	return false;
+
 }
 EXPORT_SYMBOL(refcount_sub_and_test_checked);
 
@@ -202,8 +210,8 @@ EXPORT_SYMBOL(refcount_sub_and_test_checked);
  * decrement when saturated at UINT_MAX.
  *
  * Provides release memory ordering, such that prior loads and stores are done
- * before, and provides a control dependency such that free() must come after.
- * See the comment on top.
+ * before, and provides an acquire ordering on success such that free()
+ * must come after.
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
