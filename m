Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4C121773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kaNjq98K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfBSKJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:09:04 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48270 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfBSKJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:09:02 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; 
   d="scan'208";a="27948385"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2019 03:09:01 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 03:09:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3E6Wo+AZa4XHzkvn78qab2Q7zcW7Lup6VgZRRQySG4=;
 b=kaNjq98KHpH+G7OyR6ySwTZY6vsJGTnrU8v/Ckw7GFhrSdCCRUfuj/AIIEX05OkvNM35NAqvHZRj/2GkbPOhE+0ov6ljH1d1rck/dumPme89WjdBk3yCdA0LeUkDVQM03bqMW5xlpQo4QApX7wsCBofl7GbsKws9g9K1+5FP9yk=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1831.namprd11.prod.outlook.com (10.175.60.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 10:09:00 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1%8]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 10:09:00 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 3/4] pwm: atmel: add support for SAM9X60's PWM controller
Thread-Topic: [PATCH v2 3/4] pwm: atmel: add support for SAM9X60's PWM
 controller
Thread-Index: AQHUyDsiDT3T0eJSS0SM7JH09g6Vag==
Date:   Tue, 19 Feb 2019 10:09:00 +0000
Message-ID: <1550570914-26391-4-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 6d01777b-3472-4c83-6083-08d696524480
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1831;
x-ms-traffictypediagnostic: CY4PR11MB1831:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1831;23:hX7ow4ndV8HTwxO6wDGSBCnPP0fdzK1DGSytZ3X?=
 =?iso-8859-1?Q?zrDnUMJERqbCJMjgOIwLFft90OLqFsx+2oI0qSc+Fs1d+MhqCTsCRGgHEQ?=
 =?iso-8859-1?Q?q4feCDgOOi+lak7jgc9YU9N5CxAEWNizGIswF5auEkwLKnGlW1QK5BZHip?=
 =?iso-8859-1?Q?YZrhuXMlqTwOparTKBzpBejYKFhCguhQFF76f3ypqjvaCgvvL2QXeAxosL?=
 =?iso-8859-1?Q?467H1eVCtE8umrcLwQBLPzPEjId6WT5Qdy/AXYAQWnHxELN+V4UWOc33Rb?=
 =?iso-8859-1?Q?tq4d27G1cPXeeILQT9Z38bHdBGCZZ1qp0gcId/SUe8XB6UIXDAoOBwifVq?=
 =?iso-8859-1?Q?DwWEDpOkpEYK6GRVIZmZYnksDxWZyHItzqIObGDLaV/srbKogP6zAtpgXs?=
 =?iso-8859-1?Q?vznu9h0qgk4mOfgYzzVP6xXJzmiqOLcbIzDzNa8xHaLjqzQ978aqw4oG+Y?=
 =?iso-8859-1?Q?3uf7SB6Rh5gWcGZCjGH2avtj78xViuOUeXmxtyEthFzij+d7FTBqMuTesP?=
 =?iso-8859-1?Q?wmKp6ysCVXE037eDy0VYkoUG1S32vdNqN5OMzIvHn9sJUIfdhN+KudjHyi?=
 =?iso-8859-1?Q?96xOma1+LxRJQn1SWnXy328gYDRYBO8T+SOoGHlEoVSCsATrdYWe7y729R?=
 =?iso-8859-1?Q?mx+PrymUEKO7AfkXsFzkwJH1R2qhXCzz1abJjAN44tFg0TpqYUXoyu8iJr?=
 =?iso-8859-1?Q?9TMk2DoCljVQbAnbNDiKnDChEdgh3Hp+rPRP9BYEJn49AMVwHwee3nz3zc?=
 =?iso-8859-1?Q?27cP7SeMCz3sbt4YYVlrnuvJCHqmk8agI5fApnrqRn0g2+Qj00a3nt/ri1?=
 =?iso-8859-1?Q?hq2vs3VS0KWngU/+ydHzI1gX20OznxnYin33OTJqqzRRnb68Ijk8PnSdfn?=
 =?iso-8859-1?Q?04Ie4QITb6tc+v59pEiTABKOLDqRCiPfmcmng6hD0b9e0jB6FJIPEmYoEY?=
 =?iso-8859-1?Q?HCMW6UfT/DKOmYMuPG7LlMh0NsnT6YfbiBxopHaqV9buBKE4r7SDQeMANo?=
 =?iso-8859-1?Q?e6xQYfqc7ewX+rIIaqHXYpJi4s95fME5aYqYLoqjl3ZHflA7BOCw5Qwlgw?=
 =?iso-8859-1?Q?aljW+OPubCY1Kvab7F8qeWl8VRzOZCxEVLbIx8d6qb0vj/u5lS2E+DVNrv?=
 =?iso-8859-1?Q?FnoPeEQk/VNrPT/4Tqebm6xzwgHsgokA9IRjj6DuzDVNPY+egWQUIem23v?=
 =?iso-8859-1?Q?/tCRDBY/LvX8Vj6Z5TtoW8odct7wNDSAxsK+wZkiFy3quXlt6SXC1XKs9o?=
 =?iso-8859-1?Q?JXKSU/1qSjvaAWW8ha+tvgqC6zt+07HogQXtGTOVGE7cYalsYDR9g7RmC0?=
 =?iso-8859-1?Q?5G2hBKY6rzmECv9/Q9j94B+?=
