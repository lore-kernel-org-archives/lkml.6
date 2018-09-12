Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC37C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602C62146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602C62146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeIMAjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:39:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbeIMAjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:39:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C757140241C4;
        Wed, 12 Sep 2018 19:33:20 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B842A2026D76;
        Wed, 12 Sep 2018 19:33:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] perf: Prevent recursion in ring buffer
Date:   Wed, 12 Sep 2018 21:33:17 +0200
Message-Id: <20180912193317.10339-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 12 Sep 2018 19:33:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 12 Sep 2018 19:33:20 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the scheduling tracepoints allow the perf_tp_event
code to write to ring buffer under different cpu than the
code is running on.

This results in corrupted ring buffer data demonstrated in
following perf commands:

  # perf record -e 'sched:sched_switch,sched:sched_wakeup' perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.383 [sec]
  [ perf record: Woken up 8 times to write data ]
  0x42b890 [0]: failed to process type: -1765585640
  [ perf record: Captured and wrote 4.825 MB perf.data (29669 samples) ]

  # perf report --stdio
  0x42b890 [0]: failed to process type: -1765585640

The reason for the corruptions are some of the scheduling tracepoints,
that have __perf_task dfined and thus allow to store data to another
cpu ring buffer:

  sched_waking
  sched_wakeup
  sched_wakeup_new
  sched_stat_wait
  sched_stat_sleep
  sched_stat_iowait
  sched_stat_blocked

The perf_tp_event function first store samples for current cpu
related events defined for tracepoint:

    hlist_for_each_entry_rcu(event, head, hlist_entry)
      perf_swevent_event(event, count, &data, regs);

And then iterates events of the 'task' and store the sample
for any task's event that passes tracepoint checks:

  ctx = rcu_dereference(task->perf_event_ctxp[perf_sw_context]);

  list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
    if (event->attr.type != PERF_TYPE_TRACEPOINT)
      continue;
    if (event->attr.config != entry->type)
      continue;

    perf_swevent_event(event, count, &data, regs);
  }

Above code can race with same code running on another cpu,
ending up with 2 cpus trying to store under the same ring
buffer, which is not handled at the moment.

This patch adds atomic 'recursion' flag (any cpu could touch
the ring buffer at any moment), that guards the entry to the
storage code. It's set in __perf_output_begin function and
released in perf_output_put_handle. If the flag is set, the
code increases the lost count and bails out.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/internal.h    | 1 +
 kernel/events/ring_buffer.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 6dc725a7e7bc..82599da9723f 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -11,6 +11,7 @@
 
 struct ring_buffer {
 	atomic_t			refcount;
+	atomic_t			recursion;
 	struct rcu_head			rcu_head;
 #ifdef CONFIG_PERF_USE_VMALLOC
 	struct work_struct		work;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4a9937076331..0c976ac414c5 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -101,6 +101,7 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
 
 out:
 	preempt_enable();
+	atomic_set(&rb->recursion, 0);
 }
 
 static __always_inline bool
@@ -145,6 +146,12 @@ __perf_output_begin(struct perf_output_handle *handle,
 		goto out;
 	}
 
+	if (atomic_cmpxchg(&rb->recursion, 0, 1) != 0) {
+		if (rb->nr_pages)
+			local_inc(&rb->lost);
+		goto out;
+	}
+
 	handle->rb    = rb;
 	handle->event = event;
 
@@ -286,6 +293,7 @@ ring_buffer_init(struct ring_buffer *rb, long watermark, int flags)
 		rb->overwrite = 1;
 
 	atomic_set(&rb->refcount, 1);
+	atomic_set(&rb->recursion, 0);
 
 	INIT_LIST_HEAD(&rb->event_list);
 	spin_lock_init(&rb->event_lock);
-- 
2.17.1

