Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FA7C10F05
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC8D2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kNSP2nFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393885AbfBNKjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:39:47 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:53057 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfBNKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:39:46 -0500
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; 
   d="scan'208";a="26727443"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 03:39:45 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 03:39:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9pEge9jHPRkIpmmp6f9i13eKcs7W6QUdW+IVcEz4j0=;
 b=kNSP2nFqU9+RE0pj18ZX+8HLp44bWNhxXBTOU7BCfpPu+hVwiuyjY9hLUhKh7ulIFHWiOmb9fyX5AbqxbYsxOkZr23IIU2arjPYaUDteVufNQBdDgH+ZBQqP0GNsm7zB88Qo2HOClvhXbkSkkBlQS0KZYJ7wUgjy9Ob7fdmxYao=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1311.namprd11.prod.outlook.com (10.169.237.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 10:39:41 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 10:39:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/2] clk: at91: sckc: adapt sckc driver to work for SAM9X60
Thread-Topic: [PATCH 1/2] clk: at91: sckc: adapt sckc driver to work for
 SAM9X60
Thread-Index: AQHUxFGXuEaJzr2tUEWTZnavtTCZMw==
Date:   Thu, 14 Feb 2019 10:39:41 +0000
Message-ID: <1550140748-21714-2-git-send-email-claudiu.beznea@microchip.com>
References: <1550140748-21714-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550140748-21714-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0131.eurprd07.prod.outlook.com
 (2603:10a6:802:16::18) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69b9de97-123a-4ce7-4825-08d69268b982
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1311;
x-ms-traffictypediagnostic: MWHPR11MB1311:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1311;23:BS1rIMHOAFK0BUF5n2Xb3DlwsClX0chBrqld71K?=
 =?iso-8859-1?Q?MczTkxUapSALHXTt4YOFYgJGmlxd82LwrKjmXEPUbTQ/8a/lJG9nwWyJ1M?=
 =?iso-8859-1?Q?nUltvExIhaa8wrgNd/2OXSLgjsiXooVkIRysPKhFixopRnujNQjhhFvEtc?=
 =?iso-8859-1?Q?khp+RBdINtcB93o2q4oSEq1M7K6AOQZMa6tBapx+zUlxI65HgUxmV/X6fI?=
 =?iso-8859-1?Q?+Q8eMAo9cc85Zv5FOJoai7DtL55Xi9mPSmw2BhObN6k3BosPsIOhdcWlXG?=
 =?iso-8859-1?Q?tgMF+brGYqSCr9v0p/kZpX98VOeoSiR3fnt4oMg5l8Hutw+NRIIdR4U9Po?=
 =?iso-8859-1?Q?UmAwjqGiwdmu/3WcQrGvLQonqWnjiTIo/GTfauD5T50WKXq3jJw4RQTSNf?=
 =?iso-8859-1?Q?ZuN6U8qz5DstNQjmRnerKSfwJWzjHex/MFjMuo0CJuocABdGOzGGcynQCy?=
 =?iso-8859-1?Q?zQHEeDa0dsCpIA8BvcaU449lpjQliNXd3gAOClDlENuexJCu671nVdgbQA?=
 =?iso-8859-1?Q?1Fzc9vQz4AtMErcRf+n6Y2I2G3o1iOJBMegwH+wKjNnvy53oRDdPAy3PjX?=
 =?iso-8859-1?Q?KUu0McDWjLxiFRErpcKoKH04bCdJROsjnmnxckEYXMRaR1FC6BVGrRA6Ib?=
 =?iso-8859-1?Q?gnAsAQrnklhbOzym7KLvE7qKJdSxXdNtT8Ic8RdiWORoCei1dFQC0SEmNo?=
 =?iso-8859-1?Q?jz5IO7rRTShWzob61FSHHTD1kIjLj+TyfkW8/ukJlz+Ss4gz/0Z+rHNCIG?=
 =?iso-8859-1?Q?vYAXNMemVE60pzzwrOQxNpHXtaK+qbEq5EmcaGBVXzLL0Zo5Y8KFg3oign?=
 =?iso-8859-1?Q?C9qFy8PhL8dwjReGrVzK0SvWBzVt8KYX3AwLMEW0jelAKZZBqjBbFq2bNF?=
 =?iso-8859-1?Q?bZY9p00ltgb1JI8wwH8RREPtD61ifVmI51e7doiZYjpTTTS+/kDFa6pNKb?=
 =?iso-8859-1?Q?racCSGXyz1+4cua9TuHW8pugWEkCipdVF/xRO5NWbktKNtVTRiAjGz0cqj?=
 =?iso-8859-1?Q?m6DHrri9uiHIwaWpVNW8EWIvcq78omQQA58Rq8NLvxQdRJjqOO6xwVPBQ6?=
 =?iso-8859-1?Q?wHnvWMwzMYZGt5Pmw21TVqieshZikaX3Nul+MHerCcGbc/L2U8aEAkti2E?=
 =?iso-8859-1?Q?FZp37fZVJJxqEs6jdd7waHBw4xLOzch647OZ4U22WAOs0p7W4JzAlrv6M6?=
 =?iso-8859-1?Q?dhaFOiEtxja+RMii2hv2HG3bgjygH4uQ4yWJZTXTF4w9sWTkpe/1xDv4U+?=
 =?iso-8859-1?Q?GGN+AQQMHRCilXUJFUlUuNGHhXVTTNfTxHIssv8sEV8bM19+H7AO6PM69Z?=
 =?iso-8859-1?Q?6XTlmM9cZ33DN/QLvp+C+Zz?=
