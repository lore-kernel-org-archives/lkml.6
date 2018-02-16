Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932600AbeBPJt5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:49:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49871 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbeBPJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:49:55 -0500
Date: Fri, 16 Feb 2018 01:34:26 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-6888ff66c44ffa3077ed69e978902d0ff4b84ae1@git.kernel.org>
Cc: kan.liang@intel.com, namhyung@kernel.org, hpa@zytor.com,
        peterz@infradead.org, mingo@kernel.org, yao.jin@linux.intel.com,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, wangnan0@huawei.com, acme@redhat.com
Reply-To: yao.jin@linux.intel.com, kan.liang@intel.com, namhyung@kernel.org,
        mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
        wangnan0@huawei.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, jolsa@kernel.org, tglx@linutronix.de
In-Reply-To: <1516310792-208685-2-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-2-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evlist: Remove stale mmap read for backward
Git-Commit-ID: 6888ff66c44ffa3077ed69e978902d0ff4b84ae1
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

Commit-ID:  6888ff66c44ffa3077ed69e978902d0ff4b84ae1
Gitweb:     https://git.kernel.org/tip/6888ff66c44ffa3077ed69e978902d0ff4b84ae1
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:16 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:50:53 -0300

perf evlist: Remove stale mmap read for backward

perf_evlist__mmap_read_catchup() and perf_evlist__mmap_read_backward()
are only for overwrite mode.

But they read the evlist->mmap buffer which is for non-overwrite mode.

It did not bring any serious problem yet, because there is no one use
it.

Remove the unused interfaces.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Wang Nan <wangnan0@huawei.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1516310792-208685-2-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 17 -----------------
 tools/perf/util/evlist.h |  4 ----
 2 files changed, 21 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ac35cd2..e5fc14e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -715,28 +715,11 @@ union perf_event *perf_evlist__mmap_read_forward(struct perf_evlist *evlist, int
 	return perf_mmap__read_forward(md);
 }
 
-union perf_event *perf_evlist__mmap_read_backward(struct perf_evlist *evlist, int idx)
-{
-	struct perf_mmap *md = &evlist->mmap[idx];
-
-	/*
-	 * No need to check messup for backward ring buffer:
-	 * We can always read arbitrary long data from a backward
-	 * ring buffer unless we forget to pause it before reading.
-	 */
-	return perf_mmap__read_backward(md);
-}
-
 union perf_event *perf_evlist__mmap_read(struct perf_evlist *evlist, int idx)
 {
 	return perf_evlist__mmap_read_forward(evlist, idx);
 }
 
-void perf_evlist__mmap_read_catchup(struct perf_evlist *evlist, int idx)
-{
-	perf_mmap__read_catchup(&evlist->mmap[idx]);
-}
-
 void perf_evlist__mmap_consume(struct perf_evlist *evlist, int idx)
 {
 	perf_mmap__consume(&evlist->mmap[idx], false);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 75f8e0a..336b838 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -133,10 +133,6 @@ union perf_event *perf_evlist__mmap_read(struct perf_evlist *evlist, int idx);
 
 union perf_event *perf_evlist__mmap_read_forward(struct perf_evlist *evlist,
 						 int idx);
-union perf_event *perf_evlist__mmap_read_backward(struct perf_evlist *evlist,
-						  int idx);
-void perf_evlist__mmap_read_catchup(struct perf_evlist *evlist, int idx);
-
 void perf_evlist__mmap_consume(struct perf_evlist *evlist, int idx);
 
 int perf_evlist__open(struct perf_evlist *evlist);
