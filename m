Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeCFGtE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:49:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58309 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCFGtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:49:02 -0500
Date: Mon, 5 Mar 2018 22:48:53 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-00fc2460e735fa0f6add802c7426273e7dbc2b27@git.kernel.org>
Cc: acme@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, wangnan0@huawei.com,
        hpa@zytor.com, namhyung@kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Reply-To: kan.liang@linux.intel.com, ak@linux.intel.com, namhyung@kernel.org,
        hpa@zytor.com, wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        acme@redhat.com
In-Reply-To: <1519945751-37786-5-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-5-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Switch to new perf_mmap__read_event()
 interface for 'code reading' test
Git-Commit-ID: 00fc2460e735fa0f6add802c7426273e7dbc2b27
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

Commit-ID:  00fc2460e735fa0f6add802c7426273e7dbc2b27
Gitweb:     https://git.kernel.org/tip/00fc2460e735fa0f6add802c7426273e7dbc2b27
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:02 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:48:36 -0300

perf test: Switch to new perf_mmap__read_event() interface for 'code reading' test

The perf test 'object code reading' still use the legacy interface.

No functional change.

Committer notes:

Testing:

  # perf test reading
  23: Object code reading: Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-5-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/code-reading.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index c7115d369511..03ed8c77b1bb 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -409,15 +409,22 @@ static int process_events(struct machine *machine, struct perf_evlist *evlist,
 			  struct state *state)
 {
 	union perf_event *event;
+	struct perf_mmap *md;
+	u64 end, start;
 	int i, ret;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+		md = &evlist->mmap[i];
+		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 			ret = process_event(machine, evlist, event, state);
-			perf_evlist__mmap_consume(evlist, i);
+			perf_mmap__consume(md, false);
 			if (ret < 0)
 				return ret;
 		}
+		perf_mmap__read_done(md);
 	}
 	return 0;
 }
