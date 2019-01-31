Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBE0C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9090C2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KZDsK8Tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732911AbfAaM3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:29:20 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:17046 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaM3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:29:18 -0500
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="23251714"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 31 Jan 2019 05:29:17 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 05:29:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhChX10vwbYxOclrTUsmMFyts4oFCatbv6zC85rEGJo=;
 b=KZDsK8Tph0IR/9CQUT6zEGIqk9Vp0CM+o3maVQeGGZKHRCrByGufUsooVgAolkfv32ErerPYMJU2yl/H/avXE+mSaNQkzeFyN7/DKdP+U2e0fyK7SwBiu8driaXZJFCvNXEYBmg0/q7eudP4fo7XjXMD2qK5Ty+9TplZcWl8/SY=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1454.namprd11.prod.outlook.com (10.172.53.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Thu, 31 Jan 2019 12:29:15 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 12:29:15 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/7] pinctrl: at91: add option to use drive strength bits
Thread-Topic: [PATCH 1/7] pinctrl: at91: add option to use drive strength bits
Thread-Index: AQHUuWCU7D5bO1vuGEKczbOmmOh17g==
Date:   Thu, 31 Jan 2019 12:29:15 +0000
Message-ID: <1548937733-20189-2-git-send-email-claudiu.beznea@microchip.com>
References: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0036.eurprd07.prod.outlook.com
 (2603:10a6:800:90::22) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1454;6:rGBbLhUOCvn5XvxuCKjjEEQi0lFR1cD51hw/2lRs0K2Q7FU0YIb9CJJwCmSGuL86uCYIwRuiwEvGGu85vMx8q28n3iYUPLz+lr61G6KWY1y4LIKkyb4/74f80JjyfpFdwhK80DigNvchjJn4d6+/fHanazlKmp5rlYSnhCOo0vvPbXMK1HksgN498T6eXXICmRdM6h+YwWi16Tn0MUYZZGUSDiYSUn5WlKXCF6k7Zv5hk8U4CHXKZu+Hopkvs/C520OBSYdQKNfZ6UlGTyTn0sAyGCEMVpvyz2xIw/8QvsL55h5NtBJsVTV8JLUlfwPATcXHl+OXWKOhSx3TM6kU3EzopmhdzAfPqwEyBG5LMzn+uNa+yp5fnSfrwupzcM1QjefDtcjhAIfJNrG+IShZl7lre0GotPHM0ciTQ9lRIJjLs8CnXRLG0/DiRT0TMO6PjOaw+u3calUnDmT0NemNuw==;5:CpdiPNdXJu6TeIRUX+xcmhKzftma4bdZs/LdopAy7Uq+Fh7GfDiS8fekGVqnTzOj7WVrmXZSZnUy1YiseIyrv5rLllR1HSGv9+j40R8APebzpkOngoWTXHFszGYcQ0ij03pqpBo2NTccInoYZ5LvER+o+VNE9VhhVbW8Gah/+m4MgJasQasdZTXyaYUlNjc6IB6VLUnHAqX105D7Zu/aQA==;7:y5ivyYZEuarIktjaqVOyVQv9ih925bw3Y6mwZeyEqlPPagrQHC85k2Y8GKevRjKsCpJNs/SLJUGLDQSGO/DsKg3bQIRagLrwQAx2veKo9tzam1aIJmi4N5n+Of0Z/Ql6LbYe5PBM64B3UPcisVLaKg==
x-ms-office365-filtering-correlation-id: 07c3563d-ed9e-41b0-ef95-08d68777b688
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1454;
x-ms-traffictypediagnostic: MWHPR11MB1454:
x-microsoft-antispam-prvs: <MWHPR11MB14547ECC067E53A233BC2A4E87910@MWHPR11MB1454.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(2906002)(110136005)(186003)(8936002)(50226002)(4326008)(11346002)(25786009)(6116002)(2616005)(97736004)(476003)(305945005)(66066001)(3846002)(36756003)(8676002)(7736002)(14454004)(72206003)(81156014)(478600001)(68736007)(486006)(81166006)(107886003)(52116002)(99286004)(6436002)(316002)(6486002)(446003)(86362001)(54906003)(2501003)(256004)(105586002)(6636002)(76176011)(53936002)(106356001)(26005)(71190400001)(6506007)(386003)(71200400001)(102836004)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1454;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CZbrC3ZeSuRd5TSTpeRVKgH+MRyGFbl9K1NbANRXIS1W7oH40HLU34GUe5pCELHeSkN7BFF+m1NZ/gmqfmpNz83IIpqr9CCGyAhHn24y4VqPWjjUYGlGrLbd6kDGQsXszfNQ/6Aos4yM+musmp3RZ6yGq6YTj3qUAB5LWoO6IyHAlx5iaCQpX5W2ND/p39bWH65h7T5Y4GdLgkkcpuOvIiLfnPO/24C02cIW1hfYbwC3TTKeaA12+CSXTVBAAXEikyMlyVYQg7VnRpYdVQUa1HEVgQkPwTk2MGjySMm8Ch3CGSTuv1FgGDVWaNXJJTb9euIenhZaPD49h7iHYB/7eHuQsk6n1VCviLmEPIA2nlD09OHWxlf4y3BAEukVhocXuCN3z/W9g67/dOgfadbkM2kSsdpB5CD3GvFflVnrOmg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c3563d-ed9e-41b0-ef95-08d68777b688
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:29:12.3395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1454
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

