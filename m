Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeEPJ0A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:26:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751904AbeEPJZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:25:58 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <alexander.shishkin@linux.intel.com>
CC: <heikki.krogerus@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        "Yisheng Xie" <xieyisheng1@huawei.com>
Subject: [PATCH] intel_th: pti: Convert to use sysfs_match_string() helper
Date: Wed, 16 May 2018 17:15:16 +0800
Message-ID: <1526462116-10894-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper returns index of the matching string in an array,
use it to simpler the code.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/hwtracing/intel_th/pti.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/intel_th/pti.c b/drivers/hwtracing/intel_th/pti.c
index 5669433..75cb368 100644
--- a/drivers/hwtracing/intel_th/pti.c
+++ b/drivers/hwtracing/intel_th/pti.c
@@ -272,15 +272,12 @@ static ssize_t lpp_dest_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t size)
 {
 	struct pti_device *pti = dev_get_drvdata(dev);
-	ssize_t ret = -EINVAL;
-	int i;
+	ssize_t ret;
 
-	for (i = 0; i < ARRAY_SIZE(lpp_dest_str); i++)
-		if (sysfs_streq(buf, lpp_dest_str[i]))
-			break;
+	ret = sysfs_match_string(lpp_dest_str, buf);
 
-	if (i < ARRAY_SIZE(lpp_dest_str) && pti->lpp_dest_mask & BIT(i)) {
-		pti->lpp_dest = i;
+	if (ret >= 0 && pti->lpp_dest_mask & BIT(ret)) {
+		pti->lpp_dest = ret;
 		ret = size;
 	}
 
-- 
1.7.12.4
