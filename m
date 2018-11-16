Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8E0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8B7208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8B7208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389600AbeKPWc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:32:59 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39523 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727825AbeKPWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:32:58 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAGCIeJh002467;
        Fri, 16 Nov 2018 13:20:31 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nr7cyqh9u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 16 Nov 2018 13:20:31 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 605AD31;
        Fri, 16 Nov 2018 12:20:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A6F12A17;
        Fri, 16 Nov 2018 12:20:30 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 16 Nov 2018 13:20:29
 +0100
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] i2c: i2c-stm32f7: SYSCFG Fast Mode Plus support for I2C STM32F7
Date:   Fri, 16 Nov 2018 13:20:22 +0100
Message-ID: <1542370822-14721-3-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542370822-14721-1-git-send-email-pierre-yves.mordret@st.com>
References: <1542370822-14721-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read SYSCFG bindings to set Fast Mode Plus bits if Fast Mode Plus
speed is selected.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/i2c/busses/i2c-stm32f7.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 62d023e..8e381b7 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -276,6 +277,7 @@ struct stm32f7_i2c_msg {
  * slave)
  * @dma: dma data
  * @use_dma: boolean to know if dma is used in the current transfer
+ * @regmap: holds SYSCFG phandle for Fast Mode Plus bits
  */
 struct stm32f7_i2c_dev {
 	struct i2c_adapter adap;
@@ -296,6 +298,7 @@ struct stm32f7_i2c_dev {
 	bool master_mode;
 	struct stm32_i2c_dma *dma;
 	bool use_dma;
+	struct regmap *regmap;
 };
 
 /**
@@ -1763,6 +1766,30 @@ static int stm32f7_i2c_unreg_slave(struct i2c_client *slave)
 	return 0;
 }
 
+static int stm32f7_i2c_setup_fm_plus_bits(struct platform_device *pdev,
+					  struct stm32f7_i2c_dev *i2c_dev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+	u32 reg, mask;
+
+	i2c_dev->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg-fmp");
+	if (IS_ERR(i2c_dev->regmap)) {
+		/* Optional */
+		return 0;
+	}
+
+	ret = of_property_read_u32_index(np, "st,syscfg-fmp", 1, &reg);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_index(np, "st,syscfg-fmp", 2, &mask);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(i2c_dev->regmap, reg, mask, mask);
+}
+
 static u32 stm32f7_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SLAVE |
@@ -1828,12 +1855,16 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	i2c_dev->speed = STM32_I2C_SPEED_STANDARD;
 	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
 				       &clk_rate);
-	if (!ret && clk_rate >= 1000000)
+	if (!ret && clk_rate >= 1000000) {
 		i2c_dev->speed = STM32_I2C_SPEED_FAST_PLUS;
-	else if (!ret && clk_rate >= 400000)
+		ret = stm32f7_i2c_setup_fm_plus_bits(pdev, i2c_dev);
+		if (ret)
+			goto clk_free;
+	} else if (!ret && clk_rate >= 400000) {
 		i2c_dev->speed = STM32_I2C_SPEED_FAST;
-	else if (!ret && clk_rate >= 100000)
+	} else if (!ret && clk_rate >= 100000) {
 		i2c_dev->speed = STM32_I2C_SPEED_STANDARD;
+	}
 
 	rst = devm_reset_control_get(&pdev->dev, NULL);
 	if (IS_ERR(rst)) {
-- 
2.7.4

