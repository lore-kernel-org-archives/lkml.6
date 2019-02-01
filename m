Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C78AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37368204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfBAHix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:38:53 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:62247 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbfBAHiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:38:22 -0500
X-UUID: 5440c94893d249db9cdd8efdef13fbdb-20190201
X-UUID: 5440c94893d249db9cdd8efdef13fbdb-20190201
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 807436136; Fri, 01 Feb 2019 15:38:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 15:38:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 15:38:16 +0800
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
Subject: [PATCH 7/7] thermal: mediatek: add support for MT8183
Date:   Fri, 1 Feb 2019 15:38:13 +0800
Message-ID: <1549006693-11659-8-git-send-email-michael.kao@mediatek.com>
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

MT8183 has two built-in thermal controllers with total six thermal
sensors. And it doesn't have bank, so doesn't need to select bank.
This patch adds support for mt8183.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 98 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 3e97638..e449177 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -71,6 +71,15 @@
 
 #define TEMP_SPARE0		0x0f0
 
+#define TEMP_ADCPNP0_1          0x148
+#define TEMP_ADCPNP1_1          0x14c
+#define TEMP_ADCPNP2_1          0x150
+#define TEMP_MSR0_1             0x190
+#define TEMP_MSR1_1             0x194
+#define TEMP_MSR2_1             0x198
+#define TEMP_ADCPNP3_1          0x1b4
+#define TEMP_MSR3_1             0x1B8
+
 #define PTPCORESEL		0x400
 
 #define TEMP_MONCTL1_PERIOD_UNIT(x)	((x) & 0x3ff)
@@ -113,7 +122,8 @@
 
 /*
  * Layout of the fuses providing the calibration data
- * These macros could be used for MT8173, MT2701, and MT2712.
+ * These macros could be used for MT8183, MT8173, MT2701, and MT2712.
+ * MT8183 has 6 sensors and needs 6 VTS calibration data.
  * MT8173 has 5 sensors and needs 5 VTS calibration data.
  * MT2701 has 3 sensors and needs 3 VTS calibration data.
  * MT2712 has 4 sensors and needs 4 VTS calibration data.
@@ -124,6 +134,7 @@
 #define CALIB_BUF0_VTS_TS2(x)		(((x) >> 8) & 0x1ff)
 #define CALIB_BUF1_VTS_TS3(x)		(((x) >> 0) & 0x1ff)
 #define CALIB_BUF2_VTS_TS4(x)		(((x) >> 23) & 0x1ff)
+#define CALIB_BUF2_VTS_TS5(x)		(((x) >> 5) & 0x1ff)
 #define CALIB_BUF2_VTS_TSABB(x)		(((x) >> 14) & 0x1ff)
 #define CALIB_BUF0_DEGC_CALI(x)		(((x) >> 1) & 0x3f)
 #define CALIB_BUF0_O_SLOPE(x)		(((x) >> 26) & 0x3f)
@@ -135,6 +146,7 @@ enum {
 	VTS2,
 	VTS3,
 	VTS4,
+	VTS5,
 	VTSABB,
 	MAX_NUM_VTS,
 };
@@ -190,6 +202,29 @@ enum {
 /* The calibration coefficient of sensor  */
 #define MT7622_CALIBRATION	165
 
+/* MT8183 thermal sensors */
+#define MT8183_TS1	0
+#define MT8183_TS2	1
+#define MT8183_TS3	2
+#define MT8183_TS4	3
+#define MT8183_TS5	4
+#define MT8183_TSABB	5
+
+/* AUXADC channel  is used for the temperature sensors */
+#define MT8183_TEMP_AUXADC_CHANNEL	11
+
+/* The total number of temperature sensors in the MT8183 */
+#define MT8183_NUM_SENSORS	6
+
+/* The number of sensing points per bank */
+#define MT8183_NUM_SENSORS_PER_ZONE	 6
+
+/* The number of controller in the MT8183 */
+#define MT8183_NUM_CONTROLLER		2
+
+/* The calibration coefficient of sensor  */
+#define MT8183_CALIBRATION	153
+
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -236,6 +271,27 @@ struct mtk_thermal {
 	struct mtk_thermal_bank banks[];
 };
 
