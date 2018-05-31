Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754788AbeEaLWo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:22:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754598AbeEaLWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:38 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Stuart Yoder" <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 07/21] bus: fsl-mc: use match_string() helper
Date: Thu, 31 May 2018 19:11:12 +0800
Message-ID: <1527765086-19873-8-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - add Reviewed-by tag.

 drivers/bus/fsl-mc/fsl-mc-allocator.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index fb1442b..63c4735 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -156,22 +156,6 @@ static int __must_check fsl_mc_resource_pool_remove_device(struct fsl_mc_device
 	[FSL_MC_POOL_IRQ] = "irq",
 };
 
-static int __must_check object_type_to_pool_type(const char *object_type,
-						 enum fsl_mc_pool_type
-								*pool_type)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(fsl_mc_pool_type_strings); i++) {
-		if (strcmp(object_type, fsl_mc_pool_type_strings[i]) == 0) {
-			*pool_type = i;
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-
 int __must_check fsl_mc_resource_allocate(struct fsl_mc_bus *mc_bus,
 					  enum fsl_mc_pool_type pool_type,
 					  struct fsl_mc_resource **new_resource)
@@ -581,9 +565,11 @@ static int fsl_mc_allocator_probe(struct fsl_mc_device *mc_dev)
 		return -EINVAL;
 
 	mc_bus = to_fsl_mc_bus(mc_bus_dev);
-	error = object_type_to_pool_type(mc_dev->obj_desc.type, &pool_type);
-	if (error < 0)
-		return error;
+	pool_type = match_string(fsl_mc_pool_type_strings,
+				 ARRAY_SIZE(fsl_mc_pool_type_strings),
+				 mc_dev->obj_desc.type);
+	if (pool_type < 0)
+		return pool_type;
 
 	error = fsl_mc_resource_pool_add_device(mc_bus, pool_type, mc_dev);
 	if (error < 0)
-- 
1.7.12.4
