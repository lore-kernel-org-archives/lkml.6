Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681D5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AB0218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PfPM8U/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBGJZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:25:11 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:29540 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:25:07 -0500
X-IronPort-AV: E=Sophos;i="5.58,342,1544511600"; 
   d="scan'208";a="23535634"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Feb 2019 02:25:07 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 7 Feb 2019 02:25:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol0TarVjTHFKZ/iLNGFnMquEzr7gqfurGJ9ZwU9reo0=;
 b=PfPM8U/b4h1G9l5p5iuA5aOPk5Xl2K/iYJAEyMtpIKHChxMI74KQ/wk1Rv1A81FhDZqTV9LxrpmAQo52LCwiAUEpVx7ULbSTTYE20jo88SOc/h27d38XBwEiXiCDsBNvrMg76AU5Il6kINUzJinUL0YjeAi0L9LMWm7w7+rkZ6U=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1952.namprd11.prod.outlook.com (10.175.54.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:25:05 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:25:05 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 6/7] pinctrl: at91: add slewrate support for SAM9X60
Thread-Topic: [PATCH v3 6/7] pinctrl: at91: add slewrate support for SAM9X60
Thread-Index: AQHUvscCVENqfuzdpka0sn480dQTNg==
Date:   Thu, 7 Feb 2019 09:25:05 +0000
Message-ID: <1549531468-1676-7-git-send-email-claudiu.beznea@microchip.com>
References: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0350.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5a::26) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1952;6:hel3hGKM1Ux6tGWOy3/KuGgTBiCYsztUYblLhS74sBJixOIYmQwAWNFNQyLfyKfR/ouNU3CHavPgmbMJ9BB8ruUiWMxCCAFGDdfbShKA4BlGvKKfSRlyYTA+QYc1OKb7XB8ZgNNTI1mB89TFhrRlx/ck/rdIv7LPtnQ8xK+dQaDUz/hvuvhzihI/ZBqR5VYB9zhj9I2Z3iW0ZxPOvccFdou0meLpNawFvuJA+jiN6bWS1aXRx4XAz4G5Rl+Z1Hhno/OvtWOBPzD+6fG81W5kOwuJSSaLtGyn/3CZMTJ9Dh5T8xH0HoR7fUJAEbBHF2wOuSDAMOt3UM69Tei2hUmwNAeLwd6RdBmLI+J6pZGsZt05FtXhsD9rkvwwopNsTRNiCyHtFe2nEsZ1PkLlRHh4ETuEkKF8z8s3d/ZihqBy7CipDdh4HV9xrJD+ZH/3sqRRNTqMDCg2i/sMGCEsxxAMKg==;5:Z2ihp7dIkHr/xncPCNaiyJqZwNhJeR5d2iy656vEIiH5OF69BlafyCmbMaarB3B+igSfB3ssjO7YWZlddAFmDNQaNY8ygHSqEfPuMp0UMzmbIi4/pBfeY2QtQDI5Sz06IjVOK8UpPDz57hsGBfoRQONqtVg+xr3mDd/pTr9k+squrwlxJuaKAGKRPEFPQmXFagG3opYf4nRvP/JX1EKsQA==;7:FXa6eRLxvWnos5DWiKtgSnPfzF5A5Bvd8709LvXuDGoVqGF1yg9v9TUIWyXT2U3CC0bTv8xKMKW1ZUMqXy0RYNqeNzMY3Z/2Bf5m5QooracUXAKiU0nZnpDkzPz0jj+i6GFRwM2j3/HOvX84wg5twg==
x-ms-office365-filtering-correlation-id: f1f52376-5932-4743-4987-08d68cde24b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1952;
x-ms-traffictypediagnostic: MWHPR11MB1952:
x-microsoft-antispam-prvs: <MWHPR11MB1952D2CFBE78A1F9A0DAD17D87680@MWHPR11MB1952.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(396003)(346002)(189003)(199004)(6512007)(66066001)(486006)(2616005)(476003)(97736004)(25786009)(106356001)(6436002)(305945005)(105586002)(2501003)(53936002)(26005)(50226002)(186003)(3846002)(76176011)(6116002)(110136005)(6506007)(102836004)(2906002)(52116002)(386003)(11346002)(107886003)(4326008)(7736002)(316002)(446003)(36756003)(8936002)(81166006)(81156014)(54906003)(99286004)(6486002)(71190400001)(71200400001)(256004)(72206003)(6636002)(478600001)(14454004)(86362001)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1952;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kLboT9GRh9BrVk4V+6DkGKgB7C0EJlpKPVqCA8vTITqHkMhbMuA/G+pJbHRGC9yUOEMs65eoBK7/baH44fCspcw8qKLo8Nc990p1JwhFJRgJRcRdKTbQRd+msmI/LPKvOvRK5UrJwyiqCqKPUXxd+dvXD0TvlIHuOYzdN1cijOI/X/Zxsd504hbTxmLJX5R4Esq9bPRAY89+b/UU9dU1uV4c5fjp5M4hFTZJLbLzwsVr30P/47+/utGA7mAxr0NnZ4DnIC5BWRhXzSi1cztyt8ij5xaOWjDhQv0TUur/NHfVU4TViqYfTnFxDZJhDJMvw8HetPmA2ylSqxxGtg4RtdopUKusL4RTIkw6+rJ+eGDzMDMZ/dIdsRAmcrcXP7plpfd1E28K/JUzTYU+jUiA3FtFwY0P5FYuW6JLQfMdc6I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f52376-5932-4743-4987-08d68cde24b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:25:01.8946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1952
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add slew rate support for SAM9X60 pin controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c     | 48 ++++++++++++++++++++++++++++++++++=
++++
 drivers/pinctrl/pinctrl-at91.h     |  1 +
 include/dt-bindings/pinctrl/at91.h |  4 ++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.=
