Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0E8C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D7020645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="L01LcDZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D7020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeLMMuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:50:09 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:52292 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbeLMMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:50:06 -0500
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; 
   d="scan'208";a="25196447"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Dec 2018 05:50:04 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 13 Dec 2018 05:50:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyUsVR2vP3b30ui9wooEsbttVTjegX/NS06gcPyMgnE=;
 b=L01LcDZH5ibDuEtpBeX83+l3sSPtJe2CU7czRVjAUfly+xReWHIOUSsm9zGN2IY0+F2qwLlJkgwxTGcl9Y1+v0Di2TWwcLSvCdHAnzxbhQbCBXN8X1ek3IyO/59fWupa5F5gQteH20s4wQO8zQoIB1HbyrBFoAdklthkSU1l06c=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0519.namprd11.prod.outlook.com (10.163.158.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 12:50:02 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:50:02 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v4 5/6] regulator: act8945a-regulator: add shutdown function
Thread-Topic: [PATCH v4 5/6] regulator: act8945a-regulator: add shutdown
 function
Thread-Index: AQHUkuJd6h9VvlI3ZU+F3S1PikWtDQ==
Date:   Thu, 13 Dec 2018 12:50:02 +0000
Message-ID: <1544703110-27161-6-git-send-email-claudiu.beznea@microchip.com>
References: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0519;6:+Z0FqA7OBajmzrbxgdd5CRzY46yLWnMfmYnOar69puJV4uZd7FxBx/+L8zSdnqRd6hinUR4sncRubcgbjkHgJl3LqW4N+6sjLS+suDIzYMvgS15XCZ7H0tXxRcwY3jUXm+sq7O1nNOh56GENnXHZmvbzAuyQsojtqw6G0Q1LM/uByhmu7GpBmW1tu0t5wosJIr+2BLMC/kfORyv7s/Rcn04L0WJD9QmFkeg3ckVHfIj+xTgJDMLSst/ksYDLl1G+whLDSRTSbe3Y3huoUjrkjUMQbPT4Oblg6FVD0NzAJYv/3UCGYLnZjLSgNh/z4EHAy6H3Nq9Ug0DT5ZRTZJX+ksXuIz3b2hkVnAqGojO6fJDgW2R0pjiW66M3j+WNmdMt5ODWr8hrSbZO4R9kdPGu1vuIrFkl8c0nvvO6z2PoUFJ4dUEmTCWcCwZm155UkSffU4QAk9ogDqbNLBAhuGmlEwXOEu997fMBwjOfn1+PTLA=;5:/xzYGA+7vBXae1TnNQzv+qgAA8Dp+ajkoB5uypMlvjLkN1kFXB/+hrK9zacXcnBj4jugrmQ7geQSA9MGgPWa9VBBNFIMJ6L/FPLj/x+0C9tNPLHf7Ge0DQ8ZBNKVkVb/4cveZ511ffujRbEOpVh85ocFcn3VDDwjuTPR3MgkXtE=;7:93fpS2dhWNRitu89nVwWMAlOeigvlmIThEn29goGbkgFV9qxzcNqH1VqUg9IRb0ir/uRyxeTVsenEYmUka1Dy+g9fGKVKLAm//k4rxI1ekM/Ung6zLeFnCdrEMxZXa2JCJwdkI7nZjZqgfDmEVQwSw==
x-ms-office365-filtering-correlation-id: 251d7663-e9bc-427e-52e2-08d660f97f66
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0519;
x-ms-traffictypediagnostic: BY2PR11MB0519:
x-microsoft-antispam-prvs: <BY2PR11MB05193713E2BBDE66E3276F1C87A00@BY2PR11MB0519.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0519;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0519;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(316002)(5660300001)(305945005)(8936002)(97736004)(2501003)(102836004)(26005)(6436002)(36756003)(99286004)(476003)(68736007)(3846002)(386003)(6506007)(7736002)(14444005)(76176011)(52116002)(6486002)(6306002)(106356001)(6116002)(186003)(4326008)(105586002)(6512007)(256004)(53936002)(81166006)(81156014)(8676002)(2906002)(66066001)(39060400002)(25786009)(966005)(2616005)(86362001)(486006)(446003)(6636002)(478600001)(54906003)(107886003)(110136005)(71200400001)(71190400001)(72206003)(11346002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0519;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QRAlLK69ZUgvijFhf0Llz47lv/Q9NummeMT02LaH4/zq2GgYkDAvtegktJM1G7zbTLNmMh2HocLxV6XNaoZnrnc6KB18bYXVT127YJIZcgRq93DKr5a8k/jRECK/3iBk99N7OIDnr3AQN9kg3OA98+J48zFzRYDptmeZS/ztmS7ajF+fAiLs69tBKYKe2yVjVGlAJVMX7Ay+jAmKawabFmm7tlywXy2Esfa/8Q2FdLg20ahZxeLp2rYDy9Hgp7e9YiNZffdgaWknZduaxXDB3vhlCr7Z59BXRUYLMYI0gy4fKbN49TnYjPlmJLYO18Os
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 251d7663-e9bc-427e-52e2-08d660f97f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:50:02.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0519
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

