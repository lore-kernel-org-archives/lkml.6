Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeBFRE7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752721AbeBFQyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015DF217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/21] perf mmap: Add new return value logic for perf_mmap__read_init()
Date: Tue,  6 Feb 2018 13:53:35 -0300
Message-Id: <20180206165350.2570-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Improve the readability by using meaningful enum (-EAGAIN, -EINVAL and
0) to replace the three returning states (0, -1 and 1).

Suggested-by: Wang Nan <wangnan0@huawei.com>
Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-6-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index c19a4e640e8e..38fa69dc635e 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -282,7 +282,7 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 	*endp = overwrite ? old : head;
 
 	if (*startp == *endp)
-		return 0;
+		return -EAGAIN;
 
 	size = *endp - *startp;
 	if (size > (unsigned long)(md->mask) + 1) {
@@ -291,7 +291,7 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 
 			md->prev = head;
 			perf_mmap__consume(md, overwrite);
-			return 0;
+			return -EAGAIN;
 		}
 
 		/*
@@ -299,10 +299,10 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 		 * most of data from it.
 		 */
 		if (overwrite_rb_find_range(data, md->mask, head, startp, endp))
-			return -1;
+			return -EINVAL;
 	}
 
-	return 1;
+	return 0;
 }
 
 int perf_mmap__push(struct perf_mmap *md, bool overwrite,
@@ -316,8 +316,8 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 	int rc = 0;
 
 	rc = perf_mmap__read_init(md, overwrite, &start, &end);
-	if (rc < 1)
-		return rc;
+	if (rc < 0)
+		return (rc == -EAGAIN) ? 0 : -1;
 
 	size = end - start;
 
-- 
2.14.3
