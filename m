Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066A4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A89217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfBDIwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:52:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfBDIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:52:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148poBs357484
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:51:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148pokV357481;
        Mon, 4 Feb 2019 00:51:50 -0800
Date:   Mon, 4 Feb 2019 00:51:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Elena Reshetova <tipbot@zytor.com>
Message-ID: <tip-8c94abbbe1ba24961278055434504b7dc3595415@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, acme@redhat.com,
        hpa@zytor.com, jolsa@redhat.com, keescook@chromium.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        ishkamiel@gmail.com, elena.reshetova@intel.com, dwindsor@gmail.com
Reply-To: peterz@infradead.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          mingo@kernel.org, hpa@zytor.com, ishkamiel@gmail.com,
          elena.reshetova@intel.com, jolsa@redhat.com,
          keescook@chromium.org, dwindsor@gmail.com
In-Reply-To: <1548678448-24458-2-git-send-email-elena.reshetova@intel.com>
References: <1548678448-24458-2-git-send-email-elena.reshetova@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf: Convert perf_event_context.refcount to
 refcount_t
Git-Commit-ID: 8c94abbbe1ba24961278055434504b7dc3595415
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

Commit-ID:  8c94abbbe1ba24961278055434504b7dc3595415
Gitweb:     https://git.kernel.org/tip/8c94abbbe1ba24961278055434504b7dc3595415
Author:     Elena Reshetova <elena.reshetova@intel.com>
AuthorDate: Mon, 28 Jan 2019 14:27:26 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:46:15 +0100

perf: Convert perf_event_context.refcount to refcount_t

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

** Important note for maintainers:

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
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: namhyung@kernel.org
Link: https://lkml.kernel.org/r/1548678448-24458-2-git-send-email-elena.reshetova@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h |  3 ++-
 kernel/events/core.c       | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a79e59fc3b7d..6cb5d483ab34 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -54,6 +54,7 @@ struct perf_guest_info_callbacks {
 #include <linux/sysfs.h>
 #include <linux/perf_regs.h>
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
index 5b89de7918d0..677164d54547 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1172,7 +1172,7 @@ static void perf_event_ctx_deactivate(struct perf_event_context *ctx)
 
 static void get_ctx(struct perf_event_context *ctx)
 {
-	WARN_ON(!atomic_inc_not_zero(&ctx->refcount));
+	refcount_inc(&ctx->refcount);
 }
 
 static void free_ctx(struct rcu_head *head)
@@ -1186,7 +1186,7 @@ static void free_ctx(struct rcu_head *head)
 
 static void put_ctx(struct perf_event_context *ctx)
 {
-	if (atomic_dec_and_test(&ctx->refcount)) {
+	if (refcount_dec_and_test(&ctx->refcount)) {
 		if (ctx->parent_ctx)
 			put_ctx(ctx->parent_ctx);
 		if (ctx->task && ctx->task != TASK_TOMBSTONE)
@@ -1268,7 +1268,7 @@ perf_event_ctx_lock_nested(struct perf_event *event, int nesting)
 again:
 	rcu_read_lock();
 	ctx = READ_ONCE(event->ctx);
-	if (!atomic_inc_not_zero(&ctx->refcount)) {
+	if (!refcount_inc_not_zero(&ctx->refcount)) {
 		rcu_read_unlock();
 		goto again;
 	}
@@ -1401,7 +1401,7 @@ retry:
 		}
 
 		if (ctx->task == TASK_TOMBSTONE ||
-		    !atomic_inc_not_zero(&ctx->refcount)) {
+		    !refcount_inc_not_zero(&ctx->refcount)) {
 			raw_spin_unlock(&ctx->lock);
 			ctx = NULL;
 		} else {
@@ -4057,7 +4057,7 @@ static void __perf_event_init_context(struct perf_event_context *ctx)
 	INIT_LIST_HEAD(&ctx->event_list);
 	INIT_LIST_HEAD(&ctx->pinned_active);
 	INIT_LIST_HEAD(&ctx->flexible_active);
-	atomic_set(&ctx->refcount, 1);
+	refcount_set(&ctx->refcount, 1);
 }
 
 static struct perf_event_context *
@@ -10613,7 +10613,7 @@ __perf_event_ctx_lock_double(struct perf_event *group_leader,
 again:
 	rcu_read_lock();
 	gctx = READ_ONCE(group_leader->ctx);
-	if (!atomic_inc_not_zero(&gctx->refcount)) {
+	if (!refcount_inc_not_zero(&gctx->refcount)) {
 		rcu_read_unlock();
 		goto again;
 	}
