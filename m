Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932937AbeBPJwg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:52:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39171 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbeBPJwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:52:30 -0500
Date: Fri, 16 Feb 2018 01:41:09 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-a1ff5b05e988ca3620027148cd61013408ea4194@git.kernel.org>
Cc: yao.jin@linux.intel.com, acme@redhat.com, tglx@linutronix.de,
        ak@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, namhyung@kernel.org,
        kan.liang@intel.com, jolsa@kernel.org, peterz@infradead.org
Reply-To: ak@linux.intel.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        yao.jin@linux.intel.com, acme@redhat.com, jolsa@kernel.org,
        peterz@infradead.org, wangnan0@huawei.com, namhyung@kernel.org,
        kan.liang@intel.com
In-Reply-To: <1516310792-208685-16-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-16-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Remove lost events checking
Git-Commit-ID: a1ff5b05e988ca3620027148cd61013408ea4194
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

Commit-ID:  a1ff5b05e988ca3620027148cd61013408ea4194
Gitweb:     https://git.kernel.org/tip/a1ff5b05e988ca3620027148cd61013408ea4194
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:30 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:56:43 -0300

perf top: Remove lost events checking

There would be some records lost in overwrite mode because of pausing
the ringbuffer. It has little impact for the accuracy of the snapshot
and could be tolerated by 'perf top'.

Remove the lost events checking.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-16-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7def861..5965306 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -283,8 +283,9 @@ static void perf_top__print_sym_table(struct perf_top *top)
 
 	printf("%-*.*s\n", win_width, win_width, graph_dotted_line);
 
-	if (hists->stats.nr_lost_warned !=
-	    hists->stats.nr_events[PERF_RECORD_LOST]) {
+	if (!top->record_opts.overwrite &&
+	    (hists->stats.nr_lost_warned !=
+	    hists->stats.nr_events[PERF_RECORD_LOST])) {
 		hists->stats.nr_lost_warned =
 			      hists->stats.nr_events[PERF_RECORD_LOST];
 		color_fprintf(stdout, PERF_COLOR_RED,
@@ -611,7 +612,8 @@ static void *display_thread_tui(void *arg)
 
 	perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
 				      top->min_percent,
-				      &top->session->header.env, true);
+				      &top->session->header.env,
+				      !top->record_opts.overwrite);
 
 	done = 1;
 	return NULL;
