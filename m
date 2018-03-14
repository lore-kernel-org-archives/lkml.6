Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCNRL2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:11:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48465 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751449AbeCNRL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:11:27 -0400
From: John Garry <john.garry@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>, <wcohen@redhat.com>,
        <sukadev@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] perf vendor events: fix processing for xfs
Date: Thu, 15 Mar 2018 01:10:52 +0800
Message-ID: <1521047452-28565-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the recently introduced support for vendor subdirectory,
the checking for directory entries under xfs (or any other fs
which does not support dirent.d_type) is missing the check
for links for current and parent directory. This can result
in a broken pmu_events.c being generated.

Fix this by adding the appropriate check in is_leaf_dir().

Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 1c01844..db3a594 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -873,7 +873,10 @@ static int is_leaf_dir(const char *fpath)
 		return 0;
 
 	while ((dir = readdir(d)) != NULL) {
-		if (dir->d_type == DT_DIR && dir->d_name[0] != '.') {
+		if (!strcmp(dir->d_name, ".") || !strcmp(dir->d_name, ".."))
+			continue;
+
+		if (dir->d_type == DT_DIR) {
 			res = 0;
 			break;
 		} else if (dir->d_type == DT_UNKNOWN) {
-- 
1.9.1
