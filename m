Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAFCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E662821104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXxd/UZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E662821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbeK1D2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:28:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40054 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbeK1D2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:28:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so22795292wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BylX33cS3WT8vpnwLcJYmHJwvcIW8NPYepeh979rT/Y=;
        b=HXxd/UZf9xiZr7kRcIy8dGg03mbzq9Y0S5ROI6V0cbfbyLnE8uzwAxt778JTtSxGMD
         xaZDmbG+03GnnWIw00lzzbLCppDTHoHgQHZ2o3chCxYq+KLslQgr1yCe/glcObDTXk4k
         26exEBMAQqdXy5+K+P3ulENNc2YdxeNK+xyC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BylX33cS3WT8vpnwLcJYmHJwvcIW8NPYepeh979rT/Y=;
        b=IzEpZ5i+4GeyT20NIO+YyVRSwpSJ++jmTYJu4SH+VJnABewyuBYdRbXCyFMaPmFyud
         nnd0Co7Z2qKLBgVuxeVAdhT6HGZHMGp2rVFI/JJStUiOOrng6VmwH8/wDBZEWMEoyJ9c
         VvpMQJyZZ6C3Rb4vSQcVsSf+Efnt7WY9zv+g1iJ1nQUEfc0pYCxpFDWbaU9lBIC0RVhO
         vGbgeDoowoOzV1UY9ok7ZiHU3T/OM73tYwB9k1jBsnrIV8RaZweH50Baymuss1cVYCo/
         P7RXStHTt2y64JIxXIRqc4+eDHaYzsUa96+pp7YD8LDMV4h5KKdHVw8ba6awiqPupDkf
         t3SA==
X-Gm-Message-State: AA+aEWZC1Zbq+CaU8oj4VXM4tV+iixpXi7XpNaMi1MTNF2KwECpxqy7E
        X6SQPKo+ufs6lpdgG4dQDx+YDZvi3L8=
X-Google-Smtp-Source: AFSGD/WeQE3h7F6rvJrRRdO1HU8NjbvIIMroeEaAeDvHgZgwvGdZwxzQfRQKttlkVOTbxFdcksJkbw==
X-Received: by 2002:a1c:cf82:: with SMTP id f124mr21573532wmg.95.1543336181360;
        Tue, 27 Nov 2018 08:29:41 -0800 (PST)
Received: from localhost ([49.248.92.105])
        by smtp.gmail.com with ESMTPSA id j8sm5579490wmd.0.2018.11.27.08.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 08:29:40 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        khasim.mohammed@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v3 2/4] drivers: thermal: tsens: Add generic support for TSENS v1 IP
Date:   Tue, 27 Nov 2018 21:59:05 +0530
Message-Id: <578f79ce10c51bbb7bd6f44395e10a3369a050f4.1543335819.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1543335819.git.amit.kucheria@linaro.org>
References: <cover.1543335819.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1543335819.git.amit.kucheria@linaro.org>
References: <cover.1543335819.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 has a single TSENS IP block with 10 sensors. It uses version 1.4
of the TSENS IP, functionality for which is encapsulated inside
qcom,tsens-v1 compatible.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/thermal/qcom/Makefile       |   2 +-
 drivers/thermal/qcom/tsens-common.c |   2 +-
 drivers/thermal/qcom/tsens-v1.c     | 196 ++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c        |   3 +
 drivers/thermal/qcom/tsens.h        |   3 +-
 5 files changed, 203 insertions(+), 3 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-v1.c

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index a821929ede0b..60269ee90c43 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o tsens-v1.o
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 3be4be2e0465..98f77401bc12 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -76,7 +76,7 @@ void compute_intercept_slope(struct tsens_device *tmdev, u32 *p1,
 	}
 }
 
