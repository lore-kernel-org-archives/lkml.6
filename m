Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125C0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77CA21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wKTVJB54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfBYQpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:45:33 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:7849 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfBYQpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:45:31 -0500
X-IronPort-AV: E=Sophos;i="5.58,411,1544511600"; 
   d="scan'208";a="24421571"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 25 Feb 2019 09:45:29 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 25 Feb 2019 09:45:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KrnJsV0ppo6FtDTbayqaSeCdImw5bEJxxHRY4JrHE4=;
 b=wKTVJB54m8LnEY7UJh+ka4RcfNWH5dJSIOPmIPQkDcqxrchNkgO1PxfSq+7phchF/ok4zAre8vl6Ym0BQ0xUz3pgT3QY/XNJW1lcM8e/iNwyEXbsza++khRjJJ+4WDWACUWfj+O1URCHzABb+iDnqYCqbKlz5gEkUoAYxkLlkrg=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 16:44:45 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 16:44:45 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 4/5] pwm: atmel: add support for SAM9X60's PWM controller
Thread-Topic: [PATCH v3 4/5] pwm: atmel: add support for SAM9X60's PWM
 controller
Thread-Index: AQHUzSlpFJIlnQtuu0mQS6Xfdtxe0A==
Date:   Mon, 25 Feb 2019 16:44:45 +0000
Message-ID: <1551113039-937-5-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 0083d61f-9ab8-4e54-bf44-08d69b408bf2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1662;
x-ms-traffictypediagnostic: MWHPR11MB1662:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1662;23:gcW6xc+FIUeO13yFhK6HMsj48QsHRFXJy0vBwww?=
 =?iso-8859-1?Q?7oXkcJ14lFW8v7dj/jkeWwAnj1coI04NcIFywzQLbP7RS3Ayf9C4I4lJnO?=
 =?iso-8859-1?Q?ZWmddJAef6GDwXaIsm+2AriUv498o7cKlhK5CY6I6UJYJarmPW1s7zXoEU?=
 =?iso-8859-1?Q?IsNjBbqaYawQUi5VruPjAs9uhmsHS7OOsuWezMXjGKE6VKv+sU7ZU/Jpoa?=
 =?iso-8859-1?Q?anvbi+NLWT54Z3TN4Edeu7zZEwpVzpXGa4Hx+5wtxOnNpU1rW9RLjAb+Xb?=
 =?iso-8859-1?Q?F2HfYW+qEJtUZf1dp194n1kfzC2z9sDtdiXFsBkBQ8ZVTK8gntTqHdhIAx?=
 =?iso-8859-1?Q?Buu45/5F26LB6PktC2Ork+6tkIO2WiJwQlbE1OpA3lWdIFNAuV6sSvC6a5?=
 =?iso-8859-1?Q?LuFZs4WdElVfnRPLhIp/LohDqv2JKJsAlrqxJ4h/8jlmQCQsThhegZc4vT?=
 =?iso-8859-1?Q?Y+TlXqTfonuHfhFSTJu511joksIhuk/EiL4aQXr1/UyW1i8r7F/kMJGLR4?=
 =?iso-8859-1?Q?6uYUDwVhxTaKx0DmgkLWBDFs3YKgMJ7QbO7mwSp+u2kSJrlUMQ1GQWQ3Ar?=
 =?iso-8859-1?Q?PYPeuvjs85S5V6p2oTIezUZM+mHl24LilH+1Tl5p3H38qZQ7JCmL3LuHpw?=
 =?iso-8859-1?Q?06YsgcVW5L/7exg3PwzzNESKJ7ixdyA6/QtDXGEAr374I1zfILSDD+ze48?=
 =?iso-8859-1?Q?He0ZANhPnc6Mf2yHjHacEfr26smK8PU4qn7gc7TKccKPXa7aT+i2J6hN0N?=
 =?iso-8859-1?Q?aP8OYTxuH+Noz3zOZmREBpCQU+N6omdkGon/4Jz9xkRmE2PPS/6/HdXsXY?=
 =?iso-8859-1?Q?QGnU8ZXN8KiOmRVUHEiXiUgHgQb5sCmVuJC6j+11nqM4o7W8Zmnee+n8+N?=
 =?iso-8859-1?Q?AxQh+cru2Ld7ixyNgfqbDxwklYTNEt+0yxbS/6lU45TOD12hTyVkPDSApV?=
 =?iso-8859-1?Q?L7bJjueMAjXroj4cwTCzSv5x18UwPNPMsxHK1YnjSYcL/A0Ab6hKQB+uNU?=
 =?iso-8859-1?Q?uT9WqhRucjX/PMlGEjSREqOxd9D0Q4mU3Ws9dnjUeiEdzhlE3mTLIAtili?=
 =?iso-8859-1?Q?0Wmc+/rHtD+k9IWaVsTbNuVJeTsWxQtxpfaIv2ykOUJ9oU0eGmzf5H3BIU?=
 =?iso-8859-1?Q?tJ3qzkhLkkg9unwy/En3HXOLFL+31EzSBTI8uyxQQi6ny+Imwn0NiG7DTH?=
 =?iso-8859-1?Q?YDSeNEcoM+NEoGWB213PiPNKduEkyT/uam6KrTbivvCtAnMJmZDgK/V9sL?=
 =?iso-8859-1?Q?647OM9bsaMVDukDw/I0pTbGsgdDOhBNqNCSXwR9flIUPRrFHVOSCR17rPq?=
 =?iso-8859-1?Q?YqRPXNzaPjOoBIKsG8RtqzA?=
