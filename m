Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E03C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E1F21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T5DCQJsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbeLTI4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:56:30 -0500
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:49567
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728725AbeLTI42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DjiJUU3JsLHTOMWgTAfFMxUCK01lBDe2voLmWTW15g=;
 b=T5DCQJsSBEEnpKsgxjoIZKR/98e76S2kaZM8RfRp4emiSZVBHguWIuX7bFsstpjFaBm20sszSympZ6fl/9azXvFN3rluHZ3DfglvzjMmVFm1HMlWB7Vq0wea+9wZXZLHMLHZp8osujWCwzg1HRGlbk+3WPB4u4uaYkjBRAynJD4=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3653.eurprd04.prod.outlook.com (52.133.28.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 08:56:16 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71%2]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 08:56:16 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 2/4] rtc: add i.MX system controller RTC support
Thread-Topic: [PATCH V5 2/4] rtc: add i.MX system controller RTC support
Thread-Index: AQHUmEHdVixj4el6fUSTLnxifG4HUQ==
Date:   Thu, 20 Dec 2018 08:56:16 +0000
Message-ID: <1545295872-20169-3-git-send-email-Anson.Huang@nxp.com>
References: <1545295872-20169-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545295872-20169-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3653;6:XBpKXG4VT24jF9P1ULrbrrt1XFi1DgWhlDCfPwIDWRCp+WkU7bQA+Hrg+IoUk8TZ9vMhVY5xCofC/IepPjgEkg8Sw9Q3TkLgzq/MhU/Fi1WNYG9t6JuHIuMDr8cqo+BjCCoP5Ww49HC4dk4502ijuh3Rpv8ab8JYOsOwb+fDudgAj1vDRyE+E1CnLenk54BFqlz1RBXcnsZQDaqIHhZYY+bYSlXsHgxHxi0lTlUW+QmijiZu2F3Jxg5vQKI32fYVAgXakrne4kNdwB5qLt++d8UqSbLK/iWM7+BL1l8z02gcXzB0uOLR0ZUxjqa6GtdCVSo7WQ8z3EbYIsrplHVsKjVBx6rxwO4/tMwmPFY1UMVmhgfZ3uFZKShJcz/FdNXzoEClQi9b/PzytDeovOvjoFYKW1WulJRzqwyCVhY2b6kIPCoXfEVSHnwDxzeS/8N4MFXq42XIz/Qcfuyo9CgIIQ==;5:gmCxj3zb57mMrY4/5E8hMCYzj/EM0toLoPZE+D9UNk9bwnld7NfEcldZiWX9lteDRSjmB+NWuBJVZCsZVT0KjQbaTch0Js8T8Hbdejhb2qb1m6f+aE8mKt1aqBnbKDooUyV2G5LjrBXEAcLdLsIaHttK2Ll9kkuQiVc7BTGwbYc=;7:GjfGGUdPSq5I2LASqytcEPdx5+PmsOuqgTxsGVFK4TkmF0TX+BMTrCHcTFxzbIH0nHJcGVHu+sn8wSBiRhDMgpzN7eCxVY7BGFbzCPwF2IfXF0wDsVELkSn8XxYXJasAZjB0IJG/+Fl9xNB9idGbew==
x-ms-office365-filtering-correlation-id: b03dbc36-1815-4819-eabe-08d666590028
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3653;
x-ms-traffictypediagnostic: AM6PR0402MB3653:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB36539ADE30D47427B9567C2AF5BF0@AM6PR0402MB3653.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3653;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3653;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(54534003)(76176011)(102836004)(11346002)(446003)(2616005)(6506007)(14454004)(386003)(478600001)(52116002)(53936002)(2201001)(6512007)(575784001)(86362001)(25786009)(71200400001)(71190400001)(50226002)(110136005)(4326008)(6436002)(68736007)(6486002)(5660300001)(106356001)(105586002)(305945005)(316002)(66066001)(2501003)(97736004)(7416002)(99286004)(81166006)(81156014)(8936002)(8676002)(7736002)(3846002)(6116002)(2906002)(256004)(6346003)(26005)(476003)(36756003)(486006)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3653;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-message-info: h+bT9s0jM4hMS2iaz0f4/eTVx674uRi70sqOmaXpdTIie/hVaWKayxI0HxDOzfjw/AhXXxqIVclucF8h8+RIdkEd0Ks7IRLykzBgyyOWU/eQIQ87Qv+gtsU/CVD+6eShG3IFRYj5SLJYPHqm6ineKRs/GHKu7euZQTd8q9+kukso5JMjs+OzoYeEeRLIMcOjMyp8rAZsXVtummHgM2lme48FDJ3TDvF4vbwC65KZcXfxbPCEvI6AjWLH+P8lN9gRXVB0nSzR3TcfBYRRvyRU1u4aa7lDQmvukg7nnHfyCjYSdlIx6Ff/HyFRFZan4kS8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03dbc36-1815-4819-eabe-08d666590028
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 08:56:16.2409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3653
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
ChangeLog since V4:
    - Add dependency on IMX_SCU to avoid compile error when IMX_SCU is NOT =
enabled;
    - Use dev_err instead of pr_err;
    - Remove unneccssary different errors check in imx_scu_get_handle which=
 is already done in API.
---
 drivers/rtc/Kconfig      |  7 ++++
 drivers/rtc/Makefile     |  1 +
 drivers/rtc/rtc-imx-sc.c | 91 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 99 insertions(+)
 create mode 100644 drivers/rtc/rtc-imx-sc.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a819ef0..225b0b8 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1677,6 +1677,13 @@ config RTC_DRV_SNVS
 	   This driver can also be built as a module, if so, the module
 	   will be called "rtc-snvs".
=20
+config RTC_DRV_IMX_SC
+	depends on IMX_SCU
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
index 0000000..7ff0854
--- /dev/null
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP.
+ */
+
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
+struct imx_sc_msg_timer_get_rtc_time {
+	struct imx_sc_rpc_msg hdr;
+	u32 time;
+} __packed;
+
+static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct imx_sc_msg_timer_get_rtc_time msg;
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
+		dev_err(dev, "read rtc time failed, ret %d\n", ret);
+		return ret;
+	}
+
+	rtc_time_to_tm(msg.time, tm);
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
+	if (ret)
+		return ret;
+
+	imx_sc_rtc =3D devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(imx_sc_rtc))
+		return PTR_ERR(imx_sc_rtc);
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
+	{ .compatible =3D "fsl,imx8qxp-sc-rtc", },
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

