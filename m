Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbeBQItR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 03:49:17 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33134 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751122AbeBQItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 03:49:14 -0500
X-UUID: 700429ef7e4346679ea3a2a3eccf397c-20180217
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <rui.zhang@intel.com>, <edubezval@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Shunli Wang <shunli.wang@mediatek.com>
Subject: [PATCH v2 2/2] thermal: mediatek: add support for MT7622 SoC
Date: Sat, 17 Feb 2018 16:49:02 +0800
Message-ID: <5030064e79d65b812e3c71118bf10aa197928418.1518856935.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c72262a17332a227aa2db39b682db50e2324821a.1518856935.git.sean.wang@mediatek.com>
References: <c72262a17332a227aa2db39b682db50e2324821a.1518856935.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MT7622 SoC has built-in thermal controller with one sensing point, the
patch just is to extend the functionality of the existing logic.

Changes v1 -> v2: rebase to 4.16-rc1

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index c75661a..e709acb 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -153,6 +153,12 @@
 /* The number of sensing points per bank */
 #define MT2712_NUM_SENSORS_PER_ZONE	4
 
+#define MT7622_TEMP_AUXADC_CHANNEL	11
+#define MT7622_NUM_SENSORS		1
+#define MT7622_NUM_ZONES		1
+#define MT7622_NUM_SENSORS_PER_ZONE	1
+#define MT7622_TS1	0
+
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -242,6 +248,12 @@ static const int mt2712_adcpnp[MT2712_NUM_SENSORS_PER_ZONE] = {
 
 static const int mt2712_mux_values[MT2712_NUM_SENSORS] = { 0, 1, 2, 3 };
 
+/* MT7622 thermal sensor data */
+static const int mt7622_bank_data[MT7622_NUM_SENSORS] = { MT7622_TS1, };
+static const int mt7622_msr[MT7622_NUM_SENSORS_PER_ZONE] = { TEMP_MSR0, };
+static const int mt7622_adcpnp[MT7622_NUM_SENSORS_PER_ZONE] = { TEMP_ADCPNP0, };
+static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
+
 /**
  * The MT8173 thermal controller has four banks. Each bank can read up to
  * four temperature sensors simultaneously. The MT8173 has a total of 5
@@ -329,6 +341,25 @@ static const struct mtk_thermal_data mt2712_thermal_data = {
 	.sensor_mux_values = mt2712_mux_values,
 };
 
+/*
+ * MT7622 have only one sensing point which uses AUXADC Channel 11 for raw data
+ * access.
+ */
+static const struct mtk_thermal_data mt7622_thermal_data = {
+	.auxadc_channel = MT7622_TEMP_AUXADC_CHANNEL,
+	.num_banks = MT7622_NUM_ZONES,
+	.num_sensors = MT7622_NUM_SENSORS,
+	.bank_data = {
+		{
+			.num_sensors = 1,
+			.sensors = mt7622_bank_data,
+		},
+	},
+	.msr = mt7622_msr,
+	.adcpnp = mt7622_adcpnp,
+	.sensor_mux_values = mt7622_mux_values,
+};
+
 /**
  * raw_to_mcelsius - convert a raw ADC value to mcelsius
  * @mt:		The thermal controller
@@ -631,6 +662,10 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 	{
 		.compatible = "mediatek,mt2712-thermal",
 		.data = (void *)&mt2712_thermal_data,
+	},
+	{
+		.compatible = "mediatek,mt7622-thermal",
+		.data = (void *)&mt7622_thermal_data,
 	}, {
 	},
 };
-- 
2.7.4
