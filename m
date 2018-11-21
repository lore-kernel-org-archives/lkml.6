Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79D5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6314721479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K+1+q4DX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6314721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeKUPlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:41:04 -0500
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:2112
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbeKUPlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msnZKEbXiU7JHP6e/KWFIU1cBU49PvWMNy62Xh0ryug=;
 b=K+1+q4DXAXjjwX2G/5+B85nYmZ68IREGEnu4ygn7kQSsCsD1wMRRRCsGprO0+HUBK1FqUue05oEKaUWUfQHjXqoBQzOamON/SXnryx7wmAJaAeTdHWwl03IrgiJk75/SFicOP3CFymv4TGdGGVBE1h65deN+FTylyuTxsnb6lzk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3705.eurprd04.prod.outlook.com (52.134.70.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Wed, 21 Nov 2018 05:08:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 05:08:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4] thermal: imx: fix for dependency on cpu-freq
Thread-Topic: [PATCH V4] thermal: imx: fix for dependency on cpu-freq
Thread-Index: AQHUgVgvfgSaUi1sF0WIYUcUodkMEg==
Date:   Wed, 21 Nov 2018 05:08:05 +0000
Message-ID: <1542776563-6716-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3705;6:2FDG21lZXjLa5iD5z/+nqGDP59s7hweSNMV+c2QiXG0HsuGahzesHv+kcYtbWo6layM6B4ma8yXVTzCE88gNc86Ixc83edvtxpeqn+l6VoobQQ3xLSOnWBh8984XkdzKpa//X88mrNer0a8M0YvOfdxOs+sqUqO5MN5lBNded8O1+Lm5T6ILSzZDBbwR8EdFnrir6oCs/5ISU61OBxcyPNGYxA29O0hN19GPwx0bf25+/pZgMx+2/eDLg3IZ1mMY7/aNy8Unntj+71hC2QDuzAFY9S3NBUcTKLr8g2grR0u//V2A4Ic4hMy4xK/2TO15nT9QHufvbipC8TUjY61os5XSJ8/agt4xYSKTHlL3DStod7Y8amQITknJln41kalnDNRZLWeyvEEH80sX6UZaigD9pWu2IuE/D+H+LRv7mg8gtgO13GDmBC3WwJadFu0Yn1XDotdwR7dmj4uAxlHtwA==;5:UDtyrtA03jLZ8UJgQI2bkfh4IuUpWNo0ftCkUvxfCvHNjoMznYByuPdubf7mKUI/BgrCG6HmOYr3ijpzzGsbRawRYXX4OsswJZ1tQlEVMegBR6UhPe8OQd82fGS0sNG1ngvGGCaz40j523jJUCcExzyHiVY50A10U2ZKo2zkEFs=;7:EWd0OdCvVQ30Ogb1Hj5sPFtyQ5OrtW9gpMA/ZGC8KrE5MxLV1oGnn3tlJeIjHI4uzI/7BPyOaiWfDX3qb9ohZdMrVzMxFGnJE4hip9jeDAPBUN3vTJbeOzCZKJ41TZILaom9iLD0rVpBWvvmSX2duw==
x-ms-office365-filtering-correlation-id: 2f04f96f-c653-4f70-c7b8-08d64f6f51bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3705;
x-ms-traffictypediagnostic: DB3PR0402MB3705:
x-microsoft-antispam-prvs: <DB3PR0402MB3705F269EE1212996ACD5A94F5DA0@DB3PR0402MB3705.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3705;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3705;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(478600001)(39060400002)(486006)(14454004)(106356001)(476003)(105586002)(2616005)(68736007)(2900100001)(4326008)(110136005)(6116002)(3846002)(5660300001)(6486002)(2906002)(53936002)(6436002)(6512007)(316002)(71190400001)(25786009)(36756003)(99286004)(305945005)(7736002)(186003)(52116002)(26005)(97736004)(2501003)(81156014)(81166006)(66066001)(102836004)(386003)(6506007)(8936002)(50226002)(86362001)(256004)(71200400001)(2201001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3705;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T7B9sODJfpuuRDlvhO+jPpmwVc9S65++lEviSpZP+bLJdGjDIfEMkfIIHzsOJYv8djkma9shiOAyUT7oPH0AoEgWjKP2YgvN/+oeT5COvInT7mqtE8Dx+ae6ge+HNnGZmHks6+sZzx2qgPgs30IeTM/o3zXB7BTMCkbxnLlXeevPSKDuxdeicZ74X0OqVn1ZdD+QU4EBu1qthIs5W839bwVMuHHZbq8st8XnxyBtRN3LccJcpaJbOxOGV6WadkgwOeJzWpVppleSDty/0341PGbHOR6xMI0+kl6aAJWUD6eHiYzkJhptUrxaufG1v/PGQj1PVe8YNQvfUjrY4yHAE7QuuFllvVMVPHW4tA/X5eo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f04f96f-c653-4f70-c7b8-08d64f6f51bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 05:08:05.5497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal driver is a standalone driver for monitoring SoC temperature
by enabling thermal sensor, so it can be enabled even when CONFIG_CPU_FREQ
is NOT set. So remove the dependency with CPU_THERMAL.

Introduce dummy function of legacy cooling register/unregister to make
thermal driver probe successfully when CONFIG_CPU_FREQ is NOT set.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V3:
	rename the label of "cpufreq_put" with "legacy_cleanup".
 drivers/thermal/Kconfig       |  2 +-
 drivers/thermal/imx_thermal.c | 44 +++++++++++++++++++++++++++++++--------=
----
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5422523..93bd3bb 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -212,7 +212,7 @@ config HISI_THERMAL
=20
 config IMX_THERMAL
 	tristate "Temperature sensor driver for Freescale i.MX SoCs"
-	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on NVMEM || !NVMEM
 	depends on MFD_SYSCON
 	depends on OF
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 1566154..328ee05 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -648,15 +648,24 @@ static const struct of_device_id of_imx_thermal_match=
[] =3D {
 };
 MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
=20
+#ifdef CONFIG_CPU_FREQ
 /*
  * Create cooling device in case no #cooling-cells property is available i=
n
  * CPU node
  */
 static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *da=
ta)
 {
-	struct device_node *np =3D of_get_cpu_node(data->policy->cpu, NULL);
+	struct device_node *np;
 	int ret;
=20
+	data->policy =3D cpufreq_cpu_get(0);
+	if (!data->policy) {
+		pr_debug("%s: CPUFreq policy not found\n", __func__);
+		return -EPROBE_DEFER;
+	}
+
+	np =3D of_get_cpu_node(data->policy->cpu, NULL);
+
 	if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
 		data->cdev =3D cpufreq_cooling_register(data->policy);
 		if (IS_ERR(data->cdev)) {
@@ -669,6 +678,22 @@ static int imx_thermal_register_legacy_cooling(struct =
imx_thermal_data *data)
 	return 0;
 }
=20
+static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data =
*data)
+{
+	cpufreq_cooling_unregister(data->cdev);
+	cpufreq_cpu_put(data->policy);
+}
+#else
+static inline int imx_thermal_register_legacy_cooling(struct imx_thermal_d=
ata *data)
+{
+	return 0;
+}
+
+static inline void imx_thermal_unregister_legacy_cooling(struct imx_therma=
l_data *data)
+{
+}
+#endif
+
 static int imx_thermal_probe(struct platform_device *pdev)
 {
 	struct imx_thermal_data *data;
@@ -743,13 +768,9 @@ static int imx_thermal_probe(struct platform_device *p=
dev)
 	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
 		     data->socdata->power_down_mask);
