Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD86C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E7520892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSh4XoBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E7520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbeLFJjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:39:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52746 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeLFJjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:39:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so271361wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d1+BTdxj2KV5OgO7Eh6W4io7PjLKDST3CdGEejtC8Ek=;
        b=dSh4XoBP8vXWpfC9HCta3u+XGs3mBkgTnmWZxZ29DeeQ4ctzubRlMVn4ewPLPdbVju
         8oVHRcbDYqNytGck5LGb18FLlAzgBHpRrekM/paGu/hpCS2tXWUFi2Nf5YtkqqxfkSsk
         zE+5QUZV22v9hBI7LZ9M7XxTk1YPzt6fLmHaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d1+BTdxj2KV5OgO7Eh6W4io7PjLKDST3CdGEejtC8Ek=;
        b=slzgSW+WOph/yxXN2UcpUAb2KRUHkRgV32os0fYEwrsAvRc5kRAzZeGrYivFK8JGke
         U/hgQdSZUpECADFHJ7BNEOBcPhZX406vvTCz/fMxPAPlLzG0w66DoyyjC55AaE9Ng1OJ
         SoHgtiMUdHvLfs/PFqhZ8FIG9hBw56aZ1eHnQqdonFzbk6w0tzsn38HHT5qTHRrv4u5n
         qCz3EUbwijEZruKKkv6/ga9aYyRJZwMBAyNwepAtMlWFpUnrHHX4U8Sn7vg5QxM9ajHn
         syY77n8raKga8KcBPH+p/SrgxGoaXumcXQTyf5f8jQZ4rV+8/gFDXWYRHm1lELS3MlNK
         4b3Q==
X-Gm-Message-State: AA+aEWbuRsSj1ALjhB70Y58bBoRKyXifL9egauIQx8mG4PxZzS/3qC6p
        H8o11UJnVBpdHJQhJCq0WO2OJA==
X-Google-Smtp-Source: AFSGD/W/39Muwb1Br8jLL2DVpYMQotDzUpQyipo9NcNjuElD3RzP0+oVW6/i36ia5VdZqqwOPQoOdw==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr14769713wmf.17.1544089161511;
        Thu, 06 Dec 2018 01:39:21 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id o81sm378003wmd.10.2018.12.06.01.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 01:39:20 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     amit.kucheria@linaro.org, edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] thermal: tsens: qcom: do not create duplicate regmap debugfs entries
Date:   Thu,  6 Dec 2018 09:39:17 +0000
Message-Id: <20181206093917.26610-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
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
Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
---
Changes since v1:
 -rename tsens_config to tsens_tm_config as suggested by Amit.

 drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 3be4be2e0465..ddfdf88ffb4e 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -113,7 +113,15 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 	return 0;
 }
 
-static const struct regmap_config tsens_config = {
+static const struct regmap_config tsens_tm_config = {
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
 
@@ -154,7 +162,8 @@ int __init init_common(struct tsens_device *tmdev)
 	if (IS_ERR(tm_base))
 		return PTR_ERR(tm_base);
 
-	tmdev->tm_map = devm_regmap_init_mmio(tmdev->dev, tm_base, &tsens_config);
+	tmdev->tm_map = devm_regmap_init_mmio(tmdev->dev, tm_base,
+						 &tsens_tm_config);
 	if (IS_ERR(tmdev->tm_map))
 		return PTR_ERR(tmdev->tm_map);
 
-- 
2.19.2

