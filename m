Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC1CC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EE02086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfA1M1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:27:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:21831 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfA1M1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:27:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 04:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="139402590"
Received: from elena-thinkpad-x230.fi.intel.com ([10.237.68.34])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2019 04:27:47 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, keescook@chromium.org, tglx@linutronix.de,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 3/3] perf/ring_buffer: convert ring_buffer.aux_refcount to refcount_t
Date:   Mon, 28 Jan 2019 14:27:28 +0200
Message-Id: <1548678448-24458-4-git-send-email-elena.reshetova@intel.com>
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

The variable ring_buffer.aux_refcount is used as pure reference counter.
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

For the ring_buffer.aux_refcount it might make a difference
in following places:
 - perf_aux_output_begin(): increment in refcount_inc_not_zero() only
   guarantees control dependency on success vs. fully ordered
   atomic counterpart
 - rb_free_aux(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and ACQUIRE ordering + control dependency
   on success vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 kernel/events/core.c        | 2 +-
 kernel/events/internal.h    | 2 +-
 kernel/events/ring_buffer.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 963cee0..31ab5d7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5463,7 +5463,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 
 		/* this has to be the last one */
 		rb_free_aux(rb);
-		WARN_ON_ONCE(atomic_read(&rb->aux_refcount));
+		WARN_ON_ONCE(refcount_read(&rb->aux_refcount));
 
 		mutex_unlock(&event->mmap_mutex);
 	}
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 4718de2..79c4707 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -49,7 +49,7 @@ struct ring_buffer {
 	atomic_t			aux_mmap_count;
 	unsigned long			aux_mmap_locked;
 	void				(*free_aux)(void *);
-	atomic_t			aux_refcount;
+	refcount_t			aux_refcount;
 	void				**aux_pages;
 	void				*aux_priv;
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index e841d48..0416f01 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -358,7 +358,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 	if (!atomic_read(&rb->aux_mmap_count))
 		goto err;
 
-	if (!atomic_inc_not_zero(&rb->aux_refcount))
+	if (!refcount_inc_not_zero(&rb->aux_refcount))
 		goto err;
 
 	/*
@@ -671,7 +671,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 	 * we keep a refcount here to make sure either of the two can
 	 * reference them safely.
 	 */
-	atomic_set(&rb->aux_refcount, 1);
+	refcount_set(&rb->aux_refcount, 1);
 
 	rb->aux_overwrite = overwrite;
 	rb->aux_watermark = watermark;
@@ -690,7 +690,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 
 void rb_free_aux(struct ring_buffer *rb)
 {
-	if (atomic_dec_and_test(&rb->aux_refcount))
+	if (refcount_dec_and_test(&rb->aux_refcount))
 		__rb_free_aux(rb);
 }
 
-- 
2.7.4

