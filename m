Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeEDTT2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:19:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:3276 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeEDTT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:19:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,363,1520924400";
   d="scan'208";a="225884317"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] intel_th: pti: Use sysfs_match_string() helper
Date: Fri,  4 May 2018 22:19:25 +0300
Message-Id: <20180504191925.74759-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysfs_match_string() helper instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/pti.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/intel_th/pti.c b/drivers/hwtracing/intel_th/pti.c
index 56694339cb06..0da6b787f553 100644
--- a/drivers/hwtracing/intel_th/pti.c
+++ b/drivers/hwtracing/intel_th/pti.c
@@ -272,19 +272,17 @@ static ssize_t lpp_dest_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t size)
 {
 	struct pti_device *pti = dev_get_drvdata(dev);
-	ssize_t ret = -EINVAL;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(lpp_dest_str); i++)
-		if (sysfs_streq(buf, lpp_dest_str[i]))
-			break;
+	i = sysfs_match_string(lpp_dest_str, buf);
+	if (i < 0)
+		return i;
 
-	if (i < ARRAY_SIZE(lpp_dest_str) && pti->lpp_dest_mask & BIT(i)) {
-		pti->lpp_dest = i;
-		ret = size;
-	}
+	if (!(pti->lpp_dest_mask & BIT(i)))
+		return -EINVAL;
 
-	return ret;
+	pti->lpp_dest = i;
+	return size;
 }
 
 static DEVICE_ATTR_RW(lpp_dest);
-- 
2.17.0
