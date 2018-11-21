Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A390C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E820A20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W1SUmuXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E820A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeKUMaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:30:35 -0500
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:54776
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbeKUMae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 07:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMU/v/SX6wiE+FvNbKBwQ1dqaxXl82H+0YOiZOhb7Kw=;
 b=W1SUmuXQzepKH9PmzKj+tGECLBJTw5l9IgP+WLq8VzRQ6awr/zlmBrAFePELT0BBhqjwYR4EkUSNiGiWnDY3ywvMnvNns2aQ411uZ2pLMzY/2yg29zKu1kaOttetDZQNKYPjtIAM4dg7O5ogRH/x3teew4OVzKIykfscsyH6By4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3852.eurprd04.prod.outlook.com (52.134.71.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 21 Nov 2018 01:58:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 01:58:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] thermal: imx: fix for dependency on cpu-freq
Thread-Topic: [PATCH V2] thermal: imx: fix for dependency on cpu-freq
Thread-Index: AQHUgT2rutTwZP1maU6Y9yw4ZWmM4g==
Date:   Wed, 21 Nov 2018 01:58:16 +0000
Message-ID: <1542765172-4004-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3852;6:kFYhjrO+di0bUI+rBPMnSzKM0EqwOeOlalCNZ3acLsXiH/k9LfS5p9pinVMTbKTmtloE2odcAw0tPVcTDv2UHLqoVCKreoWCehULzvrrZFAPiroRfCHh72ktqd8dTQ5xWNXTiKP/Bogl3vAqZIGK0Q69plN1V2aZQ6XzMZ3tpcN8UHKCgYqNeNXpDV3e13F7wn9deCoxVpA7KHBps30yKVq+TdLmRO7nWM14A9bVyIBzGYiTUXhv/s0715nq2JSGOBXt3c/fbMbytWXPm6Yfgc0JAyvSJ5BeIYASQUymEKQ3N9KI5nZZeFPSVmbbs1pP/d7grzR89NP1fJX4MN+RsAXi8qLn8dcWWi8KFO1RypyDVTGtgyPo8nNUZj5oQLpSv1VzpeIFLwNoBDCBhLPMbKc6FSuw/EraK//Wqfb8dIqUcpdWs8tedIZI3C3JLdtirPh6A3ju3ys5S3Lv9gNMMg==;5:Fk/yzRGFi5lI+K5/xRKW6l40oOZr+1OMkhrRmabfGrSNneeoj5/2/nvhwytLrxf2OVxvuKM32wk2AtTaSdYFp5ZrKt+Q8KoTbmOgXSt4/61DekBCIhWKNyxy2w9VHEcoUlOdETS/KW/FuwpnREFZkfzC9/kzlSmlEmszhSbY9IE=;7:adAJlTrE4ko03qnTx+wPIPP7at16OTpkFDKhnzSARmGYFGqEros2rJK+brf9sJlrW2i+gFb9Sb7xXBd3DB6W3ksKTMjtYT1mlUb/nOmjssJ+gP4/o8aUOfz2m4Qz93EmoqYAeD6GcfTRGzcH08M+tg==
x-ms-office365-filtering-correlation-id: 5fedb34b-dd88-4489-f16d-08d64f54cd9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3852;
x-ms-traffictypediagnostic: DB3PR0402MB3852:
x-microsoft-antispam-prvs: <DB3PR0402MB38520187A9B121E16C25352FF5DA0@DB3PR0402MB3852.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3852;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3852;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(316002)(71200400001)(110136005)(8676002)(25786009)(81166006)(4326008)(71190400001)(6116002)(3846002)(106356001)(97736004)(5660300001)(66066001)(2201001)(2906002)(50226002)(478600001)(81156014)(8936002)(2501003)(256004)(14454004)(68736007)(39060400002)(36756003)(26005)(186003)(2900100001)(6486002)(6506007)(386003)(102836004)(86362001)(6436002)(6512007)(53936002)(7736002)(105586002)(52116002)(476003)(305945005)(486006)(99286004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3852;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /A+QNAsquvbt2EiiRSdRSDFsXq5+yyhtxUp5gtscQt8Tly9e2+6/p86e4z6fbkqGWOHTGIFsyNQubuotnLXlP03F7QGZ0IGLXvv1YvHq9nu0/+Z7+dtXmz3hFQRNyJ62J38gfGySC8iXlF7cKJMbEd5R1PoAAHmQY34xbmHb3czLqm8eWpW/5Xql449afzKIq5C30za4nuMzbcQeN7JGRhNFEnxF3wuMkwVCVs6Kzc3tIThyDbrSDBNLezRlmkY1WGofTh6eK/1N/IXER5NAirR0E9VGrKq/lUfO4GFX9ipyHHsokJf5RiFaNeuvIvFqklzZCaL9rqKRZLvghhdgr2OPnOuR5H7KAD3DPEWiMAE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fedb34b-dd88-4489-f16d-08d64f54cd9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 01:58:17.0359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3852
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
changes since V1:
	Introduce dummy function of legacy cooling register/unregister instead
of adding #define check in .probe function, handle error path correctly whe=
n
CONFIG_CPU_FREQ is NOT set.
 drivers/thermal/Kconfig       |  2 +-
 drivers/thermal/imx_thermal.c | 39 ++++++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 10 deletions(-)

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
index 1566154..44e0154 100644
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
@@ -669,6 +678,23 @@ static int imx_thermal_register_legacy_cooling(struct =
imx_thermal_data *data)
 	return 0;
 }
=20
+static int imx_thermal_unregister_legacy_cooling(struct imx_thermal_data *=
data)
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
+static inline int imx_thermal_unregister_legacy_cooling(struct imx_thermal=
_data *data)
+{
+	return 0;
+}
+#endif
+
 static int imx_thermal_probe(struct platform_device *pdev)
 {
 	struct imx_thermal_data *data;
@@ -743,13 +769,9 @@ static int imx_thermal_probe(struct platform_device *p=
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
@@ -830,8 +852,7 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 clk_disable:
 	clk_disable_unprepare(data->thermal_clk);
 cpufreq_put:
-	cpufreq_cooling_unregister(data->cdev);
-	cpufreq_cpu_put(data->policy);
+	imx_thermal_unregister_legacy_cooling(data);
=20
 	return ret;
 }
--=20
2.7.4

