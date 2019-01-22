Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FE9C41518
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862BF20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rRZLYkMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfAVD3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:29:30 -0500
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:15021
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbfAVD33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 22:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8Wq/jIYAhSIzVUXwGevh+56kPcloVWwk8cz9mpLoDA=;
 b=rRZLYkMSQUsXSbngQUgHr9YdQrWwZt38e80wD4MG214QGKlyW9z2/dHJ3pMG+kyYvLxtA0TuizxbLER27Wo4Q7Zdjk9zucXdssE1oo/7X2hE7uoSdT0ec4XecPlu9mAxGBHNEWMVSWQlgZw/BpYoOZsz8e3q5CdS8EQ8tm/Jbjs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Tue, 22 Jan 2019 03:29:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 03:29:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] rtc: imx-sc: add rtc set time support
Thread-Topic: [PATCH] rtc: imx-sc: add rtc set time support
Thread-Index: AQHUsgKsboFOYTBbXkGWmnrJUtGfDQ==
Date:   Tue, 22 Jan 2019 03:29:24 +0000
Message-ID: <1548127476-7958-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3929;6:p9HPNjnNGiEaK3FXrb3Fc1inxYDx+4cJrdMU6aZ1z/Ibnsu/ijQzbbgCky3axPcN8tZ/S3VV0CYMoB5KaWP0/kQsSVmj4e4KGQXK24lM092eDwmfoqe+Lbnny+6XXOzXj3k8cxYjCcfNjJDyzj9EN9zf8pxxBA9fTl0pwxMZZojvLATeqHRMx+TwEd9C3jR/3qEWPDxarXir8NTVUfB+15f61+XHWV38U57KBxYjfdRNByztadxtiq+giKm0O6cEWKq5VFs/IkyZ6QRaZLqjzkYOv0w1AfOby8ecFs8m3r4/sMSMjIsvixXCZENIDVelJaeAwG+XQ3JkuoRLFIVl+rg1kku3dVGWDvrp9MGLL4vcZuUC0TwC+GTjB/aV/kTyAiFGrwhYWvQ+YakBqjYbSk52tYh06FZ9Ea6tuVzwF1L2b4FWAnRxdK5/zFNX0osZEM5PUpPMCPcTwp2FyK1OUA==;5:hhz40ZDDfqPhwZFd3nHJTduerdZJiU2WWm0xMQJsvyYqxiYkn8ygpRR0Ck+UH5d2tDyzIi0InEyjGcqw5/jCI5eWZmq4UgqnpT7cxPtMleS/2j/69Fx57zWQ05EzfwMznXPvki/B1363mkluHIUP3UiH8cUcxIuaw5y668Ap/SrwRSOUCXqqvABqauxK2KxlfCDOl+nZRjA9mcAYtsHZGw==;7:l1L9udk5q5QnREdfLkGci3KdF3ZK6d1E9ZTel952Dkvs8kTxVEW67faJb9wxjQklpN3kBSSHVQo+45GoKLckFsLcQd5SqXm7h8AYx/caCjz0DcitT3iH1rf2SRYzYBWhI4Thh41+t+/TikFNfpGbsQ==
x-ms-office365-filtering-correlation-id: cc89aeab-dcbc-451a-33db-08d68019ce4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB39299C0C367F39B75236BD7FF5980@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(199004)(189003)(6486002)(36756003)(81166006)(68736007)(478600001)(25786009)(4326008)(53936002)(6512007)(6116002)(3846002)(305945005)(7736002)(486006)(6436002)(2906002)(86362001)(14454004)(81156014)(50226002)(52116002)(8936002)(8676002)(316002)(102836004)(97736004)(106356001)(6506007)(386003)(66066001)(105586002)(71200400001)(71190400001)(110136005)(476003)(2501003)(2201001)(186003)(2616005)(99286004)(256004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tp18lG2L/YorqeqMT1Ldx+Yk7Ze3YnDhktTj36Y7GHE7CeYeRsbIY+ViHJpaB+p5GLdx49Zh+f9VXpBp9MGRFWptPfYBGJb0IjzIZCkeV/79PJv3ioJJic5Zv8nglhecIK9PVMhetJHNd4S0ETtH2Ntv/D2nB48M/knw/B42CpDcixWXAL9CNRA4peFLWHx8LRL3UAXOIdBlT/1nblNUNrILYbnlRFmBTutUGTiCz5kDrzxM/wY5vOsKd4kNGFGV9WCB0cG7L3jTBaFj5n1VL55rwFaeSLky9e8OPZmkO9fN/MMj9VxeTUG5OETpItFcZVaW+V8pr++7Iu68YoEppjQPgEvsAYmHLW7PNKBSOxIwFoVYTALVRyePbKmPVsOCSs7zahHGrefieaz+VVP033RHLIpD3zb6T+DzxkQZYyU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc89aeab-dcbc-451a-33db-08d68019ce4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 03:29:21.0146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds i.MX system controller RTC set time support, the
RTC set time is implemented via SIP(silicon provider) runtime
service call and ARM-Trusted-Firmware will communicate with system
controller via MU(message unit) IPC to set RTC time.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/rtc/rtc-imx-sc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
index 7ff0854..60570a2 100644
--- a/drivers/rtc/rtc-imx-sc.c
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -3,6 +3,7 @@
  * Copyright 2018 NXP.
  */
=20
+#include <linux/arm-smccc.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -12,6 +13,9 @@
 #define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
 #define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
=20
+#define IMX_SIP_SRTC			0xC2000002
+#define IMX_SIP_SRTC_SET_TIME		0x0
+
 static struct imx_sc_ipc *rtc_ipc_handle;
 static struct rtc_device *imx_sc_rtc;
=20
@@ -42,8 +46,23 @@ static int imx_sc_rtc_read_time(struct device *dev, stru=
ct rtc_time *tm)
 	return 0;
 }
=20
+static int imx_sc_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct arm_smccc_res res;
+
+	/* pack 2 time parameters into 1 register, 16 bits for each */
+	arm_smccc_smc(IMX_SIP_SRTC, IMX_SIP_SRTC_SET_TIME,
+		      ((tm->tm_year + 1900) << 16) | (tm->tm_mon + 1),
+		      (tm->tm_mday << 16) | tm->tm_hour,
+		      (tm->tm_min << 16) | tm->tm_sec,
+		      0, 0, 0, &res);
+
+	return res.a0;
+}
+
 static const struct rtc_class_ops imx_sc_rtc_ops =3D {
 	.read_time =3D imx_sc_rtc_read_time,
+	.set_time =3D imx_sc_rtc_set_time,
 };
=20
 static int imx_sc_rtc_probe(struct platform_device *pdev)
--=20
2.7.4

