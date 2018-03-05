Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbeCETMb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:12:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:47640 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753051AbeCETM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:12:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="23109063"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/7] perf mmap: Using the stored scope data in perf_mmap__push
Date: Mon,  5 Mar 2018 14:10:54 -0500
Message-Id: <1520277059-32749-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
References: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Using the 'start' and 'end' which are stored in struct perf_mmap to
replace the temporary 'start' and 'end'.
The temporary variables will be discarded later.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/mmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 642b479..4cb3614 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -294,12 +294,12 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 	if (rc < 0)
 		return (rc == -EAGAIN) ? 0 : -1;
 
-	size = end - start;
+	size = md->end - md->start;
 
-	if ((start & md->mask) + size != (end & md->mask)) {
-		buf = &data[start & md->mask];
-		size = md->mask + 1 - (start & md->mask);
-		start += size;
+	if ((md->start & md->mask) + size != (md->end & md->mask)) {
+		buf = &data[md->start & md->mask];
+		size = md->mask + 1 - (md->start & md->mask);
+		md->start += size;
 
 		if (push(to, buf, size) < 0) {
 			rc = -1;
@@ -307,9 +307,9 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 		}
 	}
 
-	buf = &data[start & md->mask];
-	size = end - start;
-	start += size;
+	buf = &data[md->start & md->mask];
+	size = md->end - md->start;
+	md->start += size;
 
 	if (push(to, buf, size) < 0) {
 		rc = -1;
-- 
2.4.11
