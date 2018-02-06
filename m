Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753090AbeBFQ4R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752910AbeBFQyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B322172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/21] perf mmap: Introduce perf_mmap__read_done()
Date: Tue,  6 Feb 2018 13:53:37 -0300
Message-Id: <20180206165350.2570-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

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
index 125bfda9d037..4f59eaefc706 100644
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
index 9ab2b48df65b..95549d4af943 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -96,4 +96,5 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
 int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 			 u64 *startp, u64 *endp);
+void perf_mmap__read_done(struct perf_mmap *map);
 #endif /*__PERF_MMAP_H */
-- 
2.14.3
