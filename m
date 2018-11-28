Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D179FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCD52086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YS8A0RMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCD52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeK1U6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:58:44 -0500
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]:34688
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728154AbeK1U6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdhU9pS0lN3boypIHskXKjxHP2jUYWmy+kiEWhgLObc=;
 b=YS8A0RMjtmYTkuIQBQVV2mgzWBivzL7XjKb+ItlATPe2xN5l6+uE9a9YnGqT9BySF3U7no20X8psko+/vLabxV1KjZ7rpoqfZLT5G7ltZoQJuctubQ3O0ji5WPtZD/leyly219imL95f9OtvbrY6vPbdhLJNGZouvNyV9InqdX8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 09:57:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:57:31 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 2/4] rtc: add i.MX system controller RTC support
Thread-Topic: [PATCH V3 2/4] rtc: add i.MX system controller RTC support
Thread-Index: AQHUhwDG0FIAPUym8EqAu7gOhqQZcg==
Date:   Wed, 28 Nov 2018 09:57:29 +0000
Message-ID: <1543398696-3140-3-git-send-email-Anson.Huang@nxp.com>
References: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:203:36::36) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:fJgSiP3n8mBzspViaqM3xi5floIHBlYP9Jl+puIgJQV6kRzYvCaS4SANTFb/7e316Q0WPo8czLKsL8yt4jAOEk+brwITeJU0itF6KWjtKentrM8zE0Dtx5uGMkv5RbsVBuamnoPMYy7pDYXtzSqxyODwy67fY6Rw+CsgR0iLgWeNii7+RIKpMyGY4rFUd95NK7F94RkEJD42sWyh2r7Mxs6B5Qg7yWsi6hzwVAOmurWgK9Rhe9uOOv1ptr4Eft/RmOkQlfdrjWVQRVXI+33o/UqBRAOC68tozxTFITuKnwvPMtukDwdFghOgBuMkvuU0CoyU8FeeHiwvrMQlpiCtFMYnAw6rzGkK3ZybqVlrPgn/zc/iGwoRHh0z3aFQsDwlztUXoEz/oRgwHfMNVTN3bzhZIzjrBDpWbIW1dwi4i3Q7y9JoPtVI3daJluPWaa48ly22SI4r6VdgjV0aQ1nnjw==;5:AScs39KJHoLKX6+XQBXsulPlWN3f5qFNyc7NSHAXVzY9leK08EgV9wMfTqkf2xjUr8P+SsHBiv5MV13LEtdln2hZUifD6tEPfbjyvPrVrExVODQcYwK4HoDrUzWTSqYJ6dqejsUYcUq8tZn2TVTfxnmF4Ucq/Ae5+DL9Yn0eCBc=;7:+zv/cwkVPvC58imJW1Ex9QTJnU9z4Y8S0x0CBoTKVslwWCpxrot24m91hP0MF122YSdubONo8t2QgUuSi0GyaDTzcqvwy87jpUWkTeo4NyzZCXSan4dIr0F0GPq6vxuirhDDqaHNxAZSP65eS4ESyw==
x-ms-office365-filtering-correlation-id: 1f061103-5839-473f-f754-08d65517e8b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB36902F5278218901D39828FAF5D10@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(8936002)(50226002)(106356001)(256004)(8676002)(105586002)(305945005)(81156014)(7416002)(81166006)(71200400001)(53936002)(6512007)(25786009)(6116002)(3846002)(71190400001)(446003)(486006)(11346002)(476003)(2616005)(6486002)(2906002)(86362001)(2201001)(36756003)(186003)(110136005)(97736004)(99286004)(52116002)(7736002)(2501003)(14454004)(66066001)(68736007)(26005)(6436002)(386003)(478600001)(6506007)(316002)(76176011)(5660300001)(4326008)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iyD795jYI36ifyjR+dB9fXkc2BaIhAbkuFFHMQBVqC6gKe0vM8k/qHwVnTICSLZW4zrIEvqMi2MJDCfqrW+js0ilgRJvK7by5P6DiK7Wr9k9lk4O4UTJytUzbw1dnZM67kOLyDsaZEucNGzEldQTSZze2sKl49kNuW/M86MODVnfgMUIH9yhezxl9880tqpw1eUANVd92A5KCF60+XZ7DelEzeqe9sWBQfCDJ98CTkSQ7jIOaNraLABMbbkQFQDPbtt31zclyRZ7JAozkugCeUyYC6gXK4xUixNFu8/MrLnJ+gERMH/6HrxfkyCSn6JnGSXxd4neyFH/zBXVxgj/CMeXua4iSL3s9nXObLdJeQI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f061103-5839-473f-f754-08d65517e8b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:57:29.9139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and secure rtc etc..

