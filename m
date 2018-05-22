Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeEVLjQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:39:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50894 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751624AbeEVLjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:39:10 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sagar Dharia <sdharia@codeaurora.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] slimbus: qcom: fix potential NULL dereference in qcom_slim_prg_slew()
Date: Tue, 22 May 2018 11:46:22 +0000
Message-ID: <1526989582-139939-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource() may fail and return NULL, so we should
better check it's return value to avoid a NULL pointer dereference
a bit later in the code.

This is detected by Coccinelle semantic patch.

@@
expression pdev, res, n, t, e, e1, e2;
@@

res = platform_get_resource_byname(pdev, t, n);
+ if (!res)
+   return -EINVAL;
... when != res == NULL
e = devm_ioremap(e1, res->start, e2);

Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/slimbus/qcom-ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index bb36a8f..caea3b9 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -478,6 +478,8 @@ static void qcom_slim_prg_slew(struct platform_device *pdev,
 		/* SLEW RATE register for this SLIMbus */
 		slew_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 				"slew");
+		if (!slew_mem)
+			return;
 		ctrl->slew_reg = devm_ioremap(&pdev->dev, slew_mem->start,
 				resource_size(slew_mem));
 		if (!ctrl->slew_reg)
