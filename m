Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A63C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9552145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy/JBnX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9552145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeJPMBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbeJPMBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7225D21471;
        Tue, 16 Oct 2018 04:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663205;
        bh=mBVBQ3REcKAgw3KSYgb3JYObBLNOrFgi+wWYYpQi+iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uy/JBnX1gKjXcYUyjSAo0Kq9MHeAaji4AE2TdyWYrDy51toxlPetZMniiNBV8h+tI
         FDXt4w2OlCT0tnmFvL5BtluaOifcTwragpn57TwM+JAa0DOcEDtcfG92l1ApuHEBoe
         1xi0/DXs2jCJ9Ct/q7xoxxkXipCxL4cYlmtKgQ2A=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Vagin <avagin@openvz.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 067/100] perf/ring_buffer: Prevent concurent ring buffer access
Date:   Tue, 16 Oct 2018 00:11:48 -0400
Message-Id: <20181016041221.135528-67-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

[ Upstream commit cd6fb677ce7e460c25bdd66f689734102ec7d642 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b1ed5e99d9c6..fc072b7f839d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8319,6 +8319,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+			if (event->cpu != smp_processor_id())
+				continue;
 			if (event->attr.type != PERF_TYPE_TRACEPOINT)
 				continue;
 			if (event->attr.config != entry->type)
-- 
2.17.1