=20
-	data->policy =3D cpufreq_cpu_get(0);
-	if (!data->policy) {
-		pr_debug("%s: CPUFreq policy not found\n", __func__);
-		return -EPROBE_DEFER;
-	}
-
 	ret =3D imx_thermal_register_legacy_cooling(data);
+	if (ret =3D=3D -EPROBE_DEFER)
+		return ret;
 	if (ret) {
 		dev_err(&pdev->dev,
 			"failed to register cpufreq cooling device: %d\n", ret);
@@ -762,7 +783,7 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 		if (ret !=3D -EPROBE_DEFER)
 			dev_err(&pdev->dev,
 				"failed to get thermal clk: %d\n", ret);
-		goto cpufreq_put;
+		goto legacy_cleanup;
 	}
=20
 	/*
@@ -775,7 +796,7 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 	ret =3D clk_prepare_enable(data->thermal_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-		goto cpufreq_put;
+		goto legacy_cleanup;
 	}
=20
 	data->tz =3D thermal_zone_device_register("imx_thermal_zone",
@@ -829,9 +850,8 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 	thermal_zone_device_unregister(data->tz);
 clk_disable:
 	clk_disable_unprepare(data->thermal_clk);
-cpufreq_put:
-	cpufreq_cooling_unregister(data->cdev);
-	cpufreq_cpu_put(data->policy);
+legacy_cleanup:
+	imx_thermal_unregister_legacy_cooling(data);
=20
 	return ret;
 }
--=20
2.7.4

