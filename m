Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49409C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F82520820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfBDIwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:52:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59961 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfBDIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:52:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148qTrV357533
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:52:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148qT0a357530;
        Mon, 4 Feb 2019 00:52:29 -0800
Date:   Mon, 4 Feb 2019 00:52:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Elena Reshetova <tipbot@zytor.com>
Message-ID: <tip-fecb8ed2ce7010db373f8517ee815380d8e3c0c4@git.kernel.org>
Cc:     elena.reshetova@intel.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        keescook@chromium.org, jolsa@redhat.com, peterz@infradead.org,
        acme@redhat.com, ishkamiel@gmail.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, dwindsor@gmail.com
Reply-To: keescook@chromium.org, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, mingo@kernel.org,
          tglx@linutronix.de, elena.reshetova@intel.com,
          dwindsor@gmail.com, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, ishkamiel@gmail.com, peterz@infradead.org,
          acme@redhat.com, jolsa@redhat.com
In-Reply-To: <1548678448-24458-3-git-send-email-elena.reshetova@intel.com>
References: <1548678448-24458-3-git-send-email-elena.reshetova@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/ring_buffer: Convert ring_buffer.refcount to
 refcount_t
Git-Commit-ID: fecb8ed2ce7010db373f8517ee815380d8e3c0c4
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

Commit-ID:  fecb8ed2ce7010db373f8517ee815380d8e3c0c4
Gitweb:     https://git.kernel.org/tip/fecb8ed2ce7010db373f8517ee815380d8e3c0c4
Author:     Elena Reshetova <elena.reshetova@intel.com>
AuthorDate: Mon, 28 Jan 2019 14:27:27 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:46:16 +0100

perf/ring_buffer: Convert ring_buffer.refcount to refcount_t

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

The variable ring_buffer.refcount is used as pure reference counter.
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

For the ring_buffer.refcount it might make a difference
in following places:

 - ring_buffer_get(): increment in refcount_inc_not_zero() only
   guarantees control dependency on success vs. fully ordered
   atomic counterpart
 - ring_buffer_put(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and ACQUIRE ordering + control dependency
   on success vs. fully ordered atomic counterpart

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
Link: https://lkml.kernel.org/r/1548678448-24458-3-git-send-email-elena.reshetova@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c        | 4 ++--
 kernel/events/internal.h    | 3 ++-
 kernel/events/ring_buffer.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 677164d54547..284232edf9be 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5393,7 +5393,7 @@ struct ring_buffer *ring_buffer_get(struct perf_event *event)
 	rcu_read_lock();
 	rb = rcu_dereference(event->rb);
 	if (rb) {
-		if (!atomic_inc_not_zero(&rb->refcount))
+		if (!refcount_inc_not_zero(&rb->refcount))
 			rb = NULL;
 	}
 	rcu_read_unlock();
@@ -5403,7 +5403,7 @@ struct ring_buffer *ring_buffer_get(struct perf_event *event)
 
 void ring_buffer_put(struct ring_buffer *rb)
 {
-	if (!atomic_dec_and_test(&rb->refcount))
+	if (!refcount_dec_and_test(&rb->refcount))
 		return;
 
 	WARN_ON_ONCE(!list_empty(&rb->event_list));
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 6dc725a7e7bc..4718de2a04e6 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -4,13 +4,14 @@
 
 #include <linux/hardirq.h>
 #include <linux/uaccess.h>
+#include <linux/refcount.h>
 
 /* Buffer handling */
 
 #define RING_BUFFER_WRITABLE		0x01
 
 struct ring_buffer {
-	atomic_t			refcount;
+	refcount_t			refcount;
 	struct rcu_head			rcu_head;
 #ifdef CONFIG_PERF_USE_VMALLOC
 	struct work_struct		work;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index ed6409300ef5..0a71d16ca41b 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -284,7 +284,7 @@ ring_buffer_init(struct ring_buffer *rb, long watermark, int flags)
 	else
 		rb->overwrite = 1;
 
-	atomic_set(&rb->refcount, 1);
+	refcount_set(&rb->refcount, 1);
 
 	INIT_LIST_HEAD(&rb->event_list);
 	spin_lock_init(&rb->event_lock);
