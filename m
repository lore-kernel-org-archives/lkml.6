Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDBDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48052073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="XCitMKeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfACNaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:30:06 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:64911 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfACNaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:30:04 -0500
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="24598646"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 03 Jan 2019 06:30:03 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 3 Jan 2019 06:30:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvVjPyoaV+bK8s4DYjcBuwUc1zpXS76CKb2RhaH4FuE=;
 b=XCitMKeVSsNk+UUyPmj4fKBAFvKD5NSDD5OptEIVBqCBi/fl4WYkvMQeeSaKihyx+loxf6A62492cfbQUglwgZYxyBrBosNLv4PsOYSptPy6+P5VMi6j9/hF+lsaQjieOFuZUZMupA5sjr1QCcUJLfWuMQ9WW0XXGUmrlVRW6/c=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 13:30:00 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 13:30:00 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v8 6/6] pwm: atmel: add push-pull mode support
Thread-Topic: [PATCH v8 6/6] pwm: atmel: add push-pull mode support
Thread-Index: AQHUo2hs3Asi3dS+VE+SDxWViVheTw==
Date:   Thu, 3 Jan 2019 13:30:00 +0000
Message-ID: <1546522081-23659-7-git-send-email-claudiu.beznea@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0209.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::33) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1984;6:7J/Lek8oSIWdAhYE1g7xObPwB2XNbSAS3n/7e04g4VNvVkFGsyP/bPCpoNFyqdAL+M8umrqSYkUGY2K+2qZtWGP9iiFW1TNmNeoqpH43O2aUM/fDNRGguaueRUl0PEJKA2uAJm2x/uWagzsxaPQJbWW2MAKcmcSpfoMUay2aEjuPBh4d8HpI8Iy5Gtq5WwEa7MANw7Dzl7WOxGQ8zYHUyrdcBJNGLal/Pjje3eRa8HaHhmoPJmPfvo3VTQu0zqF8dgs+xEAs1nEVestGK6279NUgGXrLlpZNxCVu1s7LIoKqR0NbiJr/sBZQCRuqnUhGOoK0ADcCd79IjpVF9924r/vSYLWcEUFn3DSgA8+dwfMOCcxC1gT37F+e3l4F4TkHGdCGc1HK22/rF4gncot7YrZoXJqOuixyYNjM8aYNLH7DXd9BqKgu6fy80YbxKYeEfPukExwAA7kuCpR4L0f5kQ==;5:B1ronpSTt6aWGuqhaO+xBqh4gU1H5ocCpYg/CBz7zLCwY5KBQcH4eDPkqlGRPubJdC0DyC5mOtia5TZmDOoQKaxZWBnTwky1oecHBiHNLNK3GCSYcwnZVggyofQLw/0lgnNSR0QUW8yAfN1Tc//MJzEHRQi6SFs9sEDeSXW24cBI9FTbPodlKewQVyZmh/MjB3PtZA+PD0sjpbUwjhnWbA==;7:YH19KO77H0n7LoAh6UePmD5U+9n7E2BLDnCjj4BSLPoj55xXTNG6bC25iXK5ZIGK2k6k/1aaOVZRlLotaev/4OFzar3GXgK9E81ydQ5JT/97++FutroOfCO8wspD7dl9L3LZnY+pyIs7O7VjTmJekQ==
x-ms-office365-filtering-correlation-id: ee8cd5a7-c3e5-4010-016a-08d6717f8f54
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB19847D671CEFAF53F5B27918878D0@MWHPR11MB1984.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB1984;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1984;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(11346002)(71190400001)(6486002)(2501003)(72206003)(14454004)(2616005)(476003)(97736004)(446003)(5660300001)(478600001)(316002)(6636002)(575784001)(86362001)(99286004)(54906003)(52116002)(110136005)(71200400001)(6436002)(6512007)(186003)(53936002)(305945005)(7736002)(3846002)(39060400002)(6506007)(386003)(6116002)(105586002)(106356001)(107886003)(68736007)(76176011)(36756003)(4326008)(26005)(81156014)(81166006)(102836004)(8936002)(66066001)(2906002)(486006)(8676002)(256004)(25786009)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ok4vjGA1P23XdHYEKQGxSblKMPqr3tSX/+Z36oVbpV+VYBxtE0VKhIrdSMlA23qBaebS8K7xqX0whbsccV4Ao7DCOx0TNXNedW8eBzczg6brsKTcNRO3DhXBGImqt5hUsXj26HZfnO43mZ9mZmzZLVny/yWrXkMJFK8R/R5G9SQ9m7GFddjSwBIDSqDoQ62n9yLNlRMO2rxwL8Hp28FTIudQezIalY79R1yY99C8kV4pzLaxYcUbn8JRvrYm11BUO9JewmhIvnXL9w8dFPLqq6ezpygaAE74E9uFsjXFmmaBbZzIThD9RyCciD/7E8Vh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8cd5a7-c3e5-4010-016a-08d6717f8f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 13:30:00.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support for PWM push-pull mode. This is only supported by SAMA5D2 SoCs.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index b72cacd5dca3..650d475a4c34 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -33,8 +33,11 @@
=20
 #define PWM_CMR			0x0
 /* Bit field in CMR */
