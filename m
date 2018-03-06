Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeCFGt4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:49:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37287 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbeCFGtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:49:55 -0500
Date: Mon, 5 Mar 2018 22:49:46 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-334f823e2ab58b3c0e58fa71321680382c5f60ff@git.kernel.org>
Cc: ak@linux.intel.com, acme@redhat.com, tglx@linutronix.de,
        namhyung@kernel.org, wangnan0@huawei.com, kan.liang@linux.intel.com,
        mingo@kernel.org, hpa@zytor.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        wangnan0@huawei.com, namhyung@kernel.org, tglx@linutronix.de,
        acme@redhat.com, ak@linux.intel.com
In-Reply-To: <1519945751-37786-7-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-7-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Switch to new perf_mmap__read_event()
 interface for mmap-basic
Git-Commit-ID: 334f823e2ab58b3c0e58fa71321680382c5f60ff
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

Commit-ID:  334f823e2ab58b3c0e58fa71321680382c5f60ff
Gitweb:     https://git.kernel.org/tip/334f823e2ab58b3c0e58fa71321680382c5f60ff
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:04 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:49:37 -0300

perf test: Switch to new perf_mmap__read_event() interface for mmap-basic

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
