Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9970C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 02:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF3920989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 02:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vc8iaMNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF3920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeKUNMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:12:53 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:23920
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbeKUNMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 08:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IbWOzXEG8lwvASZbHVkx0sIdr2DctGujCxDVfbnG/4=;
 b=vc8iaMNUOxPm5Tu7S5CW4uwYOudtyPVpYw4/PlnK9GvpWCvVWltQb18CwZUKByQmLStgmWIm4ozPQxX40BtJa/8EbpUZCnc6o+9i+zD381JL3PCh9ANaa6fQWuln0wCcdpJw7qtrhDN4tMnkhRmbLfBQD84BGvG9VD9xoWS+WW0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 21 Nov 2018 02:40:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 02:40:25 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3] thermal: imx: fix for dependency on cpu-freq
Thread-Topic: [PATCH V3] thermal: imx: fix for dependency on cpu-freq
Thread-Index: AQHUgUOOUNfbKOmxbEi5Wn+3w8jwqA==
Date:   Wed, 21 Nov 2018 02:40:25 +0000
Message-ID: <1542767703-1984-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3883;6:z3IrxjbZTZUFIhNOBS+LwFQo1Bbakg0Kk4PHFQk2LSjO76jsVV1kJvzfwbExaYbWlrDfP+/Tf6IyBOQR5udOO3tUDeaWRu7TFN7Fa38+aXT5Pj3/OZ4f/piOBVgCj8WVK2hHNxB7HV3sGhEyrJB4jBpejvOgJOEhYUQiqDPsPTQ1BNGOXVwEFJ7tcv6FKwlhAgH6CG0v2m4EOHF+nW6oJP5GIgZDTITLSPey+nojdx2h9GpejdX7TlrezZfjkLmyrqCUM1xrlQcVUQzd43oU3yZQWVXblM7fr3yTZ/0Oe/KULJQYYA+XYZd2Hc5ShWoP8+zZ22tI0wS9VeUXHMNse4bkzfMBH/zxM/KGmQdrd6BjkBQTRZv/RL89Z54G9BLACfWqisqvTyhshOCsdsSVO/VpBSExzZBF3BbrCD805n+qdlcZnLlrMRiCaeF0w42+dBfnbI37vLc6Dm/E5+IG0g==;5:t1M9EBk06YtFKLmc1qr87QFM56ZSFBjaR3r/RBGhTE/gNezpE6NXQFGRzVHXqTinem0TXPA9EB2FqvSrt4WEjz8uHABKvQkcdDR1oEDEzs4l3FS149zkHZqV2bmi8XZ/inDA8em5+TBY6/WkjDerKpORBNL8jwZvsZi6JYW+Zzc=;7:QTzMHRlMqhIwX7vgah+6qAMihcBJ5v8UzYLk2ZUOLzx4KHW+nlbgnGafJrzyo7CRXfcVj15PQq6KAyNdzMFDpY+AXBl1mvvf5Z0lufFGn/Gp0DnO1V05SdvNQeR7hrTXQmJ8wtiMU+Q+vMeIqCu+Dg==
x-ms-office365-filtering-correlation-id: 1d8cac30-ffe4-4bf8-bdad-08d64f5ab0d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-microsoft-antispam-prvs: <DB3PR0402MB3883AC00A719D1D44FE8B761F5DA0@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3883;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3883;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(396003)(136003)(189003)(199004)(81156014)(81166006)(39060400002)(2616005)(14444005)(256004)(8676002)(8936002)(4326008)(6116002)(97736004)(3846002)(486006)(5660300001)(71190400001)(110136005)(50226002)(53936002)(6512007)(6436002)(68736007)(2501003)(476003)(71200400001)(7736002)(105586002)(86362001)(305945005)(26005)(25786009)(102836004)(52116002)(186003)(106356001)(2906002)(386003)(6506007)(14454004)(316002)(2201001)(66066001)(2900100001)(478600001)(6486002)(99286004)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3VzUN1IEVGGJNnavwyri9BWLTSCd12+3N0W5vdEv4eWuk589V6uzrAt2eL0WOb+R8x5/wye66v/7SfCZ7zJVesiHxa9BMvYhmKJ2mCy0NN1cGbJyfCuvEXN9oC9ntTmgCePyyUwlR5sjffSXjcACwTU0zPkoEC2ldikWC9FV0nMfhP9HR6Ggge254KfUj7KBy32Y2RGCqi/C0Bfeo1ejnGm+l6xMoBVhafZfvyEAhN4iJnHP3aDPUnef0/masmpiBrcgceBYHP9igMZgUGx4wisnwhcA8TJyc7ScqKtMFlZ+Lfr4Z71BThNuorXIuHxxeq1FIhokZDlIeqkrDiBMMBHMD8QH98lQQ8gMbGqmVig=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8cac30-ffe4-4bf8-bdad-08d64f5ab0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 02:40:25.9277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
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
changes since V2:
	fix build warning of no return value for imx_thermal_unregister_legacy_coo=
ling.
 drivers/thermal/Kconfig       |  2 +-
 drivers/thermal/imx_thermal.c | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 10 deletions(-)

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
index 1566154..518e5a0 100644
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
@@ -830,8 +851,7 @@ static int imx_thermal_probe(struct platform_device *pd=
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

