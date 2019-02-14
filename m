Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C496C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3D821900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3HrhAFuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394434AbfBNMOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:14:47 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:16022 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfBNMOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:14:46 -0500
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; 
   d="scan'208";a="26555765"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 05:14:30 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 05:14:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dodt25BBBfLd4ZQZOR8HaYEIztLbD+qOT5lurzPxLMM=;
 b=3HrhAFuu1xRwzgT3UlvQhqqNj3cE/BT6MAMm3A9o8R2RvhAEyXR927RBiHMEDtPLCKYcW2K8rgd6KyNdf2b2SLFcMRoKU6Yku210fJU2TNwEscSNSxkxHVtQalt/OO3R6VxLbKqEN/UsPfKur+/+/r6vzYWRH3in7/ZMfDrZ8Is=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1518.namprd11.prod.outlook.com (10.172.54.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 12:14:28 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 12:14:28 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 1/3] clk: at91: sckc: add support to specify registers bit
 offsets
Thread-Topic: [PATCH v2 1/3] clk: at91: sckc: add support to specify registers
 bit offsets
Thread-Index: AQHUxF7V9nqwlEcieUmVG7K88z/Dxw==
Date:   Thu, 14 Feb 2019 12:14:28 +0000
Message-ID: <1550146447-1441-2-git-send-email-claudiu.beznea@microchip.com>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:803:1::37) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29cf747f-2013-4cfa-062c-08d69275f75d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1518;
x-ms-traffictypediagnostic: MWHPR11MB1518:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1518;23:PWfDB9xt2hGoL1O8bVxJ2JLic51vqRF7Lz4t1iJ?=
 =?iso-8859-1?Q?+Ve0vsI05XXdg0mmdkIizyeEAw6p38Gj4SB4KEi9Ss4InghKWGn89hMqEv?=
 =?iso-8859-1?Q?uppYrX9qxF1s94tr1dFt3qOM8EEaOTp1slCSTvoHGMdHC61sRcBl0ObAox?=
 =?iso-8859-1?Q?Pq+z3XZM9xyDUTWp0NMp1XQlcwScoNYOmHAcRzO0dGexHqY33cg2zOzK5X?=
 =?iso-8859-1?Q?kiYWPHroByIjpYfQTbIcjESu9xXUI+dpj9VjSNlfaO9K0reH+2OSpP+NwJ?=
 =?iso-8859-1?Q?Bs5aj9zQwANmu794/sQ9NMv4fxKIe+j6oEuTSpKEQYT3zERGIB6UyLAsQu?=
 =?iso-8859-1?Q?4BXhcaBj4uzh4EeHqWdNyMKCH+QaKB8+JpjiUQDJbV6ZjSyO6CWJknpTI2?=
 =?iso-8859-1?Q?hKIvNNuYHZlDBDkYKqz7BdpMqB3MaHUffm+zoKyamGeUlDlYmG+2NBc2U1?=
 =?iso-8859-1?Q?jo00o8g/RIrPbkuYitZLsnossVZ+1ceMN5Rzf6J3bZI90QqqLd8PNIc5zR?=
 =?iso-8859-1?Q?3rYa3sPeFTZb3SxV1S5FA4Klfz6Grf1KiR87eM9jG2yPpcfrDaIRfccUI/?=
 =?iso-8859-1?Q?vZsUeEnJ58wq7kdQCJck1+B9gK183PI7cidWaMzuEI1Nr4hO+gE1ftcsWP?=
 =?iso-8859-1?Q?TZp1QlnKDWkkdrZ6oeyUAyF7PG2uZszJwN69A5Y6+0YJOQLPVyB/YgA+9o?=
 =?iso-8859-1?Q?q+Tvu+9KVT+Fu/JfMBPrx/x9pcQ8Xtkx1gctqnhC6MQA1nLyCYLfDqN1qK?=
 =?iso-8859-1?Q?FVW+hlVyWL3xt4tP3iyKfquNz/LnkGEK24sW3Bzgikj10f1S05Maxp47NB?=
 =?iso-8859-1?Q?r1PP3xa84dinn7+53Zkn9nrZUbcS6Qx6TKiEBpqTVTr6PaZS+kfULApWin?=
 =?iso-8859-1?Q?/akU9oKvof05wz2T8I978usf41x6MOkpsbAQO/7gXCghbDNMh3j13Z8zmQ?=
 =?iso-8859-1?Q?epJ1SKTkkSflNz3ZMfePE+8bZfr2CMIXn/8NFbGttAItEj6yJ3kKRd7Sn6?=
 =?iso-8859-1?Q?1LVv4UIVFA+tlRwJl3tZQ8Xkgl2MOZSAv9RaSOwgUdreCvBRij+gZJ0jQe?=
 =?iso-8859-1?Q?EmCFILPB6imPCoIByQktMGsF6VVLUKh5jREFJi+DxelB3qV0+4e4uSep4i?=
 =?iso-8859-1?Q?dXqhhEQIY7X4tpAw3WI1Gw8gxgBIY8AZRCvl4THZf27FaFte7vPIKLIxR/?=
 =?iso-8859-1?Q?x0rF062COwrWk/Cf3MEBS7RA2W0B6WV6KNpR5i6Mrk4t1/a+j632YUzo+r?=
 =?iso-8859-1?Q?SsgUMjzY5NPNOHoc1AQevDxnN47nwaWh2ZfEq03ti4qiEAWbxAiMJe+QPh?=
 =?iso-8859-1?Q?K3T+1qT9A0RWQQC1vm5zw7O?=
