Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FCDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B4E222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Y3+476ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502409AbfBNPzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:55:11 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:17430 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733258AbfBNPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:54:44 -0500
X-IronPort-AV: E=Sophos;i="5.58,369,1544511600"; 
   d="scan'208";a="23863282"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 08:54:37 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 08:54:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXl5rR4aFPv3PsriLRaht8E8JlyDTEeGsJ+rsKPmwA8=;
 b=Y3+476ZK67vZi020499eJgccS0t6LOdFK276iCFn0zQ8oA7W28NoUJqNnkvfOT5S1tTMC2WDH9n5N/SOk8O8+vNIXeuUH9iTJjuF3E/cvTWLcXJNoe4BnH0QPatU+QqDvncvVxkGGO7K3FTEwwoDFIS2qAjfTnl9AEOsa88NNwQ=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2031.namprd11.prod.outlook.com (10.169.236.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 14 Feb 2019 15:54:31 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 15:54:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/8] ARM: at91: pm: introduce at91_soc_pm structure
Thread-Topic: [PATCH 1/8] ARM: at91: pm: introduce at91_soc_pm structure
Thread-Index: AQHUxH2TDCqaNyQ5LkC7OjYQ/CzNzw==
Date:   Thu, 14 Feb 2019 15:54:31 +0000
Message-ID: <1550159642-26878-2-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: b4bd4073-cbbd-40d0-18e2-08d69294b51b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2031;
x-ms-traffictypediagnostic: MWHPR11MB2031:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB2031;23:F77TLxi1QRSvcsGFNSEpR/S3f/h2RNmTn0Kq8aN?=
 =?iso-8859-1?Q?1+Q8qtd7Q+hAVPEHri4/ZvOM/6/qKEJ+B+WixHTRmrq5R8tffKr4Tp5fEM?=
 =?iso-8859-1?Q?Uftpl8ZWevtw2Je259XtXcHEVCLx0DWavrW0jB8LzZ/ClGXEPCyEJ7xBLC?=
 =?iso-8859-1?Q?bKUdwRddvRfV6lPYJ+SKYyXOx7NVwEpe/9OHskCpCzr8dwN1PnR6p7mDMj?=
 =?iso-8859-1?Q?+njNQgybh1VdxFLv7OyMnBq9W5xSKew7iHZfdIQw0vS8XXl9EQ/BPjEGVw?=
 =?iso-8859-1?Q?WSDmR0mOWRx0LDriUEUPTJ4aAZrxWMFLow4vMfWF+F3hLUKEFJqgMFCDBz?=
 =?iso-8859-1?Q?HrhpqbjfYeMqVD5mFy+zKQg+I0rcDihQmv1MqUyFfDPd3j+PxeUO394ACK?=
 =?iso-8859-1?Q?YvieA54JxcmdOtHP+pHB7S/FVKaDwxMxGllRSaXFmrHP8RtK6ULOes7X+f?=
 =?iso-8859-1?Q?WvC52Gstcd1CDxudtY4QubftbVYRSe7XyuNXnOV/Uy4bXtfyNlQei0Swjx?=
 =?iso-8859-1?Q?+Aql8SyzsQeNbr3l/SPCFwuo597nkvRFd5MjpgD6QUKwI06QYF7EU1IQQz?=
 =?iso-8859-1?Q?SssDwMtQJ5WVE1ueakMOm945S6JUyUHLXYBBqLR7RiR7ylGxhtzHgcZ474?=
 =?iso-8859-1?Q?nDoNDZL7swAH6ScxSm4972OVFTN0TCmiMiRtYX1AWfcNrMhn12Us5zjh01?=
 =?iso-8859-1?Q?X9TUPEH9uAxFv/Dn6GtYDLlZyXq7JkLSNNrgST+qBQT/kPRLiLElQ2lzQG?=
 =?iso-8859-1?Q?4T16f3IaHHCgN9smq8v9bUydnZy5PGCbciGi+qhdqYJnrpJTSzSvYpPg0Q?=
 =?iso-8859-1?Q?KRvywAMdjc7lcUAH2HshN9l8ttE0+fzmzQb7UA0RsGL+FWEKFTK8BqJ5Pc?=
 =?iso-8859-1?Q?WWZ5DPFRylrjcTCG1XkrsfP9+Rer8lB+3onqoseMiulo511aYjsHrAthGp?=
 =?iso-8859-1?Q?ayHgQZ+83+qYr1bK0Vbb+cBbPSO1t7+YVJZCLzuiwOinRQbg8plje/jKh9?=
 =?iso-8859-1?Q?Folv80ZkG6573vzesGJ8U1tjqd1XufxrsjTqnghhxa7Inj9uOCR7zP6+oD?=
 =?iso-8859-1?Q?w1VF9jXBbN5hVvgTlGYt2nkL8WX7p6ezRwWVyL+nff9nJXgbOLMZ4ydlKz?=
 =?iso-8859-1?Q?u+XusiIcH7gJZlp0ea4F6j0xoCgqRs4m7D4nXeuP2NPsIpQ70XosROzNwo?=
 =?iso-8859-1?Q?OLhQCBdcD4eMZKSPYJeRDjG3SHOZtQAUkvEUDGmMObH57j/RcSTlmuOANi?=
 =?iso-8859-1?Q?Jv7WJLq+GYGV1F/dEFAi2bGaMVhDXD8ZuJKzOMmWEn/qSYzgErtdXGOhN4?=
 =?iso-8859-1?Q?o2/xEikOsWImjYlKPX+iPMqm3i6EZPPndITvTMR0Fi3kpXWO0tvzjrbmD9?=
 =?iso-8859-1?Q?vU1D/XbR03e0btxaHBaXGf8+q6/lEostMS6U6L1gQXKaE8OQlhiKGIiCv6?=
 =?iso-8859-1?Q?iOLXCxw9LdjT3cA6SLhq3wXU7/tPnf37EL0?=
