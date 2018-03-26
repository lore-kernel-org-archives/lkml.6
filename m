Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeCZNnT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:43:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:60240 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751752AbeCZNnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:43:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="214936743"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf mmap: Fix accessing unmapped mmap in perf_mmap__read_done()
Date: Mon, 26 Mar 2018 09:42:09 -0400
Message-Id: <1522071729-16776-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There is segmentation fault when running perf trace. For example,
  [root@jouet e]# perf trace -e *chdir -o /tmp/bla perf report
  --ignore-vmlinux -i ../perf.data

The perf_mmap__consume() could unmap the mmap. It needs to check the
refcnt in perf_mmap__read_done().

Fixes: ee023de05f35 ("perf mmap: Introduce perf_mmap__read_done()")
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/mmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 38ca3ff..f6cfc52 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -317,5 +317,11 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
  */
 void perf_mmap__read_done(struct perf_mmap *map)
 {
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return;
+
 	map->prev = perf_mmap__read_head(map);
 }
-- 
2.4.11