x-microsoft-antispam-prvs: <MWHPR11MB1518058A2B935857800C83EC87670@MWHPR11MB1518.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(72206003)(11346002)(107886003)(476003)(25786009)(4326008)(52116002)(486006)(6512007)(14454004)(6636002)(478600001)(446003)(36756003)(3846002)(2616005)(6116002)(97736004)(8936002)(76176011)(50226002)(54906003)(110136005)(99286004)(7736002)(256004)(186003)(71200400001)(2501003)(316002)(71190400001)(106356001)(68736007)(26005)(81166006)(105586002)(81156014)(2906002)(305945005)(66066001)(6486002)(53936002)(86362001)(6436002)(386003)(102836004)(30864003)(6506007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1518;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YhK5yjYQ6tBsxAEsMUvvOShwBsKNPsyIQztJ1xcCCgc8+IGYY6Cd4suUzpro/wOZ+sXZOz+Y/Ep/GEcw8eYB2xcBB2E4MtdpSeL5mFIWKhJlQY68n6fZIbYgOLJnoSgdi8VUmCT1paT2LYEtWwkI24ZqgDI+/9Vu/GnEQ8HGCGkZNXWtTx1oUjOtEBCmIKDWCz9+xsLOe+whrXUUf7d5KC4EmR+vQE2ZEAB4rXgj5Fad1QMAjwsx8Bv15MQik7gNIusxChFiOhlURHYr8plE6Mjh0OmttI4YtSTBopGiKLBTHXM/mx8pucndOtclr0l7x661e9VSG8/94mvFbJWde/FnrzwCC5/CwCVwqeB0ywlyiw34tlNsRn/X66MGS4TS4XN1j0/KKgdY5heYmCvos2zsR/eun8aTQe54zZ76Z9U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cf747f-2013-4cfa-062c-08d69275f75d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 12:14:24.3613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1518
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Different IPs uses different offsets in registers for the same
functionality, thus adapt the driver to support this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sckc.c | 112 +++++++++++++++++++++++++++++++++-----------=
----
 1 file changed, 77 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index ab6ecefc49ad..b7163d3a2269 100644
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
@@ -421,7 +453,7 @@ static void __init of_at91sam9x5_sckc_setup(struct devi=
ce_node *np)
 		if (!clk_id)
 			continue;
 		clk_setup =3D clk_id->data;
-		clk_setup(childnp, regbase);
+		clk_setup(childnp, regbase, &at91sam9x5_offsets);
 	}
 }
 CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
@@ -438,7 +470,7 @@ static int clk_sama5d4_slow_osc_prepare(struct clk_hw *=
hw)
 	 * Assume that if it has already been selected (for example by the
 	 * bootloader), enough time has aready passed.
 	 */
-	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL)) {
+	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL(osc->offsets))) {
 		osc->prepared =3D true;
 		return 0;
 	}
@@ -461,6 +493,13 @@ static const struct clk_ops sama5d4_slow_osc_ops =3D {
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
@@ -498,9 +537,11 @@ static void __init of_sama5d4_sckc_setup(struct device=
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
@@ -509,7 +550,8 @@ static void __init of_sama5d4_sckc_setup(struct device_=
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

