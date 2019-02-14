Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C955FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84155222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FoMA7bVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502398AbfBNPy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:54:58 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:18105 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388239AbfBNPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:54:57 -0500
X-IronPort-AV: E=Sophos;i="5.58,369,1544511600"; 
   d="scan'208";a="26565218"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 08:54:54 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 08:54:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxvJskMUc7UwZVt/Jk3ZV4jjrDzNjlcr8v5Nx7uxB+4=;
 b=FoMA7bVjnA5B3JnCXUEYz3i/YxI8vj+EznBMaV9DvB6NBlRuGBw4Oj4UT0rVeYe3yTwE3+MNZzoDJR8y2cICIezlWTMqAht8yjyWy60KnJVB3K0AHXGSP+zV8kJx1OoShFL6aHOJws+q2uamNDgdrGrLx+8g8M9S9bHuX9efHsI=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1472.namprd11.prod.outlook.com (10.172.53.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 15:54:52 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 15:54:52 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 5/8] ARM: at91: pm: add support for per SoC wakeup source
 configuration
Thread-Topic: [PATCH 5/8] ARM: at91: pm: add support for per SoC wakeup source
 configuration
Thread-Index: AQHUxH2fcSUQrSNGs0mRnpHh/9aZYg==
Date:   Thu, 14 Feb 2019 15:54:51 +0000
Message-ID: <1550159642-26878-6-git-send-email-claudiu.beznea@microchip.com>
References: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0098.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::24) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91008001-3219-4b52-f84e-08d69294c148
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1472;
x-ms-traffictypediagnostic: MWHPR11MB1472:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1472;23:Vn7/dUe3+6tI/xO87R7g52pkmH45U1ZcNKMsmS1?=
 =?iso-8859-1?Q?zM+MNFlBgjtqbTBg12/IaLNvI8xpQXbXsjYbCxj5SvB4n9EcC6b0jdf6M7?=
 =?iso-8859-1?Q?B1ZBldNbbCLjtUYf4ovukVbsGVRvIcMuqJlHIfAI9GL1U1bkKJ3Blabzjj?=
 =?iso-8859-1?Q?iwr4zl8V/k2SgtfRZE9oK9xdkEX5CTkmvo56k+oHDgcc1U45iUpe0WGxXl?=
 =?iso-8859-1?Q?SoboW5uF/4l+DRfL/0HQ1cT8PBX9oEiTy8wyedHM4QfxJkRubMePvZfdDb?=
 =?iso-8859-1?Q?3b56+YlfNRCWor64Wx093t5LbUdxPxz2muHtgH/hrZWXum9nLPTs1kdmOa?=
 =?iso-8859-1?Q?e47ArZUD9JOABTUoonLaGIZ7UnDJPbFTgFHSezkZVRq3yUuxF/AWr5teH3?=
 =?iso-8859-1?Q?nD23VQkhKbB1zeuEF+75RRn70Frw6Jfl5/FErML59le/3PMzuww8cu+MHk?=
 =?iso-8859-1?Q?tMXVAWz42R6iRGV4JZcqvOTU7gfrMSg2UwBp9uICAOAeHd0kHpOZXxgNI4?=
 =?iso-8859-1?Q?QGNv7fmiAmlJIAA1HuHQgLikYki8h6QKCG/H19DIBftstF7Ap3bcsvCTup?=
 =?iso-8859-1?Q?WLqfDJ3I6Ee3XosnfBhaZ/RAhFgGjaURa/A5Q4QNZHafkK3ZMzZhvEyPZX?=
 =?iso-8859-1?Q?XzL2FnyiAvyNgxhXxGqgvg/Xzl3J08N6vZIIKc9gS73IrM6aXGgmJwcb6Y?=
 =?iso-8859-1?Q?4slHUCb6ajdippUamwYgRSDgkBf7sQiNyHiIj8hq1hEl+hMCN/vUU3iTSY?=
 =?iso-8859-1?Q?OqxDKYwZURl+UtLzsZjxYdXoFRcAqrWu+N8hc41t/f/uQxfsRGkZTJWBpj?=
 =?iso-8859-1?Q?mIwk1TTl18FJjMUGTgwmdzYDE1Kpw2q5xola1y4z8D5CQU5Y5FsIdk+Qbr?=
 =?iso-8859-1?Q?D7RZmVDGyVKZcYz48QZP82v7dM4FyLyLDMZQ9nWGgA0u+OKY25bPoxeAwq?=
 =?iso-8859-1?Q?nb3+5vgEYNOa+fQTmtLMeEdA0X6NGfL3bIO31Z9eDpdPiNw83aHa8iMM+l?=
 =?iso-8859-1?Q?IMjVhHW4D5SWkHeOwdxj/OMWMtF1Ll67HfS0iUod4tnhLvcSJG4SlOp4UI?=
 =?iso-8859-1?Q?wIoRoquPp4Nyb0OLMzRFkz0cCG/W33NIbe2yCdKrrwAPoceeRGhTlnyBcq?=
 =?iso-8859-1?Q?+OSp9ctaiJSy/NcBPeFKEWoKYMjYCo/tPS3ypj3/tTX9CDO1/ZshP+gnXn?=
 =?iso-8859-1?Q?iWsmNoYG2qGcMnwUS5Nc4dUk0TqP/MNmXw5UEBmgobS8wlgj4vZYrtwPIp?=
 =?iso-8859-1?Q?QKCdfQFIbtCA3zNt0U1qQeexQ2upEAlFpxkpYvvLoVmzVBMl2bHrS/1AHv?=
 =?iso-8859-1?Q?bd+v+gP2ptM28hQwHqL7wDb?=
