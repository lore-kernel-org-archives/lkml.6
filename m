Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935151AbeBMMUC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:20:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51419 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934827AbeBMMUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:20:00 -0500
Date: Tue, 13 Feb 2018 04:09:36 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-6a669091c0d93cc1ac4a0de7af722d1359bfe98f@git.kernel.org>
Cc: acme@redhat.com, jolsa@kernel.org, hpa@zytor.com, ak@linux.intel.com,
        tglx@linutronix.de, namhyung@kernel.org, wangnan0@huawei.com,
        kan.liang@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, yao.jin@linux.intel.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, yao.jin@linux.intel.com,
        peterz@infradead.org, wangnan0@huawei.com, kan.liang@intel.com,
        namhyung@kernel.org, mingo@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        acme@redhat.com, ak@linux.intel.com, tglx@linutronix.de
In-Reply-To: <1516310792-208685-14-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-14-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Add overwrite fall back
Git-Commit-ID: 6a669091c0d93cc1ac4a0de7af722d1359bfe98f
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

Commit-ID:  6a669091c0d93cc1ac4a0de7af722d1359bfe98f
Gitweb:     https://git.kernel.org/tip/6a669091c0d93cc1ac4a0de7af722d1359bfe98f
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:28 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:51 -0300

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
