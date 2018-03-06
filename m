Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbeCFGrn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:47:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39063 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCFGrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:47:42 -0500
Date: Mon, 5 Mar 2018 22:47:32 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-d7f55c62e63461c4071afe8730851e406935d960@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, wangnan0@huawei.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, mingo@kernel.org,
        kan.liang@linux.intel.com
Reply-To: wangnan0@huawei.com, acme@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        mingo@kernel.org, ak@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com
In-Reply-To: <1519945751-37786-2-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-2-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Switch to new perf_mmap__read_event()
 interface
Git-Commit-ID: d7f55c62e63461c4071afe8730851e406935d960
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

Commit-ID:  d7f55c62e63461c4071afe8730851e406935d960
Gitweb:     https://git.kernel.org/tip/d7f55c62e63461c4071afe8730851e406935d960
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:08:59 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:41:59 -0300

perf trace: Switch to new perf_mmap__read_event() interface

The 'perf trace' utility still use the legacy interface.

Switch to the new perf_mmap__read_event() interface.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-2-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e7f1b182fc15..1a93debc1e8d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2472,8 +2472,14 @@ again:
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
+		struct perf_mmap *md;
+		u64 end, start;
 
-		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+		md = &evlist->mmap[i];
+		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 			struct perf_sample sample;
 
 			++trace->nr_events;
@@ -2486,7 +2492,7 @@ again:
 
 			trace__handle_event(trace, event, &sample);
 next_event:
-			perf_evlist__mmap_consume(evlist, i);
+			perf_mmap__consume(md, false);
 
 			if (interrupted)
 				goto out_disable;
@@ -2496,6 +2502,7 @@ next_event:
 				draining = true;
 			}
 		}
+		perf_mmap__read_done(md);
 	}
 
 	if (trace->nr_events == before) {
