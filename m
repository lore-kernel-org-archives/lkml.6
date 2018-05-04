Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeEDOmV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:42:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:6610 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbeEDOmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:42:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400";
   d="scan'208";a="221642127"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Parav Pandit <pandit.parav@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] rdmacg: Convert to use match_string() helper
Date: Fri,  4 May 2018 17:42:16 +0300
Message-Id: <20180504144216.60262-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new helper returns index of the matching string in an array.
We are going to use it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- fix compile error
 kernel/cgroup/rdma.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index defad3c5e7dc..d3bbb757ee49 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -362,35 +362,32 @@ EXPORT_SYMBOL(rdmacg_unregister_device);
 static int parse_resource(char *c, int *intval)
 {
 	substring_t argstr;
-	const char **table = &rdmacg_resource_names[0];
 	char *name, *value = c;
 	size_t len;
-	int ret, i = 0;
+	int ret, i;
 
 	name = strsep(&value, "=");
 	if (!name || !value)
 		return -EINVAL;
 
-	len = strlen(value);
+	i = match_string(rdmacg_resource_names, RDMACG_RESOURCE_MAX, name);
+	if (i < 0)
+		return i;
 
-	for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
-		if (strcmp(table[i], name))
-			continue;
+	len = strlen(value);
 
-		argstr.from = value;
-		argstr.to = value + len;
+	argstr.from = value;
+	argstr.to = value + len;
 
-		ret = match_int(&argstr, intval);
-		if (ret >= 0) {
-			if (*intval < 0)
-				break;
-			return i;
-		}
-		if (strncmp(value, RDMACG_MAX_STR, len) == 0) {
-			*intval = S32_MAX;
-			return i;
-		}
-		break;
+	ret = match_int(&argstr, intval);
+	if (ret >= 0) {
+		if (*intval < 0)
+			return -EINVAL;
+		return i;
+	}
+	if (strncmp(value, RDMACG_MAX_STR, len) == 0) {
+		*intval = S32_MAX;
+		return i;
 	}
 	return -EINVAL;
 }
-- 
2.17.0
