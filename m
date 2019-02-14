Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1ABC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772372177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZVqEXcXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438522AbfBNLqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:46:17 -0500
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:49888
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727868AbfBNLpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZil3f5lc3RjSr9khnquoomA3GFVw4UnOOr3k5Z/RIw=;
 b=ZVqEXcXSNWi4Bo+1lj9/hlrthD7jWGK6bgGobkhw9pr8HpRjobmVo5196SRaoQPRmFH7tk8t63mkoK5ebjxoXjf/zZVB9WIHzoR+tGBUT4q5fvhr79yvbh7wP4DLidqnmgAh0kK3hxzIurhDrRPew0oVGfTsg88bRb2WGHWYO3o=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 11:45:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 11:45:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/4] watchdog: imx_sc: Add i.MX system controller watchdog
 support
Thread-Topic: [PATCH 2/4] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHUxFq1gAj/lMKvbEW699bfZ6osBA==
Date:   Thu, 14 Feb 2019 11:44:56 +0000
Message-ID: <1550144346-1187-3-git-send-email-Anson.Huang@nxp.com>
References: <1550144346-1187-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550144346-1187-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7083b570-7dfd-41ec-f8d5-08d69271d74e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3676;
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3676;23:SWQ7mM0QEsMAeWpITV/K7N39rLOQf1AUxaw7J?=
 =?iso-8859-1?Q?f4Fu56swtNVKrapOSakL5nqOGl2zACW+l7IB2WqWGQn/ov3dZOIlCJwubD?=
 =?iso-8859-1?Q?6/ZNJudZIFHRCaF5QVLSE4d9SbWB3sJuJIuSQhBoUbfe7ZDnOGacauT3xI?=
 =?iso-8859-1?Q?4WiBXM4hygjpXEDtAUvt4rAaY9HtloCK7lxxeMNOhA4lM3s9AyqzjEpags?=
 =?iso-8859-1?Q?rgJY0QvRXkYqItKM8sHnxyjao3eOnobkJ0kqf+sf+rLMspLCfMSDrnIM4I?=
 =?iso-8859-1?Q?5kYWYzXlpfUUif1/1i9JZWaEwW+D8mbHuVeB5SsKJSXEaPxOkOacpFZDV/?=
 =?iso-8859-1?Q?P4oEzzsfz9anUddCgqvLW2XiulIJtXxuo2kJuHeOH15gzLODNPTWiA6wA9?=
 =?iso-8859-1?Q?gQYCqjRB4NZKUaBxVOOkZwh0AXlYOwhoyjQ78+jTqzyLiE4P6SCj+JkaDs?=
 =?iso-8859-1?Q?hgTC+oMGaUwnSkzhX76MkssVzEqyzyHS+5qSLdbyXBbT3qo7RnogwMXNkc?=
 =?iso-8859-1?Q?dZuw9OhKb647FGd0I1JPlKdIcb5v5elfjOozkQYPxORIm0FlttaRTWcu80?=
 =?iso-8859-1?Q?nuIwSBDu6H0xiv0JsFq0kuUPWZzDO3pwpJdnibQlbdasVl3peLi031TUds?=
 =?iso-8859-1?Q?GyK+TcyAX0U+4BOGmJPPLAfNibfom3ZU25OPoE8fHTmjOSbVQISZv0NjFo?=
 =?iso-8859-1?Q?MurKQ+W/P0S6IG1osXW/AcPjiknHdfi+C0yCXpuliekd4ocd6LvdKlHak3?=
 =?iso-8859-1?Q?3wCs98fg72p05fVNFFi4srMmLX9+aZQxpFK0JYYTAaz7lv6Nrl4yE6z/Dt?=
 =?iso-8859-1?Q?XUA3hCrysEYlyLjc6W2DIN9QMe6BM2L5wtm6Wf3Db141v63TxlHkaGreUI?=
 =?iso-8859-1?Q?iXZs08nQjWv8tQY71s+ARTPNrf/NouBBnOAf5lakqUTIeGhz23LqWqCxt/?=
 =?iso-8859-1?Q?RHxa8wg1PoUNDyL3Zt5gHkzPcDZxUriQViCYeYIwDXqMA1sKl92Wsn5rIR?=
 =?iso-8859-1?Q?RJ6JhdglnoDxWPi8zun7thXPQdIQrtBs1h73fQ1KXGZEK0VIYH8tNAzCS8?=
 =?iso-8859-1?Q?tvR9Maal7VqT3Jr8gRGb5Pvrt3l5S+4lGZTR6HM858HINkNJHinhlYwspn?=
 =?iso-8859-1?Q?Vie21kK/OR9GAdup3eYakbCJ7ARsAjKALPIOduyRriCeZmXD+TOJoKQz5P?=
 =?iso-8859-1?Q?sfkQUt0SP1f+Z0DXWZyjUdV+MEhlGicHXG+26NN0YUYMBEN8gn0ZRdKGGF?=
 =?iso-8859-1?Q?e+UO4fm3gNB9ZRSIW/AB6kWtsmOLBPyOJ7El/ivHyC1W81hE+M7bLBeo0y?=
 =?iso-8859-1?Q?gQZ8Il5OKJzwuhMUdtuKhN2UQ?=