-static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
+int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 {
 	int degc, num, den;
 
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
new file mode 100644
index 000000000000..1dbf4fde6da8
--- /dev/null
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <linux/regmap.h>
+#include <linux/bitops.h>
+#include "tsens.h"
+
+/* eeprom layout data for qcs404 (v1) */
+#define BASE0_MASK	0x000007f8
+#define BASE1_MASK	0x0007f800
+#define BASE0_SHIFT	3
+#define BASE1_SHIFT	11
+
+#define S0_P1_MASK	0x0000003f
+#define S1_P1_MASK	0x0003f000
+#define S2_P1_MASK	0x3f000000
+#define S3_P1_MASK	0x000003f0
+#define S4_P1_MASK	0x003f0000
+#define S5_P1_MASK	0x0000003f
+#define S6_P1_MASK	0x0003f000
+#define S7_P1_MASK	0x3f000000
+#define S8_P1_MASK	0x000003f0
+#define S9_P1_MASK	0x003f0000
+
+#define S0_P2_MASK	0x00000fc0
+#define S1_P2_MASK	0x00fc0000
+#define S2_P2_MASK_1_0	0xc0000000
+#define S2_P2_MASK_5_2	0x0000000f
+#define S3_P2_MASK	0x0000fc00
+#define S4_P2_MASK	0x0fc00000
+#define S5_P2_MASK	0x00000fc0
+#define S6_P2_MASK	0x00fc0000
+#define S7_P2_MASK_1_0	0xc0000000
+#define S7_P2_MASK_5_2	0x0000000f
+#define S8_P2_MASK	0x0000fc00
+#define S9_P2_MASK	0x0fc00000
+
+#define S0_P1_SHIFT	0
+#define S0_P2_SHIFT	6
+#define S1_P1_SHIFT	12
+#define S1_P2_SHIFT	18
+#define S2_P1_SHIFT	24
+#define S2_P2_SHIFT_1_0	30
+
+#define S2_P2_SHIFT_5_2	0
+#define S3_P1_SHIFT	4
+#define S3_P2_SHIFT	10
+#define S4_P1_SHIFT	16
+#define S4_P2_SHIFT	22
+
+#define S5_P1_SHIFT	0
+#define S5_P2_SHIFT	6
+#define S6_P1_SHIFT	12
+#define S6_P2_SHIFT	18
+#define S7_P1_SHIFT	24
+#define S7_P2_SHIFT_1_0	30
+
+#define S7_P2_SHIFT_5_2	0
+#define S8_P1_SHIFT	4
+#define S8_P2_SHIFT	10
+#define S9_P1_SHIFT	16
+#define S9_P2_SHIFT	22
+
+#define CAL_SEL_MASK	7
+#define CAL_SEL_SHIFT	0
+
+static int calibrate_v1(struct tsens_device *tmdev)
+{
+	u32 base0 = 0, base1 = 0;
+	u32 p1[10], p2[10];
+	u32 mode = 0, lsb = 0, msb = 0;
+	u32 *qfprom_cdata;
+	int i;
+
+	qfprom_cdata = (u32 *)qfprom_read(tmdev->dev, "calib");
+	if (IS_ERR(qfprom_cdata))
+		return PTR_ERR(qfprom_cdata);
+
+	mode = (qfprom_cdata[4] & CAL_SEL_MASK) >> CAL_SEL_SHIFT;
+	dev_dbg(tmdev->dev, "calibration mode is %d\n", mode);
+
+	switch (mode) {
+	case TWO_PT_CALIB:
+		base1 = (qfprom_cdata[4] & BASE1_MASK) >> BASE1_SHIFT;
+		p2[0] = (qfprom_cdata[0] & S0_P2_MASK) >> S0_P2_SHIFT;
+		p2[1] = (qfprom_cdata[0] & S1_P2_MASK) >> S1_P2_SHIFT;
+		/* This value is split over two registers, 2 bits and 4 bits */
+		lsb   = (qfprom_cdata[0] & S2_P2_MASK_1_0) >> S2_P2_SHIFT_1_0;
+		msb   = (qfprom_cdata[1] & S2_P2_MASK_5_2) >> S2_P2_SHIFT_5_2;
+		p2[2] = msb << 2 | lsb;
+		p2[3] = (qfprom_cdata[1] & S3_P2_MASK) >> S3_P2_SHIFT;
+		p2[4] = (qfprom_cdata[1] & S4_P2_MASK) >> S4_P2_SHIFT;
+		p2[5] = (qfprom_cdata[2] & S5_P2_MASK) >> S5_P2_SHIFT;
+		p2[6] = (qfprom_cdata[2] & S6_P2_MASK) >> S6_P2_SHIFT;
+		/* This value is split over two registers, 2 bits and 4 bits */
+		lsb   = (qfprom_cdata[2] & S7_P2_MASK_1_0) >> S7_P2_SHIFT_1_0;
+		msb   = (qfprom_cdata[3] & S7_P2_MASK_5_2) >> S7_P2_SHIFT_5_2;
+		p2[7] = msb << 2 | lsb;
+		p2[8] = (qfprom_cdata[3] & S8_P2_MASK) >> S8_P2_SHIFT;
+		p2[9] = (qfprom_cdata[3] & S9_P2_MASK) >> S9_P2_SHIFT;
+		for (i = 0; i < tmdev->num_sensors; i++)
+			p2[i] = ((base1 + p2[i]) << 2);
+		/* Fall through */
+	case ONE_PT_CALIB2:
+		base0 = (qfprom_cdata[4] & BASE0_MASK) >> BASE0_SHIFT;
+		p1[0] = (qfprom_cdata[0] & S0_P1_MASK) >> S0_P1_SHIFT;
+		p1[1] = (qfprom_cdata[0] & S1_P1_MASK) >> S1_P1_SHIFT;
+		p1[2] = (qfprom_cdata[0] & S2_P1_MASK) >> S2_P1_SHIFT;
+		p1[3] = (qfprom_cdata[1] & S3_P1_MASK) >> S3_P1_SHIFT;
+		p1[4] = (qfprom_cdata[1] & S4_P1_MASK) >> S4_P1_SHIFT;
+		p1[5] = (qfprom_cdata[2] & S5_P1_MASK) >> S5_P1_SHIFT;
+		p1[6] = (qfprom_cdata[2] & S6_P1_MASK) >> S6_P1_SHIFT;
+		p1[7] = (qfprom_cdata[2] & S7_P1_MASK) >> S7_P1_SHIFT;
+		p1[8] = (qfprom_cdata[3] & S8_P1_MASK) >> S8_P1_SHIFT;
+		p1[9] = (qfprom_cdata[3] & S9_P1_MASK) >> S9_P1_SHIFT;
+		for (i = 0; i < tmdev->num_sensors; i++)
+			p1[i] = (((base0) + p1[i]) << 2);
+		break;
+	default:
+		for (i = 0; i < tmdev->num_sensors; i++) {
+			p1[i] = 500;
+			p2[i] = 780;
+		}
+		break;
+	}
+
+	compute_intercept_slope(tmdev, p1, p2, mode);
+
+	return 0;
+}
+
+#define STATUS_OFFSET		0x44
+#define LAST_TEMP_MASK		0x3ff
+#define STATUS_VALID_BIT	BIT(14)
+
+static int get_temp_tsens_v1(struct tsens_device *tmdev, int id, int *temp)
+{
+	struct tsens_sensor *s = &tmdev->sensor[id];
+	u32 code;
+	unsigned int status_reg;
+	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
+	int ret;
+
+	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
+	ret = regmap_read(tmdev->tm_map, status_reg, &code);
+	if (ret)
+		return ret;
+	last_temp = code & LAST_TEMP_MASK;
+	if (code & STATUS_VALID_BIT)
+		goto done;
+
+	/* Try a second time */
+	ret = regmap_read(tmdev->tm_map, status_reg, &code);
+	if (ret)
+		return ret;
+	if (code & STATUS_VALID_BIT) {
+		last_temp = code & LAST_TEMP_MASK;
+		goto done;
+	} else {
+		last_temp2 = code & LAST_TEMP_MASK;
+	}
+
+	/* Try a third/last time */
+	ret = regmap_read(tmdev->tm_map, status_reg, &code);
+	if (ret)
+		return ret;
+	if (code & STATUS_VALID_BIT) {
+		last_temp = code & LAST_TEMP_MASK;
+		goto done;
+	} else {
+		last_temp3 = code & LAST_TEMP_MASK;
+	}
+
+	if (last_temp == last_temp2)
+		last_temp = last_temp2;
+	else if (last_temp2 == last_temp3)
+		last_temp = last_temp3;
+done:
+	/* Convert temperature from ADC code to milliCelsius */
+	*temp = code_to_degc(last_temp, s) * 1000;
+
+	return 0;
+}
+
+static const struct tsens_ops ops_generic_v1 = {
+	.init		= init_common,
+	.calibrate	= calibrate_v1,
+	.get_temp	= get_temp_tsens_v1,
+};
+
+const struct tsens_data data_tsens_v1 = {
+	.ops		= &ops_generic_v1,
+	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index f1ec9bbe4717..d0cc0c09894a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -63,6 +63,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,tsens-v1",
+		.data = &data_tsens_v1,
 	}, {
 		.compatible = "qcom,tsens-v2",
 		.data = &data_tsens_v2,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 7b7feee5dc46..f8dc96c42b94 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -90,9 +90,10 @@ char *qfprom_read(struct device *, const char *);
 void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
 int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
+int code_to_degc(u32 adc_code, const struct tsens_sensor *s);
 
 /* TSENS v1 targets */
-extern const struct tsens_data data_8916, data_8974, data_8960;
+extern const struct tsens_data data_8916, data_8974, data_8960, data_tsens_v1;
 /* TSENS v2 targets */
 extern const struct tsens_data data_8996, data_tsens_v2;
 
-- 
2.17.1

