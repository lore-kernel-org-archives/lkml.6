Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751065AbeBQLpX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:45:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeBQLpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:45:21 -0500
Date: Sat, 17 Feb 2018 03:34:59 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e3ebaa465136ecfedf9c6f4671df02bf625f8125@git.kernel.org>
Cc: acme@redhat.com, peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        kan.liang@intel.com, tglx@linutronix.de, ak@linux.intel.com,
        jolsa@redhat.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Reply-To: kan.liang@intel.com, jolsa@redhat.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, yao.jin@linux.intel.com,
        tglx@linutronix.de, peterz@infradead.org, acme@redhat.com,
        hpa@zytor.com, jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org
In-Reply-To: <20180216123619.GA9945@krava>
References: <20180216123619.GA9945@krava>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Fix memory corruption in
 --branch-history mode --branch-history
Git-Commit-ID: e3ebaa465136ecfedf9c6f4671df02bf625f8125
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

Commit-ID:  e3ebaa465136ecfedf9c6f4671df02bf625f8125
Gitweb:     https://git.kernel.org/tip/e3ebaa465136ecfedf9c6f4671df02bf625f8125
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Fri, 16 Feb 2018 13:36:19 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:47 -0300

perf report: Fix memory corruption in --branch-history mode --branch-history

Jin Yao reported memory corrupton in perf report with
branch info used for stack trace:

  > Following command lines will cause perf crash.

  > perf record -j call -g -a <application>
  > perf report --branch-history
  >
  > *** Error in `perf': double free or corruption (!prev): 0x00000000104aa040 ***
  > ======= Backtrace: =========
  > /lib/x86_64-linux-gnu/libc.so.6(+0x77725)[0x7f6b37254725]
  > /lib/x86_64-linux-gnu/libc.so.6(+0x7ff4a)[0x7f6b3725cf4a]
  > /lib/x86_64-linux-gnu/libc.so.6(cfree+0x4c)[0x7f6b37260abc]
  > perf[0x51b914]
  > perf(hist_entry_iter__add+0x1e5)[0x51f305]
  > perf[0x43cf01]
  > perf[0x4fa3bf]
  > perf[0x4fa923]
  > perf[0x4fd396]
  > perf[0x4f9614]
  > perf(perf_session__process_events+0x89e)[0x4fc38e]
  > perf(cmd_report+0x15d2)[0x43f202]
  > perf[0x4a059f]
  > perf(main+0x631)[0x427b71]
  > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7f6b371fd830]
  > perf(_start+0x29)[0x427d89]

For the cumulative output, we allocate the he_cache array based on the
--max-stack option value and populate it with data from 'callchain_cursor'.

The --max-stack option value does not ensure now the limit for number of
callchain_cursor nodes, so the cumulative iter code will allocate smaller array
than it's actually needed and cause above corruption.

I think the --max-stack limit does not apply here anyway, because we add
callchain data as normal hist entries, while the --max-stack control the limit
of single entry callchain depth.

Using the callchain_cursor.nr as he_cache array count to fix this. Also
removing struct hist_entry_iter::max_stack, because there's no longer any use
for it.

We need more fixes to ensure that the branch stack code follows properly the
logic of --max-stack, which is not the case at the moment.

Original-patch-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reported-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180216123619.GA9945@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 4 +---
 tools/perf/util/hist.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b614095..44a8456 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -879,7 +879,7 @@ iter_prepare_cumulative_entry(struct hist_entry_iter *iter,
 	 * cumulated only one time to prevent entries more than 100%
 	 * overhead.
 	 */
-	he_cache = malloc(sizeof(*he_cache) * (iter->max_stack + 1));
+	he_cache = malloc(sizeof(*he_cache) * (callchain_cursor.nr + 1));
 	if (he_cache == NULL)
 		return -ENOMEM;
 
@@ -1045,8 +1045,6 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	if (err)
 		return err;
 
-	iter->max_stack = max_stack_depth;
-
 	err = iter->ops->prepare_entry(iter, al);
 	if (err)
 		goto out;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 02721b57..e869cad 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -107,7 +107,6 @@ struct hist_entry_iter {
 	int curr;
 
 	bool hide_unresolved;
-	int max_stack;
 
 	struct perf_evsel *evsel;
 	struct perf_sample *sample;
