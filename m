Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6719DC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173FC20824
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173FC20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeJ3Jza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:55:30 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38974 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeJ3Jza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:55:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E7EFF1A0011;
        Tue, 30 Oct 2018 02:04:11 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 93A881A0007;
        Tue, 30 Oct 2018 02:04:08 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 62A4040302;
        Tue, 30 Oct 2018 09:04:04 +0800 (SGT)
From:   andy.tang@nxp.com
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH v3] thermal: qoriq: add multiple sensors support
Date:   Tue, 30 Oct 2018 09:00:08 +0800
Message-Id: <20181030010008.27237-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

The QorIQ Layerscape SoC has several thermal sensors but the current
driver only supports one.

Massage the code to be sensor oriented and allow the support for
multiple sensors.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
v3:
  - add Reviewed-by
v2:
  - update the commit message
  - refine the qoriq_tmu_register_tmu_zone()

 drivers/thermal/qoriq_thermal.c |  100 ++++++++++++++++++---------------------
 1 files changed, 46 insertions(+), 54 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 450ed66..8beb344 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -59,14 +59,21 @@ struct qoriq_tmu_regs {
 	u32 ttr3cr;		/* Temperature Range 3 Control Register */
 };
 
+struct qoriq_tmu_data;
+
 /*
  * Thermal zone data
  */
+struct qoriq_sensor {
+	struct thermal_zone_device	*tzd;
+	struct qoriq_tmu_data		*qdata;
+	int				id;
+};
+
 struct qoriq_tmu_data {
-	struct thermal_zone_device *tz;
 	struct qoriq_tmu_regs __iomem *regs;
-	int sensor_id;
 	bool little_endian;
+	struct qoriq_sensor	*sensor[SITES_MAX];
 };
 
 static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
@@ -87,48 +94,51 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
 
 static int tmu_get_temp(void *p, int *temp)
 {
+	struct qoriq_sensor *qsensor = p;
+	struct qoriq_tmu_data *qdata = qsensor->qdata;
 	u32 val;
-	struct qoriq_tmu_data *data = p;
 
-	val = tmu_read(data, &data->regs->site[data->sensor_id].tritsr);
+	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
 	*temp = (val & 0xff) * 1000;
 
 	return 0;
 }
 
-static int qoriq_tmu_get_sensor_id(void)
+static const struct thermal_zone_of_device_ops tmu_tz_ops = {
+	.get_temp = tmu_get_temp,
+};
+
+static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 {
-	int ret, id;
-	struct of_phandle_args sensor_specs;
-	struct device_node *np, *sensor_np;
+	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
+	int id, sites = 0;
 
-	np = of_find_node_by_name(NULL, "thermal-zones");
-	if (!np)
-		return -ENODEV;
+	for (id = 0; id < SITES_MAX; id++) {
+		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
+				sizeof(struct qoriq_sensor), GFP_KERNEL);
+		if (!qdata->sensor[id])
+			return -ENOMEM;
 
-	sensor_np = of_get_next_child(np, NULL);
-	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
-			"#thermal-sensor-cells",
-			0, &sensor_specs);
-	if (ret) {
-		of_node_put(np);
-		of_node_put(sensor_np);
-		return ret;
-	}
+		qdata->sensor[id]->id = id;
+		qdata->sensor[id]->qdata = qdata;
 
-	if (sensor_specs.args_count >= 1) {
-		id = sensor_specs.args[0];
-		WARN(sensor_specs.args_count > 1,
-				"%s: too many cells in sensor specifier %d\n",
-				sensor_specs.np->name, sensor_specs.args_count);
-	} else {
-		id = 0;
-	}
+		qdata->sensor[id]->tzd = devm_thermal_zone_of_sensor_register(
+				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
+		if (IS_ERR(qdata->sensor[id]->tzd)) {
+			if (PTR_ERR(qdata->sensor[id]->tzd) == -ENODEV)
+				continue;
+			else
+				return PTR_ERR(qdata->sensor[id]->tzd);
 
-	of_node_put(np);
-	of_node_put(sensor_np);
+		}
+
+		sites |= 0x1 << (15 - id);
+	}
+	/* Enable monitoring */
+	if (sites != 0)
+		tmu_write(qdata, sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
 
-	return id;
+	return 0;
 }
 
 static int qoriq_tmu_calibration(struct platform_device *pdev)
@@ -178,16 +188,11 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 }
 
-static const struct thermal_zone_of_device_ops tmu_tz_ops = {
-	.get_temp = tmu_get_temp,
-};
-
 static int qoriq_tmu_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
-	u32 site;
 
 	if (!np) {
 		dev_err(&pdev->dev, "Device OF-Node is NULL");
@@ -203,13 +208,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
-	data->sensor_id = qoriq_tmu_get_sensor_id();
-	if (data->sensor_id < 0) {
-		dev_err(&pdev->dev, "Failed to get sensor id\n");
-		ret = -ENODEV;
-		goto err_iomap;
-	}
-
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
 		dev_err(&pdev->dev, "Failed to get memory region\n");
@@ -223,19 +221,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_tmu;
 
-	data->tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							data->sensor_id,
-							data, &tmu_tz_ops);
-	if (IS_ERR(data->tz)) {
-		ret = PTR_ERR(data->tz);
-		dev_err(&pdev->dev,
-			"Failed to register thermal zone device %d\n", ret);
-		goto err_tmu;
+	ret = qoriq_tmu_register_tmu_zone(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register sensors\n");
+		ret = -ENODEV;
+		goto err_iomap;
 	}
 
-	/* Enable monitoring */
-	site = 0x1 << (15 - data->sensor_id);
-	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
 
 	return 0;
 
-- 
1.7.1