x-microsoft-antispam-prvs: <MWHPR11MB13119F5DC2F09745AAD0CF4087670@MWHPR11MB1311.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(53936002)(110136005)(105586002)(106356001)(72206003)(97736004)(3846002)(6436002)(478600001)(6116002)(86362001)(36756003)(6512007)(2501003)(2906002)(25786009)(68736007)(14454004)(50226002)(81166006)(81156014)(8676002)(99286004)(71190400001)(66066001)(4326008)(486006)(7736002)(30864003)(305945005)(71200400001)(8936002)(76176011)(26005)(256004)(386003)(6506007)(52116002)(6486002)(6636002)(446003)(476003)(316002)(2616005)(11346002)(54906003)(102836004)(186003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1311;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A3mkm/pun9YCdTlnadrlCsUzkIr7D37/mSJnsAwYl+UQPPji4NcY/dP/ckw4A42MnWX2+/Bk9dgBNuHY3oeJwPMKiUmT17U2J795DJwDj7V5/I3G/FurW19T+4yRps5HPlNqX9yevRCUi1Q7Ns6A9YKIuPjJ6hicm2XpBlCV8ZnjwWk17FbdTefw9oDljWbgJvg7Im05KumcqVad4liBCq9gMGM5dM9pg2dMnWWk9H9sOxr3Y8yYBkjwe07ecPlxF/6drjimmC8Of7GoU4lQcpv0O6Mj4wKJsR9/T0EJzycxJyb+E0RXdZXSwtvdu0Nh2QD/ubpb39zG9kfO5X+w0AVNHGYZHcYkdEe/HIt/QTgFi26gLNtlt3jjJncVmV5iXnEF24tqTxynMgQC4OmcjCB1EHz68FniarEbn9tThXI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b9de97-123a-4ce7-4825-08d69268b982
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 10:39:37.0381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1311
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

SAM9X60 uses different bit offsets in registers. Adapt the driver to work
also for SAM9X60.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sckc.c | 142 ++++++++++++++++++++++++++++++++++++--------=
----
 1 file changed, 107 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index ab6ecefc49ad..aaef29dacbb5 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -22,15 +22,25 @@
 #define SLOWCK_SW_TIME_USEC	((SLOWCK_SW_CYCLES * USEC_PER_SEC) / \
 				 SLOW_CLOCK_FREQ)