-#define PWM_CMR_CPOL		(1 << 9)
-#define PWM_CMR_UPD_CDTY	(1 << 10)
+#define PWM_CMR_CPOL		BIT(9)
+#define PWM_CMR_UPD_CDTY	BIT(10)
+#define PWM_CMR_DTHI		BIT(17)
+#define PWM_CMR_DTLI		BIT(18)
+#define PWM_CMR_PPM		BIT(19)
 #define PWM_CMR_CPRE_MSK	0xF
=20
 /* The following registers for PWM v1 */
@@ -219,16 +222,19 @@ static int atmel_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 {
 	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
 	struct pwm_state cstate;
+	struct pwm_caps caps;
 	unsigned long cprd, cdty;
 	u32 pres, val;
 	int ret;
=20
 	pwm_get_state(pwm, &cstate);
+	pwm_get_caps(pwm, &caps);
=20
 	if (state->enabled) {
 		if (cstate.enabled &&
 		    cstate.polarity =3D=3D state->polarity &&
-		    cstate.period =3D=3D state->period) {
+		    cstate.period =3D=3D state->period &&
+		    cstate.modebit =3D=3D state->modebit) {
 			cprd =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
 						  atmel_pwm->data->regs.period);
 			atmel_pwm_calculate_cdty(state, cprd, &cdty);
@@ -263,6 +269,18 @@ static int atmel_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 			val &=3D ~PWM_CMR_CPOL;
 		else
 			val |=3D PWM_CMR_CPOL;
+
+		/* PWM mode. */
+		if (caps.modes_msk & PWM_MODE_BIT(PUSH_PULL)) {
+			if (state->modebit =3D=3D PWM_MODE_BIT(PUSH_PULL)) {
+				val |=3D PWM_CMR_PPM | PWM_CMR_DTLI;
+				val &=3D ~PWM_CMR_DTHI;
+			} else {
+				val &=3D ~(PWM_CMR_PPM | PWM_CMR_DTLI |
+					 PWM_CMR_DTHI);
+			}
+		}
+
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 		atmel_pwm_set_cprd_cdty(chip, pwm, cprd, cdty);
 		mutex_lock(&atmel_pwm->isr_lock);
@@ -319,6 +337,20 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 =
=3D {
 	},
 };
=20
+static const struct atmel_pwm_data atmel_pwm_data_v3 =3D {
+	.regs =3D {
+		.period		=3D PWMV2_CPRD,
+		.period_upd	=3D PWMV2_CPRDUPD,
+		.duty		=3D PWMV2_CDTY,
+		.duty_upd	=3D PWMV2_CDTYUPD,
+	},
+	.caps =3D {
+		.modes_msk =3D PWM_MODE_BIT(NORMAL) |
+			     PWM_MODE_BIT(COMPLEMENTARY) |
+			     PWM_MODE_BIT(PUSH_PULL),
+	},
+};
+
 static const struct platform_device_id atmel_pwm_devtypes[] =3D {
 	{
 		.name =3D "at91sam9rl-pwm",
@@ -341,7 +373,7 @@ static const struct of_device_id atmel_pwm_dt_ids[] =3D=
 {
 		.data =3D &atmel_pwm_data_v2,
 	}, {
 		.compatible =3D "atmel,sama5d2-pwm",
-		.data =3D &atmel_pwm_data_v2,
+		.data =3D &atmel_pwm_data_v3,
 	}, {
 		/* sentinel */
 	},
--=20
2.7.4

