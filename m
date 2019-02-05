Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664AEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EB420821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfBEMYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:24:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:56903 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfBEMYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:24:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 04:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; 
   d="scan'208";a="316457764"
Received: from elena-thinkpad-x230.fi.intel.com ([10.237.68.34])
  by fmsmga006.fm.intel.com with ESMTP; 05 Feb 2019 04:24:34 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH] futex: convert futex_pi_state.refcount to refcount_t
Date:   Tue,  5 Feb 2019 14:24:27 +0200
Message-Id: <1549369467-3505-1-git-send-email-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 kernel/futex.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 873204a..2442136 100644
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
-- 
2.7.4

