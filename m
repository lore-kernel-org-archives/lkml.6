Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E727C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BB820874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ZsAh0Gbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbeLQOO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:14:28 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:44908 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387442AbeLQOOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:14:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="24311049"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 17 Dec 2018 07:13:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 07:13:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvVjPyoaV+bK8s4DYjcBuwUc1zpXS76CKb2RhaH4FuE=;
 b=ZsAh0GblGMqmnSNf8GithG2oFf5VmSwg1VsFwGHSPb+pjAXAsg6OF2EVLc+7v/O6EtLzsyLFJroPOTCEuREnzVkIZsVxQiwuv8fgcslPpcDeYtRdIeZTFKIgR2AFOan4Z+DOXkqm71Hs2GmHMLoMfDC8c4h2urVh/IeuQca8akI=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0584.namprd11.prod.outlook.com (10.163.159.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:13:56 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:13:56 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh@kernel.org>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v7 6/6] pwm: atmel: add push-pull mode support
Thread-Topic: [PATCH v7 6/6] pwm: atmel: add push-pull mode support
Thread-Index: AQHUlhK/YNrd5tGcekuRqvgsmc9ZwQ==
Date:   Mon, 17 Dec 2018 14:13:56 +0000
Message-ID: <1545055999-23950-7-git-send-email-claudiu.beznea@microchip.com>
References: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::25) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0584;6:AoQ0QGzzp+MlkHg3v2sP7hNYfj1ngPsJEbjXtdap8AcRG1MQEfSe+G6U/OYpzL/UJXIm8jwxoRUfvIIAmTZsxGxq2i9KZEE16i7O4cxJ/mjK3nweig1UEEd8lGFkAs1WA+2WebEeLKw8RikoG6xvXXxC6gzsWLSojC1KNqfjIRTSOhgX5s37NCM9OvEHrEnMtOOkggh2piBwSKcyCbMNvTto9nROo3BGueV1aTwaMa4tf5dLq0yweTxe6QeecCj2zwCvsNj8xOYH9dXHR3G9OcYg3mzAeNjjUxbQND9+O50lb9d596xf4AX1oy9TfeKSXbR/XXWNjmruOcJWS9Y+HY6VMvsLMfnm4i3kYjd30FC9iYDEZVSi8I4pghg1g7AjMdAZSHxg8EYXOPBd/t0aGx+G9nDOu+IFPMgbS1sFxmJ3V8aVd/qxDE7bcAOelvvyfWCxAkAz4XvQbX+h7YAMvA==;5:mpH4D+rJHtyeGjSyXhjLVYqnZllNc6uh2v4h38saophONl7KfXesvx2JArPZCZGZAqoeVKy5AG4QiSX2f1yUBYyyukfDLI6p3F/N0qTKliOTigUHm7w+mjrepkchZHGV63n2XlWSlksOvWcAFi7uwcnW1/dodte/keiv7/NSgBc=;7:7bkb0zWRPMRZYuzGjGd1twYNWM7arXihwqwBpy8cAcR6pmP8J7BzE9Y0Ydqj4qWAyh1tNlmILDxaKp/DvSdfpnnYNIfyPt1LiGcLolKC6VQhZx6jFK6TEMJ93jc6u5Ir7PISSeoSas3OLhm8dEYl0w==
x-ms-office365-filtering-correlation-id: f10fc0e4-9509-47f4-9fdb-08d66429e1c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0584;
x-ms-traffictypediagnostic: BY2PR11MB0584:
x-microsoft-antispam-prvs: <BY2PR11MB05846C361C9F13EA236C741887BC0@BY2PR11MB0584.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0584;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0584;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(8676002)(25786009)(68736007)(6506007)(386003)(6116002)(102836004)(5660300001)(6436002)(66066001)(3846002)(39060400002)(478600001)(107886003)(71190400001)(2501003)(72206003)(256004)(305945005)(71200400001)(6486002)(7736002)(186003)(97736004)(26005)(52116002)(316002)(54906003)(476003)(4326008)(2201001)(99286004)(14444005)(14454004)(11346002)(2616005)(446003)(2906002)(76176011)(6512007)(36756003)(53936002)(110136005)(86362001)(6636002)(8936002)(81156014)(575784001)(486006)(81166006)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0584;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ulsTaBJ+0Tf6UoEBzf6DJxt5Gqwuaeg4ihmAyPgWtYe0ebi7rQGA/WRESkAIUV4fxsJUgxhky7IF/hFgqrCz24UkWGbKMC95fNzRQ9nWEqfmXQbsW0Kw/kKU6Rk19PlnL5sColN/wRZ1Cc2AhuuUP/iY/wIHBEaufYswh5g6DKeGa0qV7iO7GFhhHa0Gk9V9+xracJsirwxWUWjfARXVzM67ZywlduRBmboNEZ2ibydrDGEJ77IFn+9T9SLDdqX3LZseL7//4/5TgJTlehjR+5VNHQfppm89gB4guOU1W6u1yPskDxHVBbiQnmbARnGp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f10fc0e4-9509-47f4-9fdb-08d66429e1c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:13:56.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0584
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