x-microsoft-antispam-prvs: <DB3PR0402MB3676C478450004CBFBCB8F93F5670@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(199004)(476003)(2616005)(486006)(2201001)(6436002)(36756003)(66066001)(106356001)(7416002)(446003)(25786009)(105586002)(186003)(6506007)(386003)(11346002)(26005)(3846002)(6116002)(4326008)(102836004)(99286004)(256004)(8936002)(81166006)(81156014)(8676002)(2906002)(14454004)(7736002)(97736004)(14444005)(6666004)(305945005)(71200400001)(2501003)(86362001)(316002)(50226002)(68736007)(6512007)(478600001)(6486002)(52116002)(76176011)(53936002)(110136005)(71190400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3676;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nGIVP/YLhFZcT06OyhyaI+mEJSMdlsPlvsOW10J2uHm/UbnIPAE8r5b+mHQHiH503jPefBTBvNoPFeZJf+A1Bf6NDeOMLa3u5dMAJjx97rSv8fUa0IWgRDDIBGt4YkWS3jjRsEroxB1RL4KBr4GcFfzW8kxmfWPPWgaHc9YXGlJIYzX9ke15PL4T/DGd4TGj4TRaYSjfjABCeYkNoufNA4BBBCHOMG9VEH2+UQMfPlKGcvLqMEY7ON95smCMdLKS84kqymPxJErsgNL6ahi7EWkwCYgMpCi5dpvEewySpIUcZgZSxts2ICCGJ1ptOELV4mVTOXiTCGmFfYJy3Nq6NwvPf7UljdQNg+LCaMEESrvtc4VyerzAMOOwFjjl5GFsqYRTgUf4CCYAnQoRlJjS+0CITVrqE14j7ro+n+7swlI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7083b570-7dfd-41ec-f8d5-08d69271d74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:44:47.9593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and watchdog etc..

This patch adds i.MX system controller watchdog driver support,
watchdog operation needs to be done in secure EL3 mode via
ARM-Trusted-Firmware, using SMC call, CPU will trap into
ARM-Trusted-Firmware and then it will request system controller
to do watchdog operation via IPC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/watchdog/Kconfig      |  13 +++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/imx_sc_wdt.c | 210 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 224 insertions(+)
 create mode 100644 drivers/watchdog/imx_sc_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 65c3c42..5c5b8ba 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -625,6 +625,19 @@ config IMX2_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx2_wdt.
=20
+config IMX_SC_WDT
+	tristate "IMX SC Watchdog"
+	depends on ARCH_MXC || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  This is the driver for the system controller watchdog
+	  on the NXP i.MX SoCs with system controller inside.
+	  If you have one of these processors and wish to have
+	  watchdog support enabled, say Y, otherwise say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx_sc_wdt.
+
 config UX500_WATCHDOG
 	tristate "ST-Ericsson Ux500 watchdog"
 	depends on MFD_DB8500_PRCMU
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 4e78a8c..0c9da63 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_NUC900_WATCHDOG) +=3D nuc900_wdt.o
 obj-$(CONFIG_TS4800_WATCHDOG) +=3D ts4800_wdt.o
 obj-$(CONFIG_TS72XX_WATCHDOG) +=3D ts72xx_wdt.o
 obj-$(CONFIG_IMX2_WDT) +=3D imx2_wdt.o
+obj-$(CONFIG_IMX_SC_WDT) +=3D imx_sc_wdt.o
 obj-$(CONFIG_UX500_WATCHDOG) +=3D ux500_wdt.o
 obj-$(CONFIG_RETU_WATCHDOG) +=3D retu_wdt.o
 obj-$(CONFIG_BCM2835_WDT) +=3D bcm2835_wdt.o
diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
new file mode 100644
index 0000000..ae52e34
--- /dev/null
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/watchdog.h>
+
+#define DEFAULT_TIMEOUT 60
+/*
+ * Software timer tick implemented in scfw side, support 10ms to 0xfffffff=
f ms
+ * in theory, but for normal case, 1s~128s is enough, you can change this =
max
+ * value in case it's not enough.
+ */
+#define MAX_TIMEOUT 128
+
+#define IMX_SIP_TIMER			0xC2000002
+#define IMX_SIP_TIMER_START_WDOG		0x01
+#define IMX_SIP_TIMER_STOP_WDOG		0x02
+#define IMX_SIP_TIMER_SET_WDOG_ACT	0x03
+#define IMX_SIP_TIMER_PING_WDOG		0x04
+#define IMX_SIP_TIMER_SET_TIMEOUT_WDOG	0x05
+#define IMX_SIP_TIMER_GET_WDOG_STAT	0x06
+#define IMX_SIP_TIMER_SET_PRETIME_WDOG	0x07
+
+#define SC_TIMER_WDOG_ACTION_PARTITION	0
+
+static bool nowayout =3D WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0000);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (defau=
lt=3D"
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static unsigned int timeout =3D DEFAULT_TIMEOUT;
+module_param(timeout, uint, 0000);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=3D"
+		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
+
+static struct watchdog_device imx_sc_wdd;
+
+static int imx_sc_wdt_ping(struct watchdog_device *wdog)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_PING_WDOG,
+		      0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static int imx_sc_wdt_start(struct watchdog_device *wdog)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_START_WDOG,
+		      0, 0, 0, 0, 0, 0, &res);
+	if (res.a0)
+		return res.a0;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_WDOG_ACT,
+		      SC_TIMER_WDOG_ACTION_PARTITION,
+		      0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static int imx_sc_wdt_stop(struct watchdog_device *wdog)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_STOP_WDOG,
+		      0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static int imx_sc_wdt_set_timeout(struct watchdog_device *wdog,
+				unsigned int timeout)
+{
+	struct arm_smccc_res res;
+
+	wdog->timeout =3D timeout;
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_TIMEOUT_WDOG,
+		      timeout * 1000, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static const struct watchdog_ops imx_sc_wdt_ops =3D {
+	.owner =3D THIS_MODULE,
+	.start =3D imx_sc_wdt_start,
+	.stop  =3D imx_sc_wdt_stop,
+	.ping  =3D imx_sc_wdt_ping,
+	.set_timeout =3D imx_sc_wdt_set_timeout,
+};
+
+static const struct watchdog_info imx_sc_wdt_info =3D {
+	.identity	=3D "i.MX SC watchdog timer",
+	.options	=3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE | WDIOF_PRETIMEOUT,
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int imx_sc_wdt_suspend(struct device *dev)
+{
+	if (test_bit(WDOG_ACTIVE, &imx_sc_wdd.status))
+		imx_sc_wdt_stop(&imx_sc_wdd);
+
+	return 0;
+}
+
+static int imx_sc_wdt_resume(struct device *dev)
+{
+	if (test_bit(WDOG_ACTIVE, &imx_sc_wdd.status))
+		imx_sc_wdt_start(&imx_sc_wdd);
+
+	return 0;
+}
+
+static const struct dev_pm_ops imx_sc_wdt_pm_ops =3D {
+	.suspend =3D imx_sc_wdt_suspend,
+	.resume =3D imx_sc_wdt_resume,
+};
+
+#define IMX_SC_WDT_PM_OPS	(&imx_sc_wdt_pm_ops)
+
+#else
+
+#define IMX_SC_WDT_PM_OPS	NULL
+
+#endif
+
+static int imx_sc_wdt_probe(struct platform_device *pdev)
+{
+	struct watchdog_device *wdt =3D &imx_sc_wdd;
+	int err;
+
+	platform_set_drvdata(pdev, wdt);
+
+	wdt->info =3D &imx_sc_wdt_info;
+	wdt->ops =3D &imx_sc_wdt_ops;
+	wdt->min_timeout =3D 1;
+	wdt->max_timeout =3D MAX_TIMEOUT;
+	wdt->parent =3D &pdev->dev;
+	watchdog_set_drvdata(wdt, NULL);
+
+	err =3D watchdog_init_timeout(wdt, DEFAULT_TIMEOUT, &pdev->dev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to init the wdog timeout:%d\n",
+			err);
+		return err;
+	}
+
+	err =3D watchdog_register_device(wdt);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register watchdog device\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int imx_sc_wdt_remove(struct platform_device *pdev)
+{
+	struct watchdog_device *wdt =3D platform_get_drvdata(pdev);
+
+	imx_sc_wdt_stop(wdt);
+
+	watchdog_unregister_device(wdt);
+
+	return 0;
+}
+
+static void imx_sc_wdt_shutdown(struct platform_device *pdev)
+{
+	struct watchdog_device *wdt =3D platform_get_drvdata(pdev);
+
+	if (watchdog_active(wdt))
+		imx_sc_wdt_stop(wdt);
+}
+
+static const struct of_device_id imx_sc_wdt_dt_ids[] =3D {
+	{ .compatible =3D "fsl,imx8qxp-sc-wdt", },
+	{ /*sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_sc_wdt_dt_ids);
+
+static struct platform_driver imx_sc_wdt_driver =3D {
+	.probe		=3D imx_sc_wdt_probe,
+	.remove		=3D imx_sc_wdt_remove,
+	.shutdown	=3D imx_sc_wdt_shutdown,
+	.driver		=3D {
+		.name	=3D "imx-sc-wdt",
+		.of_match_table =3D imx_sc_wdt_dt_ids,
+		.pm	=3D IMX_SC_WDT_PM_OPS,
+	},
+};
+
+module_platform_driver(imx_sc_wdt_driver);
+
+MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX system controller watchdog driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4

