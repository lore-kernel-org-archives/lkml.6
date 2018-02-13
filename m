Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935072AbeBMMUz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:20:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60427 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934827AbeBMMUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:20:54 -0500
Date: Tue, 13 Feb 2018 04:10:28 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-c14dec366b440fe46f35f99215434f3f9277e19b@git.kernel.org>
Cc: peterz@infradead.org, hpa@zytor.com, jolsa@kernel.org,
        yao.jin@linux.intel.com, acme@redhat.com, tglx@linutronix.de,
        kan.liang@intel.com, wangnan0@huawei.com, ak@linux.intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: hpa@zytor.com, jolsa@kernel.org, peterz@infradead.org,
        kan.liang@intel.com, acme@redhat.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, ak@linux.intel.com, wangnan0@huawei.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <1516310792-208685-16-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-16-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Remove lost events checking
Git-Commit-ID: c14dec366b440fe46f35f99215434f3f9277e19b
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

Commit-ID:  c14dec366b440fe46f35f99215434f3f9277e19b
Gitweb:     https://git.kernel.org/tip/c14dec366b440fe46f35f99215434f3f9277e19b
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:30 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:51 -0300

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
