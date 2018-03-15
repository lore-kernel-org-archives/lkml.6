Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeCOMhH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:37:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49182 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeCOMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:43 -0400
Message-Id: <20180315123202.419618431@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 02/11] sched/wait,drm: Replace wait_on_atomic_t usage
References: <20180315121902.942902000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-wait_var-2.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the wait_on_atomic_t() usage to the new wait_var_event() API.

Unlike the wake_up_atomic_t(), wake_up_var() will issue the wakeup
even if the variable is not 0.

Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/gpu/drm/drm_dp_aux_dev.c                   |   13 +++++++------
 drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c |   14 ++++----------
 2 files changed, 11 insertions(+), 16 deletions(-)

--- a/drivers/gpu/drm/drm_dp_aux_dev.c
+++ b/drivers/gpu/drm/drm_dp_aux_dev.c
@@ -177,8 +177,9 @@ static ssize_t auxdev_read_iter(struct k
 		res = pos - iocb->ki_pos;
 	iocb->ki_pos = pos;
 
-	atomic_dec(&aux_dev->usecount);
-	wake_up_atomic_t(&aux_dev->usecount);
+	if (atomic_dec_and_test(&aux_dev->usecount))
+		wake_up_var(&aux_dev->usecount);
+
 	return res;
 }
 
@@ -218,8 +219,9 @@ static ssize_t auxdev_write_iter(struct
 		res = pos - iocb->ki_pos;
 	iocb->ki_pos = pos;
 
-	atomic_dec(&aux_dev->usecount);
-	wake_up_atomic_t(&aux_dev->usecount);
+	if (atomic_dec_and_test(&aux_dev->usecount))
+		wake_up_var(&aux_dev->usecount);
+
 	return res;
 }
 
@@ -277,8 +279,7 @@ void drm_dp_aux_unregister_devnode(struc
 	mutex_unlock(&aux_idr_mutex);
 
 	atomic_dec(&aux_dev->usecount);
-	wait_on_atomic_t(&aux_dev->usecount, atomic_t_wait,
-			 TASK_UNINTERRUPTIBLE);
+	wait_var_event(&aux_dev->usecount, !atomic_read(&aux_dev->usecount));
 
 	minor = aux_dev->index;
 	if (aux_dev->dev)
--- a/drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c
@@ -271,18 +271,13 @@ struct igt_wakeup {
 	u32 seqno;
 };
 
-static int wait_atomic_timeout(atomic_t *p, unsigned int mode)
-{
-	return schedule_timeout(10 * HZ) ? 0 : -ETIMEDOUT;
-}
-
 static bool wait_for_ready(struct igt_wakeup *w)
 {
 	DEFINE_WAIT(ready);
 
 	set_bit(IDLE, &w->flags);
 	if (atomic_dec_and_test(w->done))
-		wake_up_atomic_t(w->done);
+		wake_up_var(w->done);
 
 	if (test_bit(STOP, &w->flags))
 		goto out;
@@ -299,7 +294,7 @@ static bool wait_for_ready(struct igt_wa
 out:
 	clear_bit(IDLE, &w->flags);
 	if (atomic_dec_and_test(w->set))
-		wake_up_atomic_t(w->set);
+		wake_up_var(w->set);
 
 	return !test_bit(STOP, &w->flags);
 }
@@ -342,7 +337,7 @@ static void igt_wake_all_sync(atomic_t *
 	atomic_set(ready, 0);
 	wake_up_all(wq);
 
-	wait_on_atomic_t(set, atomic_t_wait, TASK_UNINTERRUPTIBLE);
+	wait_var_event(set, !atomic_read(set));
 	atomic_set(ready, count);
 	atomic_set(done, count);
 }
@@ -350,7 +345,6 @@ static void igt_wake_all_sync(atomic_t *
 static int igt_wakeup(void *arg)
 {
 	I915_RND_STATE(prng);
-	const int state = TASK_UNINTERRUPTIBLE;
 	struct intel_engine_cs *engine = arg;
 	struct igt_wakeup *waiters;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
@@ -418,7 +412,7 @@ static int igt_wakeup(void *arg)
 		 * that they are ready for the next test. We wait until all
 		 * threads are complete and waiting for us (i.e. not a seqno).
 		 */
-		err = wait_on_atomic_t(&done, wait_atomic_timeout, state);
+		err = wait_var_event_timeout(&done, !atomic_read(&done), 10 * HZ);
 		if (err) {
 			pr_err("Timed out waiting for %d remaining waiters\n",
 			       atomic_read(&done));