=20
-#define	AT91_SCKC_CR			0x00
-#define		AT91_SCKC_RCEN		(1 << 0)
-#define		AT91_SCKC_OSC32EN	(1 << 1)
-#define		AT91_SCKC_OSC32BYP	(1 << 2)
-#define		AT91_SCKC_OSCSEL	(1 << 3)
+#define	AT91_SCKC_CR		0x00
+#define		AT91_SCKC_RCEN(off)	(1 << (off)->cr_rcen)
+#define		AT91_SCKC_OSC32EN(off)	(1 << (off)->cr_osc32en)
+#define		AT91_SCKC_OSC32BYP(off)	(1 << (off)->cr_osc32byp)
+#define		AT91_SCKC_OSCSEL(off)	(1 << (off)->cr_oscsel)
+
+#define AT91_SCKC_OFFSET_INVALID        (32)
+
+struct clk_slow_offsets {
+	u8 cr_rcen;
+	u8 cr_osc32en;
+	u8 cr_osc32byp;
+	u8 cr_oscsel;
+};
=20
 struct clk_slow_osc {
 	struct clk_hw hw;
 	void __iomem *sckcr;
+	const struct clk_slow_offsets *offsets;
 	unsigned long startup_usec;
 };
=20
@@ -39,6 +49,7 @@ struct clk_slow_osc {
 struct clk_sama5d4_slow_osc {
 	struct clk_hw hw;
 	void __iomem *sckcr;
+	const struct clk_slow_offsets *offsets;
 	unsigned long startup_usec;
 	bool prepared;
 };
@@ -48,6 +59,7 @@ struct clk_sama5d4_slow_osc {
 struct clk_slow_rc_osc {
 	struct clk_hw hw;
 	void __iomem *sckcr;
+	const struct clk_slow_offsets *offsets;
 	unsigned long frequency;
 	unsigned long accuracy;
 	unsigned long startup_usec;
@@ -58,6 +70,7 @@ struct clk_slow_rc_osc {
 struct clk_sam9x5_slow {
 	struct clk_hw hw;
 	void __iomem *sckcr;
+	const struct clk_slow_offsets *offsets;
 	u8 parent;
 };
=20
@@ -69,10 +82,11 @@ static int clk_slow_osc_prepare(struct clk_hw *hw)
 	void __iomem *sckcr =3D osc->sckcr;
 	u32 tmp =3D readl(sckcr);
=20
-	if (tmp & (AT91_SCKC_OSC32BYP | AT91_SCKC_OSC32EN))
+	if (tmp & (AT91_SCKC_OSC32BYP(osc->offsets) |
+		   AT91_SCKC_OSC32EN(osc->offsets)))
 		return 0;
=20
-	writel(tmp | AT91_SCKC_OSC32EN, sckcr);
+	writel(tmp | AT91_SCKC_OSC32EN(osc->offsets), sckcr);
=20
 	usleep_range(osc->startup_usec, osc->startup_usec + 1);
=20
@@ -85,10 +99,10 @@ static void clk_slow_osc_unprepare(struct clk_hw *hw)
 	void __iomem *sckcr =3D osc->sckcr;
 	u32 tmp =3D readl(sckcr);
=20
-	if (tmp & AT91_SCKC_OSC32BYP)
+	if (tmp & AT91_SCKC_OSC32BYP(osc->offsets))
 		return;
=20
-	writel(tmp & ~AT91_SCKC_OSC32EN, sckcr);
+	writel(tmp & ~AT91_SCKC_OSC32EN(osc->offsets), sckcr);
 }
=20
 static int clk_slow_osc_is_prepared(struct clk_hw *hw)
@@ -97,10 +111,10 @@ static int clk_slow_osc_is_prepared(struct clk_hw *hw)
 	void __iomem *sckcr =3D osc->sckcr;
 	u32 tmp =3D readl(sckcr);
=20
-	if (tmp & AT91_SCKC_OSC32BYP)
+	if (tmp & AT91_SCKC_OSC32BYP(osc->offsets))
 		return 1;
=20
-	return !!(tmp & AT91_SCKC_OSC32EN);
+	return !!(tmp & AT91_SCKC_OSC32EN(osc->offsets));
 }
=20
 static const struct clk_ops slow_osc_ops =3D {
@@ -114,7 +128,8 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 			   const char *name,
 			   const char *parent_name,
 			   unsigned long startup,
-			   bool bypass)
+			   bool bypass,
+			   const struct clk_slow_offsets *offsets)
 {
 	struct clk_slow_osc *osc;
 	struct clk_hw *hw;
@@ -137,9 +152,11 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 	osc->hw.init =3D &init;
 	osc->sckcr =3D sckcr;
 	osc->startup_usec =3D startup;
+	osc->offsets =3D offsets;
=20
 	if (bypass)
-		writel((readl(sckcr) & ~AT91_SCKC_OSC32EN) | AT91_SCKC_OSC32BYP,
+		writel((readl(sckcr) & ~AT91_SCKC_OSC32EN(osc->offsets)) |
+					AT91_SCKC_OSC32BYP(osc->offsets),
 		       sckcr);
=20
 	hw =3D &osc->hw;
@@ -153,7 +170,8 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 }
=20
 static void __init
-of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sck=
cr)
+of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sck=
cr,
+				 const struct clk_slow_offsets *offsets)
 {
 	struct clk_hw *hw;
 	const char *parent_name;
@@ -167,7 +185,7 @@ of_at91sam9x5_clk_slow_osc_setup(struct device_node *np=
, void __iomem *sckcr)
 	bypass =3D of_property_read_bool(np, "atmel,osc-bypass");
=20
 	hw =3D at91_clk_register_slow_osc(sckcr, name, parent_name, startup,
-					 bypass);
+					bypass, offsets);
 	if (IS_ERR(hw))
 		return;
