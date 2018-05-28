Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162906AbeE1N6f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162485AbeE1Kk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:40:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 289/329] perf/core: Fix perf_output_read_group()
Date: Mon, 28 May 2018 12:03:38 +0200
Message-Id: <20180528100305.763006347@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 9e5b127d6f33468143d90c8a45ca12410e4c3fa7 ]

Mark reported his arm64 perf fuzzer runs sometimes splat like:

  armv8pmu_read_counter+0x1e8/0x2d8
  armpmu_event_update+0x8c/0x188
  armpmu_read+0xc/0x18
  perf_output_read+0x550/0x11e8
  perf_event_read_event+0x1d0/0x248
  perf_event_exit_task+0x468/0xbb8
  do_exit+0x690/0x1310
  do_group_exit+0xd0/0x2b0
  get_signal+0x2e8/0x17a8
  do_signal+0x144/0x4f8
  do_notify_resume+0x148/0x1e8
  work_pending+0x8/0x14

which asserts that we only call pmu::read() on ACTIVE events.

The above callchain does:

  perf_event_exit_task()
    perf_event_exit_task_context()
      task_ctx_sched_out() // INACTIVE
      perf_event_exit_event()
        perf_event_set_state(EXIT) // EXIT
        sync_child_event()
          perf_event_read_event()
            perf_output_read()
              perf_output_read_group()
                leader->pmu->read()

Which results in doing a pmu::read() on an !ACTIVE event.

I _think_ this is 'new' since we added attr.inherit_stat, which added
the perf_event_read_event() to the exit path, without that
perf_event_read_output() would only trigger from samples and for
@event to trigger a sample, it's leader _must_ be ACTIVE too.

Still, adding this check makes it consistent with the @sub case for
the siblings.

Reported-and-Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5700,7 +5700,8 @@ static void perf_output_read_group(struc
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
-	if (leader != event)
+	if ((leader != event) &&
+	    (leader->state == PERF_EVENT_STATE_ACTIVE))
 		leader->pmu->read(leader);
 
 	values[n++] = perf_event_count(leader);
