Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeCFGvq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:51:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeCFGvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:51:44 -0500
Date: Mon, 5 Mar 2018 22:51:35 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-5d0007cdfc6612788badceb276156d6ccb30b6de@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com,
        kan.liang@linux.intel.com, jolsa@redhat.com, tglx@linutronix.de,
        namhyung@kernel.org, wangnan0@huawei.com, ak@linux.intel.com,
        hpa@zytor.com, mingo@kernel.org
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, namhyung@kernel.org, wangnan0@huawei.com,
        tglx@linutronix.de, jolsa@redhat.com, mingo@kernel.org, hpa@zytor.com,
        ak@linux.intel.com
In-Reply-To: <1519945751-37786-11-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-11-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Switch to new perf_mmap__read_event()
 interface for sw-clock
Git-Commit-ID: 5d0007cdfc6612788badceb276156d6ccb30b6de
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

Commit-ID:  5d0007cdfc6612788badceb276156d6ccb30b6de
Gitweb:     https://git.kernel.org/tip/5d0007cdfc6612788badceb276156d6ccb30b6de
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:08 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:50:37 -0300

perf test: Switch to new perf_mmap__read_event() interface for sw-clock

The perf test 'sw-clock' still use the legacy interface.

No functional change.

Committer testing:

  # perf test clock
  22: Software clock events period values                   : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-11-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sw-clock.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index f6c72f915d48..e6320e267ba5 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -39,6 +39,8 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	};
 	struct cpu_map *cpus;
 	struct thread_map *threads;
+	struct perf_mmap *md;
+	u64 end, start;
 
 	attr.sample_freq = 500;
 
@@ -93,7 +95,11 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 
 	perf_evlist__disable(evlist);
 
-	while ((event = perf_evlist__mmap_read(evlist, 0)) != NULL) {
+	md = &evlist->mmap[0];
+	if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		goto out_init;
+
+	while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 		struct perf_sample sample;
 
 		if (event->header.type != PERF_RECORD_SAMPLE)
@@ -108,9 +114,11 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		total_periods += sample.period;
 		nr_samples++;
 next_event:
-		perf_evlist__mmap_consume(evlist, 0);
+		perf_mmap__consume(md, false);
 	}
+	perf_mmap__read_done(md);
 
+out_init:
 	if ((u64) nr_samples == total_periods) {
 		pr_debug("All (%d) samples have period value of 1!\n",
 			 nr_samples);
