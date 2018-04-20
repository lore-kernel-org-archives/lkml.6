Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755320AbeDTOdU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754968AbeDTOdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:33:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349842183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, syzkaller-bugs@googlegroups.com,
        x86@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/17] perf: Fix sample_max_stack maximum check
Date: Fri, 20 Apr 2018 11:32:17 -0300
Message-Id: <20180420143227.16030-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The syzbot hit KASAN bug in perf_callchain_store having the entry stored
behind the allocated bounds [1].

We miss the sample_max_stack check for the initial event that allocates
callchain buffers. This missing check allows to create an event with
sample_max_stack value bigger than the global sysctl maximum:

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

Note the '-C 1', which forces perf record to create just single event.
Otherwise it opens event for every cpu, then the sample_max_stack check
fails on the second event and all's fine.

The fix is to run the sample_max_stack check also for the first event
with callchains.

[1] https://marc.info/?l=linux-kernel&m=152352732920874&w=2

Reported-by: syzbot+7c449856228b63ac951e@syzkaller.appspotmail.com
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: syzkaller-bugs@googlegroups.com
Cc: x86@kernel.org
Fixes: 97c79a38cd45 ("perf core: Per event callchain limit")
Link: http://lkml.kernel.org/r/20180415092352.12403-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