=20
@@ -195,7 +213,7 @@ static int clk_slow_rc_osc_prepare(struct clk_hw *hw)
 	struct clk_slow_rc_osc *osc =3D to_clk_slow_rc_osc(hw);
 	void __iomem *sckcr =3D osc->sckcr;
=20
-	writel(readl(sckcr) | AT91_SCKC_RCEN, sckcr);
+	writel(readl(sckcr) | AT91_SCKC_RCEN(osc->offsets), sckcr);
=20
 	usleep_range(osc->startup_usec, osc->startup_usec + 1);
=20
@@ -207,14 +225,14 @@ static void clk_slow_rc_osc_unprepare(struct clk_hw *=
hw)
 	struct clk_slow_rc_osc *osc =3D to_clk_slow_rc_osc(hw);
 	void __iomem *sckcr =3D osc->sckcr;
=20
-	writel(readl(sckcr) & ~AT91_SCKC_RCEN, sckcr);
+	writel(readl(sckcr) & ~AT91_SCKC_RCEN(osc->offsets), sckcr);
 }
=20
 static int clk_slow_rc_osc_is_prepared(struct clk_hw *hw)
 {
 	struct clk_slow_rc_osc *osc =3D to_clk_slow_rc_osc(hw);
=20
-	return !!(readl(osc->sckcr) & AT91_SCKC_RCEN);
+	return !!(readl(osc->sckcr) & AT91_SCKC_RCEN(osc->offsets));
 }
=20
 static const struct clk_ops slow_rc_osc_ops =3D {
@@ -230,7 +248,8 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 			      const char *name,
 			      unsigned long frequency,
 			      unsigned long accuracy,
-			      unsigned long startup)
+			      unsigned long startup,
+			      const struct clk_slow_offsets *offsets)
 {
 	struct clk_slow_rc_osc *osc;
 	struct clk_hw *hw;
@@ -252,6 +271,7 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
=20
 	osc->hw.init =3D &init;
 	osc->sckcr =3D sckcr;
+	osc->offsets =3D offsets;
 	osc->frequency =3D frequency;
 	osc->accuracy =3D accuracy;
 	osc->startup_usec =3D startup;
@@ -267,7 +287,8 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 }
=20
 static void __init
