Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224E9C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E281820870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfBAHio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:38:44 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:1965 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725807AbfBAHiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:38:23 -0500
X-UUID: 2afa4f3863824742aefc173183015b73-20190201
X-UUID: 2afa4f3863824742aefc173183015b73-20190201
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1764095464; Fri, 01 Feb 2019 15:38:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 15:38:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 15:38:15 +0800
From:   <michael.kao@mediatek.com>
To:     =Zhang Rui <rui.zhang@intel.com>,
        =Eduardo Valentin <edubezval@gmail.com>,
        =Daniel Lezcano <daniel.lezcano@linaro.org>,
        =Rob Herring <robh+dt@kernel.org>,
        =Mark Rutland <mark.rutland@arm.com>,
        =Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH 2/7] thermal: mediatek: add common index of vts settings.
Date:   Fri, 1 Feb 2019 15:38:08 +0800
Message-ID: <1549006693-11659-3-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

Each project has different number of vts settings.
For the MT2701 just have to set three vts, but the
original code flow add five unnecessary vts.
Add common index of vts settings for scalablity,
and reduce the setting of unnecessary vts.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 93 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index f646436..07f8ad7 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -112,17 +112,26 @@
  * MT2701 has 3 sensors and needs 3 VTS calibration data.
  * MT2712 has 4 sensors and needs 4 VTS calibration data.
  */
-#define MT8173_CALIB_BUF0_VALID		BIT(0)
-#define MT8173_CALIB_BUF1_ADC_GE(x)	(((x) >> 22) & 0x3ff)
-#define MT8173_CALIB_BUF0_VTS_TS1(x)	(((x) >> 17) & 0x1ff)
-#define MT8173_CALIB_BUF0_VTS_TS2(x)	(((x) >> 8) & 0x1ff)
-#define MT8173_CALIB_BUF1_VTS_TS3(x)	(((x) >> 0) & 0x1ff)
-#define MT8173_CALIB_BUF2_VTS_TS4(x)	(((x) >> 23) & 0x1ff)
-#define MT8173_CALIB_BUF2_VTS_TSABB(x)	(((x) >> 14) & 0x1ff)
-#define MT8173_CALIB_BUF0_DEGC_CALI(x)	(((x) >> 1) & 0x3f)
-#define MT8173_CALIB_BUF0_O_SLOPE(x)	(((x) >> 26) & 0x3f)
-#define MT8173_CALIB_BUF0_O_SLOPE_SIGN(x)	(((x) >> 7) & 0x1)
-#define MT8173_CALIB_BUF1_ID(x)	(((x) >> 9) & 0x1)
+#define CALIB_BUF0_VALID		BIT(0)
+#define CALIB_BUF1_ADC_GE(x)		(((x) >> 22) & 0x3ff)
+#define CALIB_BUF0_VTS_TS1(x)		(((x) >> 17) & 0x1ff)
+#define CALIB_BUF0_VTS_TS2(x)		(((x) >> 8) & 0x1ff)
+#define CALIB_BUF1_VTS_TS3(x)		(((x) >> 0) & 0x1ff)
+#define CALIB_BUF2_VTS_TS4(x)		(((x) >> 23) & 0x1ff)
+#define CALIB_BUF2_VTS_TSABB(x)		(((x) >> 14) & 0x1ff)
+#define CALIB_BUF0_DEGC_CALI(x)		(((x) >> 1) & 0x3f)
+#define CALIB_BUF0_O_SLOPE(x)		(((x) >> 26) & 0x3f)
+#define CALIB_BUF0_O_SLOPE_SIGN(x)	(((x) >> 7) & 0x1)
+#define CALIB_BUF1_ID(x)		(((x) >> 9) & 0x1)
+
+enum {
+	VTS1,
+	VTS2,
+	VTS3,
+	VTS4,
+	VTSABB,
+	MAX_NUM_VTS,
+};
 
 /* MT2701 thermal sensors */
 #define MT2701_TS1	0
