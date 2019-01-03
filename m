Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03478C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB290217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="O7KIBp+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfACN37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:29:59 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:42337 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbfACN35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:29:57 -0500
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="22165268"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2019 06:29:56 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 3 Jan 2019 06:30:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjFg29XHhDXqTgFi5EoSX4cAMyvbWDuYFU00hDJO7a0=;
 b=O7KIBp+hsyBbJOPYffPG31G18poj9pW+CXaWmkneh9+BVYemYCdpPDgMtupKBTYruPcX3plKYLjnoFi+vBMuIznbOnSMorF4Mfq1fmnZ4oPYGOzbn0PcAybcc+5jsjxBxVLnG8Pp0PTJNR152iXlwfXONo/bSml5Suga6APdR5k=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 13:29:54 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 13:29:53 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v8 4/6] pwm: add push-pull mode support
Thread-Topic: [PATCH v8 4/6] pwm: add push-pull mode support
Thread-Index: AQHUo2hpuyo0awWDokawYxVpCZY9Zw==
Date:   Thu, 3 Jan 2019 13:29:53 +0000
Message-ID: <1546522081-23659-5-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1984;6:2ERLDmW0/MBnIJYjzPh2UTSE30nP4mAAPWkLXYpPvuF47zIrvvaZa7IVJrvBDLwz4rit1KyS3XmaDcJuuYkpqRBPwiCyQwN/pHODSp3CxLs5d6Lrf0VWFMfa+V75YMXa03RVLo9SUKTgnY1E3OyPGpQjf6Lx0Mc2Im2biHfMaZx8EV3hcp9oIya4unnwD8S4q37/bd3/8r0v1EODKFvKun9nuD7ekH5lrAMIWwIkzcqf49nQVk0IQFFxK/AYKXMOUF/Jyw3Ow7pzmWaMam9GgswSI6XdGSC5brIe1zTlfcBa8DQAYYOlHuwvz+9QTc5Jq0rllWAPA5GEE2z3Kdh7xK5sUIJJivZeL0UWxXyZlvGRX4CfcfTvAdc8kE/4/owxPABjOMpdBBWAaPmAXE2+peY5vs4TIqDLDXqDTDtbBKWSc084DNLtr6DtVxyqlEeIBmIS7G5yCFkzfcPsM+WqLw==;5:7B9hhtGmgfzQI8dRQNqHmJvd/5VjAKAMZNsZyiziCSoKekK02yEvWGUBzwiV9upjaAq1DwfUYk9GtglEdhDnuQLhIHhVplf3qHhmMfiZc+LZSoRzKhn4fD2YZpGBvsR4kdledsGIB9scjQnnuAZxlHEaJnnfmplrnV/+naCUspcSCUXYeBeCe42T0zD0o1MtOpW4IMwogrUBptjHN95ReQ==;7:EzcJbB6HUATjaE7lWQ5CBjsC+1ZxJRySL+wWN4yQVMxPg09UWvgjO/70FzpIFRf4d5tiFWhQRBe9DCjvbwtXYhB0rXKaUNye9rr8GXI7oEHbtbvZdGFIp6Ux8/W6C+X+bLyXVXSSU62CGFxSTiwNUA==
x-ms-office365-filtering-correlation-id: ca365de5-551b-4e40-6f09-08d6717f8b76
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB1984ED22071BB3F912DA662C878D0@MWHPR11MB1984.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB1984;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1984;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(11346002)(71190400001)(6486002)(2501003)(72206003)(14454004)(2616005)(476003)(97736004)(446003)(5660300001)(478600001)(316002)(6636002)(86362001)(99286004)(54906003)(52116002)(110136005)(71200400001)(6436002)(6512007)(186003)(53936002)(305945005)(7736002)(3846002)(39060400002)(6506007)(386003)(6116002)(105586002)(106356001)(107886003)(68736007)(76176011)(36756003)(4326008)(26005)(81156014)(81166006)(102836004)(8936002)(66066001)(2906002)(486006)(8676002)(256004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ik+SD3we1KefbgkGxJeptwRhWxXF8CeCX2SgTjqI6j0moW5SMLvDVeOwDu0Ua1E+ggpgQpwagrDK+A37c8+oRZWpFopvw+EmlowwtC70PAnRJdD1DhMFrPF6vYqanLbT2KZRGwKSL+ZDwuHAcZskF6xEpNMdyE5t6sL5O7ruS0CjGTqOwe0lqaH1YqAL2n5WvAw9iiaR0/L8XgGfgcdJfe1B4sAfScOD5jloWPjxZiVOj090BPwbjwby5OExAScq+og3inr47o9F8NwCzNdaLIAcy3Rh3qI40iEx0OgZpchWwjcmpLUReOPZO0/RYv+P
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ca365de5-551b-4e40-6f09-08d6717f8b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 13:29:53.7997
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
index 3d89343bc405..629754902ab0 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -29,11 +29,14 @@ enum pwm_polarity {
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

