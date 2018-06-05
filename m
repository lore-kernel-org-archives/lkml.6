Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeFEVov (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:44:51 -0400
Received: from foss.arm.com ([217.140.101.70]:34420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeFEVor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:44:47 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 01/20] coresight: Fix memory leak in coresight_register
Date: Tue,  5 Jun 2018 22:43:12 +0100
Message-Id: <1528235011-30691-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 6403587a930c ("coresight: use put_device() instead of kfree()")
introduced a memory leak where, if we fail to register the device
for coresight_device, we don't free the "coresight_device" object,
which was allocated via kzalloc(). Fix this by jumping to the
appropriate error path.

Fixes: commit 6403587a930c ("coresight: use put_device() instead of kfree()")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 4969b32..2893cfe 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1020,7 +1020,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	ret = device_register(&csdev->dev);
 	if (ret) {
 		put_device(&csdev->dev);
-		goto err_kzalloc_csdev;
+		goto err_kzalloc_refcnts;
 	}
 
 	mutex_lock(&coresight_mutex);
-- 
2.7.4
