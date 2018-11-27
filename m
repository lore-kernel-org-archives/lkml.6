Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC42C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF749208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rkefmXJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF749208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbeK0WzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:55:00 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:50219 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbeK0Wy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:54:59 -0500
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="24557532"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Nov 2018 04:57:19 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 27 Nov 2018 04:57:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyUsVR2vP3b30ui9wooEsbttVTjegX/NS06gcPyMgnE=;
 b=rkefmXJXNwjeMl904PDOYydFfWBnaP7s2dKgJ8ChRVS4uPpqPyo3J6GmBmmImswUxr+3g78URXbncDxgC+yGqRPbek7MEPpA2FlfiAv7FYTI+rA+sbkjE8+DBkyhUTiqYqmKx8R+SFG5R5548UB8l4H6EQzfPIq1JcUy7V0dGNA=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0582.namprd11.prod.outlook.com (10.163.159.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Tue, 27 Nov 2018 11:57:17 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 11:57:17 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 3/5] regulator: act8945a-regulator: add shutdown function
Thread-Topic: [PATCH v2 3/5] regulator: act8945a-regulator: add shutdown
 function
Thread-Index: AQHUhkhXsQSGQ5TI00ytRQiLaZ1dDA==
Date:   Tue, 27 Nov 2018 11:57:17 +0000
Message-ID: <1543319801-19100-4-git-send-email-claudiu.beznea@microchip.com>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::17) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0582;6:AXXTXtE6yNdGKAIn9crEh3DaT6snrdA7TXL40qG7EA7udV6NUvOaz8Rd+w2RhNrrFTpin5ETR7TLU4GdKmJ2MNwLtMrNW/otbBjOtq3GaxVeDsH3Tpz1TFHkw7EJm+xQKTzxMSpp3w59zrtdET2dMfy+3MsTe4zHms6+h6C1yI5Gb8q1zEDSaStGPC0rcw/0sP9NYzFFqWF6LnqKwtpqQsmZDRgtSgXNPzRUEjd13SVmsH8MPAoxY3SnIWVRFbXzQLZ4UY3wptQLzh/JXKmpt585G6OnQp/08XFp0sHVDyC8Pyw3Wbe93qsaXpI5QLdKKJ8tXsorRk3FggbgFfJQ6Eg9sgA+9T9pnm8W2hF5MDUVdZr2tzqLI5s98lRih4qbbr/cl+VxdW7xKC10xktm/CLGfecfPh2IyjsOcvMy+rivM0ByRA7vOE0APLisTqGrT60g5L7XauG0SrSKIyhwwZy7zdzhH0DcWVnlRO/9PJI=;5:qIk8jSAQdbe6gAcitfeFCOt92FHSgohPsj6h0bPxDM8WM0qzocdRvwRON0DbdQSglDfatbjySJr923jCc9ZB+cWAH2l2+Dt/bVn5dg7IPCK0xkUzP5AL6H+bts1ceI4rPCAcoVQn0pTNAm7fWooxKlADRZh9nzhRUeA9qNk9JNk=;7:wrQrKUVFD5Rx/9HfnQWfM6uf+k8o3Cfz8A1EhriGF07+jPaNxES1Fmx6IrAk5hHvRAk8PrAb9hoZ4UborlmO/701e8vfVOHCmEMiuoibQ8/o+EyUMXbhRx/Sk5mZjnl4zDULLB1YWHr3PgNAuIHhVw==
x-ms-office365-filtering-correlation-id: 2e75e12b-2c96-4f39-1ec4-08d6545f7a01
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0582;
x-ms-traffictypediagnostic: BY2PR11MB0582:
x-microsoft-antispam-prvs: <BY2PR11MB05825EA73B887A1C1A6DBCF087D00@BY2PR11MB0582.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0582;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0582;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(4326008)(66066001)(106356001)(86362001)(5660300001)(97736004)(186003)(39060400002)(99286004)(6486002)(52116002)(26005)(105586002)(478600001)(36756003)(256004)(14444005)(2501003)(110136005)(54906003)(386003)(6506007)(107886003)(72206003)(7736002)(102836004)(305945005)(6116002)(3846002)(76176011)(71200400001)(68736007)(14454004)(71190400001)(6636002)(2906002)(476003)(2616005)(6436002)(25786009)(446003)(6306002)(53936002)(316002)(8936002)(8676002)(966005)(11346002)(486006)(81156014)(6512007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0582;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DonTZ3rzfRoUk7Sz2tt/KGuUzVx5B6xapUNIT+5t8/QzpDqmMuIOhF27HB+pdlRk957Gmudk+TSGhdzYgGIHzNFye3Uspzn+APDIU/QwW29L1p+mnumMKf9x8L2m4FpeKM2saJ3EmMAmRAwCAhk16Vyof0Hz97bDv0m/SnrHI1R404AQYLrfZclR19ptomre8HRvWpW9XRgRsKWDlj/JI8UT/Shk/gIVz7MUR6P0rxnXceUmppzKwhBOLbLRdAUHr2YC7N61y9/gFEe2xoouLOdNc0ugYXFLu00RcyiiiIZ20gBOKhrg2XB47HfCoA49gJOynmKIljWSA4pClmflUOABRiRKuaExt0kK2apMACU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e75e12b-2c96-4f39-1ec4-08d6545f7a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 11:57:17.0419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0582
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Implement shutdown method to make sure the PMIC will not enter the suspend
state when the system is shutdown.

This work is based on work done by Borris Brezillon on [1].

[1] https://www.spinics.net/lists/kernel/msg2942960.html

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/act8945a-regulator.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act=
8945a-regulator.c
index f4d60743efb3..90572b6370c6 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -339,12 +339,23 @@ static int act8945a_suspend(struct device *pdev)
=20
 SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
=20
+static void act8945a_pmic_shutdown(struct platform_device *pdev)
+{
+	struct act8945a_pmic *act8945a =3D platform_get_drvdata(pdev);
+
+	/*
+	 * Ask the PMIC to shutdown everything on the next PWRHLD transition.
+	 */
+	regmap_write(act8945a->regmap, ACT8945A_SYS_CTRL, 0x0);
+}
+
 static struct platform_driver act8945a_pmic_driver =3D {
 	.driver =3D {
 		.name =3D "act8945a-regulator",
 		.pm =3D &act8945a_pm,
 	},
 	.probe =3D act8945a_pmic_probe,
+	.shutdown =3D act8945a_pmic_shutdown,
 };
 module_platform_driver(act8945a_pmic_driver);
=20
--=20
2.7.4

