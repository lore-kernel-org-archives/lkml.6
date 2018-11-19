Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A01920851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A01920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeKSV11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:27:27 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50262 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbeKSV11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:27:27 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAJAx52C016310;
        Mon, 19 Nov 2018 12:03:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ntarga8p4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 19 Nov 2018 12:03:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6DEF231;
        Mon, 19 Nov 2018 11:03:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4C28B26A3;
        Mon, 19 Nov 2018 11:03:36 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 19 Nov 2018 12:03:35
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
Subject: [PATCH v2 2/2] i2c: i2c-stm32f7: SYSCFG Fast Mode Plus support for I2C STM32F7
Date:   Mon, 19 Nov 2018 12:03:32 +0100
Message-ID: <1542625412-4277-3-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542625412-4277-1-git-send-email-pierre-yves.mordret@st.com>
References: <1542625412-4277-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_04:,,
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
    v2:
       * Missing header file inclusion
    v1:
       * Initial
---
---
 drivers/i2c/busses/i2c-stm32f7.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 62d023e..e9f0c0b 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -21,12 +21,14 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 
@@ -276,6 +278,7 @@ struct stm32f7_i2c_msg {
  * slave)
  * @dma: dma data
  * @use_dma: boolean to know if dma is used in the current transfer
+ * @regmap: holds SYSCFG phandle for Fast Mode Plus bits
  */
 struct stm32f7_i2c_dev {
 	struct i2c_adapter adap;
@@ -296,6 +299,7 @@ struct stm32f7_i2c_dev {
 	bool master_mode;
 	struct stm32_i2c_dma *dma;
 	bool use_dma;
+	struct regmap *regmap;
 };
 
 /**
@@ -1763,6 +1767,30 @@ static int stm32f7_i2c_unreg_slave(struct i2c_client *slave)
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
@@ -1828,12 +1856,16 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
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