-of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *=
sckcr)
+of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *=
sckcr,
+				    const struct clk_slow_offsets *offsets)
 {
 	struct clk_hw *hw;
 	u32 frequency =3D 0;
@@ -281,7 +302,7 @@ of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node =
*np, void __iomem *sckcr)
 	of_property_read_u32(np, "atmel,startup-time-usec", &startup);
=20
 	hw =3D at91_clk_register_slow_rc_osc(sckcr, name, frequency, accuracy,
-					    startup);
+					   startup, offsets);
 	if (IS_ERR(hw))
 		return;
=20
@@ -299,14 +320,14 @@ static int clk_sam9x5_slow_set_parent(struct clk_hw *=
hw, u8 index)
=20
 	tmp =3D readl(sckcr);
=20
-	if ((!index && !(tmp & AT91_SCKC_OSCSEL)) ||
-	    (index && (tmp & AT91_SCKC_OSCSEL)))
+	if ((!index && !(tmp & AT91_SCKC_OSCSEL(slowck->offsets))) ||
+	    (index && (tmp & AT91_SCKC_OSCSEL(slowck->offsets))))
 		return 0;
=20
 	if (index)
-		tmp |=3D AT91_SCKC_OSCSEL;
+		tmp |=3D AT91_SCKC_OSCSEL(slowck->offsets);
 	else
-		tmp &=3D ~AT91_SCKC_OSCSEL;
+		tmp &=3D ~AT91_SCKC_OSCSEL(slowck->offsets);
=20
 	writel(tmp, sckcr);
=20
@@ -319,7 +340,7 @@ static u8 clk_sam9x5_slow_get_parent(struct clk_hw *hw)
 {
 	struct clk_sam9x5_slow *slowck =3D to_clk_sam9x5_slow(hw);
=20
-	return !!(readl(slowck->sckcr) & AT91_SCKC_OSCSEL);
+	return !!(readl(slowck->sckcr) & AT91_SCKC_OSCSEL(slowck->offsets));
 }
=20
 static const struct clk_ops sam9x5_slow_ops =3D {
@@ -331,7 +352,8 @@ static struct clk_hw * __init
 at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 			      const char *name,
 			      const char **parent_names,
-			      int num_parents)
+			      int num_parents,
+			      const struct clk_slow_offsets *offsets)
 {
 	struct clk_sam9x5_slow *slowck;
 	struct clk_hw *hw;
@@ -353,7 +375,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
=20
 	slowck->hw.init =3D &init;
 	slowck->sckcr =3D sckcr;
-	slowck->parent =3D !!(readl(sckcr) & AT91_SCKC_OSCSEL);
+	slowck->offsets =3D offsets;
+	slowck->parent =3D !!(readl(sckcr) & AT91_SCKC_OSCSEL(slowck->offsets));
=20
 	hw =3D &slowck->hw;
 	ret =3D clk_hw_register(NULL, &slowck->hw);
@@ -366,7 +389,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 }
=20
 static void __init
-of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
+of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr,
+			     const struct clk_slow_offsets *offsets)
 {
 	struct clk_hw *hw;
 	const char *parent_names[2];
@@ -382,7 +406,7 @@ of_at91sam9x5_clk_slow_setup(struct device_node *np, vo=
id __iomem *sckcr)
 	of_property_read_string(np, "clock-output-names", &name);
=20
 	hw =3D at91_clk_register_sam9x5_slow(sckcr, name, parent_names,
-					    num_parents);
+					   num_parents, offsets);
 	if (IS_ERR(hw))
 		return;
=20
@@ -406,10 +430,18 @@ static const struct of_device_id sckc_clk_ids[] __ini=
tconst =3D {
 	{ /*sentinel*/ }
 };