x-microsoft-antispam-prvs: <MWHPR11MB2031C8E4F1C1A758739687F687670@MWHPR11MB2031.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(346002)(39860400002)(136003)(376002)(366004)(189003)(199004)(97736004)(6486002)(2906002)(72206003)(14454004)(478600001)(81156014)(36756003)(2501003)(71190400001)(71200400001)(316002)(30864003)(81166006)(7416002)(110136005)(54906003)(6436002)(76176011)(66066001)(50226002)(14444005)(256004)(6512007)(106356001)(8936002)(68736007)(52116002)(2201001)(26005)(186003)(446003)(53936002)(11346002)(6116002)(7736002)(3846002)(25786009)(107886003)(4326008)(305945005)(99286004)(8676002)(105586002)(486006)(86362001)(386003)(476003)(6506007)(102836004)(2616005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2031;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Tj8Qz5QDpx5ko2KQvn2VwlWf2av3Uq7hPP/R8nKHbSuvWQszeDy+taah1zLmO0Rz90Ra39H/cr9wuf++cLtt54B7xn4TuCrRB6vuZyX1gOOty3XlqlQvbZXKFLJLp5u+5zrV7ml4f3vsDSa4vQMJt03Wvv3N/06L7sV2ylynARZEIPZYIxc1nxAwXbx0602t/qv0QeazPQXILnqRjvYiYmp05n/3oBIVm3DvA4pf9uEx2klrS0iHz5KdqgzFfd6H033fCnbVCOjeZ6geB5muWY4cpfOHmgXQAK8NlQ4SmDDHmPHBjWuBw8LnQiL2JpDHMvfXK3axBciUA24yo+4vVF1H2ZCrI2Wdty1Gx0WjqkSPG7zJOqKvmaZQCWw6/f2KtK+KksreJO3BrGk753O22wt3tOwuPM1EBrgacQ+8Bo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bd4073-cbbd-40d0-18e2-08d69294b51b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:54:27.1869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2031
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

To have per SoC PM information add a new structure which embed
a member of type struct at91_pm_data. This will allow easy addition
of new information without contaminate struct at91_pm_data that is
passed to the last phase suspend function (at91_suspend_sram_fn).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 118 +++++++++++++++++++++++++-------------------=
----
 1 file changed, 62 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 51e808adb00c..ce2ff86968f6 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -39,6 +39,17 @@ extern void at91_pinctrl_gpio_suspend(void);
 extern void at91_pinctrl_gpio_resume(void);
 #endif
=20
+struct at91_soc_pm {
+	struct at91_pm_data data;
+};
+
+static struct at91_soc_pm soc_pm =3D {
+	.data =3D {
+		.standby_mode =3D AT91_PM_STANDBY,
+		.suspend_mode =3D AT91_PM_ULP0,
+	},
+};
+
 static const match_table_t pm_modes __initconst =3D {
 	{ AT91_PM_STANDBY, "standby" },
 	{ AT91_PM_ULP0, "ulp0" },
@@ -47,16 +58,11 @@ static const match_table_t pm_modes __initconst =3D {
 	{ -1, NULL },
 };
=20
-static struct at91_pm_data pm_data =3D {
-	.standby_mode =3D AT91_PM_STANDBY,
-	.suspend_mode =3D AT91_PM_ULP0,
-};
-
 #define at91_ramc_read(id, field) \
-	__raw_readl(pm_data.ramc[id] + field)
+	__raw_readl(soc_pm.data.ramc[id] + field)
=20
 #define at91_ramc_write(id, field, value) \
-	__raw_writel(value, pm_data.ramc[id] + field)
+	__raw_writel(value, soc_pm.data.ramc[id] + field)
=20
 static int at91_pm_valid_state(suspend_state_t state)
 {
@@ -116,21 +122,21 @@ static int at91_pm_config_ws(unsigned int pm_mode, bo=
ol set)
 	if (pm_mode !=3D AT91_PM_ULP1)
 		return 0;
=20
-	if (!pm_data.pmc || !pm_data.shdwc)
+	if (!soc_pm.data.pmc || !soc_pm.data.shdwc)
 		return -EPERM;
=20
 	if (!set) {
-		writel(mode, pm_data.pmc + AT91_PMC_FSMR);
+		writel(mode, soc_pm.data.pmc + AT91_PMC_FSMR);
 		return 0;
 	}
=20
 	/* SHDWC.WUIR */
-	val =3D readl(pm_data.shdwc + 0x0c);
+	val =3D readl(soc_pm.data.shdwc + 0x0c);
 	mode |=3D (val & 0x3ff);
 	polarity |=3D ((val >> 16) & 0x3ff);
=20
 	/* SHDWC.MR */
-	val =3D readl(pm_data.shdwc + 0x04);
+	val =3D readl(soc_pm.data.shdwc + 0x04);
=20
 	/* Loop through defined wakeup sources. */
 	for_each_matching_node_and_match(np, sama5d2_ws_ids, &match) {
@@ -155,8 +161,8 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool=
 set)
 	}
=20
 	if (mode) {
-		writel(mode, pm_data.pmc + AT91_PMC_FSMR);
-		writel(polarity, pm_data.pmc + AT91_PMC_FSPR);
+		writel(mode, soc_pm.data.pmc + AT91_PMC_FSMR);
+		writel(polarity, soc_pm.data.pmc + AT91_PMC_FSPR);
 	} else {
 		pr_err("AT91: PM: no ULP1 wakeup sources found!");
 	}
@@ -171,18 +177,18 @@ static int at91_pm_begin(suspend_state_t state)
 {
 	switch (state) {
 	case PM_SUSPEND_MEM:
-		pm_data.mode =3D pm_data.suspend_mode;
+		soc_pm.data.mode =3D soc_pm.data.suspend_mode;
 		break;
=20
 	case PM_SUSPEND_STANDBY:
-		pm_data.mode =3D pm_data.standby_mode;
+		soc_pm.data.mode =3D soc_pm.data.standby_mode;
 		break;
=20
 	default:
-		pm_data.mode =3D -1;
+		soc_pm.data.mode =3D -1;
 	}
=20
-	return at91_pm_config_ws(pm_data.mode, true);
+	return at91_pm_config_ws(soc_pm.data.mode, true);
 }
=20
 /*
@@ -194,10 +200,10 @@ static int at91_pm_verify_clocks(void)
 	unsigned long scsr;
 	int i;
=20
-	scsr =3D readl(pm_data.pmc + AT91_PMC_SCSR);
+	scsr =3D readl(soc_pm.data.pmc + AT91_PMC_SCSR);
=20
 	/* USB must not be using PLLB */
-	if ((scsr & pm_data.uhp_udp_mask) !=3D 0) {
+	if ((scsr & soc_pm.data.uhp_udp_mask) !=3D 0) {
 		pr_err("AT91: PM - Suspend-to-RAM with USB still active\n");
 		return 0;
 	}
@@ -208,7 +214,7 @@ static int at91_pm_verify_clocks(void)
=20
 		if ((scsr & (AT91_PMC_PCK0 << i)) =3D=3D 0)
 			continue;
-		css =3D readl(pm_data.pmc + AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
+		css =3D readl(soc_pm.data.pmc + AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
 		if (css !=3D AT91_PMC_CSS_SLOW) {
 			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", i, css);
 			return 0;
@@ -230,7 +236,7 @@ static int at91_pm_verify_clocks(void)
  */
 int at91_suspend_entering_slow_clock(void)
 {
-	return (pm_data.mode >=3D AT91_PM_ULP0);
+	return (soc_pm.data.mode >=3D AT91_PM_ULP0);
 }
 EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
=20
@@ -243,14 +249,14 @@ static int at91_suspend_finish(unsigned long val)
 	flush_cache_all();
 	outer_disable();
=20
-	at91_suspend_sram_fn(&pm_data);
+	at91_suspend_sram_fn(&soc_pm.data);
=20
 	return 0;
 }
=20
 static void at91_pm_suspend(suspend_state_t state)
 {
-	if (pm_data.mode =3D=3D AT91_PM_BACKUP) {
+	if (soc_pm.data.mode =3D=3D AT91_PM_BACKUP) {
 		pm_bu->suspended =3D 1;
=20
 		cpu_suspend(0, at91_suspend_finish);
@@ -289,7 +295,7 @@ static int at91_pm_enter(suspend_state_t state)
 		/*
 		 * Ensure that clocks are in a valid state.
 		 */
-		if (pm_data.mode >=3D AT91_PM_ULP0 &&
+		if (soc_pm.data.mode >=3D AT91_PM_ULP0 &&
 		    !at91_pm_verify_clocks())
 			goto error;
=20
@@ -318,7 +324,7 @@ static int at91_pm_enter(suspend_state_t state)
  */
 static void at91_pm_end(void)
 {
-	at91_pm_config_ws(pm_data.mode, false);
+	at91_pm_config_ws(soc_pm.data.mode, false);
 }
=20
=20
@@ -351,7 +357,7 @@ static void at91rm9200_standby(void)
 		"    str    %2, [%1, %3]\n\t"
 		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
 		:
-		: "r" (0), "r" (pm_data.ramc[0]),
+		: "r" (0), "r" (soc_pm.data.ramc[0]),
 		  "r" (1), "r" (AT91_MC_SDRAMC_SRR));
 }
=20
@@ -374,7 +380,7 @@ static void at91_ddr_standby(void)
 		at91_ramc_write(0, AT91_DDRSDRC_MDR, mdr);
 	}
=20
-	if (pm_data.ramc[1]) {
+	if (soc_pm.data.ramc[1]) {
 		saved_lpr1 =3D at91_ramc_read(1, AT91_DDRSDRC_LPR);
 		lpr1 =3D saved_lpr1 & ~AT91_DDRSDRC_LPCB;
 		lpr1 |=3D AT91_DDRSDRC_LPCB_SELF_REFRESH;
@@ -392,14 +398,14 @@ static void at91_ddr_standby(void)
=20
 	/* self-refresh mode now */
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
-	if (pm_data.ramc[1])
+	if (soc_pm.data.ramc[1])
 		at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
=20
 	cpu_do_idle();
=20
 	at91_ramc_write(0, AT91_DDRSDRC_MDR, saved_mdr0);
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
-	if (pm_data.ramc[1]) {
+	if (soc_pm.data.ramc[1]) {
 		at91_ramc_write(0, AT91_DDRSDRC_MDR, saved_mdr1);
 		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
 	}
@@ -429,7 +435,7 @@ static void at91sam9_sdram_standby(void)
 	u32 lpr0, lpr1 =3D 0;
 	u32 saved_lpr0, saved_lpr1 =3D 0;
=20
-	if (pm_data.ramc[1]) {
+	if (soc_pm.data.ramc[1]) {
 		saved_lpr1 =3D at91_ramc_read(1, AT91_SDRAMC_LPR);
 		lpr1 =3D saved_lpr1 & ~AT91_SDRAMC_LPCB;
 		lpr1 |=3D AT91_SDRAMC_LPCB_SELF_REFRESH;
@@ -441,13 +447,13 @@ static void at91sam9_sdram_standby(void)
=20
 	/* self-refresh mode now */
 	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr0);
-	if (pm_data.ramc[1])
+	if (soc_pm.data.ramc[1])
 		at91_ramc_write(1, AT91_SDRAMC_LPR, lpr1);
=20
 	cpu_do_idle();
=20
 	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr0);
-	if (pm_data.ramc[1])
+	if (soc_pm.data.ramc[1])
 		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
 }
=20
@@ -480,14 +486,14 @@ static __init void at91_dt_ramc(void)
 	const struct ramc_info *ramc;
=20
 	for_each_matching_node_and_match(np, ramc_ids, &of_id) {
-		pm_data.ramc[idx] =3D of_iomap(np, 0);
-		if (!pm_data.ramc[idx])
+		soc_pm.data.ramc[idx] =3D of_iomap(np, 0);
+		if (!soc_pm.data.ramc[idx])
 			panic(pr_fmt("unable to map ramc[%d] cpu registers\n"), idx);
=20
 		ramc =3D of_id->data;
 		if (!standby)
 			standby =3D ramc->idle;
-		pm_data.memctrl =3D ramc->memctrl;
+		soc_pm.data.memctrl =3D ramc->memctrl;
=20
 		idx++;
 	}
@@ -509,12 +515,12 @@ static void at91rm9200_idle(void)
 	 * Disable the processor clock.  The processor will be automatically
 	 * re-enabled by an interrupt or by a reset.
 	 */
-	writel(AT91_PMC_PCK, pm_data.pmc + AT91_PMC_SCDR);
+	writel(AT91_PMC_PCK, soc_pm.data.pmc + AT91_PMC_SCDR);
 }
=20
 static void at91sam9_idle(void)
 {
-	writel(AT91_PMC_PCK, pm_data.pmc + AT91_PMC_SCDR);
+	writel(AT91_PMC_PCK, soc_pm.data.pmc + AT91_PMC_SCDR);
 	cpu_do_idle();
 }
=20
@@ -566,8 +572,8 @@ static void __init at91_pm_sram_init(void)
=20
 static bool __init at91_is_pm_mode_active(int pm_mode)
 {
-	return (pm_data.standby_mode =3D=3D pm_mode ||
-		pm_data.suspend_mode =3D=3D pm_mode);
+	return (soc_pm.data.standby_mode =3D=3D pm_mode ||
+		soc_pm.data.suspend_mode =3D=3D pm_mode);
 }
=20
 static int __init at91_pm_backup_init(void)
@@ -586,7 +592,7 @@ static int __init at91_pm_backup_init(void)
 		return ret;
 	}
=20
-	pm_data.sfrbu =3D of_iomap(np, 0);
+	soc_pm.data.sfrbu =3D of_iomap(np, 0);
 	of_node_put(np);
=20
 	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
@@ -620,8 +626,8 @@ static int __init at91_pm_backup_init(void)
 	return 0;
=20
 securam_fail:
-	iounmap(pm_data.sfrbu);
-	pm_data.sfrbu =3D NULL;
+	iounmap(soc_pm.data.sfrbu);
+	soc_pm.data.sfrbu =3D NULL;
 	return ret;
 }
=20
@@ -630,10 +636,10 @@ static void __init at91_pm_use_default_mode(int pm_mo=
de)
 	if (pm_mode !=3D AT91_PM_ULP1 && pm_mode !=3D AT91_PM_BACKUP)
 		return;
=20
-	if (pm_data.standby_mode =3D=3D pm_mode)
-		pm_data.standby_mode =3D AT91_PM_ULP0;
-	if (pm_data.suspend_mode =3D=3D pm_mode)
-		pm_data.suspend_mode =3D AT91_PM_ULP0;
+	if (soc_pm.data.standby_mode =3D=3D pm_mode)
+		soc_pm.data.standby_mode =3D AT91_PM_ULP0;
+	if (soc_pm.data.suspend_mode =3D=3D pm_mode)
+		soc_pm.data.suspend_mode =3D AT91_PM_ULP0;
 }
=20
 static void __init at91_pm_modes_init(void)
@@ -651,7 +657,7 @@ static void __init at91_pm_modes_init(void)
 		goto ulp1_default;
 	}
=20
-	pm_data.shdwc =3D of_iomap(np, 0);
+	soc_pm.data.shdwc =3D of_iomap(np, 0);
 	of_node_put(np);
=20
 	ret =3D at91_pm_backup_init();
@@ -665,8 +671,8 @@ static void __init at91_pm_modes_init(void)
 	return;
=20
 unmap:
-	iounmap(pm_data.shdwc);
-	pm_data.shdwc =3D NULL;
+	iounmap(soc_pm.data.shdwc);
+	soc_pm.data.shdwc =3D NULL;
 ulp1_default:
 	at91_pm_use_default_mode(AT91_PM_ULP1);
 backup_default:
@@ -709,14 +715,14 @@ static void __init at91_pm_init(void (*pm_idle)(void)=
)
 		platform_device_register(&at91_cpuidle_device);
=20
 	pmc_np =3D of_find_matching_node_and_match(NULL, atmel_pmc_ids, &of_id);
-	pm_data.pmc =3D of_iomap(pmc_np, 0);
-	if (!pm_data.pmc) {
+	soc_pm.data.pmc =3D of_iomap(pmc_np, 0);
+	if (!soc_pm.data.pmc) {
 		pr_err("AT91: PM not supported, PMC not found\n");
 		return;
 	}
=20
 	pmc =3D of_id->data;
-	pm_data.uhp_udp_mask =3D pmc->uhp_udp_mask;
+	soc_pm.data.uhp_udp_mask =3D pmc->uhp_udp_mask;
=20
 	if (pm_idle)
 		arm_pm_idle =3D pm_idle;
@@ -726,8 +732,8 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 	if (at91_suspend_sram_fn) {
 		suspend_set_ops(&at91_pm_ops);
 		pr_info("AT91: PM: standby: %s, suspend: %s\n",
-			pm_modes[pm_data.standby_mode].pattern,
-			pm_modes[pm_data.suspend_mode].pattern);
+			pm_modes[soc_pm.data.standby_mode].pattern,
+			pm_modes[soc_pm.data.suspend_mode].pattern);
 	} else {
 		pr_info("AT91: PM not supported, due to no SRAM allocated\n");
 	}
@@ -793,8 +799,8 @@ static int __init at91_pm_modes_select(char *str)
 	if (suspend < 0)
 		return 0;
=20
-	pm_data.standby_mode =3D standby;
-	pm_data.suspend_mode =3D suspend;
+	soc_pm.data.standby_mode =3D standby;
+	soc_pm.data.suspend_mode =3D suspend;
=20
 	return 0;
 }
--=20
2.7.4

