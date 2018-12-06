Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E476C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E385D20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v5+KvSv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E385D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLFRiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:38:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51542 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:38:03 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB6Hc1U2068282;
        Thu, 6 Dec 2018 11:38:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544117881;
        bh=Jpu3/AQCVr4DWpZM5faVa/Dqz+ceehuhmq6rNL/6+ls=;
        h=From:To:CC:Subject:Date;
        b=v5+KvSv8Q+HyGprJPPPLzRtdFTJqCiDYfsH+mRfCBBF3kSFYZW8APItmXRJwxv9Ew
         AlY9LuyYy2BTrXvJqqY299f/uK+2tBckDUcbh6f9dbfb7MKaD6Qp396NUvAsWFLTJ6
         rDuQxMRqafinThwO+1qhMEJ/Wu/SvSweCXkCwy6M=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB6Hc1cu035432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Dec 2018 11:38:01 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 6
 Dec 2018 11:38:00 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 6 Dec 2018 11:38:00 -0600
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB6Hbwxe011678;
        Thu, 6 Dec 2018 11:37:58 -0600
From:   Keerthy <j-keerthy@ti.com>
To:     <tony@atomide.com>, <lee.jones@linaro.org>
CC:     <t-kristo@ti.com>, <j-keerthy@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: tps65218: Use devm_regmap_add_irq_chip and clean up error path in probe
Date:   Thu, 6 Dec 2018 23:07:44 +0530
Message-ID: <1544117864-28276-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_regmap_add_irq_chip and clean up error path in probe.

Reported-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Boot tested on am437x-gp-evm.

 drivers/mfd/tps65218.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 910f569..2383621 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -235,9 +235,9 @@ static int tps65218_probe(struct i2c_client *client,
 
 	mutex_init(&tps->tps_lock);
 
-	ret = regmap_add_irq_chip(tps->regmap, tps->irq,
-			IRQF_ONESHOT, 0, &tps65218_irq_chip,
-			&tps->irq_data);
+	ret = devm_regmap_add_irq_chip(&client->dev, tps->regmap, tps->irq,
+				       IRQF_ONESHOT, 0, &tps65218_irq_chip,
+				       &tps->irq_data);
 	if (ret < 0)
 		return ret;
 
@@ -253,14 +253,6 @@ static int tps65218_probe(struct i2c_client *client,
 			      ARRAY_SIZE(tps65218_cells), NULL, 0,
 			      regmap_irq_get_domain(tps->irq_data));
 
-	if (ret < 0)
-		goto err_irq;
-
-	return 0;
-
-err_irq:
-	regmap_del_irq_chip(tps->irq, tps->irq_data);
-
 	return ret;
 }
 
-- 
1.9.1

