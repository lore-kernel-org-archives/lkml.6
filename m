Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919D9C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3234C2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3234C2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeJBQok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:44:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44941 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeJBQok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:44:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A1QZ21913229
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:01:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A1QtN1913226;
        Tue, 2 Oct 2018 03:01:26 -0700
Date:   Tue, 2 Oct 2018 03:01:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-cd6fb677ce7e460c25bdd66f689734102ec7d642@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, torvalds@linux-foundation.org,
        peterz@infradead.org, jolsa@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, avagin@openvz.org,
        jolsa@kernel.org, vincent.weaver@maine.edu, acme@redhat.com,
        mingo@kernel.org, eranian@google.com
Reply-To: jolsa@redhat.com, torvalds@linux-foundation.org,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, namhyung@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, avagin@openvz.org, acme@kernel.org,
          jolsa@kernel.org, eranian@google.com, acme@redhat.com,
          mingo@kernel.org, vincent.weaver@maine.edu
In-Reply-To: <20180923161343.GB15054@krava>
References: <20180923161343.GB15054@krava>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/ring_buffer: Prevent concurent ring buffer
 access
Git-Commit-ID: cd6fb677ce7e460c25bdd66f689734102ec7d642
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

Commit-ID:  cd6fb677ce7e460c25bdd66f689734102ec7d642
Gitweb:     https://git.kernel.org/tip/cd6fb677ce7e460c25bdd66f689734102ec7d642
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Sun, 23 Sep 2018 18:13:43 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:37:59 +0200

perf/ring_buffer: Prevent concurent ring buffer access

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

The reason for the corruption are some of the scheduling tracepoints,
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
buffer, which is specifically not allowed.

This patch prevents the problem, by allowing only events with the same
current cpu to receive the event.

NOTE: this requires the use of (per-task-)per-cpu buffers for this
feature to work; perf-record does this.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
[peterz: small edits to Changelog]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Vagin <avagin@openvz.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: e6dab5ffab59 ("perf/trace: Add ability to set a target task for events")
Link: http://lkml.kernel.org/r/20180923161343.GB15054@krava
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dfb1d951789e..5a97f34bc14c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8314,6 +8314,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+			if (event->cpu != smp_processor_id())
+				continue;
 			if (event->attr.type != PERF_TYPE_TRACEPOINT)
 				continue;
 			if (event->attr.config != entry->type)
