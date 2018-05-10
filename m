Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757119AbeEJNGr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:06:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55676 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756808AbeEJNGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:06:46 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH] perf/ring_buffer: ensure atomicity and order of updates
Date: Thu, 10 May 2018 14:06:32 +0100
Message-Id: <20180510130632.34497-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can read/write the user page at any point in time, and in
perf_output_put_handle() we're very careful to use memory barriers to
ensure ordering between updates to data and the user page.

We don't use barriers when updating aux_head, where similar ordering
constraints apply. This could result in userspace seeing stale data, or
data being overwritten while userspace was still consuming it.

Further, we update data_head and aux_head with plain assignments, which
the compiler can tear, potentially resulting in userspace seeing
erroneous values.

We can solve both of these problems by using smp_store_release to update
data_head and aux_head, so let's do so.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 kernel/events/ring_buffer.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 6c6b3c48db71..839b207e4c77 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -63,10 +63,10 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
 	 *   kernel				user
 	 *
 	 *   if (LOAD ->data_tail) {		LOAD ->data_head
-	 *			(A)		smp_rmb()	(C)
+	 *				(A) 	smp_rmb()	(C)
 	 *	STORE $data			LOAD $data
-	 *	smp_wmb()	(B)		smp_mb()	(D)
-	 *	STORE ->data_head		STORE ->data_tail
+	 *					smp_mb()	(D)
+	 *	RELEASE ->data_head	(B)	STORE ->data_tail
 	 *   }
 	 *
 	 * Where A pairs with D, and B pairs with C.
@@ -83,8 +83,7 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
 	 *
 	 * See perf_output_begin().
 	 */
-	smp_wmb(); /* B, matches C */
-	rb->user_page->data_head = head;
+	smp_store_release(&rb->user_page->data_head, head); /* B, matches C */
 
 	/*
 	 * Now check if we missed an update -- rely on previous implied
@@ -464,7 +463,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 		                     handle->aux_flags);
 	}
 
-	rb->user_page->aux_head = rb->aux_head;
+	smp_store_release(&rb->user_page->aux_head, rb->aux_head);
 	if (rb_need_aux_wakeup(rb))
 		wakeup = true;
 
@@ -496,7 +495,7 @@ int perf_aux_output_skip(struct perf_output_handle *handle, unsigned long size)
 
 	rb->aux_head += size;
 
-	rb->user_page->aux_head = rb->aux_head;
+	smp_store_release(&rb->user_page->aux_head, rb->aux_head);
 	if (rb_need_aux_wakeup(rb)) {
 		perf_output_wakeup(handle);
 		handle->wakeup = rb->aux_wakeup + rb->aux_watermark;
-- 
2.11.0
