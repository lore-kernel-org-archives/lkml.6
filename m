Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BD82145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HzGulEAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbeLQODb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:03:31 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:1887 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733058AbeLQODa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:03:30 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="24021593"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 07:03:28 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 07:03:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/jkLcqWaHllnls9ZlExlDdmmrsn65dPM/sYdupYrjU=;
 b=HzGulEAULaAehAtJPxtvDqYOyHbp6jYdBLx2zqVRxn5j/1FdKUTWqOcafSk+WTaPGdxyPGMCOHtFLHbetVMzgfjlRKmH6ioy/EvOHfEiaEbPm4PDV+RHce4t7hXmjtSRJ/JPRmoLZATrUNXMXivESDdfLaFEKTG6E8XhDybTpi8=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0504.namprd11.prod.outlook.com (10.163.158.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:03:26 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:03:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh@kernel.org>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v6 4/6] pwm: add push-pull mode support
Thread-Topic: [PATCH v6 4/6] pwm: add push-pull mode support
Thread-Index: AQHUlhFH71mIPc7Zok2Ua+rawUhruA==
Date:   Mon, 17 Dec 2018 14:03:26 +0000
Message-ID: <1545055368-23338-5-git-send-email-claudiu.beznea@microchip.com>
References: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5f::34) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0504;6:X1izm4E+i6O1t0+SW1I7i+vDcvwQpnROe1pWVKxQI9WowvVME0jFYiVH37Dxmb5pvFyJ19D67RTCvrtjoltKdv3aGguE2TQmkLZWjBiU2TM/VSD2u2lSV4Ttlv3yKekUnxeU0x6nnmb7lIs2CjLylj/Fus3+JWM04oXxUEAnSmPlqARDso2ZyyGhBlpErZMxnXQ93qTy5bGmK6gin29ORb1CzVaNp+jn6jphIATs6skUGyVqgI3d+beyMj9Z1Oxpa/Nw30V9qlXPsUkf8rkbk6p0COSlIK5kY0VTX/t8J4QlgIKKPGMVqsEbK6RkpIzrptX9XAPnUcVGa5Ia03ZCYiFe2IRSwZWJuIxNbpis7riV6NPA1BC53XM6KK7xbLpmKqJtzW4QwDR7r2g0M/PRpiHRod7ii+5LLQgZIW5VAn/mtDrEoIVUto2TRpzKSVyufYZv94NsRQQn20XKVxs55Q==;5:tYdNsbA5EWm0CM4OOsWu46vctfS1sDi/8sONuB9IhK1EIOspB3PjmkYLtpCng9ZSXtFaacpmR/lpshrHQybZP0zyq9t4Bo4h0tp9D0BglpfKQoGEHDaLQsfZpgsDcRrFDmFu1iHB3DRqj8v2aYy+La2CkbT7b4HZ+qqX6c9kucQ=;7:5RuYcOdg+5JfTIot+JhbwNvov2f52EAqEO1haoEnbKY0f7Rusya8Fz+Sr1swzZsjVrGmuwDOU0BeF9rhpNSOqq1PahA+Y5/sENdHuCRoWWlHxmNm7JrtvqDcPuvny/p+KbDDtdGP/mBzYzZM8th4RA==
x-ms-office365-filtering-correlation-id: 156c415d-aed1-4020-45be-08d6642869ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0504;
x-ms-traffictypediagnostic: BY2PR11MB0504:
x-microsoft-antispam-prvs: <BY2PR11MB0504386D72C5BADD0D95C83687BC0@BY2PR11MB0504.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0504;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0504;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(52116002)(476003)(186003)(106356001)(14454004)(5660300001)(2906002)(97736004)(99286004)(25786009)(86362001)(11346002)(2616005)(71200400001)(71190400001)(6436002)(6486002)(3846002)(6116002)(316002)(110136005)(54906003)(66066001)(486006)(26005)(6512007)(8936002)(81166006)(8676002)(446003)(36756003)(105586002)(102836004)(53936002)(72206003)(81156014)(305945005)(6506007)(76176011)(386003)(68736007)(39060400002)(478600001)(107886003)(7736002)(256004)(4326008)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0504;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZDCFF6X1zeXQ3mW1BknhKjX83DERykrBWKLfTM1htRFudbXFkSlkwap41lKscMdDbwnN1wIYhr2rlXohzrFiPBhEXd8Q4EZ/wsRG05IEwPNdVeL8FUoZNmfon9xhYH8aTxgTzBGdzCD4toocwXC16pE5IfNrsCg+E4bXIUHNK+0yGHAZPNp4E7JiA7Od/j9PZ2+78YXb5GpBBZbgQQ/may2iqYIaaMVeOw9o9Hu2sTTvY7zlatUpvpJlehKbe8B/jcuAV3FvOZ3eb+b+LLMVoq+hMksLuKVdzQLwv73a45LI1VLZFyrp65+vpU2urWPE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 156c415d-aed1-4020-45be-08d6642869ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:03:26.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0504
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add push-pull mode support. In push-pull mode the channels' outputs have
same polarities and the edges are complementary delayed for one period.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/core.c  | 3 +++
 include/linux/pwm.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index eb444ee8d486..f182d1eb564e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -328,6 +328,9 @@ const char *pwm_get_mode_name(unsigned long modebit)
 	if (modebit =3D=3D PWM_MODE_BIT(COMPLEMENTARY))
 		return "complementary";
=20
+	if (modebit =3D=3D PWM_MODE_BIT(PUSH_PULL))
+		return "push-pull";
+
 	return "normal";
 }
=20
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index abe189d891af..cce29733d44e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -32,11 +32,14 @@ enum pwm_polarity {
  * PWM modes capabilities
  * @PWM_MODE_NORMAL: PWM has one output
  * @PWM_MODE_COMPLEMENTARY: PWM has 2 outputs with opposite polarities
+ * @PWM_MODE_PUSH_PULL: PWM has 2 outputs with same polarities and the edg=
es
+ * are complementary delayed for one period
  * @PWM_MODE_CNT: PWM modes count
  */
 enum pwm_mode {
 	PWM_MODE_NORMAL,
 	PWM_MODE_COMPLEMENTARY,
+	PWM_MODE_PUSH_PULL,
 	PWM_MODE_CNT,
 };
=20
--=20
2.7.4