x-microsoft-antispam-prvs: <MWHPR11MB147253F25208C63C2DB70F8187670@MWHPR11MB1472.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(50226002)(478600001)(52116002)(2501003)(110136005)(25786009)(316002)(66066001)(8936002)(2906002)(8676002)(72206003)(68736007)(4326008)(54906003)(76176011)(81166006)(99286004)(6512007)(256004)(81156014)(305945005)(7736002)(6486002)(6436002)(26005)(186003)(6506007)(476003)(106356001)(105586002)(7416002)(14454004)(446003)(6116002)(102836004)(386003)(11346002)(97736004)(2201001)(71190400001)(107886003)(71200400001)(3846002)(86362001)(53936002)(2616005)(36756003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1472;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uoqtuH0EC7+3uTKbEyv98LLU4bdirm9XpiLbAr9BZIRt+Luo6ppHLbzaa/wF752iEtdysur2sQHFIU0D5xtZQlMGYrIzgkf+52UXY6xGVQ027qr1QQ0LzWgwZcqBbfoYu9+pMX2jjKjiru2DtVQFrSdB5EeVCx6otCw2+1jrbjMNxrUzRw+VM+Yo3Y0SDQFBE4IvovbnUkky02rVSFO29p85I1/QynUN6OGZ/FX6xRWV56T484PEFS0dUwpSz/iNxcJKiJgxL7sJmEgXOJmGRUYbHwJdMWZRE5/Mxim98ofJI72pcmVNIEnDUCZPHT8s/cQhZcnyG1Anc82NACJotG5n1xWacSqqsufoBo9qGZ88sYPUE9zN5xbrmvXnRC47IDKIw6XW2vQ0hVnJJyTby/gGShCkT87VESvGSIN26O4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 91008001-3219-4b52-f84e-08d69294c148
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:54:47.3830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1472
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support for per SoC wakeup source configuration. In this way
we could have per SoC wakeup sources, shutdown controller and power
management controller configurations for ULP1 power management mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index c83f78000ab3..27264caa4ec6 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -40,6 +40,9 @@ extern void at91_pinctrl_gpio_resume(void);
 #endif
=20
 struct at91_soc_pm {
+	int (*config_shdwc_ws)(void __iomem *shdwc, u32 *mode, u32 *polarity);
+	int (*config_pmc_ws)(void __iomem *pmc, u32 mode, u32 polarity);
+	const struct of_device_id *ws_ids;
 	struct at91_pm_data data;
 };
=20
@@ -122,7 +125,7 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool=
 set)
 	if (pm_mode !=3D AT91_PM_ULP1)
 		return 0;
=20
-	if (!soc_pm.data.pmc || !soc_pm.data.shdwc)
+	if (!soc_pm.data.pmc || !soc_pm.data.shdwc || !soc_pm.ws_ids)
 		return -EPERM;
=20
 	if (!set) {
@@ -130,16 +133,14 @@ static int at91_pm_config_ws(unsigned int pm_mode, bo=
ol set)
 		return 0;
 	}
=20
-	/* SHDWC.WUIR */
-	val =3D readl(soc_pm.data.shdwc + 0x0c);
-	mode |=3D (val & 0x3ff);
-	polarity |=3D ((val >> 16) & 0x3ff);
+	if (soc_pm.config_shdwc_ws)
+		soc_pm.config_shdwc_ws(soc_pm.data.shdwc, &mode, &polarity);
=20
 	/* SHDWC.MR */
 	val =3D readl(soc_pm.data.shdwc + 0x04);
=20
 	/* Loop through defined wakeup sources. */
-	for_each_matching_node_and_match(np, sama5d2_ws_ids, &match) {
+	for_each_matching_node_and_match(np, soc_pm.ws_ids, &match) {
 		pdev =3D of_find_device_by_node(np);
 		if (!pdev)
 			continue;
@@ -161,8 +162,8 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool=
 set)
 	}
=20
 	if (mode) {
-		writel(mode, soc_pm.data.pmc + AT91_PMC_FSMR);
-		writel(polarity, soc_pm.data.pmc + AT91_PMC_FSPR);
+		if (soc_pm.config_pmc_ws)
+			soc_pm.config_pmc_ws(soc_pm.data.pmc, mode, polarity);
 	} else {
 		pr_err("AT91: PM: no ULP1 wakeup sources found!");
 	}
@@ -170,6 +171,27 @@ static int at91_pm_config_ws(unsigned int pm_mode, boo=
l set)
 	return mode ? 0 : -EPERM;
 }
=20
+static int at91_sama5d2_config_shdwc_ws(void __iomem *shdwc, u32 *mode,
+					u32 *polarity)
+{
+	u32 val;
+
+	/* SHDWC.WUIR */
+	val =3D readl(shdwc + 0x0c);
+	*mode |=3D (val & 0x3ff);
+	*polarity |=3D ((val >> 16) & 0x3ff);
+
+	return 0;
+}
+
+static int at91_sama5d2_config_pmc_ws(void __iomem *pmc, u32 mode, u32 pol=
arity)
+{
+	writel(mode, pmc + AT91_PMC_FSMR);
+	writel(polarity, pmc + AT91_PMC_FSPR);
+
+	return 0;
+}
+
 /*
  * Called after processes are frozen, but before we shutdown devices.
  */
@@ -796,6 +818,10 @@ void __init sama5d2_pm_init(void)
=20
 	at91_pm_modes_init();
 	sama5_pm_init();
+
+	soc_pm.ws_ids =3D sama5d2_ws_ids;
+	soc_pm.config_shdwc_ws =3D at91_sama5d2_config_shdwc_ws;
+	soc_pm.config_pmc_ws =3D at91_sama5d2_config_pmc_ws;
 }
=20
 static int __init at91_pm_modes_select(char *str)
--=20
2.7.4

