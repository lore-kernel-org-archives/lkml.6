Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CC3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A022086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfA1M1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:27:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:21831 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfA1M1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:27:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 04:27:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="139402579"
Received: from elena-thinkpad-x230.fi.intel.com ([10.237.68.34])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2019 04:27:44 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, keescook@chromium.org, tglx@linutronix.de,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 2/3] perf/ring_buffer: convert ring_buffer.refcount to refcount_t
Date:   Mon, 28 Jan 2019 14:27:27 +0200
Message-Id: <1548678448-24458-3-git-send-email-elena.reshetova@intel.com>
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

The variable ring_buffer.refcount is used as pure reference counter.
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

For the ring_buffer.refcount it might make a difference
in following places:
 - ring_buffer_get(): increment in refcount_inc_not_zero() only
   guarantees control dependency on success vs. fully ordered
   atomic counterpart
 - ring_buffer_put(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and ACQUIRE ordering + control dependency
   on success vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 kernel/events/core.c        | 4 ++--
 kernel/events/internal.h    | 3 ++-
 kernel/events/ring_buffer.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a1e87d2..963cee0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5388,7 +5388,7 @@ struct ring_buffer *ring_buffer_get(struct perf_event *event)
 	rcu_read_lock();
 	rb = rcu_dereference(event->rb);
 	if (rb) {
-		if (!atomic_inc_not_zero(&rb->refcount))
+		if (!refcount_inc_not_zero(&rb->refcount))
 			rb = NULL;
 	}
 	rcu_read_unlock();
@@ -5398,7 +5398,7 @@ struct ring_buffer *ring_buffer_get(struct perf_event *event)
 
 void ring_buffer_put(struct ring_buffer *rb)
 {
-	if (!atomic_dec_and_test(&rb->refcount))
+	if (!refcount_dec_and_test(&rb->refcount))
 		return;
 
 	WARN_ON_ONCE(!list_empty(&rb->event_list));
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 6dc725a..4718de2 100644
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
index 4a99370..e841d48 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -285,7 +285,7 @@ ring_buffer_init(struct ring_buffer *rb, long watermark, int flags)
 	else
 		rb->overwrite = 1;
 
-	atomic_set(&rb->refcount, 1);
+	refcount_set(&rb->refcount, 1);
 
 	INIT_LIST_HEAD(&rb->event_list);
 	spin_lock_init(&rb->event_lock);
-- 
2.7.4