This patch adds i.MX system controller RTC driver support,
Linux kernel has to communicate with system controller via MU
(message unit) IPC to set/get RTC time and other alarm functions,
since the RTC set time needs to be done in secure EL3 mode (required
by system controller firmware) and alarm functions needs to be done
with general MU IRQ handle, these depend on other components which
are NOT ready, so this patch ONLY enables the RTC time read.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V2:
	- make rtc_ipc_handle/imx_sc_rtc static;
	- remove comma in last entry of imx_sc_dt_ids;
	- rename rtc_device.
 drivers/rtc/Kconfig      |   6 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-imx-sc.c | 107 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 114 insertions(+)
 create mode 100644 drivers/rtc/rtc-imx-sc.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a819ef0..3b9642e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1677,6 +1677,12 @@ config RTC_DRV_SNVS
 	   This driver can also be built as a module, if so, the module
 	   will be called "rtc-snvs".
=20
+config RTC_DRV_IMX_SC
+	tristate "NXP i.MX System Controller RTC support"
+	help
+	   If you say yes here you get support for the NXP i.MX System
+	   Controller RTC module.
+
 config RTC_DRV_SIRFSOC
 	tristate "SiRFSOC RTC"
 	depends on ARCH_SIRF
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 290c173..f97c05e 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_RTC_DRV_GOLDFISH)	+=3D rtc-goldfish.o
 obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) +=3D rtc-hid-sensor-time.o
 obj-$(CONFIG_RTC_DRV_HYM8563)	+=3D rtc-hym8563.o
 obj-$(CONFIG_RTC_DRV_IMXDI)	+=3D rtc-imxdi.o
+obj-$(CONFIG_RTC_DRV_IMX_SC)	+=3D rtc-imx-sc.o
 obj-$(CONFIG_RTC_DRV_ISL12022)	+=3D rtc-isl12022.o
 obj-$(CONFIG_RTC_DRV_ISL12026)	+=3D rtc-isl12026.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+=3D rtc-isl1208.o
diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
new file mode 100644
index 0000000..b8e331e
--- /dev/null
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+
+#define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
+#define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
+
+static struct imx_sc_ipc *rtc_ipc_handle;
+static struct rtc_device *imx_sc_rtc;
+
+struct imx_sc_msg_req_timer_get_rtc_time {
+	struct imx_sc_rpc_msg hdr;
+} __packed;
+
+struct imx_sc_msg_resp_timer_get_rtc_time {
+	struct imx_sc_rpc_msg hdr;
+	u32 time;
+} __packed;
+
+static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct imx_sc_msg_resp_timer_get_rtc_time *resp;
+	struct imx_sc_msg_req_timer_get_rtc_time msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_TIMER;
+	hdr->func =3D IMX_SC_TIMER_FUNC_GET_RTC_SEC1970;
+	hdr->size =3D 1;
+
+	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("read rtc time failed, ret %d\n", ret);
+		return ret;
+	}
+
+	resp =3D (struct imx_sc_msg_resp_timer_get_rtc_time *)&msg;
+	rtc_time_to_tm(resp->time, tm);
+
+	return 0;
+}
+
+static const struct rtc_class_ops imx_sc_rtc_ops =3D {
+	.read_time =3D imx_sc_rtc_read_time,
+};
+
+static int imx_sc_rtc_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret =3D imx_scu_get_handle(&rtc_ipc_handle);
+	if (ret) {
+		if (ret =3D=3D -EPROBE_DEFER)
+			return ret;
+
+		dev_err(&pdev->dev, "failed to get ipc handle: %d!\n", ret);
+		return ret;
+	}
+
+	imx_sc_rtc =3D devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(imx_sc_rtc)) {
+		ret =3D PTR_ERR(imx_sc_rtc);
+		return ret;
+	}
+
+	imx_sc_rtc->ops =3D &imx_sc_rtc_ops;
+	imx_sc_rtc->range_min =3D 0;
+	imx_sc_rtc->range_max =3D U32_MAX;
+
+	ret =3D rtc_register_device(imx_sc_rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register rtc: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id imx_sc_dt_ids[] =3D {
+	{ .compatible =3D "nxp,imx8qxp-sc-rtc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, imx_sc_dt_ids);
+
+static struct platform_driver imx_sc_rtc_driver =3D {
+	.driver =3D {
+		.name	=3D "imx-sc-rtc",
+		.of_match_table =3D imx_sc_dt_ids,
+	},
+	.probe		=3D imx_sc_rtc_probe,
+};
+module_platform_driver(imx_sc_rtc_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX System Controller RTC Driver");
+MODULE_LICENSE("GPL");
--=20
2.7.4

