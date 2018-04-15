Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeDOJYB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 05:24:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751632AbeDOJX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 05:23:58 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, hpa@zytor.com,
        Namhyung Kim <namhyung@kernel.org>, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: [PATCH 2/3] perf: Fix sample_max_stack maximum check
Date: Sun, 15 Apr 2018 11:23:51 +0200
Message-Id: <20180415092352.12403-2-jolsa@kernel.org>
In-Reply-To: <20180415092352.12403-1-jolsa@kernel.org>
References: <20180415092352.12403-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syzbot hit KASAN bug in perf_callchain_store
having the entry stored behind the allocated bounds [1].

We miss the sample_max_stack check for the initial event
that allocates callchain buffers. This missing check allows
to create an event with sample_max_stack value bigger than
the global sysctl maximum:

  # sysctl -a | grep perf_event_max_stack
  kernel.perf_event_max_stack = 127

  # perf record -vv -C 1 -e cycles/max-stack=256/ kill
  ...
  perf_event_attr:
    size                             112
    ...
    sample_max_stack                 256
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4

Note the '-C 1', which forces perf record to create just
single event. Otherwise it opens event for every cpu, then
the sample_max_stack check fails on the second event and
all's fine.

The fix is to run the sample_max_stack check also for the
first event with callchains.

[1] https://marc.info/?l=linux-kernel&m=152352732920874&w=2

Reported-by: syzbot+7c449856228b63ac951e@syzkaller.appspotmail.com
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/callchain.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 772a43fea825..73cc26e321de 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -119,19 +119,22 @@ int get_callchain_buffers(int event_max_stack)
 		goto exit;
 	}
 
+	/*
+	 * If requesting per event more than the global cap,
+	 * return a different error to help userspace figure
+	 * this out.
+	 *
+	 * And also do it here so that we have &callchain_mutex held.
+	 */
+	if (event_max_stack > sysctl_perf_event_max_stack) {
+		err = -EOVERFLOW;
+		goto exit;
+	}
+
 	if (count > 1) {
 		/* If the allocation failed, give up */
 		if (!callchain_cpus_entries)
 			err = -ENOMEM;
-		/*
-		 * If requesting per event more than the global cap,
-		 * return a different error to help userspace figure
-		 * this out.
-		 *
-		 * And also do it here so that we have &callchain_mutex held.
-		 */
-		if (event_max_stack > sysctl_perf_event_max_stack)
-			err = -EOVERFLOW;
 		goto exit;
 	}
 
-- 
2.13.6
