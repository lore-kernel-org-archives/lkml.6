Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3E3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF572146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfBSKEu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:04:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11530 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728064AbfBSKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:04:44 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JA34EO015970;
        Tue, 19 Feb 2019 11:04:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qpc6x7p4d-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 19 Feb 2019 11:04:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F22043;
        Tue, 19 Feb 2019 10:04:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 22B4C27A1;
        Tue, 19 Feb 2019 10:04:36 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Feb
 2019 11:04:35 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 19 Feb 2019 11:04:35 +0100
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     Pascal PAILLET-LME <p.paillet@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 8/8] regulator: stpmic1: Add active discharge support
Thread-Topic: [PATCH 8/8] regulator: stpmic1: Add active discharge support
Thread-Index: AQHUyDqEfgBdj+odYEWO+nvXmTE4og==
Date:   Tue, 19 Feb 2019 10:04:35 +0000
Message-ID: <1550570647-9555-9-git-send-email-p.paillet@st.com>
References: <1550570647-9555-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1550570647-9555-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for active discharge for USB power switches.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 drivers/regulator/stpmic1_regulator.c | 68 ++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 41128c4..f090614 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -177,11 +177,19 @@ enum {
 	.disable = regulator_disable_regmap,
 };
 
+static const struct regulator_ops stpmic1_boost_regul_ops = {
+	.is_enabled = regulator_is_enabled_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_over_current_protection = stpmic1_set_icc,
+};
+
 static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.set_over_current_protection = stpmic1_set_icc,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
 };
 
 #define REG_LDO(ids, base) { \
@@ -282,7 +290,44 @@ enum {
 	.supply_name = #base, \
 }
 
-#define REG_SWITCH(ids, base, reg, mask, val) { \
+#define REG_BOOST(ids, base) { \
+	.name = #ids, \
+	.id = STPMIC1_##ids, \
+	.n_voltages = 1, \
+	.ops = &stpmic1_boost_regul_ops, \
+	.type = REGULATOR_VOLTAGE, \
+	.owner = THIS_MODULE, \
+	.min_uV = 0, \
+	.fixed_uV = 5000000, \
+	.enable_reg = BST_SW_CR, \
+	.enable_mask = BOOST_ENABLED, \
+	.enable_val = BOOST_ENABLED, \
+	.disable_val = 0, \
+	.enable_time = PMIC_ENABLE_TIME_US, \
+	.supply_name = #base, \
+}
+
+#define REG_VBUS_OTG(ids, base) { \
+	.name = #ids, \
+	.id = STPMIC1_##ids, \
+	.n_voltages = 1, \
+	.ops = &stpmic1_switch_regul_ops, \
+	.type = REGULATOR_VOLTAGE, \
+	.owner = THIS_MODULE, \
+	.min_uV = 0, \
+	.fixed_uV = 5000000, \
+	.enable_reg = BST_SW_CR, \
+	.enable_mask = USBSW_OTG_SWITCH_ENABLED, \
+	.enable_val = USBSW_OTG_SWITCH_ENABLED, \
+	.disable_val = 0, \
+	.enable_time = PMIC_ENABLE_TIME_US, \
+	.supply_name = #base, \
+	.active_discharge_reg = BST_SW_CR, \
+	.active_discharge_mask = VBUS_OTG_DISCHARGE, \
+	.active_discharge_on = VBUS_OTG_DISCHARGE, \
+}
+
+#define REG_SW_OUT(ids, base) { \
 	.name = #ids, \
 	.id = STPMIC1_##ids, \
 	.n_voltages = 1, \
@@ -291,12 +336,15 @@ enum {
 	.owner = THIS_MODULE, \
 	.min_uV = 0, \
 	.fixed_uV = 5000000, \
-	.enable_reg = (reg), \
-	.enable_mask = (mask), \
-	.enable_val = (val), \
+	.enable_reg = BST_SW_CR, \
+	.enable_mask = SWIN_SWOUT_ENABLED, \
+	.enable_val = SWIN_SWOUT_ENABLED, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
 	.supply_name = #base, \
+	.active_discharge_reg = BST_SW_CR, \
+	.active_discharge_mask = SW_OUT_DISCHARGE, \
+	.active_discharge_on = SW_OUT_DISCHARGE, \
 }
 
 static const struct stpmic1_regulator_cfg stpmic1_regulator_cfgs[] = {
@@ -376,23 +424,17 @@ enum {
 		.mask_reset_mask = BIT(6),
 	},
 	[STPMIC1_BOOST] = {
-		.desc = REG_SWITCH(BOOST, boost, BST_SW_CR,
-				   BOOST_ENABLED,
-				   BOOST_ENABLED),
+		.desc = REG_BOOST(BOOST, boost),
 		.icc_reg = BUCKS_ICCTO_CR,
 		.icc_mask = BIT(6),
 	},
 	[STPMIC1_VBUS_OTG] = {
-		.desc = REG_SWITCH(VBUS_OTG, pwr_sw1, BST_SW_CR,
-				   USBSW_OTG_SWITCH_ENABLED,
-				   USBSW_OTG_SWITCH_ENABLED),
+		.desc = REG_VBUS_OTG(VBUS_OTG, pwr_sw1),
 		.icc_reg = BUCKS_ICCTO_CR,
 		.icc_mask = BIT(4),
 	},
 	[STPMIC1_SW_OUT] = {
-		.desc = REG_SWITCH(SW_OUT, pwr_sw2, BST_SW_CR,
-				   SWIN_SWOUT_ENABLED,
-				   SWIN_SWOUT_ENABLED),
+		.desc = REG_SW_OUT(SW_OUT, pwr_sw2),
 		.icc_reg = BUCKS_ICCTO_CR,
 		.icc_mask = BIT(5),
 	},
-- 
1.9.1
