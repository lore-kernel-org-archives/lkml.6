Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FBEC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C41120844
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="aGKriZkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfBGJZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:25:03 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:57652 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:24:59 -0500
X-IronPort-AV: E=Sophos;i="5.58,342,1544511600"; 
   d="scan'208";a="25951392"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Feb 2019 02:24:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 7 Feb 2019 02:24:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsqFGmrkxMOuMDQMM+iopajYEgoCPwLOzczGpTOw8Dk=;
 b=aGKriZkccGTacF/BR/lF1TD8vPCE3NiFdNyWYeeWZWIwMgaqJjsqS0T4wkSulguZp4QhAwVWi/AKVOKcYXv6tezVU0grOcwPrkpXzKsBG+om6yvMm+Y2M9TVypzMuq29R6NxnUZVvStjYq6cp7KLBiCHL/2FqaVUrN6/mT3QC94=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1757.namprd11.prod.outlook.com (10.175.53.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:24:49 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:24:49 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 2/7] pinctrl: at91: add drive strength support for SAM9X60
Thread-Topic: [PATCH v3 2/7] pinctrl: at91: add drive strength support for
 SAM9X60
Thread-Index: AQHUvsb5aQfjaUldQUGWIwrkwE/hiA==
Date:   Thu, 7 Feb 2019 09:24:49 +0000
Message-ID: <1549531468-1676-3-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1757;6:CV7iBHToKEWXPPb+HNkBHscIvpey6p/v6sqS0F3nxnKmftDkb1uiwJhXhjOEk4whOGoUtGVkgG2CEGucigLRQRL+Z1ctKjj+7OWc3qmSdcTolnJZ/rDtJxpLutcFluXV2ZItZC1SiyCjLeW5pc6i/UDLooKM2ae3K5WBs5ecKPc5YEB5elRhlP5OAqyffzQZRHP/EvzfMcC+xIKTlfNViyWj6RF5XnWOuB2L/bvOThZ7NR/duxCVI9gnZ6pznX+eS/B5AhtTcB0lfIcF80M4nCNbbYZv+MAJgjXaUMytwZII+TvPm0lmyL55G310uuiuWJi11AalOBjXC+SCK28nRil7nMPXf6Hk0+FP3W4XlaS+zsXaSczyCm5kVGe6Sl2YO4Uq/T5giTG7oH+UUhaKBWCJNXD6JbS8bLYIFUBEvZG2U30fQuKO7VQn1USS8EUNv7rTm6rKm3n4FBOCPTgqpQ==;5:n20SwJyGV3gIGik9DP3f5q9+4Qw+0faKWe2DL00wOBdOr6ZC5/CUVW5HrC5JOOfHGXViuxg5y67cvbmipIpIKI56hCjO7fgFJ94OFd915VQ/ISgIwCk48NwUXn1ycDMDrxyoiIZSn4q2ZqNvsB46D+/6ni38M5hiMwOcjPOhjaf8wMuJHHH5y3RJcy6tW5xvUUhwiQxz0++6Cs9sAtmLDw==;7:tGgQtE4ZHl55pzycx3VVDixAkPPnlDfWMkyPSnVXpAOFRyf8z0JKyahTpd5jXL616HdNHoVv6ai06ujAkJI5fyR8uY1evJvnmUCetl2Y+gMGPvlWkqSvLQCsItXiggbCbGoRlhbEqDSG/7sNRGAENQ==
x-ms-office365-filtering-correlation-id: 139f51ac-8a01-40c1-33ed-08d68cde1b8a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1757;
x-ms-traffictypediagnostic: MWHPR11MB1757:
x-microsoft-antispam-prvs: <MWHPR11MB1757370B6F7722EF9D9974AF87680@MWHPR11MB1757.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(53936002)(66066001)(72206003)(6486002)(256004)(71190400001)(71200400001)(99286004)(26005)(102836004)(386003)(6506007)(4326008)(25786009)(478600001)(2906002)(76176011)(186003)(52116002)(68736007)(316002)(14454004)(50226002)(97736004)(8676002)(8936002)(86362001)(6436002)(81166006)(81156014)(2501003)(2616005)(6512007)(107886003)(446003)(11346002)(476003)(6116002)(486006)(305945005)(3846002)(6636002)(106356001)(54906003)(105586002)(110136005)(36756003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1757;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l/941DDXJzuxu/zdQ1KHLFgBmY7CqaXnUr6zlhmAZ7YAv+/z4dp0n3ScC66tYFeT6iyg5w0ZTAGAlN3+jbvjggunwhDzwvLsDiFe+yWvekV5pozcsubsUn/sCtYH9VSYkKmXNgGr1+gfUkOxYrgiCiOga3Ov/y7/LXe6ftZUbuZRZuIig3i3L1y6qsKTdMYWAHqIXznfvGne6usm1MnkznoTupvcNE9nuds9viI0Q20pjN6iNE5sHRjZyVIHdKGr0ppNTpdwe7tcjKQxjR978XTSaGn/ARx4Gd3SvB14tJqBu8/pv5swLYbmcGwqGpuFk9i2+ZQjAQyZpJx50bY7Gjk+fvGIdsf5/1m9qusRVQraAwozP2areCsmDeuRHaioEWS1UxMAv0qdNnA1qh98A/FpKtFf4y5cszSIDOclylY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 139f51ac-8a01-40c1-33ed-08d68cde1b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:24:46.5823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1757
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add drive strength support for SAM9X60 pin controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 52 ++++++++++++++++++++++++++++++++++++++=
++++
 drivers/pinctrl/pinctrl-at91.h |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.=
c
index 31f06dafca2e..46443b97d811 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -574,6 +574,17 @@ static unsigned at91_mux_sam9x5_get_drivestrength(void=
 __iomem *pio,
 	return tmp;
 }
=20
+static unsigned at91_mux_sam9x60_get_drivestrength(void __iomem *pio,
+						   unsigned pin)
+{
+	unsigned tmp =3D readl_relaxed(pio + SAM9X60_PIO_DRIVER1);
+
+	if (tmp & BIT(pin))
+		return DRIVE_STRENGTH_BIT_HI;
+
+	return DRIVE_STRENGTH_BIT_LOW;
+}
+
 static void set_drive_strength(void __iomem *reg, unsigned pin, u32 streng=
th)
 {
 	unsigned tmp =3D readl_relaxed(reg);
@@ -611,6 +622,27 @@ static void at91_mux_sam9x5_set_drivestrength(void __i=
omem *pio, unsigned pin,
 				setting);
 }
=20
+static void at91_mux_sam9x60_set_drivestrength(void __iomem *pio, unsigned=
 pin,
+					       u32 setting)
+{
+	unsigned int tmp;
+
+	if (setting <=3D DRIVE_STRENGTH_BIT_DEF ||
+	    setting =3D=3D DRIVE_STRENGTH_BIT_MED ||
+	    setting > DRIVE_STRENGTH_BIT_HI)
+		return;
+
+	tmp =3D readl_relaxed(pio + SAM9X60_PIO_DRIVER1);
+
+	/* Strength is 0: low, 1: hi */
+	if (setting =3D=3D DRIVE_STRENGTH_BIT_LOW)
+		tmp &=3D ~BIT(pin);
+	else
+		tmp |=3D BIT(pin);
+
+	writel_relaxed(tmp, pio + SAM9X60_PIO_DRIVER1);
+}
+
 static struct at91_pinctrl_mux_ops at91rm9200_ops =3D {
 	.get_periph	=3D at91_mux_get_periph,
 	.mux_A_periph	=3D at91_mux_set_A_periph,
@@ -639,6 +671,26 @@ static struct at91_pinctrl_mux_ops at91sam9x5_ops =3D =
{
 	.irq_type	=3D alt_gpio_irq_type,
 };
=20
+static const struct at91_pinctrl_mux_ops sam9x60_ops =3D {
+	.get_periph	=3D at91_mux_pio3_get_periph,
+	.mux_A_periph	=3D at91_mux_pio3_set_A_periph,
+	.mux_B_periph	=3D at91_mux_pio3_set_B_periph,
+	.mux_C_periph	=3D at91_mux_pio3_set_C_periph,
+	.mux_D_periph	=3D at91_mux_pio3_set_D_periph,
+	.get_deglitch	=3D at91_mux_pio3_get_deglitch,
+	.set_deglitch	=3D at91_mux_pio3_set_deglitch,
+	.get_debounce	=3D at91_mux_pio3_get_debounce,
+	.set_debounce	=3D at91_mux_pio3_set_debounce,
+	.get_pulldown	=3D at91_mux_pio3_get_pulldown,
+	.set_pulldown	=3D at91_mux_pio3_set_pulldown,
+	.get_schmitt_trig =3D at91_mux_pio3_get_schmitt_trig,
+	.disable_schmitt_trig =3D at91_mux_pio3_disable_schmitt_trig,
+	.get_drivestrength =3D at91_mux_sam9x60_get_drivestrength,
+	.set_drivestrength =3D at91_mux_sam9x60_set_drivestrength,
+	.irq_type	=3D alt_gpio_irq_type,
+
+};
+
 static struct at91_pinctrl_mux_ops sama5d3_ops =3D {
 	.get_periph	=3D at91_mux_pio3_get_periph,
 	.mux_A_periph	=3D at91_mux_pio3_set_A_periph,
diff --git a/drivers/pinctrl/pinctrl-at91.h b/drivers/pinctrl/pinctrl-at91.=
h
index 79b957f1dfa2..19fc27e66bfd 100644
--- a/drivers/pinctrl/pinctrl-at91.h
+++ b/drivers/pinctrl/pinctrl-at91.h
@@ -69,4 +69,6 @@
 #define AT91SAM9X5_PIO_DRIVER1	0x114  /*PIO Driver 1 register offset*/
 #define AT91SAM9X5_PIO_DRIVER2	0x118  /*PIO Driver 2 register offset*/
=20
+#define SAM9X60_PIO_DRIVER1	0x118	/* PIO Driver 1 register offset */
+
 #endif
--=20
2.7.4

