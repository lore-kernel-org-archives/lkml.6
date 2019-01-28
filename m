Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC61BC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D1521738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfA1M14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:27:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:21827 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfA1M1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:27:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 04:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="139402570"
Received: from elena-thinkpad-x230.fi.intel.com ([10.237.68.34])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2019 04:27:42 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, keescook@chromium.org, tglx@linutronix.de,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 1/3] perf: convert perf_event_context.refcount to refcount_t
Date:   Mon, 28 Jan 2019 14:27:26 +0200
Message-Id: <1548678448-24458-2-git-send-email-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548678448-24458-1-git-send-email-elena.reshetova@intel.com>
References: <1548678448-24458-1-git-send-email-elena.reshetova@intel.com>
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

The variable perf_event_context.refcount is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

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

For the perf_event_context.refcount it might make a difference
in following places:
 - get_ctx(), perf_event_ctx_lock_nested(), perf_lock_task_context()
   and __perf_event_ctx_lock_double(): increment in
   refcount_inc_not_zero() only guarantees control dependency
   on success vs. fully ordered atomic counterpart
 - put_ctx(): decrement in refcount_dec_and_test() provides
   RELEASE ordering and ACQUIRE ordering + control dependency on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 include/linux/perf_event.h |  3 ++-
 kernel/events/core.c       | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1d5c551..6a94097 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -55,6 +55,7 @@ struct perf_guest_info_callbacks {
 #include <linux/perf_regs.h>
 #include <linux/workqueue.h>
 #include <linux/cgroup.h>
+#include <linux/refcount.h>
 #include <asm/local.h>
 
 struct perf_callchain_entry {
@@ -737,7 +738,7 @@ struct perf_event_context {
 	int				nr_stat;
 	int				nr_freq;
 	int				rotate_disable;
-	atomic_t			refcount;
+	refcount_t			refcount;
 	struct task_struct		*task;
 
 	/*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a3..a1e87d2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1171,7 +1171,7 @@ static void perf_event_ctx_deactivate(struct perf_event_context *ctx)
 
 static void get_ctx(struct perf_event_context *ctx)
 {
-	WARN_ON(!atomic_inc_not_zero(&ctx->refcount));
+	WARN_ON(!refcount_inc_not_zero(&ctx->refcount));
 }
 
 static void free_ctx(struct rcu_head *head)
@@ -1185,7 +1185,7 @@ static void free_ctx(struct rcu_head *head)
 
 static void put_ctx(struct perf_event_context *ctx)
 {
-	if (atomic_dec_and_test(&ctx->refcount)) {
+	if (refcount_dec_and_test(&ctx->refcount)) {
 		if (ctx->parent_ctx)
 			put_ctx(ctx->parent_ctx);
 		if (ctx->task && ctx->task != TASK_TOMBSTONE)
@@ -1267,7 +1267,7 @@ perf_event_ctx_lock_nested(struct perf_event *event, int nesting)
 again:
 	rcu_read_lock();
 	ctx = READ_ONCE(event->ctx);
-	if (!atomic_inc_not_zero(&ctx->refcount)) {
+	if (!refcount_inc_not_zero(&ctx->refcount)) {
 		rcu_read_unlock();
 		goto again;
 	}
@@ -1400,7 +1400,7 @@ perf_lock_task_context(struct task_struct *task, int ctxn, unsigned long *flags)
 		}
 
 		if (ctx->task == TASK_TOMBSTONE ||
-		    !atomic_inc_not_zero(&ctx->refcount)) {
+		    !refcount_inc_not_zero(&ctx->refcount)) {
 			raw_spin_unlock(&ctx->lock);
 			ctx = NULL;
 		} else {
@@ -4056,7 +4056,7 @@ static void __perf_event_init_context(struct perf_event_context *ctx)
 	INIT_LIST_HEAD(&ctx->event_list);
 	INIT_LIST_HEAD(&ctx->pinned_active);
 	INIT_LIST_HEAD(&ctx->flexible_active);
-	atomic_set(&ctx->refcount, 1);
+	refcount_set(&ctx->refcount, 1);
 }
 
 static struct perf_event_context *
@@ -10391,7 +10391,7 @@ __perf_event_ctx_lock_double(struct perf_event *group_leader,
 again:
 	rcu_read_lock();
 	gctx = READ_ONCE(group_leader->ctx);
-	if (!atomic_inc_not_zero(&gctx->refcount)) {
+	if (!refcount_inc_not_zero(&gctx->refcount)) {
 		rcu_read_unlock();
 		goto again;
 	}
-- 
2.7.4