+/* MT8183 thermal sensor data */
+static const int mt8183_bank_data[MT8183_NUM_SENSORS] = {
+	MT8183_TS1, MT8183_TS2, MT8183_TS3, MT8183_TS4, MT8183_TS5, MT8183_TSABB
+};
+
+static const int mt8183_msr[MT8183_NUM_SENSORS_PER_ZONE] = {
+	TEMP_MSR0_1, TEMP_MSR1_1, TEMP_MSR2_1, TEMP_MSR1, TEMP_MSR0, TEMP_MSR3_1
+};
+
+static const int mt8183_adcpnp[MT8183_NUM_SENSORS_PER_ZONE] = {
+	TEMP_ADCPNP0_1, TEMP_ADCPNP1_1, TEMP_ADCPNP2_1,
+	TEMP_ADCPNP1, TEMP_ADCPNP0, TEMP_ADCPNP3_1
+};
+
+static const int mt8183_mux_values[MT8183_NUM_SENSORS] = { 0, 1, 2, 3, 4, 0 };
+static const int mt8183_tc_offset[MT8183_NUM_CONTROLLER] = {0x0, 0x100};
+
+static const int mt8183_vts_index[MT8183_NUM_SENSORS] = {
+	VTS1, VTS2, VTS3, VTS4, VTS5, VTSABB
+};
+
 /* MT8173 thermal sensor data */
 static const int mt8173_bank_data[MT8173_NUM_ZONES][3] = {
 	{ MT8173_TS2, MT8173_TS3 },
@@ -434,6 +490,39 @@ struct mtk_thermal {
 };
 
 /**
+ * The MT8183 thermal controller has one bank for the current SW framework.
+ * The MT8183 has a total of 6 temperature sensors.
+ * There are two thermal controller to control the six sensor.
+ * The first one bind 2 sensor, and the other bind 4 sensors.
+ * The thermal core only gets the maximum temperature of all sensor, so
+ * the bank concept wouldn't be necessary here. However, the SVS (Smart
+ * Voltage Scaling) unit makes its decisions based on the same bank
+ * data, and this indeed needs the temperatures of the individual banks
+ * for making better decisions.
+ */
+
+static const struct mtk_thermal_data mt8183_thermal_data = {
+	.auxadc_channel = MT8183_TEMP_AUXADC_CHANNEL,
+	.num_banks = MT8183_NUM_SENSORS_PER_ZONE,
+	.num_sensors = MT8183_NUM_SENSORS,
+	.vts_index = mt8183_vts_index,
+	.cali_val = MT8183_CALIBRATION,
+	.num_controller = MT8183_NUM_CONTROLLER,
+	.controller_offset = mt8183_tc_offset,
+	.need_switch_bank = false,
+	.bank_data = {
+		{
+			.num_sensors = 6,
+			.sensors = mt8183_bank_data,
+		},
+	},
+
+	.msr = mt8183_msr,
+	.adcpnp = mt8183_adcpnp,
+	.sensor_mux_values = mt8183_mux_values,
+};
+
+/**
  * raw_to_mcelsius - convert a raw ADC value to mcelsius
  * @mt:		The thermal controller
  * @raw:	raw ADC value
@@ -726,6 +815,9 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 			case VTS4:
 				mt->vts[VTS4] = CALIB_BUF2_VTS_TS4(buf[2]);
 				break;
+			case VTS5:
+				mt->vts[VTS5] = CALIB_BUF2_VTS_TS5(buf[2]);
+				break;
 			case VTSABB:
 				mt->vts[VTSABB] = CALIB_BUF2_VTS_TSABB(buf[2]);
 				break;
@@ -766,6 +858,10 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 	{
 		.compatible = "mediatek,mt7622-thermal",
 		.data = (void *)&mt7622_thermal_data,
+	},
+	{
+		.compatible = "mediatek,mt8183-thermal",
+		.data = (void *)&mt8183_thermal_data,
 	}, {
 	},
 };
-- 
1.9.1

