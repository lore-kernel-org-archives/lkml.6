Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D410BC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F89E2084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nszIEoIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F89E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbeKCD7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbeKCD7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:59:47 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F242082D;
        Fri,  2 Nov 2018 18:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184692;
        bh=D5XKwHj6e5O0DE8cSxrXdROkeN0vmWc/NlcPajMUaJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nszIEoIzWDW2edTh1y+/QYasOswj9fB5omrNVdfyXhd1SyU36c6xpnDk1QYvnnwrv
         GxueYe+EqdgW07q7lNcuBrc77YNSHwhcfGx2v3BoDAn7rw2nCwsdaxoi9WLJJCeYNI
         HUS961GDULykTMNDOBkk7uJauNBFhys9R7SAqduQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Vagin <avagin@openvz.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 039/143] perf/ring_buffer: Prevent concurent ring buffer access
Date:   Fri,  2 Nov 2018 19:33:44 +0100
Message-Id: <20181102182900.191451763@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ee1c07c0b833..991af683ef9e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8058,6 +8058,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+			if (event->cpu != smp_processor_id())
+				continue;
 			if (event->attr.type != PERF_TYPE_TRACEPOINT)
 				continue;
 			if (event->attr.config != entry->type)
-- 
2.17.1



