Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932977AbeBPJxE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:53:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35803 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932690AbeBPJxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:53:02 -0500
Date: Fri, 16 Feb 2018 01:37:18 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-ee023de05f35484691f7d9e5c1f92195ac4d64d2@git.kernel.org>
Cc: jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, ak@linux.intel.com, acme@redhat.com,
        wangnan0@huawei.com, kan.liang@intel.com, yao.jin@linux.intel.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, ak@linux.intel.com, acme@redhat.com,
        wangnan0@huawei.com, kan.liang@intel.com, yao.jin@linux.intel.com
In-Reply-To: <1516310792-208685-8-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-8-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mmap: Introduce perf_mmap__read_done()
Git-Commit-ID: ee023de05f35484691f7d9e5c1f92195ac4d64d2
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

Commit-ID:  ee023de05f35484691f7d9e5c1f92195ac4d64d2
Gitweb:     https://git.kernel.org/tip/ee023de05f35484691f7d9e5c1f92195ac4d64d2
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:22 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:53:15 -0300

perf mmap: Introduce perf_mmap__read_done()

The direction of overwrite mode is backward. The last perf_mmap__read()
will set tail to map->prev. Need to correct the map->prev to head which
is the end of next read.

It will be used later.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-8-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 11 +++++++++++
 tools/perf/util/mmap.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 125bfda..4f59eae 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -338,3 +338,14 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 out:
 	return rc;
 }
+
+/*
+ * Mandatory for overwrite mode
+ * The direction of overwrite mode is backward.
+ * The last perf_mmap__read() will set tail to map->prev.
+ * Need to correct the map->prev to head which is the end of next read.
+ */
+void perf_mmap__read_done(struct perf_mmap *map)
+{
+	map->prev = perf_mmap__read_head(map);
+}
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 9ab2b48..95549d4 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -96,4 +96,5 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
 int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 			 u64 *startp, u64 *endp);
+void perf_mmap__read_done(struct perf_mmap *map);
 #endif /*__PERF_MMAP_H */
