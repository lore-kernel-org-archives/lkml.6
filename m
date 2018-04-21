Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeDUHvV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:51:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeDUHvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:51:19 -0400
Date: Sat, 21 Apr 2018 00:49:28 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5af44ca53d019de47efe6dbc4003dd518e5197ed@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
        namhyung@kernel.org, andi@firstfloor.org
Reply-To: tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, hpa@zytor.com, acme@redhat.com, namhyung@kernel.org,
        andi@firstfloor.org
In-Reply-To: <20180415092352.12403-2-jolsa@kernel.org>
References: <20180415092352.12403-2-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf: Fix sample_max_stack maximum check
Git-Commit-ID: 5af44ca53d019de47efe6dbc4003dd518e5197ed
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5af44ca53d019de47efe6dbc4003dd518e5197ed
Gitweb:     https://git.kernel.org/tip/5af44ca53d019de47efe6dbc4003dd518e5197ed
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 15 Apr 2018 11:23:51 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 17 Apr 2018 09:47:40 -0300

perf: Fix sample_max_stack maximum check

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
 