c
index 5456a2692b8c..2c6d3b61951f 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -59,6 +59,9 @@ static int gpio_banks;
 #define OUTPUT		(1 << 7)
 #define OUTPUT_VAL_SHIFT	8
 #define OUTPUT_VAL	(0x1 << OUTPUT_VAL_SHIFT)
+#define SLEWRATE_SHIFT	9
+#define SLEWRATE_MASK	0x1
+#define SLEWRATE	(SLEWRATE_MASK << SLEWRATE_SHIFT)
 #define DEBOUNCE	(1 << 16)
 #define DEBOUNCE_VAL_SHIFT	17
 #define DEBOUNCE_VAL	(0x3fff << DEBOUNCE_VAL_SHIFT)
@@ -82,6 +85,13 @@ enum drive_strength_bit {
 #define DRIVE_STRENGTH_BIT_MSK(name)	(DRIVE_STRENGTH_BIT_##name << \
 					 DRIVE_STRENGTH_SHIFT)
=20
+enum slewrate_bit {
+	SLEWRATE_BIT_DIS,
+	SLEWRATE_BIT_ENA,
+};
+
+#define SLEWRATE_BIT_MSK(name)		(SLEWRATE_BIT_##name << SLEWRATE_SHIFT)
+
 /**
  * struct at91_pmx_func - describes AT91 pinmux functions
  * @name: the name of this specific function
@@ -171,6 +181,8 @@ struct at91_pinctrl_mux_ops {
 	unsigned (*get_drivestrength)(void __iomem *pio, unsigned pin);
 	void (*set_drivestrength)(void __iomem *pio, unsigned pin,
 					u32 strength);
+	unsigned (*get_slewrate)(void __iomem *pio, unsigned pin);
+	void (*set_slewrate)(void __iomem *pio, unsigned pin, u32 slewrate);
 	/* irq */
 	int (*irq_type)(struct irq_data *d, unsigned type);
 };
@@ -585,6 +597,16 @@ static unsigned at91_mux_sam9x60_get_drivestrength(voi=
d __iomem *pio,
 	return DRIVE_STRENGTH_BIT_LOW;
 }
