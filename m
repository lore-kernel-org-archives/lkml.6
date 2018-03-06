Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeCFGuw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:50:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeCFGuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:50:51 -0500
Date: Mon, 5 Mar 2018 22:50:42 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-88e37a4bbe6e05fd5ad103738c542658b81e76ea@git.kernel.org>
Cc: kan.liang@linux.intel.com, mingo@kernel.org, jolsa@redhat.com,
        acme@redhat.com, wangnan0@huawei.com, hpa@zytor.com,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, wangnan0@huawei.com, ak@linux.intel.com,
        hpa@zytor.com, jolsa@redhat.com, acme@redhat.com, mingo@kernel.org,
        kan.liang@linux.intel.com
In-Reply-To: <1519945751-37786-9-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-9-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Switch to new perf_mmap__read_event()
 interface for perf-record
Git-Commit-ID: 88e37a4bbe6e05fd5ad103738c542658b81e76ea
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

Commit-ID:  88e37a4bbe6e05fd5ad103738c542658b81e76ea
Gitweb:     https://git.kernel.org/tip/88e37a4bbe6e05fd5ad103738c542658b81e76ea
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:06 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:50:21 -0300

perf test: Switch to new perf_mmap__read_event() interface for perf-record

The perf test 'perf-record' still use the legacy interface.

No functional change.

Committer notes:

Testing it:

  # perf test PERF_RECORD
   8: PERF_RECORD_* events & perf_sample fields             : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-9-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/perf-record.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 0afafab85238..31f3f70adca6 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -164,8 +164,14 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 
 		for (i = 0; i < evlist->nr_mmaps; i++) {
 			union perf_event *event;
+			struct perf_mmap *md;
+			u64 end, start;
 
-			while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+			md = &evlist->mmap[i];
+			if (perf_mmap__read_init(md, false, &start, &end) < 0)
+				continue;
+
+			while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 				const u32 type = event->header.type;
 				const char *name = perf_event__name(type);
 
@@ -266,8 +272,9 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 					++errs;
 				}
 
-				perf_evlist__mmap_consume(evlist, i);
+				perf_mmap__consume(md, false);
 			}
+			perf_mmap__read_done(md);
 		}
 
 		/*
