Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F56BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D0920C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bobDLCnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfBYQpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:45:30 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:40694 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfBYQp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:45:27 -0500
X-IronPort-AV: E=Sophos;i="5.58,411,1544511600"; 
   d="scan'208";a="27247354"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 25 Feb 2019 09:45:26 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 25 Feb 2019 09:45:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifQhvYlJwALm5N7iER3df56m1Y7kvJFc11ATFdZyB1c=;
 b=bobDLCnTx3Xt5HLKKfgv/d3KiOa7mqvcMmrVPxAEKf4PLep9kTMWw/MtFFdCm+ONH5oLwei50nvXTQiQ2n6S6en2lbg+uugn29uZRI5loUKh4wx6iBCKBoZWa44TOdYdpHiU1ap3hmATebLuCQR6nmAtp0C/RsuYavSgVmMzvb4=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 16:44:37 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 16:44:37 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 2/5] pwm: atmel: add support for controllers with 32 bit
 counters
Thread-Topic: [PATCH v3 2/5] pwm: atmel: add support for controllers with 32
 bit counters
Thread-Index: AQHUzSllAwNYFtAu+UGkRudfrRv/ow==
Date:   Mon, 25 Feb 2019 16:44:37 +0000
Message-ID: <1551113039-937-3-git-send-email-claudiu.beznea@microchip.com>
References: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::30) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29e75572-b42b-414d-c660-08d69b408752
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1662;
x-ms-traffictypediagnostic: MWHPR11MB1662:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1662;23:UIrqzMNh2DO0hnajxSUfQtG0mMq+LOPF2wpqXIx?=
 =?iso-8859-1?Q?KWplVj75Mw8ZL3Ms+92iZTSfLLqMcaLQZmRRQ8MTAoTLNWOsjk1r5m1j6e?=
 =?iso-8859-1?Q?mzV9yreHiDB+qQb+P/PRtuwnTY1Z5tOqC/MStHusBhB0TCIoVIAS0Zh8aE?=
 =?iso-8859-1?Q?yWC8RfUNp1pWh8TzQlBDETMUBPZF813HQIA+Vx0VrHgn/QW/q37js5Jn76?=
 =?iso-8859-1?Q?L6l4s3rZVHKsz9dceu/rHq37nB/h6wVnhSvXdZWYFjMZvE1Bt5XnmyG4iK?=
 =?iso-8859-1?Q?KwAe1ow0mXJcfm7zzmTXyuANrsZMrojv3+5bAOQnHTP9yRyX8LH1V4JIGI?=
 =?iso-8859-1?Q?Hj4ru7pHPRQohaOGcdckqt1Cifqs8nq+1S4/ELZq6BZv7UAYNyBkPKALzs?=
 =?iso-8859-1?Q?+TcmqSKwbfS4rw3dgtSwAcnEwoGa0ylst5Z8i7QavCRTx/PpYn4CQ+2ytp?=
 =?iso-8859-1?Q?EJXAh0OEes3D2oGHNICEwXoXEuJN4MoasJrsktdzZWa6i8kDMV0PxV5NNh?=
 =?iso-8859-1?Q?0jgt1v3pdmxzjU4NIzcSmNLpHS9feBihihjhcgSTJa60QiiiH1D3HlGV7D?=
 =?iso-8859-1?Q?Fv0Dy9DkH1oL7UppkcpJ1FVlFWV/UcC4eLyUZCwkFWS3iCw2S0n+Kg4EaA?=
 =?iso-8859-1?Q?YB4gfgVhj1BmpKkEHPNPSkncQvApxvZ4htFztcxwylM5WY+FN6f4NjJBbn?=
 =?iso-8859-1?Q?1pTscFkMo4fHBZzckPB8/XIDJbtNquCGD4piHXhhVxepqU+y8YB1Q671xM?=
 =?iso-8859-1?Q?UBp/iW6vzyAU4fd9UnKf6HVy1cgyjEjDkaq7thB9tHiWWKDFO2kZbqCFb9?=
 =?iso-8859-1?Q?GFspN1K4nzHs7L0ib4j8+LYqtay2riO7ve7jdy2qxiOXkZn/fX6eb4IC02?=
 =?iso-8859-1?Q?GcFhkJinIgh8I4aostHHBqwZdlujom/5fH9n5XwdmUPgz+MJ8VjF1Avs6x?=
 =?iso-8859-1?Q?MNA3fS3rhWkeQQeRyZjBlA3zzzDn7Sd+rKn+XoY8uTgoPhRiK2/Akvs276?=
 =?iso-8859-1?Q?c5pLvm8aIACYvTrg6wViYPhj6M8IVPt6K42wcH+civmXsaAnPXV1NkZTaD?=
 =?iso-8859-1?Q?Rk9f7LDqM1RwuGeUMnddK0DnLFZHnOjzLvjSlM/ARVnJisWTMymWGfd/W7?=
 =?iso-8859-1?Q?ls3rCCI509vHVwZ/FwknJui5QshRfnVuupRnYXPMCHLd1ZKRf2TDhI+76X?=
 =?iso-8859-1?Q?gCEceeXx+iYQfMbn/4UL+/BuQqtcDx6JNOLEw7NhCdqpbQaaLSMet1Cygd?=
 =?iso-8859-1?Q?sqIuIPfja/sX+bPmbZ/N+dizZeFYbdesVPHTjvYq9CRVrl04WejRZhMzzq?=
 =?iso-8859-1?Q?8/jb+oTmx5uXxApP1Qv9bTQ?=
