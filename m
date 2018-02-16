Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932735AbeBPJvH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:51:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58853 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932472AbeBPJvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:51:03 -0500
Date: Fri, 16 Feb 2018 01:36:21 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-189f2cc91f9f2efef5d5f4dde43684c01b5f6f2f@git.kernel.org>
Cc: acme@redhat.com, mingo@kernel.org, ak@linux.intel.com,
        tglx@linutronix.de, kan.liang@intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        hpa@zytor.com, peterz@infradead.org, yao.jin@linux.intel.com
Reply-To: acme@redhat.com, mingo@kernel.org, ak@linux.intel.com,
        tglx@linutronix.de, kan.liang@intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, wangnan0@huawei.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <1516310792-208685-6-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-6-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mmap: Add new return value logic for
 perf_mmap__read_init()
Git-Commit-ID: 189f2cc91f9f2efef5d5f4dde43684c01b5f6f2f
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

Commit-ID:  189f2cc91f9f2efef5d5f4dde43684c01b5f6f2f
Gitweb:     https://git.kernel.org/tip/189f2cc91f9f2efef5d5f4dde43684c01b5f6f2f
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:20 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:52:49 -0300

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
 