@@ -175,6 +184,7 @@ struct mtk_thermal_data {
 	s32 num_banks;
 	s32 num_sensors;
 	s32 auxadc_channel;
+	const int *vts_index;
 	const int *sensor_mux_values;
 	const int *msr;
 	const int *adcpnp;
@@ -194,7 +204,7 @@ struct mtk_thermal {
 	s32 adc_ge;
 	s32 degc_cali;
 	s32 o_slope;
-	s32 vts[MT8173_NUM_SENSORS];
+	s32 vts[MAX_NUM_VTS];
 
 	const struct mtk_thermal_data *conf;
 	struct mtk_thermal_bank banks[];
@@ -218,6 +228,10 @@ struct mtk_thermal {
 
 static const int mt8173_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
 
+static const int mt8173_vts_index[MT8173_NUM_SENSORS] = {
+	VTS1, VTS2, VTS3, VTS4, VTSABB
+};
+
 /* MT2701 thermal sensor data */
 static const int mt2701_bank_data[MT2701_NUM_SENSORS] = {
 	MT2701_TS1, MT2701_TS2, MT2701_TSABB
@@ -233,6 +247,10 @@ struct mtk_thermal {
 
 static const int mt2701_mux_values[MT2701_NUM_SENSORS] = { 0, 1, 16 };
 
+static const int mt2701_vts_index[MT2701_NUM_SENSORS] = {
+	VTS1, VTS2, VTS3
+};
+
 /* MT2712 thermal sensor data */
 static const int mt2712_bank_data[MT2712_NUM_SENSORS] = {
 	MT2712_TS1, MT2712_TS2, MT2712_TS3, MT2712_TS4
@@ -248,11 +266,16 @@ struct mtk_thermal {
 
 static const int mt2712_mux_values[MT2712_NUM_SENSORS] = { 0, 1, 2, 3 };
 
+static const int mt2712_vts_index[MT2712_NUM_SENSORS] = {
+	VTS1, VTS2, VTS3, VTS4
+};
+
 /* MT7622 thermal sensor data */
 static const int mt7622_bank_data[MT7622_NUM_SENSORS] = { MT7622_TS1, };
 static const int mt7622_msr[MT7622_NUM_SENSORS_PER_ZONE] = { TEMP_MSR0, };
 static const int mt7622_adcpnp[MT7622_NUM_SENSORS_PER_ZONE] = { TEMP_ADCPNP0, };
 static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
+static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
 
 /**
  * The MT8173 thermal controller has four banks. Each bank can read up to
@@ -271,6 +294,7 @@ struct mtk_thermal {
 	.auxadc_channel = MT8173_TEMP_AUXADC_CHANNEL,
 	.num_banks = MT8173_NUM_ZONES,
 	.num_sensors = MT8173_NUM_SENSORS,
+	.vts_index = mt8173_vts_index,
 	.bank_data = {
 		{
 			.num_sensors = 2,
@@ -305,6 +329,7 @@ struct mtk_thermal {
 	.auxadc_channel = MT2701_TEMP_AUXADC_CHANNEL,
 	.num_banks = 1,
 	.num_sensors = MT2701_NUM_SENSORS,
+	.vts_index = mt2701_vts_index,
 	.bank_data = {
 		{
 			.num_sensors = 3,
@@ -330,6 +355,7 @@ struct mtk_thermal {
 	.auxadc_channel = MT2712_TEMP_AUXADC_CHANNEL,
 	.num_banks = 1,
 	.num_sensors = MT2712_NUM_SENSORS,
+	.vts_index = mt2712_vts_index,
 	.bank_data = {
 		{
 			.num_sensors = 4,
@@ -349,6 +375,7 @@ struct mtk_thermal {
 	.auxadc_channel = MT7622_TEMP_AUXADC_CHANNEL,
 	.num_banks = MT7622_NUM_ZONES,
 	.num_sensors = MT7622_NUM_SENSORS,
+	.vts_index = mt7622_vts_index,
 	.bank_data = {
 		{
 			.num_sensors = 1,
@@ -629,19 +656,37 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 		goto out;
 	}
 
-	if (buf[0] & MT8173_CALIB_BUF0_VALID) {
-		mt->adc_ge = MT8173_CALIB_BUF1_ADC_GE(buf[1]);
-		mt->vts[MT8173_TS1] = MT8173_CALIB_BUF0_VTS_TS1(buf[0]);
-		mt->vts[MT8173_TS2] = MT8173_CALIB_BUF0_VTS_TS2(buf[0]);
-		mt->vts[MT8173_TS3] = MT8173_CALIB_BUF1_VTS_TS3(buf[1]);
-		mt->vts[MT8173_TS4] = MT8173_CALIB_BUF2_VTS_TS4(buf[2]);
-		mt->vts[MT8173_TSABB] = MT8173_CALIB_BUF2_VTS_TSABB(buf[2]);
-		mt->degc_cali = MT8173_CALIB_BUF0_DEGC_CALI(buf[0]);
-		if (MT8173_CALIB_BUF1_ID(buf[1]) &
-		    MT8173_CALIB_BUF0_O_SLOPE_SIGN(buf[0]))
-			mt->o_slope = -MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
+	if (buf[0] & CALIB_BUF0_VALID) {
+		mt->adc_ge = CALIB_BUF1_ADC_GE(buf[1]);
+
+		for (i = 0; i < mt->conf->num_sensors; i++) {
+			switch (mt->conf->vts_index[i]) {
+			case VTS1:
+				mt->vts[VTS1] = CALIB_BUF0_VTS_TS1(buf[0]);
+				break;
+			case VTS2:
+				mt->vts[VTS2] = CALIB_BUF0_VTS_TS2(buf[0]);
+				break;
+			case VTS3:
+				mt->vts[VTS3] = CALIB_BUF1_VTS_TS3(buf[1]);
+				break;
+			case VTS4:
+				mt->vts[VTS4] = CALIB_BUF2_VTS_TS4(buf[2]);
+				break;
+			case VTSABB:
+				mt->vts[VTSABB] = CALIB_BUF2_VTS_TSABB(buf[2]);
+				break;
+			default:
+				break;
+			}
+		}
+
+		mt->degc_cali = CALIB_BUF0_DEGC_CALI(buf[0]);
+		if (CALIB_BUF1_ID(buf[1]) &
+		    CALIB_BUF0_O_SLOPE_SIGN(buf[0]))
+			mt->o_slope = -CALIB_BUF0_O_SLOPE(buf[0]);
 		else
-			mt->o_slope = MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
+			mt->o_slope = CALIB_BUF0_O_SLOPE(buf[0]);
 	} else {
 		dev_info(dev, "Device not calibrated, using default calibration values\n");
 	}
-- 
1.9.1

