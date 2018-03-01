Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163062AbeCAXMq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:12:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:30247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162905AbeCAXKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:10:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208165022"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 07/14] perf test: Apply new perf_mmap__read_event() interface for mmap-basic
Date: Thu,  1 Mar 2018 18:09:04 -0500
Message-Id: <1519945751-37786-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 'mmap-basic' still use the legacy interface.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/mmap-basic.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index c0e971d..13aa59d 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -38,6 +38,8 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		     expected_nr_events[nsyscalls], i, j;
 	struct perf_evsel *evsels[nsyscalls], *evsel;
 	char sbuf[STRERR_BUFSIZE];
+	struct perf_mmap *md;
+	u64 end, start;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	if (threads == NULL) {
@@ -106,7 +108,11 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 			++foo;
 		}
 
-	while ((event = perf_evlist__mmap_read(evlist, 0)) != NULL) {
+	md = &evlist->mmap[0];
+	if (perf_mmap__read_init(md, 0, &start, &end) < 0)
+		goto out_init;
+
+	while ((event = perf_mmap__read_event(md, 0, &start, end)) != NULL) {
 		struct perf_sample sample;
 
 		if (event->header.type != PERF_RECORD_SAMPLE) {
@@ -129,9 +135,11 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 			goto out_delete_evlist;
 		}
 		nr_events[evsel->idx]++;
-		perf_evlist__mmap_consume(evlist, 0);
+		perf_mmap__consume(md, 0);
 	}
+	perf_mmap__read_done(md);
 
+out_init:
 	err = 0;
 	evlist__for_each_entry(evlist, evsel) {
 		if (nr_events[evsel->idx] != expected_nr_events[evsel->idx]) {
-- 
2.4.11
