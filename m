Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0C3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0361920873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfBKKzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:55:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45509 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:55:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAsxg83499604
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:54:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAswIk3499601;
        Mon, 11 Feb 2019 02:54:58 -0800
Date:   Mon, 11 Feb 2019 02:54:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Elena Reshetova <tipbot@zytor.com>
Message-ID: <tip-49262de2270e09882d7bd8866a691cdd69ab32f6@git.kernel.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, elena.reshetova@intel.com,
        dwindsor@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, ishkamiel@gmail.com
Reply-To: mingo@kernel.org, paulmck@linux.vnet.ibm.com,
          elena.reshetova@intel.com, akpm@linux-foundation.org,
          dwindsor@gmail.com, ishkamiel@gmail.com, peterz@infradead.org,
          keescook@chromium.org, torvalds@linux-foundation.org,
          will.deacon@arm.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1549369467-3505-1-git-send-email-elena.reshetova@intel.com>
References: <1549369467-3505-1-git-send-email-elena.reshetova@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] futex: Convert futex_pi_state.refcount to
 refcount_t
Git-Commit-ID: 49262de2270e09882d7bd8866a691cdd69ab32f6
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

Commit-ID:  49262de2270e09882d7bd8866a691cdd69ab32f6
Gitweb:     https://git.kernel.org/tip/49262de2270e09882d7bd8866a691cdd69ab32f6
Author:     Elena Reshetova <elena.reshetova@intel.com>
AuthorDate: Tue, 5 Feb 2019 14:24:27 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 11:37:16 +0100

futex: Convert futex_pi_state.refcount to refcount_t

atomic_t variables are currently used to implement reference
counters with the following properties:

 - counter is initialized to 1 using atomic_set()
 - a resource is freed upon counter reaching zero
 - once counter reaches zero, its further
   increments aren't allowed
 - counter schema uses basic atomic operations
   (set, inc, inc_not_zero, dec_and_test, etc.)

Such atomic variables should be converted to a newly provided
refcount_t type and API that prevents accidental counter overflows
and underflows. This is important since overflows and underflows
can lead to use-after-free situation and be exploitable.

The variable futex_pi_state.refcount is used as pure
reference counter. Convert it to refcount_t and fix up
the operations.

**Important note for maintainers:

Some functions from refcount_t API defined in lib/refcount.c
have different memory ordering guarantees than their atomic
counterparts. Please check Documentation/core-api/refcount-vs-atomic.rst
for more information.

Normally the differences should not matter since refcount_t provides
enough guarantees to satisfy the refcounting use cases, but in
some rare cases it might matter.
Please double check that you don't have some undocumented
memory guarantees for this variable usage.

For the futex_pi_state.refcount it might make a difference
in following places:

 - get_pi_state() and exit_pi_state_list(): increment in
   refcount_inc_not_zero() only guarantees control dependency
   on success vs. fully ordered atomic counterpart
 - put_pi_state(): decrement in refcount_dec_and_test() provides
   RELEASE ordering and ACQUIRE ordering on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: dvhart@infradead.org
Link: http://lkml.kernel.org/r/1549369467-3505-1-git-send-email-elena.reshetova@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/futex.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 2abe1a0b3062..113f1c042250 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -68,6 +68,7 @@
 #include <linux/freezer.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
+#include <linux/refcount.h>
 
 #include <asm/futex.h>
 
@@ -212,7 +213,7 @@ struct futex_pi_state {
 	struct rt_mutex pi_mutex;
 
 	struct task_struct *owner;
-	atomic_t refcount;
+	refcount_t refcount;
 
 	union futex_key key;
 } __randomize_layout;
@@ -799,7 +800,7 @@ static int refill_pi_state_cache(void)
 	INIT_LIST_HEAD(&pi_state->list);
 	/* pi_mutex gets initialized later */
 	pi_state->owner = NULL;
-	atomic_set(&pi_state->refcount, 1);
+	refcount_set(&pi_state->refcount, 1);
 	pi_state->key = FUTEX_KEY_INIT;
 
 	current->pi_state_cache = pi_state;
@@ -819,7 +820,7 @@ static struct futex_pi_state *alloc_pi_state(void)
 
 static void get_pi_state(struct futex_pi_state *pi_state)
 {
-	WARN_ON_ONCE(!atomic_inc_not_zero(&pi_state->refcount));
+	WARN_ON_ONCE(!refcount_inc_not_zero(&pi_state->refcount));
 }
 
 /*
@@ -831,7 +832,7 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 	if (!pi_state)
 		return;
 
-	if (!atomic_dec_and_test(&pi_state->refcount))
+	if (!refcount_dec_and_test(&pi_state->refcount))
 		return;
 
 	/*
@@ -861,7 +862,7 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 		 * refcount is at 0 - put it back to 1.
 		 */
 		pi_state->owner = NULL;
-		atomic_set(&pi_state->refcount, 1);
+		refcount_set(&pi_state->refcount, 1);
 		current->pi_state_cache = pi_state;
 	}
 }
@@ -904,7 +905,7 @@ void exit_pi_state_list(struct task_struct *curr)
 		 * In that case; drop the locks to let put_pi_state() make
 		 * progress and retry the loop.
 		 */
-		if (!atomic_inc_not_zero(&pi_state->refcount)) {
+		if (!refcount_inc_not_zero(&pi_state->refcount)) {
 			raw_spin_unlock_irq(&curr->pi_lock);
 			cpu_relax();
 			raw_spin_lock_irq(&curr->pi_lock);
@@ -1060,7 +1061,7 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
 	 * and futex_wait_requeue_pi() as it cannot go to 0 and consequently
 	 * free pi_state before we can take a reference ourselves.
 	 */
-	WARN_ON(!atomic_read(&pi_state->refcount));
+	WARN_ON(!refcount_read(&pi_state->refcount));
 
 	/*
 	 * Now that we have a pi_state, we can acquire wait_lock
