Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935206AbeBMMQe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:16:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59827 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934944AbeBMMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:16:32 -0500
Date: Tue, 13 Feb 2018 04:06:05 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-e0c75323e9f7002d84abbf68650277a6d971b3c0@git.kernel.org>
Cc: hpa@zytor.com, kan.liang@intel.com, jolsa@kernel.org,
        yao.jin@linux.intel.com, peterz@infradead.org, wangnan0@huawei.com,
        mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, tglx@linutronix.de, namhyung@kernel.org
Reply-To: ak@linux.intel.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, wangnan0@huawei.com, acme@redhat.com,
        jolsa@kernel.org, yao.jin@linux.intel.com, hpa@zytor.com,
        kan.liang@intel.com
In-Reply-To: <1516310792-208685-6-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-6-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mmap: Add new return value logic for
 perf_mmap__read_init()
Git-Commit-ID: e0c75323e9f7002d84abbf68650277a6d971b3c0
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

Commit-ID:  e0c75323e9f7002d84abbf68650277a6d971b3c0
Gitweb:     https://git.kernel.org/tip/e0c75323e9f7002d84abbf68650277a6d971b3c0
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:20 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:49 -0300

perf mmap: Add new return value logic for perf_mmap__read_init()

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
index c19a4e6..38fa69d 100644
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
 
