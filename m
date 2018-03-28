Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeC1Stm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753407AbeC1Sti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:49:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876E721836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 3/8] perf mmap: Be consistent when checking for an unmaped ring buffer
Date: Wed, 28 Mar 2018 15:49:14 -0300
Message-Id: <20180328184919.32287-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180328184919.32287-1-acme@kernel.org>
References: <20180328184919.32287-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The previous patch is insufficient to cure the reported 'perf trace'
segfault, as it only cures the perf_mmap__read_done() case, moving the
segfault to perf_mmap__read_init() functio, fix it by doing the same
refcount check.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 8872481bd048 ("perf mmap: Introduce perf_mmap__read_init()")
Link: https://lkml.kernel.org/r/20180326144127.GF18897@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index f6cfc52ff1fe..fc832676a798 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -234,7 +234,7 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
 /*
  * Report the start and end of the available data in ringbuffer
  */
-int perf_mmap__read_init(struct perf_mmap *md)
+static int __perf_mmap__read_init(struct perf_mmap *md)
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 old = md->prev;
@@ -268,6 +268,17 @@ int perf_mmap__read_init(struct perf_mmap *md)
 	return 0;
 }
 
+int perf_mmap__read_init(struct perf_mmap *map)
+{
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return -ENOENT;
+
+	return __perf_mmap__read_init(map);
+}
+
 int perf_mmap__push(struct perf_mmap *md, void *to,
 		    int push(void *to, void *buf, size_t size))
 {
-- 
2.14.3
