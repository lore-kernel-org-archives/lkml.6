Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D94C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAF421104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TPb1PPtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAF421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeKUQWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:22:42 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:9946
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbeKUQWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnFOQYtZfyPoGmDDLDtESH9FJlQQCSdy5S8e+1Moi2Q=;
 b=TPb1PPtD8Eq4ENz/VJzoxun8IZKaKMl3jqT0fPi3Y/e1flcIOzS2r0tq6MX/r9r1IGNc28BnQHGhSjYbtSdD46zH4BOOeVVv3/jEAvDD2RQ66EptW78GCD0JREJeCT6tL1Bac9/BUwtkp8TPorPTtbnz43mo+AFr44T09YE442I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3785.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Wed, 21 Nov 2018 05:49:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 05:49:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 1/2] thermal: imx: fix for dependency on cpu-freq
Thread-Topic: [PATCH V5 1/2] thermal: imx: fix for dependency on cpu-freq
Thread-Index: AQHUgV38O18LyIKJEkqTtSxbEeHS4w==
Date:   Wed, 21 Nov 2018 05:49:36 +0000
Message-ID: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3785;6:y4m7VQBxWaPWWH0uUB27Z09dS9zzwOJ4aUJZMOG7xEQEDeFHrDgCO0ZVe/NS9mJ6ZyA7UKtoHasvrJTM4a7E0e/iGzOt4ww4jmeVfZ1s+/1m94u4RxITD8PvFj92wRKF+P6l+4tAD7DhEZ6M5AkbvFCXsU/4rGQlYJWAj4NZLIwETluT4Pz/Od7OabgQRskxvrVySKWs9uX6q77tgQeXz8rFGIY/Ae0WJVKgX1gGbC3/kSr4fwPkPKRZSKeqd+MjKvo/9UcMdS3O19+Ffs5AmIu8fy2lUksbLJV97ejFvn45aEBkkwJgCtSnxrYJbaeqv/PaYDZb4Lzlk/sKxOvZm8MQHjdI3wy0N4h+2MoXOgjx2l0fuTHdZRUd6cS25QF+0gw1ugFGzwcD4CunSkwmR38CH/yA63c0FQvWJ7emrqaA6WZ6k5Xex85LP0S427NCbYL7Z1FBKeYFhaUoj9AnGA==;5:s/Ux+5DQLn6sT1gggqB647ybgsMYK1AuM/qLcv19rfOvY8Z1Z2TVQJh35BALkkq63g1wy4T0OgOBw+BF4JrmWlGOXRdNQNMFtlO5BPgl/Jk+Iv9Udrja8RxcOh0Ow8SVc9OkjCh2nXzh/2wLztuaxgAkUKyYP9aPfzWzF7h6Fvc=;7:z8NYAnaC/tdSO4Z7c1X/LeaM5av/Wlkw0e0vZdCJQbYUY2tmi2FlyFCMEwPxX+9fZnj2xkygLi+8UnDR+pW1bmz5nJ7yqhr7736VoZM6Xt0qubvSj4D9CaAwrZRlktzgZPpMDXcUpkKRAR5hF9iUIA==
x-ms-office365-filtering-correlation-id: d4bee690-ef2f-48b7-fb05-08d64f751e41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3785;
x-ms-traffictypediagnostic: DB3PR0402MB3785:
x-microsoft-antispam-prvs: <DB3PR0402MB37853A66647C3CC2E9F85C82F5DA0@DB3PR0402MB3785.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3785;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3785;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(71200400001)(102836004)(486006)(4326008)(256004)(5660300001)(66066001)(8676002)(106356001)(71190400001)(6506007)(6436002)(110136005)(6116002)(316002)(3846002)(26005)(86362001)(386003)(2906002)(476003)(2900100001)(478600001)(2201001)(2616005)(53936002)(81156014)(50226002)(52116002)(39060400002)(99286004)(8936002)(25786009)(81166006)(305945005)(7736002)(2501003)(97736004)(186003)(6486002)(105586002)(14454004)(36756003)(68736007)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3785;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WlNeazE01eWxkQMAHQfEQqmyJKNUKLwUdvFUqk5zAXDSneIqKxdBvUlgl8g2lqs0UAK2Gd9/SxFZNHh9b7RK3B5k7s/KR0h39sBx/wOa5WgCEM5TreYw6MebCWfDccLEmzAgVgPvreyCsbHg7H3QpPnxEd6OTQC/imu/PkNIfbLWNTojUUL8WwHo3LHfVJCliZBAisbiEzGFhSaktQhgVEGZeGVDYod4SjBf+CwK+LeA3gZjlUQgP2Yjao26bxCUrL3k4IL5ROL5FlorvoWbHNB5EsQ4QpCOk9rUBVp48pQnd4T3sAB/Q7nhpDaAqoJFGNeuCuu1KGLQcV7rtL94wyxErQu00RP3RiTig3eQZH8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bee690-ef2f-48b7-fb05-08d64f751e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 05:49:36.6869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
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
 drivers/thermal/Kconfig       |  2 +-
 drivers/thermal/imx_thermal.c | 47 ++++++++++++++++++++++++++++++++-------=
----
 2 files changed, 36 insertions(+), 13 deletions(-)

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
index 1566154..c924396 100644
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
@@ -669,6 +678,24 @@ static int imx_thermal_register_legacy_cooling(struct =
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
+
+#else
+
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
@@ -743,14 +770,11 @@ static int imx_thermal_probe(struct platform_device *=
pdev)
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
 	if (ret) {
+		if (ret =3D=3D -EPROBE_DEFER)
+			return ret;
+
 		dev_err(&pdev->dev,
 			"failed to register cpufreq cooling device: %d\n", ret);
 		return ret;
@@ -762,7 +786,7 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 		if (ret !=3D -EPROBE_DEFER)
 			dev_err(&pdev->dev,
 				"failed to get thermal clk: %d\n", ret);
-		goto cpufreq_put;
+		goto legacy_cleanup;
 	}
=20
 	/*
@@ -775,7 +799,7 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 	ret =3D clk_prepare_enable(data->thermal_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-		goto cpufreq_put;
+		goto legacy_cleanup;
 	}
=20
 	data->tz =3D thermal_zone_device_register("imx_thermal_zone",
@@ -829,9 +853,8 @@ static int imx_thermal_probe(struct platform_device *pd=
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

