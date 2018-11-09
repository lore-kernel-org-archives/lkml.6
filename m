Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB39C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 04:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624EF20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 04:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OS1o2GtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624EF20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeKIOfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 09:35:51 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:60291
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727485AbeKIOfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 09:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAwvvhoyiZVO4/9U5EmVzBaE+AH0R9CmrRzPnBbnOuQ=;
 b=OS1o2GtYFMbdMgP+Fk/BOWN2JPV/zpc4Ty8jOab4A5QrMw/pzgpmczGu0rqWCvFQs5qI8KJaV7vsBZ33DtDAZsKYXmGWyTN3ygP8sVwoIMHHYMxhy+YT4zm+jQHjcSIGAgnB+uYI1yZtv9Yv2jgUIZ+FuYCG94Evkb88exoIu+U=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3835.eurprd04.prod.outlook.com (52.134.65.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.32; Fri, 9 Nov 2018 04:56:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 04:56:56 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] gpio: mxc: move gpio noirq suspend/resume to syscore phase
Thread-Topic: [PATCH] gpio: mxc: move gpio noirq suspend/resume to syscore
 phase
Thread-Index: AQHUd+ijCR6p4Fob00uSJJeaQFWOJA==
Date:   Fri, 9 Nov 2018 04:56:56 +0000
Message-ID: <1541739112-383-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:203:2e::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3835;6:7fQV92vl0nYZ4nfTNw0QjQuO58eQGK+DFo6LebKlaa3HAd/V8ChMZreNZhY/GGNRBlw01MrEhiYIcywkHZLRwAhKhoGDomW36rNZ+802HDdxupe7bAOFiFP0hkGuxsF8/UcfHJAxaKfbM4uOjAMvZSrv+JKALaJWL3WMYicNGcIOqcSEr6Ch4Am+j/S1ADTNL8UCIPKS0qQOHKrqLtt2E04FrpqoNPjE1jgHdFPJpCY3YoYsoFtHcEr8G/S8/hzp0nqwAeWxcFJnI5xIoWNef1tbSf4y01VdLd9Hq273VOf4cBnx0HGw7OYrbr9lv3VmIyMxTvzjRVMQHy+FY2w0Oj9y4aZY70ANE7H88VvMfERAc+m/XGOulnMh/6XjlRVboA0+lubGYh+CL9foKLuKByS6vwY/EIW19k6T0AI1wHiArOHlK1LMNnNkywHV6l/gGrXajbEuenRYjYHKh0BBXw==;5:wcK/G19LRnD/mvsKWgTaFE4y3UcJ/8TaKchyoYbRvyZIpshVpY1MKUI4TnyItwbHDgRstasqwhHX0NIqUBQ5rm7YL9XGF9ojOox905b95chFWpNgTVTq7qe7BM2IQzZBjhbx65Qkf6bebuqhvLJSNV1rgbj4sHhEvVPW6jeGBNM=;7:LNqLpNvujn27gt4g9/9LssuFF/++r/pjQugXkKAkd4ox36SW5EMja8onZqMXjqXNwGC5fjDUN50TxAOrA9XlzYdYZ8tNleQ2STZEDM4eIA/v3TGmWU7aD0PFNcjkYcC6QKwDHWjgBWriA/qN62RE+A==
x-ms-office365-filtering-correlation-id: ebf488f3-f5df-41bd-c51d-08d645ffc5f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3835;
x-ms-traffictypediagnostic: DB3PR0402MB3835:
x-microsoft-antispam-prvs: <DB3PR0402MB383594A42708B68B0E8BECA1F5C60@DB3PR0402MB3835.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3835;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3835;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(189003)(199004)(99286004)(36756003)(2906002)(81156014)(81166006)(15650500001)(3846002)(53936002)(6512007)(2201001)(8676002)(4326008)(25786009)(86362001)(71190400001)(256004)(71200400001)(14444005)(478600001)(2900100001)(68736007)(66066001)(52116002)(2616005)(2501003)(50226002)(102836004)(476003)(110136005)(6506007)(486006)(6486002)(1857600001)(5660300001)(386003)(97736004)(8936002)(6116002)(186003)(316002)(26005)(105586002)(106356001)(7736002)(6436002)(305945005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3835;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8cPmle5Vlpy3gTog77Uy0pilifrNmPJBcaRlgPQKID5UbFdaRjWmNBdey0B7tsqf77oCXiRSolcLFnPzG21ORy39lEKNq0emdOIzjpfJ7kZ5jikQTB6wr6inxTwqebu/bmiPS1b4swljm8qUZVg3q37zJ903kD4PQLmQW/60oPAo7XoNXVxF6k/1BV95z69cfre1SufOAJVnnXPfJqyjvdv9XwT59wuzJBsXjBwjanEJNXRKDFFAmXhrEsgGi6nDTWuNORJqLSbPAFZ0a/VFojZ/3b4/YRXs1XFszE68X/fFvoedSgan2TjcMc3PvIpL9M8fxp1LBC/GiJaD+MFsvuLtR5agy7RZmwtCzvWZ0l0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf488f3-f5df-41bd-c51d-08d645ffc5f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 04:56:56.7511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During noirq suspend/resume phase, GPIO irq could arrive
and its registers like IMR will be changed by irq handle
process, to make the GPIO registers exactly when it is
powered ON after resume, move the GPIO noirq suspend/resume
callback to syscore suspend/resume phase, local irq is
disabled at this phase so GPIO registers are atomic.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/gpio/gpio-mxc.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 5c69516..2d1dfa1 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/syscore_ops.h>
 #include <linux/gpio/driver.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -550,31 +551,38 @@ static void mxc_gpio_restore_regs(struct mxc_gpio_por=
t *port)
 	writel(port->gpio_saved_reg.dr, port->base + GPIO_DR);
 }