=20
+static const struct clk_slow_offsets at91sam9x5_offsets =3D {
+	.cr_rcen =3D 0,
+	.cr_osc32en =3D 1,
+	.cr_osc32byp =3D 2,
+	.cr_oscsel =3D 3,
+};
+
 static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 {
 	struct device_node *childnp;
-	void (*clk_setup)(struct device_node *, void __iomem *);
+	void (*clk_setup)(struct device_node *np, void __iomem *io,
+			  const struct clk_slow_offsets *offsets);
 	const struct of_device_id *clk_id;
 	void __iomem *regbase =3D of_iomap(np, 0);
=20
@@ -421,12 +453,42 @@ static void __init of_at91sam9x5_sckc_setup(struct de=
vice_node *np)
 		if (!clk_id)
 			continue;
 		clk_setup =3D clk_id->data;
-		clk_setup(childnp, regbase);
+		clk_setup(childnp, regbase, &at91sam9x5_offsets);
 	}
 }
 CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
 	       of_at91sam9x5_sckc_setup);
=20
+static const struct clk_slow_offsets at91sam9x60_offsets =3D {
+	.cr_rcen =3D AT91_SCKC_OFFSET_INVALID,
+	.cr_osc32en =3D 1,
+	.cr_osc32byp =3D 2,
+	.cr_oscsel =3D 24,
+};
+
+static void __init of_at91sam9x60_sckc_setup(struct device_node *np)
+{
+	struct device_node *childnp;
+	void (*clk_setup)(struct device_node *np, void __iomem *io,
+			  const struct clk_slow_offsets *offsets);
+	const struct of_device_id *clk_id;
+	void __iomem *regbase =3D of_iomap(np, 0);
+
+	if (!regbase)
+		return;
+
+	for_each_child_of_node(np, childnp) {
+		clk_id =3D of_match_node(sckc_clk_ids, childnp);
+		if (!clk_id)
+			continue;
+		clk_setup =3D clk_id->data;
+		clk_setup(childnp, regbase, &at91sam9x60_offsets);
+	}
+}
+
+CLK_OF_DECLARE(at91sam9x60_clk_sckc, "microchip,at91sam9x60-sckc",
+	       of_at91sam9x60_sckc_setup);
+
 static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
 {
 	struct clk_sama5d4_slow_osc *osc =3D to_clk_sama5d4_slow_osc(hw);
@@ -438,7 +500,7 @@ static int clk_sama5d4_slow_osc_prepare(struct clk_hw *=
hw)
 	 * Assume that if it has already been selected (for example by the
 	 * bootloader), enough time has aready passed.
 	 */
-	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL)) {
+	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL(osc->offsets))) {
 		osc->prepared =3D true;
 		return 0;
 	}
@@ -461,6 +523,13 @@ static const struct clk_ops sama5d4_slow_osc_ops =3D {
 	.is_prepared =3D clk_sama5d4_slow_osc_is_prepared,
 };
=20
+static const struct clk_slow_offsets at91sama5d4_offsets =3D {
+	.cr_rcen =3D AT91_SCKC_OFFSET_INVALID,
+	.cr_osc32en =3D AT91_SCKC_OFFSET_INVALID,
+	.cr_osc32byp =3D AT91_SCKC_OFFSET_INVALID,
+	.cr_oscsel =3D 3,
+};
+
 static void __init of_sama5d4_sckc_setup(struct device_node *np)
 {
 	void __iomem *regbase =3D of_iomap(np, 0);
@@ -498,9 +567,11 @@ static void __init of_sama5d4_sckc_setup(struct device=
_node *np)
 	osc->hw.init =3D &init;
 	osc->sckcr =3D regbase;
 	osc->startup_usec =3D 1200000;
+	osc->offsets =3D &at91sama5d4_offsets;
=20
 	if (bypass)
-		writel((readl(regbase) | AT91_SCKC_OSC32BYP), regbase);
+		writel((readl(regbase) | AT91_SCKC_OSC32BYP(osc->offsets)),
+		       regbase);
=20
 	hw =3D &osc->hw;
 	ret =3D clk_hw_register(NULL, &osc->hw);
@@ -509,7 +580,8 @@ static void __init of_sama5d4_sckc_setup(struct device_=
node *np)
 		return;
 	}
=20
-	hw =3D at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2);
+	hw =3D at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2,
+					   &at91sama5d4_offsets);
 	if (IS_ERR(hw))
 		return;
=20
--=20
2.7.4

