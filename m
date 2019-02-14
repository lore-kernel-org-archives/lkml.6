Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CE6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A4A222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="D6q0Xez5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502380AbfBNPyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:54:49 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:17444 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502368AbfBNPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:54:47 -0500
X-IronPort-AV: E=Sophos;i="5.58,369,1544511600"; 
   d="scan'208";a="23863290"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 14 Feb 2019 08:54:44 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 08:54:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65BVjeIEXzp2/+wrCys8o6UEdbRcpqbRkkZky+uuU+M=;
 b=D6q0Xez5g8d2UQD/cS5Q2pXJ0NYgCkWA55C5ljKbcEpnJq5TsHxC5FzBWiR3etQwYXNCKG3R30tYA5g2M0VrRE996uSw7TYhHvZ6Nx3/xZ1jtNRQVglvayOO5KSbwRXP7URh8bIRJloJM+9k4blHg1zOT+I8VhpfEqM/lN6rWqU=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1472.namprd11.prod.outlook.com (10.172.53.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 15:54:42 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 15:54:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 3/8] ARM: at91: pm: initial PM support for SAM9X60
Thread-Topic: [PATCH 3/8] ARM: at91: pm: initial PM support for SAM9X60
Thread-Index: AQHUxH2ZASldydEtRkacJovuHMJ48Q==
Date:   Thu, 14 Feb 2019 15:54:41 +0000
Message-ID: <1550159642-26878-4-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: bda45bed-ce51-46d9-d80f-08d69294bb55
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1472;
x-ms-traffictypediagnostic: MWHPR11MB1472:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1472;23:EwpdkFC7RMGpXMdtvUJTvhSuHV6Ef7t88KZZTtD?=
 =?iso-8859-1?Q?gId1UJ7YBNb2FIOQdmrr1xqgbXxT6+6p3M3jEb2tSFVBwgILfFxwwCfVDD?=
 =?iso-8859-1?Q?cGPJxHu+zu21/hyGxMSLKGAESWbo+xLvKQEgNbfGE6J54YvTv5PR5eIEGp?=
 =?iso-8859-1?Q?PzaBBz/MobIXMJs0+oYobkd/Nm16EIfZsuxvnvQ7vB+FWSdfZtDE7Z3XqD?=
 =?iso-8859-1?Q?4paUBeMbtQn9/rBOJDbzc0ko+NnVO/lIy47f//yy60X8JsCoWqjX6Acf/t?=
 =?iso-8859-1?Q?hka6xNRoWy9XMVXrozKQ+SgMPa+k044z4t105bsIpclumy/8oCVu+sVFdM?=
 =?iso-8859-1?Q?H2Ey1k7nUfniHkKH0ZBeqLB3MT6KloFicjBq8rG9PG919fzurHw1leGj5F?=
 =?iso-8859-1?Q?O3HTrMkEDOKuHzZL1NakDiMxpDZL1QBK9Zxekhm9oJjp4SEvmkNEnVsW51?=
 =?iso-8859-1?Q?8E1+GFksqKyUtnc71msA/ayk194g73dk2d7hRyBbEz/135TOBcxHUSSPod?=
 =?iso-8859-1?Q?0P0t3qYQZGgMPFOOlKwDJjgV6O6ynZBDeit2wddk/SA6uBuOyp8ugFpd2P?=
 =?iso-8859-1?Q?6qf3itYrsY0gN2SpfB0EcYIY94Fd3/lIqqO84T1AVyDcSwAlJ0TD4aLZZj?=
 =?iso-8859-1?Q?NaQBmWoIznTL8DjK6yrpuP2wF+Nnj1LrWlJpXEN9so4CZ6mC+yb5ZN7KbD?=
 =?iso-8859-1?Q?mlzjIcm4Ijv1qgzxTN1tjfitESbmZ+ImgdVyBAD/wuNLqdepG6jXnKcQh0?=
 =?iso-8859-1?Q?X7VNtCr8XTGuXAy0cwo3CyVzmCZKzhE2zChdl9Kn9Zom8gJpxKKCs4Igyb?=
 =?iso-8859-1?Q?nKNbk+ubmjErCnottHIkRkqFuWD/pAs6XoGvciVtdeTwPPQcCGFp6YTJw+?=
 =?iso-8859-1?Q?HJ4OxLpu4eVZBYU/dsaeGdCcHwdOSv1tBHmEL+p3YkjTeaky90a0bYZKDK?=
 =?iso-8859-1?Q?S0g4V56EgZSWVtsaqNTon0ygwz3UkQRDTmNgANB+vVZXEJLNugs08s+Vmc?=
 =?iso-8859-1?Q?bLqzeeWwMR3xxA6mY15q5XXlsXF9oUZjnywM3bGgAKAkEnlanKaRcn47ZW?=
 =?iso-8859-1?Q?6jnFMpGcez8GhoB61ro+Off9beGwuvVJ+/pBEwsQtRFHAF2TfAKTkPlEaM?=
 =?iso-8859-1?Q?NBo3qN6a0jdjSfUVe8gX6kVBjkCLL4GGCcbXqE5jRhc6HVZuDJSULJ/JzS?=
 =?iso-8859-1?Q?wJrzf4VfaxNh+9xUUkKrh2OTMEDeLCnzzyYLjrJA/D2Q4fyue873oLlIsW?=
 =?iso-8859-1?Q?kA+5HNj1iM1yJ5x8M0wWGafLu6ehkRsEI09fO3LL0b7JuAvWCTninbV2NQ?=
 =?iso-8859-1?Q?iXseswcLJiVW6L64DCCAteh?=