x-microsoft-antispam-prvs: <CY4PR11MB18316CF6C34F70F7AD490CF6877C0@CY4PR11MB1831.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(6486002)(53936002)(446003)(11346002)(2616005)(26005)(486006)(97736004)(4326008)(76176011)(14454004)(6436002)(186003)(25786009)(2501003)(6116002)(99286004)(6506007)(476003)(102836004)(386003)(3846002)(6512007)(52116002)(107886003)(5660300002)(71200400001)(71190400001)(305945005)(8676002)(81166006)(81156014)(36756003)(7736002)(66066001)(8936002)(106356001)(478600001)(110136005)(50226002)(54906003)(2906002)(256004)(68736007)(6636002)(105586002)(72206003)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1831;H:CY4PR11MB1909.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: px/dJq7SQoCQga3DxQVgRRKiiMYg55GVjuInsotA7rlrkfKY8bof7c9NuJTTYBV5MJVzWqmkHWMG8gxMEHDcKJ7bbNOmryNJc/uUDbUuP0KqO0oSLKwFM0D2jcNc5YcTsRILJ+EY3NAbLiJfwrJtiemetctZP7aOSKn11mTfS+6SKMJqa7C1LX87ZCPaEMGLhFDFr+AILeKFXrjj/zqk/ac5bPOtzuRiMHs+Ge0++dThu4vqS5LrxvoIUijb0+bulNa82L0TRvk6Em6alxpP4RydxlknpJOz2ly0g9SHnIt17Jj2wn8Ar+5ctZmlPY64UB/8lPCQ8eXFsoJuRVCSm+4H5AMRlFOavl2dFQku1IBMqAuewWxaioYluqjFQp4NZrGkgCSI4ke6isRZObvqZKoPosSDevipfpNrem5lf7U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d01777b-3472-4c83-6083-08d696524480
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 10:08:57.3420
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

Add support for SAM9X60's PWM controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 647d063562db..229cedb02770 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -52,6 +52,8 @@
=20
 /* Only the LSB 16 bits are significant. */
 #define PWM_MAXV1_PRD		0xFFFF
+/* All 32 bits are significant. */
+#define PWM_MAXV2_PRD		0xFFFFFFFF
 #define PRD_MAXV1_PRES		10
=20
 struct atmel_pwm_registers {
@@ -311,6 +313,20 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 =
=3D {
 	},
 };
=20
+static const struct atmel_pwm_data atmel_pwm_data_v3 =3D {
+	.regs =3D {
+		.period		=3D PWMV1_CPRD,
+		.period_upd	=3D PWMV1_CUPD,
+		.duty		=3D PWMV1_CDTY,
+		.duty_upd	=3D PWMV1_CUPD,
+	},
+	.cfg =3D {
+		/* 32 bits to keep period and duty. */
+		.max_period	=3D PWM_MAXV2_PRD,
+		.max_pres	=3D PRD_MAXV1_PRES,
+	},
+};
+
 static const struct platform_device_id atmel_pwm_devtypes[] =3D {
 	{
 		.name =3D "at91sam9rl-pwm",
@@ -335,6 +351,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] =3D=
 {
 		.compatible =3D "atmel,sama5d2-pwm",
 		.data =3D &atmel_pwm_data_v2,
 	}, {
+		.compatible =3D "microchip,sam9x60-pwm",
+		.data =3D &atmel_pwm_data_v3,
+	}, {
 		/* sentinel */
 	},
 };
--=20
2.7.4

