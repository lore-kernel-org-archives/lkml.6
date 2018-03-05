Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932126AbeCEOdH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:33:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbeCEObH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:31:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3CC21770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/28] perf test: Switch to new perf_mmap__read_event() interface for mmap-basic
Date: Mon,  5 Mar 2018 11:29:25 -0300
Message-Id: <20180305142932.16921-22-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 'mmap-basic' still use the legacy interface.

No functional change.

Committer notes:

Testing it:

  # perf test "mmap interface"
   4: Read samples using the mmap interface                 : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-7-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/mmap-basic.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index c0e971da965c..44c58d69cd87 100644
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
+	if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		goto out_init;
+
+	while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 		struct perf_sample sample;
 
 		if (event->header.type != PERF_RECORD_SAMPLE) {
@@ -129,9 +135,11 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 			goto out_delete_evlist;
 		}
 		nr_events[evsel->idx]++;
-		perf_evlist__mmap_consume(evlist, 0);
+		perf_mmap__consume(md, false);
 	}
+	perf_mmap__read_done(md);
 
+out_init:
 	err = 0;
 	evlist__for_each_entry(evlist, evsel) {
 		if (nr_events[evsel->idx] != expected_nr_events[evsel->idx]) {
-- 
2.14.3