SAM9X60 uses high and low drive strengths. To implement this, in
at91_pinctrl_mux_ops::set_drivestrength and
at91_pinctrl_mux_ops::get_drivestrength we need bit numbers of
drive strengths (1 for low, 2 for high), thus change the code to
allow the usage of drive strength bit numbers.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.=
c
index 3d49bbbcdbc7..31f06dafca2e 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -72,10 +72,15 @@ static int gpio_banks;
  * DRIVE_STRENGTH_DEFAULT is just a placeholder to avoid changing the driv=
e
  * strength when there is no dt config for it.
  */
-#define DRIVE_STRENGTH_DEFAULT		(0 << DRIVE_STRENGTH_SHIFT)
-#define DRIVE_STRENGTH_LOW          (1 << DRIVE_STRENGTH_SHIFT)
-#define DRIVE_STRENGTH_MED          (2 << DRIVE_STRENGTH_SHIFT)
-#define DRIVE_STRENGTH_HI           (3 << DRIVE_STRENGTH_SHIFT)
+enum drive_strength_bit {
+	DRIVE_STRENGTH_BIT_DEF,
+	DRIVE_STRENGTH_BIT_LOW,
+	DRIVE_STRENGTH_BIT_MED,
+	DRIVE_STRENGTH_BIT_HI,
+};
+
+#define DRIVE_STRENGTH_BIT_MSK(name)	(DRIVE_STRENGTH_BIT_##name << \
+					 DRIVE_STRENGTH_SHIFT)
=20
 /**
  * struct at91_pmx_func - describes AT91 pinmux functions
@@ -551,7 +556,7 @@ static unsigned at91_mux_sama5d3_get_drivestrength(void=
 __iomem *pio,
 	/* SAMA5 strength is 1:1 with our defines,
 	 * except 0 is equivalent to low per datasheet */
 	if (!tmp)
-		tmp =3D DRIVE_STRENGTH_LOW;
+		tmp =3D DRIVE_STRENGTH_BIT_MSK(LOW);
=20
 	return tmp;
 }
@@ -564,7 +569,7 @@ static unsigned at91_mux_sam9x5_get_drivestrength(void =
__iomem *pio,
=20
 	/* strength is inverse in SAM9x5s hardware with the pinctrl defines
 	 * hardware: 0 =3D hi, 1 =3D med, 2 =3D low, 3 =3D rsvd */
-	tmp =3D DRIVE_STRENGTH_HI - tmp;
+	tmp =3D DRIVE_STRENGTH_BIT_MSK(HI) - tmp;
=20
 	return tmp;
 }
@@ -600,7 +605,7 @@ static void at91_mux_sam9x5_set_drivestrength(void __io=
mem *pio, unsigned pin,
=20
 	/* strength is inverse on SAM9x5s with our defines
 	 * 0 =3D hi, 1 =3D med, 2 =3D low, 3 =3D rsvd */
-	setting =3D DRIVE_STRENGTH_HI - setting;
+	setting =3D DRIVE_STRENGTH_BIT_MSK(HI) - setting;
=20
 	set_drive_strength(pio + at91sam9x5_get_drive_register(pin), pin,
 				setting);
@@ -959,11 +964,11 @@ static int at91_pinconf_set(struct pinctrl_dev *pctld=
ev,
 	}					\
 } while (0)
=20
-#define DBG_SHOW_FLAG_MASKED(mask,flag) do {	\
+#define DBG_SHOW_FLAG_MASKED(mask,flag,name) do {	\
 	if ((config & mask) =3D=3D flag) {		\
 		if (num_conf)			\
 			seq_puts(s, "|");	\
-		seq_puts(s, #flag);		\
+		seq_puts(s, #name);		\
 		num_conf++;			\
 	}					\
 } while (0)
@@ -981,9 +986,12 @@ static void at91_pinconf_dbg_show(struct pinctrl_dev *=
pctldev,
 	DBG_SHOW_FLAG(PULL_DOWN);
 	DBG_SHOW_FLAG(DIS_SCHMIT);
 	DBG_SHOW_FLAG(DEGLITCH);
-	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_LOW);
-	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_MED);
-	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_HI);
+	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(LOW),
+			     DRIVE_STRENGTH_LOW);
+	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(MED),
+			     DRIVE_STRENGTH_MED);
+	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(HI),
+			     DRIVE_STRENGTH_HI);
 	DBG_SHOW_FLAG(DEBOUNCE);
 	if (config & DEBOUNCE) {
 		val =3D config >> DEBOUNCE_VAL_SHIFT;
--=20
2.7.4