=20
+static unsigned at91_mux_sam9x60_get_slewrate(void __iomem *pio, unsigned =
pin)
+{
+	unsigned tmp =3D readl_relaxed(pio + SAM9X60_PIO_SLEWR);
+
+	if ((tmp & BIT(pin)))
+		return SLEWRATE_BIT_ENA;
+
+	return SLEWRATE_BIT_DIS;
+}
+
 static void set_drive_strength(void __iomem *reg, unsigned pin, u32 streng=
th)
 {
 	unsigned tmp =3D readl_relaxed(reg);
@@ -643,6 +665,24 @@ static void at91_mux_sam9x60_set_drivestrength(void __=
iomem *pio, unsigned pin,
 	writel_relaxed(tmp, pio + SAM9X60_PIO_DRIVER1);
 }
=20
+static void at91_mux_sam9x60_set_slewrate(void __iomem *pio, unsigned pin,
+					  u32 setting)
+{
+	unsigned int tmp;
+
+	if (setting < SLEWRATE_BIT_DIS || setting > SLEWRATE_BIT_ENA)
+		return;
+
+	tmp =3D readl_relaxed(pio + SAM9X60_PIO_SLEWR);
+
+	if (setting =3D=3D SLEWRATE_BIT_DIS)
+		tmp &=3D ~BIT(pin);
+	else
+		tmp |=3D BIT(pin);
+
+	writel_relaxed(tmp, pio + SAM9X60_PIO_SLEWR);
+}
+
 static struct at91_pinctrl_mux_ops at91rm9200_ops =3D {
 	.get_periph	=3D at91_mux_get_periph,
 	.mux_A_periph	=3D at91_mux_set_A_periph,
@@ -687,6 +727,8 @@ static const struct at91_pinctrl_mux_ops sam9x60_ops =
=3D {
 	.disable_schmitt_trig =3D at91_mux_pio3_disable_schmitt_trig,
 	.get_drivestrength =3D at91_mux_sam9x60_get_drivestrength,
 	.set_drivestrength =3D at91_mux_sam9x60_set_drivestrength,
+	.get_slewrate   =3D at91_mux_sam9x60_get_slewrate,
+	.set_slewrate   =3D at91_mux_sam9x60_set_slewrate,
 	.irq_type	=3D alt_gpio_irq_type,
=20
 };
@@ -950,6 +992,8 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev=
,
 	if (info->ops->get_drivestrength)
 		*config |=3D (info->ops->get_drivestrength(pio, pin)
 				<< DRIVE_STRENGTH_SHIFT);
+	if (info->ops->get_slewrate)
+		*config |=3D (info->ops->get_slewrate(pio, pin) << SLEWRATE_SHIFT);
 	if (at91_mux_get_output(pio, pin, &out))
 		*config |=3D OUTPUT | (out << OUTPUT_VAL_SHIFT);
=20
@@ -1001,6 +1045,9 @@ static int at91_pinconf_set(struct pinctrl_dev *pctld=
ev,
 			info->ops->set_drivestrength(pio, pin,
 				(config & DRIVE_STRENGTH)
 					>> DRIVE_STRENGTH_SHIFT);
+		if (info->ops->set_slewrate)
+			info->ops->set_slewrate(pio, pin,
+				(config & SLEWRATE) >> SLEWRATE_SHIFT);
=20
 	} /* for each config */
=20
@@ -1044,6 +1091,7 @@ static void at91_pinconf_dbg_show(struct pinctrl_dev =
*pctldev,
 			     DRIVE_STRENGTH_MED);
 	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(HI),
 			     DRIVE_STRENGTH_HI);
+	DBG_SHOW_FLAG(SLEWRATE);
 	DBG_SHOW_FLAG(DEBOUNCE);
 	if (config & DEBOUNCE) {
 		val =3D config >> DEBOUNCE_VAL_SHIFT;
diff --git a/drivers/pinctrl/pinctrl-at91.h b/drivers/pinctrl/pinctrl-at91.=
h
index 19fc27e66bfd..223620f14b05 100644
--- a/drivers/pinctrl/pinctrl-at91.h
+++ b/drivers/pinctrl/pinctrl-at91.h
@@ -69,6 +69,7 @@
 #define AT91SAM9X5_PIO_DRIVER1	0x114  /*PIO Driver 1 register offset*/
 #define AT91SAM9X5_PIO_DRIVER2	0x118  /*PIO Driver 2 register offset*/
=20
+#define SAM9X60_PIO_SLEWR	0x110	/* PIO Slew Rate Control Register */
 #define SAM9X60_PIO_DRIVER1	0x118	/* PIO Driver 1 register offset */
=20
 #endif
diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinct=
rl/at91.h
index eb81867eac77..8dc10e00c627 100644
--- a/include/dt-bindings/pinctrl/at91.h
+++ b/include/dt-bindings/pinctrl/at91.h
@@ -17,6 +17,7 @@
 #define AT91_PINCTRL_DIS_SCHMIT		(1 << 4)
 #define AT91_PINCTRL_OUTPUT		(1 << 7)
 #define AT91_PINCTRL_OUTPUT_VAL(x)	((x & 0x1) << 8)
+#define AT91_PINCTRL_SLEWRATE		(1 << 9)
 #define AT91_PINCTRL_DEBOUNCE		(1 << 16)
 #define AT91_PINCTRL_DEBOUNCE_VAL(x)	(x << 17)
=20
@@ -27,6 +28,9 @@
 #define AT91_PINCTRL_DRIVE_STRENGTH_MED			(0x2 << 5)
 #define AT91_PINCTRL_DRIVE_STRENGTH_HI			(0x3 << 5)
=20
+#define AT91_PINCTRL_SLEWRATE_DIS	(0x0 << 9)
+#define AT91_PINCTRL_SLEWRATE_ENA	(0x1 << 9)
+
 #define AT91_PIOA	0
 #define AT91_PIOB	1
 #define AT91_PIOC	2
--=20
2.7.4

