Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935105AbeBMMVt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:21:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934827AbeBMMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:21:47 -0500
Date: Tue, 13 Feb 2018 04:11:21 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-1db6c3a2144eaf0d8aaeecf46df73106834bad75@git.kernel.org>
Cc: tglx@linutronix.de, yao.jin@linux.intel.com, jolsa@kernel.org,
        hpa@zytor.com, peterz@infradead.org, kan.liang@intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        acme@redhat.com, mingo@kernel.org, wangnan0@huawei.com
Reply-To: acme@redhat.com, mingo@kernel.org, wangnan0@huawei.com,
        kan.liang@intel.com, hpa@zytor.com, peterz@infradead.org,
        jolsa@kernel.org, yao.jin@linux.intel.com, tglx@linutronix.de,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, namhyung@kernel.org
In-Reply-To: <1516310792-208685-18-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-18-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Check the latency of
 perf_top__mmap_read()
Git-Commit-ID: 1db6c3a2144eaf0d8aaeecf46df73106834bad75
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

Commit-ID:  1db6c3a2144eaf0d8aaeecf46df73106834bad75
Gitweb:     https://git.kernel.org/tip/1db6c3a2144eaf0d8aaeecf46df73106834bad75
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:32 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:51 -0300

perf top: Check the latency of perf_top__mmap_read()

The latency of perf_top__mmap_read() should be lower than refresh time.
If not, give some hints to reduce the latency.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-18-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 2b4914f..b7c823b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -889,8 +889,10 @@ static void perf_top__mmap_read(struct perf_top *top)
 {
 	bool overwrite = top->record_opts.overwrite;
 	struct perf_evlist *evlist = top->evlist;
+	unsigned long long start, end;
 	int i;
 
+	start = rdclock();
 	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_DATA_PENDING);
 
@@ -901,6 +903,13 @@ static void perf_top__mmap_read(struct perf_top *top)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
 	}
+	end = rdclock();
+
+	if ((end - start) > (unsigned long long)top->delay_secs * NSEC_PER_SEC)
+		ui__warning("Too slow to read ring buffer.\n"
+			    "Please try increasing the period (-c) or\n"
+			    "decreasing the freq (-F) or\n"
+			    "limiting the number of CPUs (-C)\n");
 }
 
 /*
