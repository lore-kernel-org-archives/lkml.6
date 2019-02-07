Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0712FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC6F218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="I+UTaybX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfBGJYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:24:53 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58021 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:24:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="27380982"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Feb 2019 02:24:48 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 7 Feb 2019 02:24:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPM2/klJS8Vg3nalu98oarq5O+RDifPvXyxpTxq//rM=;
 b=I+UTaybXaWu/e7WOV+OI6W+wjNB/SgqRkzbGUJqegx89b3g9s1P5xIi0LiCDtePs3G/xKaLbkJh7/L1VDHGXl/LG8Bm+aULINONbnX/OAcXdjU4PSSK/h17bUGwY/i94LdVgXcHywyH2JTRMHA91HI3NZgmS3tJN1SW0q0JCRVA=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1757.namprd11.prod.outlook.com (10.175.53.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:24:46 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:24:46 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 1/7] pinctrl: at91: add option to use drive strength bits
Thread-Topic: [PATCH v3 1/7] pinctrl: at91: add option to use drive strength
 bits
Thread-Index: AQHUvsb3YAMp/vYlCE6UmYv4iZ19sQ==
Date:   Thu, 7 Feb 2019 09:24:46 +0000
Message-ID: <1549531468-1676-2-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1757;6:Qhe5WIEzqFGTdOj56N4b2rBOjsOEKSv2UqjLMgrIJDYfnJ5cCIK3AsYdlY2QRa2lJmm8p5iz0feL4XsiiJdiS5aEZBIZEm6LDfz0yaGhm8Ib2vfCAyNikUUBzI/Q4aPRv6R9F+3eGYY0PywPLL2NoZuJTJPAOyeJjHBjTLBW6021Tw1JuXv3IVAgsi1H/Nu/lMy1pUA164cvRYF5ni6muqMmhExxzmltXOOlSJgZtMa5US8NfQR4Gy6mKaOtrOcwS7B3lyRweiXyvZI6oguGRYOlrAHFE1ZmKYzdPLW5j4AFZwcdqS8ixC/hCO6bKTeQWgaGi8rH+HGxVYSohjX8+FLdd74zfElFjtV1FDtKoaDkhz7EzBq2ve8r29hoDOzWmbDm/uNoU0dLPRYMrFgsxVgeQIK8GBz5LhK2siczGg8mGtYDml+dM+L/q9GKlN9jHs4/NC5oRWcUGhW5Sn/4Kw==;5:Cx/7oH6mMgGJi5AT26EplsyyIK18+5Cu0WX6eEjNsg6iTc8wkSsy4bbsHjlD5opZxUrQJ04sOFL8RQV06G/ZB0vT+ghQ91LN4ESNnM5YrKjtaLUwgbceP9R93DxZ5MLiNypM8JNRM+EsbOPn/3RryuFb+ltx9QRBwFpuKSl0PIn699+YI4ltoqq8QeW6bnfmumhvQAXQjZ3OSys5TfgNUQ==;7:SviO4Rhk7w9zeNK5ImNnVlPE84Bnn9E6XLHmex83DoJsIKTgEHsmA1pqOq3dKPeGy043/53Z6Q4TwtR0HoKYjfGnuZV0rYRAZAI2HUFAC5bm7BOYngw8zVAaS42uugHERi3K3upYL6lzLd53G/W1GA==
x-ms-office365-filtering-correlation-id: 3d06a1fa-4617-4aba-5990-08d68cde197b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1757;
x-ms-traffictypediagnostic: MWHPR11MB1757:
x-microsoft-antispam-prvs: <MWHPR11MB1757E0BD0FCB60823868939287680@MWHPR11MB1757.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(53936002)(66066001)(72206003)(6486002)(256004)(71190400001)(71200400001)(99286004)(26005)(102836004)(386003)(6506007)(4326008)(25786009)(478600001)(2906002)(76176011)(186003)(52116002)(68736007)(316002)(14454004)(50226002)(97736004)(8676002)(8936002)(86362001)(6436002)(81166006)(81156014)(2501003)(2616005)(6512007)(107886003)(446003)(11346002)(476003)(6116002)(486006)(305945005)(3846002)(6636002)(106356001)(54906003)(105586002)(110136005)(36756003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1757;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yl4IMXF+jt0yoc0YqDCIm288rHEGUuFWvg5128ZRCCk9HuDw80xOIEgGys1pgR7fjYWVO6tCakqhFXpgnrRtd97oAOpCrTEbiF3fakBQ23dA+kBK/GxP34vwt1cEp7srlBW7csmA8ValgLMaXLIqcsyAq84NzinWzeEh7J5gM2ouncHgL0qFCQfAbERuNM3n7ULmMKer3UMvj5Hy2QDfEHuaJtDAyDKRw+hV0ChIqLFwOWbqd9DJJbe5uWO5wL5nY/Fo7AqnVxNmJSRwe6iZF7RLHqd8o8gqAaYBukzEBQm3lpf4/57eL1RRPbCCjtz6ExqmGAvpGIBgkWxv3Fdby2eVf5JEcqznI7s5lYrNsDwEJkDlmPijX4Y1+Wf4jFV59b0I/XY77IcbFISwX9rjY2BeKuJAM5kl0fgK6IIrmrs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d06a1fa-4617-4aba-5990-08d68cde197b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:24:43.0104
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

SAM9X60 uses high and low drive strengths. To implement this, in
at91_pinctrl_mux_ops::set_drivestrength and
at91_pinctrl_mux_ops::get_drivestrength we need bit numbers of
drive strengths (1 for low, 2 for high), thus change the code to
allow the usage of drive strength bit numbers.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
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
+#define DBG_SHOW_FLAG_MASKED(mask, flag, name) do { \
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

