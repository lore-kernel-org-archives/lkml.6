Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45889222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbfBMGbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:31:37 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:48354 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbfBMGbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:31:37 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id D9C8AA435C341448DB2E;
        Wed, 13 Feb 2019 14:31:33 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1D6VU0J039236;
        Wed, 13 Feb 2019 14:31:30 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021314315216-25843176 ;
          Wed, 13 Feb 2019 14:31:52 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     amit.kucheria@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  thermal/qcom/tsens-common : fix possible object reference leak
Date:   Wed, 13 Feb 2019 22:53:29 +0800
Message-Id: <1550069609-85581-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-13 14:31:52,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-13 14:31:22,
        Serialize complete at 2019-02-13 14:31:22
X-MAIL: mse01.zte.com.cn x1D6VU0J039236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_device_by_node() takes a reference to the struct device
when it finds a match via get_device.
We also should make sure to drop the reference to the device
taken by of_find_device_by_node() when returning error.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/thermal/qcom/tsens-common.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 78652ca..f80c73f 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -144,13 +144,17 @@ int __init init_common(struct tsens_device *tmdev)
 		tmdev->tm_offset = 0;
 		res = platform_get_resource(op, IORESOURCE_MEM, 1);
 		srot_base = devm_ioremap_resource(&op->dev, res);
-		if (IS_ERR(srot_base))
-			return PTR_ERR(srot_base);
+		if (IS_ERR(srot_base)) {
+			ret = PTR_ERR(srot_base);
+			goto err_put_device;
+		}
 
 		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev, srot_base,
 							&tsens_srot_config);
-		if (IS_ERR(tmdev->srot_map))
-			return PTR_ERR(tmdev->srot_map);
+		if (IS_ERR(tmdev->srot_map)) {
+			ret = PTR_ERR(tmdev->srot_map);
+			goto err_put_device;
+		}
 
 	} else {
 		/* old DTs where SROT and TM were in a contiguous 2K block */
@@ -159,22 +163,31 @@ int __init init_common(struct tsens_device *tmdev)
 
 	res = platform_get_resource(op, IORESOURCE_MEM, 0);
 	tm_base = devm_ioremap_resource(&op->dev, res);
-	if (IS_ERR(tm_base))
-		return PTR_ERR(tm_base);
+	if (IS_ERR(tm_base)) {
+		ret = PTR_ERR(tm_base);
+		goto err_put_device;
+	}
 
 	tmdev->tm_map = devm_regmap_init_mmio(tmdev->dev, tm_base, &tsens_config);
-	if (IS_ERR(tmdev->tm_map))
-		return PTR_ERR(tmdev->tm_map);
+	if (IS_ERR(tmdev->tm_map)) {
+		ret = PTR_ERR(tmdev->tm_map);
+		goto err_put_device;
+	}
 
 	if (tmdev->srot_map) {
 		ret = regmap_read(tmdev->srot_map, ctrl_offset, &code);
 		if (ret)
-			return ret;
+			goto err_put_device;
 		if (!(code & TSENS_EN)) {
 			dev_err(tmdev->dev, "tsens device is not enabled\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_put_device;
 		}
 	}
 
 	return 0;
+
+err_put_device:
+	put_device(&op->dev);
+	return ret;
 }
-- 
1.8.3.1

