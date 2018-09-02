Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D90C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8445E2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RMSR3kty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8445E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeIBRbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:22 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:34400
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729522AbeIBRbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd9vzpMn9KTHOi4oCjxXOP68YfSuqu1rHf7R0OA5ttQ=;
 b=RMSR3ktyFPuZGoWJzM1gH1wiKqvl3I0aMBL17BD8ZE/shQpXkZZ8I6PkUbLThf+dyRJvQieiFZ+J9bq/4KoMz/JZulihKELRADvfwPLM47+rUmxNEK5p4c9fPnw/crxj5dnFooOoBKXo42hKsb8kgfBSnFzES/HIaJ7zGpgk4ac=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 45/62] media: helene: fix xtal frequency setting
 at power on
Thread-Topic: [PATCH AUTOSEL 4.9 45/62] media: helene: fix xtal frequency
 setting at power on
Thread-Index: AQHUQr7z9Km8JPykyUih+2ruXP6ilQ==
Date:   Sun, 2 Sep 2018 13:14:59 +0000
Message-ID: <20180902131411.183978-35-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:2so1ebVnvE2HljVn4IxKfqxmpZKUZvMpn/3qukTBFAXYwFiFlN1BQ4v8LEAPG0AwmWO/AMR8ZNA4dbDi47c2LKbvFCcZvu1/7sPUeTRfTOPEiBS6MgN0+moUbpfvSOg58RkqlnIypIoPRhI89S1HDvEAa7do6iYmZYWWgHuioc4hKNoD6Mq9N4BSiVGZkO0mGYny6RrA/coNjnX3HmxMeAoi+8Epeq1ql7g7tux4Q2lf7i9OI+ot68EMeUCx+etBBjH3lSxalEa/rq+C3JK0DWxaAyKFfEe8NJlvRK9WyCvcq1NNSFTcYxFcPti16GCZSWuHIRstjYS+bR9fS8mueoNu2EnCn/jQ8vYZSu/JpRL6cL7sEciEqB5fymefMOIEjWDFjFsTUgj7kapw4wN9MHTfvxErAEi/fs0YcTq0C9l8lhpJB5iBR5fJeemHp+rIpDhl2r4dGiLdn0zNf/7XXA==;5:oEv0rtBiKA9DpVrF981V5/zr8fSmdfbYai4sZmMQu34BhQX+grmXeQi+PnAQ8OHSPew26KtAla9mACcNw0FYyeIMjWu1hLlX87AU70KszL8NhhJmUzBzAGLaT0+Pe3ciyeq71jkw6sYSbXcKCm/6fs+MAoK4kU/eenfCUEaoLaM=;7:AXD2fjemFvjYSqZFsw2b28ktlAwVhcsrXDXFzxEB470iB1fDOGLDoTqX4NB8+SON1TJFNLFmVvNbdDF1qqIH/2Aq5ZIo1Fb3z3gxAWgwVMN7e6R4uFicelTUAQEOXaajemC2BSDvCLPiGfMscuOz7yOfVvfx7limEJ2qs7V8W6i/bzMPipj5L2jnCjh7xgntfgjk1pmXzE3Ppi/20r6rz4VyC7tu4+0iWzrB+V2OM4vYXwutse6WOiMyzHaBpVNO
x-ms-office365-filtering-correlation-id: 64763895-24e2-4f22-cf2c-08d610d62731
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074118BBA427D14BD2294A08FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(4477795004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SYNyDQJDUe5ZakUEoqPYXkb7BhrV4Z5tNKqrBnKGS4+rSUN5pvCpdwUUGzRHiN3/joyyI7DK2PLOhEpRlkgTm19Dsq2bDP1KkRpYko0POZCwJP1dfL9WE4szUPPkAgThHcy2FmG1P3UpO+enEQjGUdIFubo57eUaIUrRXLPSENWlHI03D0MaP+zzy6EwUahd/Cqw4OJt+AD3pKXW2AM0N4FwEocjrd5PdRIw7cYYmjLPH6JDlFQwFCyQTHPGM09TbOn7QFkYKlA8hLJWnccfb1IAeZ0BKtJgxGbyPuLrCZuFRrzX9pVNI0ydTFtl8RgHYI5W0BbBiYaeOQynnDuWPCPvbV1ikv5G4cV0MYUyZEg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64763895-24e2-4f22-cf2c-08d610d62731
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:59.7677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

[ Upstream commit a00e5f074b3f3cd39d1ccdc53d4d805b014df3f3 ]

This patch fixes crystal frequency setting when power on this device.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Acked-by: Abylay Ospan <aospan@netup.ru>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/dvb-frontends/helene.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/helene.c b/drivers/media/dvb-front=
ends/helene.c
index e06bcd4b3ddc..800f386f1f3f 100644
--- a/drivers/media/dvb-frontends/helene.c
+++ b/drivers/media/dvb-frontends/helene.c
@@ -898,7 +898,10 @@ static int helene_x_pon(struct helene_priv *priv)
 	helene_write_regs(priv, 0x99, cdata, sizeof(cdata));
=20
 	/* 0x81 - 0x94 */
-	data[0] =3D 0x18; /* xtal 24 MHz */
+	if (priv->xtal =3D=3D SONY_HELENE_XTAL_16000)
+		data[0] =3D 0x10; /* xtal 16 MHz */
+	else
+		data[0] =3D 0x18; /* xtal 24 MHz */
 	data[1] =3D (uint8_t)(0x80 | (0x04 & 0x1F)); /* 4 x 25 =3D 100uA */
 	data[2] =3D (uint8_t)(0x80 | (0x26 & 0x7F)); /* 38 x 0.25 =3D 9.5pF */
 	data[3] =3D 0x80; /* REFOUT signal output 500mVpp */
--=20
2.17.1
