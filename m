Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932664AbeBPJug (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:50:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932420AbeBPJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:50:34 -0500
Date: Fri, 16 Feb 2018 01:40:12 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-204721d7eabe6ee98aafce791ce3efdbc4715834@git.kernel.org>
Cc: peterz@infradead.org, namhyung@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, yao.jin@linux.intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, wangnan0@huawei.com,
        jolsa@kernel.org, kan.liang@intel.com, hpa@zytor.com
Reply-To: wangnan0@huawei.com, jolsa@kernel.org, kan.liang@intel.com,
        hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        namhyung@kernel.org, mingo@kernel.org, yao.jin@linux.intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com
In-Reply-To: <1516310792-208685-14-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-14-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Add overwrite fall back
Git-Commit-ID: 204721d7eabe6ee98aafce791ce3efdbc4715834
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

Commit-ID:  204721d7eabe6ee98aafce791ce3efdbc4715834
Gitweb:     https://git.kernel.org/tip/204721d7eabe6ee98aafce791ce3efdbc4715834
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:28 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:56:14 -0300

perf top: Add overwrite fall back

Switch to non-overwrite mode if kernel doesnot support overwrite
ringbuffer.

It's only effect when overwrite mode is supported.  No change to current
behavior.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-14-git-send-email-kan.liang@intel.com
[ Use perf_missing_features.write_backward instead of the non merged is_write_backward_fail() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1778379..ee4bba1 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -943,6 +943,27 @@ static int perf_top__overwrite_check(struct perf_top *top)
 	return 0;
 }
 
+static int perf_top_overwrite_fallback(struct perf_top *top,
+				       struct perf_evsel *evsel)
+{
+	struct record_opts *opts = &top->record_opts;
+	struct perf_evlist *evlist = top->evlist;
+	struct perf_evsel *counter;
+
+	if (!opts->overwrite)
+		return 0;
+
+	/* only fall back when first event fails */
+	if (evsel != perf_evlist__first(evlist))
+		return 0;
+
+	evlist__for_each_entry(evlist, counter)
+		counter->attr.write_backward = false;
+	opts->overwrite = false;
+	ui__warning("fall back to non-overwrite mode\n");
+	return 1;
+}
+
 static int perf_top__start_counters(struct perf_top *top)
 {
 	char msg[BUFSIZ];
@@ -967,6 +988,21 @@ static int perf_top__start_counters(struct perf_top *top)
 try_again:
 		if (perf_evsel__open(counter, top->evlist->cpus,
 				     top->evlist->threads) < 0) {
+
+			/*
+			 * Specially handle overwrite fall back.
+			 * Because perf top is the only tool which has
+			 * overwrite mode by default, support
+			 * both overwrite and non-overwrite mode, and
+			 * require consistent mode for all events.
+			 *
+			 * May move it to generic code with more tools
+			 * have similar attribute.
+			 */
+			if (perf_missing_features.write_backward &&
+			    perf_top_overwrite_fallback(top, counter))
+				goto try_again;
+
 			if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