x-microsoft-antispam-prvs: <MWHPR11MB1662051F0EFA3A6DDE93B10D877A0@MWHPR11MB1662.namprd11.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(68736007)(2501003)(97736004)(5660300002)(105586002)(106356001)(36756003)(256004)(110136005)(54906003)(316002)(86362001)(99286004)(6636002)(52116002)(76176011)(66066001)(446003)(2616005)(476003)(72206003)(6512007)(6506007)(11346002)(386003)(6116002)(3846002)(50226002)(14454004)(478600001)(8676002)(81166006)(81156014)(486006)(8936002)(53936002)(6486002)(107886003)(305945005)(71190400001)(71200400001)(6436002)(102836004)(186003)(4326008)(25786009)(26005)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1662;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NOb35ewSRRvX8vFBnAzc4w1PQjEj/iOqwaR335Jb2jw77P/CTX2LnNheEJnJr+wUSP/ldXnZblvXf12DgMAXWJNt4HML+CPogEr9cNQWQFTypomRS3Xk7gPB76Kbk7h22JjonDuCokCfxyS3d1fi6eJwvc3GuGpHolsMYsQrD72BVECj7kefGbDYZZ8aekqF+6/qxwpeAHeHTV6uzwnSXtPgNOTVAd24Vws3hZxiCqitJOovhQWzoy1vChT4nQ3Qix/gf98JlesZLuoNuBE4x9TK8pRjFuHtCLaEY5mRy2ccUBzQdbUGgjLZsHmqHV/KXzz1i6KGGBym7Gu65FUcMJk4o3HzOkC+yvP2ryR1+rwjCosv/qqqS532wJz9omDBR9ZUAtzzgCpFU04DMjOPyPwVbXAr9Cwr6/GeaVzl2fU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e75572-b42b-414d-c660-08d69b408752
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 16:44:34.3023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1662
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

SAM9X60's PWM controller use 32 bits counters thus it could generate
signals with higher period and duty cycles than the old ones. Prepare the
current driver to be able to work with old controllers (that uses 16 bits
counters) and with the new SAM9X60's controller, by providing counters
information based on compatible string.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 7e86a5266eb6..647d063562db 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -48,15 +48,11 @@
 #define PWMV2_CPRD		0x0C
 #define PWMV2_CPRDUPD		0x10
=20
-/*
- * Max value for duty and period
- *
- * Although the duty and period register is 32 bit,
- * however only the LSB 16 bits are significant.
- */
-#define PWM_MAX_DTY		0xFFFF
-#define PWM_MAX_PRD		0xFFFF
-#define PRD_MAX_PRES		10
+/* Max values for period and prescaler */
+
+/* Only the LSB 16 bits are significant. */
+#define PWM_MAXV1_PRD		0xFFFF
+#define PRD_MAXV1_PRES		10
=20
 struct atmel_pwm_registers {
 	u8 period;
@@ -65,8 +61,14 @@ struct atmel_pwm_registers {
 	u8 duty_upd;
 };
=20
+struct atmel_pwm_config {
+	u32 max_period;
+	u32 max_pres;
+};
+
 struct atmel_pwm_data {
 	struct atmel_pwm_registers regs;
+	struct atmel_pwm_config cfg;
 };
=20
 struct atmel_pwm_chip {
@@ -125,10 +127,10 @@ static int atmel_pwm_calculate_cprd_and_pres(struct p=
wm_chip *chip,
 	cycles *=3D clk_get_rate(atmel_pwm->clk);
 	do_div(cycles, NSEC_PER_SEC);
=20
-	for (*pres =3D 0; cycles > PWM_MAX_PRD; cycles >>=3D 1)
+	for (*pres =3D 0; cycles > atmel_pwm->data->cfg.max_period; cycles >>=3D =
1)
 		(*pres)++;
=20
-	if (*pres > PRD_MAX_PRES) {
+	if (*pres > atmel_pwm->data->cfg.max_pres) {
 		dev_err(chip->dev, "pres exceeds the maximum value\n");
 		return -EINVAL;
 	}
@@ -288,6 +290,11 @@ static const struct atmel_pwm_data atmel_pwm_data_v1 =
=3D {
 		.duty		=3D PWMV1_CDTY,
 		.duty_upd	=3D PWMV1_CUPD,
 	},
+	.cfg =3D {
+		/* 16 bits to keep period and duty. */
+		.max_period	=3D PWM_MAXV1_PRD,
+		.max_pres	=3D PRD_MAXV1_PRES,
+	},
 };
=20
 static const struct atmel_pwm_data atmel_pwm_data_v2 =3D {
@@ -297,6 +304,11 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 =
=3D {
 		.duty		=3D PWMV2_CDTY,
 		.duty_upd	=3D PWMV2_CDTYUPD,
 	},
+	.cfg =3D {
+		/* 16 bits to keep period and duty. */
+		.max_period	=3D PWM_MAXV1_PRD,
+		.max_pres	=3D PRD_MAXV1_PRES,
+	},
 };
=20
 static const struct platform_device_id atmel_pwm_devtypes[] =3D {
--=20
2.7.4