x-microsoft-antispam-prvs: <MWHPR11MB166213AAEC820A0B6F7270DA877A0@MWHPR11MB1662.namprd11.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(68736007)(2501003)(97736004)(5660300002)(105586002)(106356001)(36756003)(256004)(110136005)(54906003)(316002)(86362001)(99286004)(6636002)(52116002)(76176011)(66066001)(446003)(2616005)(476003)(72206003)(6512007)(6506007)(11346002)(386003)(6116002)(3846002)(50226002)(14454004)(478600001)(8676002)(81166006)(81156014)(486006)(8936002)(53936002)(6486002)(107886003)(305945005)(71190400001)(71200400001)(6436002)(102836004)(186003)(4326008)(25786009)(26005)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1662;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pnqlE4B07RTMD8BFrtqGpvoAylD6Gpe0psRhif2UxVYNKbY9SkjIck2p27vNJdkhajG0uHPX0i+cpp3epuz3tjTPD6mj6LtlbE9qkWFbaIOEa7mEvQSw5HT9446QPJudHIp4uC41nLQIe5BpjIl6g1RYHRT0U2njsYVCznTF7M4ETQ3pd7eJ7AKEmjG/ZoztzKlShsGsZjYCUUg7hjH0ULglMZOd4Snx7ygNmPx3f2QEXRuoDSh1phzO6wvGnpphql3y94bX6++Rb6R1hH9oep9C38xVK+3dVJpjK2H2lPyl/o+vO8Yh1kB222hJNKDOmiAjkbxOhksTOdd5sgrx4navwsNEyIjaqnoLg49O0fXHKIIzZFJLweRo0fmEj1norP92n0u6geycd1PmPV4Uc8QJTCXPtNH8nhSA0NJ+9mA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0083d61f-9ab8-4e54-bf44-08d69b408bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 16:44:42.1516
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

Add support for SAM9X60's PWM controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 4ac899d8008c..b1473ed55110 100644
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
@@ -311,6 +313,20 @@ static const struct atmel_pwm_data atmel_sama5_pwm_dat=
a =3D {
 	},
 };
=20
+static const struct atmel_pwm_data mchp_sam9x60_pwm_data =3D {
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
 		.data =3D &atmel_sama5_pwm_data,
 	}, {
+		.compatible =3D "microchip,sam9x60-pwm",
+		.data =3D &mchp_sam9x60_pwm_data,
+	}, {
 		/* sentinel */
 	},
 };
--=20
2.7.4

