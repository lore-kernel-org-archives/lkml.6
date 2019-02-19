Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF8AC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A27217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wBGy3h/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfBSKJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:09:01 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:23915 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfBSKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:09:00 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; 
   d="scan'208";a="26786204"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2019 03:08:59 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 03:08:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHWf+nFCzAuVg05N3yE+Q4lFdjrNbEEt4LD7T+XiPZ8=;
 b=wBGy3h/zpekvT0fka0ECiEQeHwSb8Ib/0WR4y6OYX0dmCi213bwO4iH88OXJ/rgHcRIlGT9P2tuut+F8GgRpoqJu5ABHytd8IFqV/b7eArEWvwxiGTxujhYey+6WRKXlAPpFjFUa1kB0mxWz97feUlkhYmGCzQy7pzfIiNQ0PNI=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1831.namprd11.prod.outlook.com (10.175.60.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 10:08:57 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1%8]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 10:08:57 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 2/4] pwm: atmel: add support for controllers with 32 bit
 counters
Thread-Topic: [PATCH v2 2/4] pwm: atmel: add support for controllers with 32
 bit counters
Thread-Index: AQHUyDsg4pV/PQZmmkCr3+x+PakMUQ==
Date:   Tue, 19 Feb 2019 10:08:57 +0000
Message-ID: <1550570914-26391-3-git-send-email-claudiu.beznea@microchip.com>
References: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0090.eurprd09.prod.outlook.com
 (2603:10a6:802:29::34) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04f00035-2f1d-4df9-d921-08d696524297
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1831;
x-ms-traffictypediagnostic: CY4PR11MB1831:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1831;23:6wnJne4xtlNafMRDryygQuIR8AFx0bH4VAWwV+a?=
 =?iso-8859-1?Q?hi0LZgOEuRjL44Ks/S4bRpj3KCrCZaFRhmaVSTH4FwJ+LVdzC3+T1KSnJq?=
 =?iso-8859-1?Q?nGnbkwk1XVN5PdggZLV9MWjdg0Y9MdUa69xTM5XJ1Up5HMjfoea4acBz7j?=
 =?iso-8859-1?Q?gWr3I2LqkMJgGimAWIx61AOsDdAAqLbo8ZWUrSlWNe6MSojRCucFGwH19F?=
 =?iso-8859-1?Q?ZLrKIImCFOd98SAO18P5e6ERdMKanq1ZSQhY4+Ka1R0cdiBEEcXgtMX52B?=
 =?iso-8859-1?Q?0idr0ZbHzuVA0icKX0k7mxwm7o6d2A7dThf1Pi8kLNnjg/SL1CKq+9CrXY?=
 =?iso-8859-1?Q?AYYNOUV9Gp2gAEFhahfEJpcAcdpXRTx50IsFC1vpICIuJBfer+SNEcBxUp?=
 =?iso-8859-1?Q?osMnBPWjmYlImP6AFAW2CV0sPVqUlrseBxNf5mRVzRJmWWanOi041Far2P?=
 =?iso-8859-1?Q?Huz5hsY10hj6UD93m5HHvObAug5R70/C4uuqssQGpiai5NzH8UqfMebvQh?=
 =?iso-8859-1?Q?Y/8V5QW5sqw/XiA7s+jBlwBPw5HU8s0YzE86gfrPLD9AEq73HmypZj1G47?=
 =?iso-8859-1?Q?5lhXoS/QeYvrY6gJtqkTyZkfnmiMciwhoavtKRkRSPCLLAqzksdOC2Togu?=
 =?iso-8859-1?Q?eqgriiAMV9+QBz6ANrxKZCKbhxDo2c70F3qykAb2jmcHcFX72HeBoxMC6L?=
 =?iso-8859-1?Q?JW7YdeyFz89hw5/T6qqZ+8MmW+sv++DiYApRj++whugVUHnWd9pvpZ58km?=
 =?iso-8859-1?Q?xRfI1bPOz2oIiMdTdvs8hsFriD7OuOJOyXFmcmrZyL/0cNOZa0R2gpTuaq?=
 =?iso-8859-1?Q?og09zcIMOcv2RnmxsoKLg0rCI4yX4SkEEjmGY5c69LtnvlyIC6AtYuvYjA?=
 =?iso-8859-1?Q?KUPvjB2xbLswboOg/VhlhVQ17RQmcYpY1Wfc6BSRrN//62SJZlPq2rTCWd?=
 =?iso-8859-1?Q?XXLp4Hn4TKFaXXHziRQN0QNucniYGUwaiix5fuqBqqvXHBDp+lf4vfYnXO?=
 =?iso-8859-1?Q?2MZYxVjVu7Dq4bJVveLb85aihr6B01etori8pAkyfvznmM6dLJiBYFEgq3?=
 =?iso-8859-1?Q?+Mq+7lb9x2r/nuaz3b64rDR1iPjJPRKggcy5IyjumdcXiHI1wEXaknd74j?=
 =?iso-8859-1?Q?a0EvZqU5zh6nyI0iY7hwAKbQlx5+lMEQ0kbSMjfozY1Qq828/RCJwNnMUZ?=
 =?iso-8859-1?Q?thPHiyii8YV/wtsXP5j09dWA+VXIO/+UaAVC2vUszqdMUkpXEEVgao/7mp?=
 =?iso-8859-1?Q?qpvPtXhscHVb5eKrVNFO6pfpyJCvX6T5E8Uzqlq8Xt88Ajg0bNcja3aGTT?=
 =?iso-8859-1?Q?gQwI2bQHTjfFnl1QmXd6ket?=
