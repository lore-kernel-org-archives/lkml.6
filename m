Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA645C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E6920820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfBDIx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:53:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53829 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:53:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148r9tf357577
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:53:10 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148r9au357574;
        Mon, 4 Feb 2019 00:53:09 -0800
Date:   Mon, 4 Feb 2019 00:53:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Elena Reshetova <tipbot@zytor.com>
Message-ID: <tip-ca3bb3d027f69ac3ab1dafb32bde2f5a3a44439c@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, peterz@infradead.org, ishkamiel@gmail.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        keescook@chromium.org, elena.reshetova@intel.com,
        dwindsor@gmail.com, torvalds@linux-foundation.org, acme@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, ishkamiel@gmail.com,
          acme@redhat.com, mingo@kernel.org, torvalds@linux-foundation.org,
          dwindsor@gmail.com, elena.reshetova@intel.com,
          peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
          jolsa@redhat.com, linux-kernel@vger.kernel.org,
          keescook@chromium.org
In-Reply-To: <1548678448-24458-4-git-send-email-elena.reshetova@intel.com>
References: <1548678448-24458-4-git-send-email-elena.reshetova@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/ring_buffer: Convert ring_buffer.aux_refcount
 to refcount_t
Git-Commit-ID: ca3bb3d027f69ac3ab1dafb32bde2f5a3a44439c
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

Commit-ID:  ca3bb3d027f69ac3ab1dafb32bde2f5a3a44439c
Gitweb:     https://git.kernel.org/tip/ca3bb3d027f69ac3ab1dafb32bde2f5a3a44439c
Author:     Elena Reshetova <elena.reshetova@intel.com>
AuthorDate: Mon, 28 Jan 2019 14:27:28 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:46:17 +0100

perf/ring_buffer: Convert ring_buffer.aux_refcount to refcount_t

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

For the ring_buffer.aux_refcount it might make a difference
in following places:

 - perf_aux_output_begin(): increment in refcount_inc_not_zero() only
   guarantees control dependency on success vs. fully ordered
   atomic counterpart
 - rb_free_aux(): decrement in refcount_dec_and_test() only
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
Link: https://lkml.kernel.org/r/1548678448-24458-4-git-send-email-elena.reshetova@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c        | 2 +-
 kernel/events/internal.h    | 2 +-
 kernel/events/ring_buffer.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 284232edf9be..5aeb4c74fb99 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5468,7 +5468,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 
 		/* this has to be the last one */
 		rb_free_aux(rb);
-		WARN_ON_ONCE(atomic_read(&rb->aux_refcount));
+		WARN_ON_ONCE(refcount_read(&rb->aux_refcount));
 
 		mutex_unlock(&event->mmap_mutex);
 	}
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 4718de2a04e6..79c47076700a 100644
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
index 0a71d16ca41b..805f0423ee0b 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -357,7 +357,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 	if (!atomic_read(&rb->aux_mmap_count))
 		goto err;
 
-	if (!atomic_inc_not_zero(&rb->aux_refcount))
+	if (!refcount_inc_not_zero(&rb->aux_refcount))
 		goto err;
 
 	/*
@@ -670,7 +670,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 	 * we keep a refcount here to make sure either of the two can
 	 * reference them safely.
 	 */
-	atomic_set(&rb->aux_refcount, 1);
+	refcount_set(&rb->aux_refcount, 1);
 
 	rb->aux_overwrite = overwrite;
 	rb->aux_watermark = watermark;
@@ -689,7 +689,7 @@ out:
 
 void rb_free_aux(struct ring_buffer *rb)
 {
-	if (atomic_dec_and_test(&rb->aux_refcount))
+	if (refcount_dec_and_test(&rb->aux_refcount))
 		__rb_free_aux(rb);
 }
 