x-microsoft-antispam-prvs: <MWHPR11MB147231C51FC85383D26DE2A987670@MWHPR11MB1472.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(50226002)(478600001)(52116002)(2501003)(110136005)(25786009)(316002)(66066001)(8936002)(2906002)(8676002)(72206003)(68736007)(4326008)(54906003)(76176011)(81166006)(99286004)(6512007)(256004)(81156014)(305945005)(7736002)(6486002)(6436002)(26005)(186003)(6506007)(476003)(106356001)(105586002)(7416002)(14454004)(446003)(6116002)(102836004)(386003)(11346002)(97736004)(2201001)(71190400001)(107886003)(71200400001)(3846002)(86362001)(53936002)(2616005)(36756003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1472;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KS+iJFWR0OgDA0HJaOw64IK1cWxh5PkvRcfBfOoDA2wjrBP8XBrJYW6pdtDyhUmE9ep36PF4xWizndcv9CEdUiqbSS5MRV0P3GOqUKs8cdXQUflzsmqhh329v7w4n+oHK8IknH0xouKEDm/ON701mJVZmt/XAIBVK5rOMbGK3Z7CxkZko2jy5hVZ91y0PCsVb4HOu0ZNUAST/G6Il1K+X4h3zdAI4s48Y9tIf+r1Pbt02dgt5FF9PjIrfW28dSokhEOHYWRU/gWco1L01txSORSnHhKLlNfEtZw4cVKjN7zI8HHZTePFZTq69N3xAruWnbqbUgAGHVPd0n97hbxLIY/HXzDzypzez0d1/CoDXIjx8HmnXpd91ioW/SAbnpiiQW9rN6Eqv4dfNNduT7DQYaRF/Rlz5khuMpWq9tKNyE0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bda45bed-ce51-46d9-d80f-08d69294bb55
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:54:37.4892
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

Add initial PM support for SAM9X60. This include idle, WFI and ULP0.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/at91sam9.c | 18 ++++++++++++++++++
 arch/arm/mach-at91/generic.h  |  2 ++
 arch/arm/mach-at91/pm.c       | 14 ++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index 3dbdef4d3cbf..c12563b09656 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -32,3 +32,21 @@ DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM9")
 	.init_machine	=3D at91sam9_init,
 	.dt_compat	=3D at91_dt_board_compat,
 MACHINE_END
+
+static void __init sam9x60_init(void)
+{
+	of_platform_default_populate(NULL, NULL, NULL);
+
+	sam9x60_pm_init();
+}
+
+static const char *const sam9x60_dt_board_compat[] __initconst =3D {
+	"microchip,sam9x60",
+	NULL
+};
+
+DT_MACHINE_START(sam9x60_dt, "Microchip SAM9X60")
+	/* Maintainer: Microchip */
+	.init_machine	=3D sam9x60_init,
+	.dt_compat	=3D sam9x60_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index e2bd17237964..72b45accfa0f 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -14,11 +14,13 @@
 #ifdef CONFIG_PM
 extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9_pm_init(void);
+extern void __init sam9x60_pm_init(void);
 extern void __init sama5_pm_init(void);
 extern void __init sama5d2_pm_init(void);
 #else
 static inline void __init at91rm9200_pm_init(void) { }
 static inline void __init at91sam9_pm_init(void) { }
+static inline void __init sam9x60_pm_init(void) { }
 static inline void __init sama5_pm_init(void) { }
 static inline void __init sama5d2_pm_init(void) { }
 #endif
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index ce2ff86968f6..e42db02eafe4 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -518,6 +518,11 @@ static void at91rm9200_idle(void)
 	writel(AT91_PMC_PCK, soc_pm.data.pmc + AT91_PMC_SCDR);
 }
=20
+static void at91sam9x60_idle(void)
+{
+	cpu_do_idle();
+}
+
 static void at91sam9_idle(void)
 {
 	writel(AT91_PMC_PCK, soc_pm.data.pmc + AT91_PMC_SCDR);
@@ -754,6 +759,15 @@ void __init at91rm9200_pm_init(void)
 	at91_pm_init(at91rm9200_idle);
 }
=20
+void __init sam9x60_pm_init(void)
+{
+	if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
+		return;
+
+	at91_dt_ramc();
+	at91_pm_init(at91sam9x60_idle);
+}
+
 void __init at91sam9_pm_init(void)
 {
 	if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
--=20
2.7.4