x-microsoft-antispam-prvs: <CY4PR11MB1831867F42A602DD52B42B77877C0@CY4PR11MB1831.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(6486002)(53936002)(446003)(11346002)(2616005)(26005)(486006)(97736004)(4326008)(76176011)(14454004)(6436002)(186003)(25786009)(2501003)(6116002)(99286004)(6506007)(476003)(102836004)(386003)(3846002)(6512007)(52116002)(107886003)(5660300002)(71200400001)(71190400001)(305945005)(8676002)(81166006)(81156014)(36756003)(7736002)(66066001)(8936002)(106356001)(478600001)(110136005)(50226002)(54906003)(2906002)(256004)(68736007)(6636002)(105586002)(72206003)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1831;H:CY4PR11MB1909.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aH3+9ltN9D5wo/jFWq4tvOyVpU9KA1q09WwEt2Q7hn03rxsZGzEEWFikHRPZCmoYMTgnnHmb23Ep08WMtPDrI1x35X8u+Ungrh8NLptVlTck/MNyylDrdWQMZVr23G2gqAl6qTW8mLcNtNSp2CSqFKFanuSGUXPaHEhY1Eci9a34iaXQoCrqfvAqhgrgdIMxG3TIk9DfQXrjXxCK9m8GYtimTEEARePPwuATq4WJL25n7/xCn4C9hjrXZKd6Seh0wSVvXGfRkFbH5+11LYoPFSfAdCHJNZLZ6mS/gPUHBoShvXNlWSJ7kATmkF8AuLLgrHF9J7eIwKQZrXf7UI1y6zYL8GfUjnELmpq3l+pJKL5OeNG9UKvCCTTsX/REQj/JzKRlKlFU/uKnCAj3lKJ8UgyR3cUfaUz3DcwkvKWuhdg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f00035-2f1d-4df9-d921-08d696524297
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 10:08:54.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1831
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

New SAM9X60's PWM controller use 32 bits counters thus it could generate
signals with higher period and duty cycles than the old ones. Prepare the
current driver to be able to work with old controllers (that uses 16 bits
counters) and with the new SAM9X60's controller, by providing counters
information based on compatible.

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

