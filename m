Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7286BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBBB21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNj0nIuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBBB21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbeKPDyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:54:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45346 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeKPDyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:54:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id v6so278543wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7mFBLtR5NCuK1acH7SmQqwojPNJoa/6zGwgaHNyGl0=;
        b=GNj0nIuvKAIf65HoVclCUVVSydu9MU05sKa3HF4fJ3t1NIZnh2HE1FJo9OFovHqxfl
         FWObvDsbUq96+KPduazm777pyE+4nBvWNRc3IREXkviyxsOKqGLZtNeNuPsQRoENRW4K
         1qfu8Z0z7M+LZSjLemphYlEs+fGyKXBaS+DaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7mFBLtR5NCuK1acH7SmQqwojPNJoa/6zGwgaHNyGl0=;
        b=Mmn3PKu89DxK5fUYZsM90fU3cWEeZmpW9ELOw6cczn16jkRyKNaqstosq3JjEXrT2u
         XnqbpuokRoMrHgHL8g7yueX5VZwOpCnffTglEdsQ6rgyR44m/8OTurucar6LyT1Yv2Rd
         TVB7tYjOnpSJTxGVNKUDiI++BCgkeB7Hg83hOGxBryNtQx7LBWShWe1/+p4tTjKr9Jxn
         1tiVJcztW3wFoWJFpAQbG7YPF++j0AqfNPEs11IFEGVn8Cn7JYVIoEGih3Qf4Lb3/cx/
         SXM0UlQQ8HMLu5VaxX/7wpQRrBtI3mAm+sZhdyLkDUd2WvXdmx22uRY4sBUPXSdJwH1X
         S8Bw==
X-Gm-Message-State: AGRZ1gIuIpPM5l2wwpp5cPOvlvMIZc33j32AybYDFhOx294kN6bmg0lz
        4daMRIeea9rdE3sPhdplE6BVbA==
X-Google-Smtp-Source: AJdET5cACGltDGqGJv5/GP/+1gB25qr7Xn911kkRTGIixYFTmtWxSrJFuO4WyCnhtziHEzc9uBRcLw==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr6751562wrx.171.1542303947259;
        Thu, 15 Nov 2018 09:45:47 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 6-v6sm18776168wra.35.2018.11.15.09.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 09:45:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     amit.kucheria@linaro.org, edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] thermal: tsens: qcom: do not create duplicate regmap debugfs entries
Date:   Thu, 15 Nov 2018 17:43:30 +0000
Message-Id: <20181115174330.15224-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regmap would use device name to create debugfs entries. If the device
has multiple regmaps it is recommended to use name field in regmap_config.
Fix this by providing name to the regmap configs correctly.

Without this patch we would see below error on DB820c.

qcom-tsens 4a9000.thermal-sensor: Failed to create 4a9000.thermal-sensor
debugfs directory

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 3be4be2e0465..78652cac7f3d 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -114,6 +114,14 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 }
 
 static const struct regmap_config tsens_config = {
+	.name		= "tm",
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+};
+
+static const struct regmap_config tsens_srot_config = {
+	.name		= "srot",
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
@@ -139,8 +147,8 @@ int __init init_common(struct tsens_device *tmdev)
 		if (IS_ERR(srot_base))
 			return PTR_ERR(srot_base);
 
-		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev,
-							srot_base, &tsens_config);
+		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev, srot_base,
+							&tsens_srot_config);
 		if (IS_ERR(tmdev->srot_map))
 			return PTR_ERR(tmdev->srot_map);
 
-- 
2.19.1