=20
-static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
+static int mxc_gpio_syscore_suspend(void)
 {
-	struct mxc_gpio_port *port =3D dev_get_drvdata(dev);
+	struct mxc_gpio_port *port;
=20
-	mxc_gpio_save_regs(port);
-	clk_disable_unprepare(port->clk);
+	/* walk through all ports */
+	list_for_each_entry(port, &mxc_gpio_ports, node) {
+		mxc_gpio_save_regs(port);
+		clk_disable_unprepare(port->clk);
+	}
=20
 	return 0;
 }
=20
-static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
+static void mxc_gpio_syscore_resume(void)
 {
-	struct mxc_gpio_port *port =3D dev_get_drvdata(dev);
+	struct mxc_gpio_port *port;
 	int ret;
=20
-	ret =3D clk_prepare_enable(port->clk);
-	if (ret)
-		return ret;
-	mxc_gpio_restore_regs(port);
-
-	return 0;
+	/* walk through all ports */
+	list_for_each_entry(port, &mxc_gpio_ports, node) {
+		ret =3D clk_prepare_enable(port->clk);
+		if (ret) {
+			pr_err("mxc: failed to enable gpio clock %d\n", ret);
+			return;
+		}
+		mxc_gpio_restore_regs(port);
+	}
 }
=20
-static const struct dev_pm_ops mxc_gpio_dev_pm_ops =3D {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_resu=
me)
+static struct syscore_ops mxc_gpio_syscore_ops =3D {
+	.suspend =3D mxc_gpio_syscore_suspend,
+	.resume =3D mxc_gpio_syscore_resume,
 };
=20
 static struct platform_driver mxc_gpio_driver =3D {
@@ -582,7 +590,6 @@ static struct platform_driver mxc_gpio_driver =3D {
 		.name	=3D "gpio-mxc",
 		.of_match_table =3D mxc_gpio_dt_ids,
 		.suppress_bind_attrs =3D true,
-		.pm =3D &mxc_gpio_dev_pm_ops,
 	},
 	.probe		=3D mxc_gpio_probe,
 	.id_table	=3D mxc_gpio_devtype,
@@ -590,6 +597,8 @@ static struct platform_driver mxc_gpio_driver =3D {
=20
 static int __init gpio_mxc_init(void)
 {
+	register_syscore_ops(&mxc_gpio_syscore_ops);
+
 	return platform_driver_register(&mxc_gpio_driver);
 }
 subsys_initcall(gpio_mxc_init);
--=20
2.7.4

