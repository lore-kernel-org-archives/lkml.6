Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeECRt6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:49:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:39809 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbeECRtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:49:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="46545133"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Parav Pandit <pandit.parav@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] rdmacg: Convert to use match_string() helper
Date: Thu,  3 May 2018 20:49:52 +0300
Message-Id: <20180503174952.21480-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new helper returns index of the matching string in an array.
We are going to use it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/cgroup/rdma.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index defad3c5e7dc..29697d2d0e85 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -362,10 +362,9 @@ EXPORT_SYMBOL(rdmacg_unregister_device);
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
@@ -373,24 +372,22 @@ static int parse_resource(char *c, int *intval)
 
 	len = strlen(value);
 
-	for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
-		if (strcmp(table[i], name))
-			continue;
+	i = match_string(rdmacg_resource_names, RDMACG_RESOURCE_MAX, name);
+	if (i < 0)
+		return i;
 
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
+			break;
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
