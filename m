Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE6C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D322080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A9cKoJbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D322080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeLNIvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:51:38 -0500
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:22544
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeLNIvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kBAMqzNjRdZz2b4seMkRRWHsEkZ1EW6lBEFWKz63r8=;
 b=A9cKoJbETM1G2eW1skkAXL1+LZBpCjTF/SblZWmaqRQqw6+P/0qL8iGH8tDSzk9VZDuIpwMgKXF2GwEdT6kBIvahK5SE04dqiv3sbLByXoGn7kq612c5qlqXQXXe27jrks6hZyCKrCDbc0lxn7TvKGp8rOuEUzqES36DhjufVA0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 08:51:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 08:51:35 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] nvmem: imx-ocotp: add i.MX7ULP support
Thread-Topic: [PATCH 1/2] nvmem: imx-ocotp: add i.MX7ULP support
Thread-Index: AQHUk4o32S6/LjsiW06Mk0cqG3Q7cg==
Date:   Fri, 14 Dec 2018 08:51:35 +0000
Message-ID: <1544777136-9195-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0038.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:f/HY/kuMnAjAnI/JzLJIDdi8Sqsq9oR1RNeuhhTf8FvlZ7vV2uG/jpbzWYqJeKMXAzXlw5JEa8XzKxa7REOkgxxU3hS1Y9jMmMXc1NeZV/d/FNzjAfqgU5SmyVe6mvHlfVqO/aR2sgEnAWsElWBCpSzAs7zeaRFxCCG6QE1aS4p1t4J9BnVfiap39+qLnrt1OhesFqQ5ZHS7alZmDSZzQ6gy8eTGvUpH84SQAbgE5mmRFT1A/6YlX21xgvIvdBSI9EfNGGKJ9WFXtpi2Tz5rFpUEcNW3wRID5yC0cJz20IJBHuSB/wGa5KTbsU8bJr3femAazdRXJv1ZjMqlPyryuBpXEk9yrGeqS9cZs1lXS1gGa56T5kvuyPLJ2OQWEuqfMqW/XX5OXhv0c/0rqiNKCAEeqOC5gIr6fvl7WlJ9hJUmTIVOUVV2g4jH8eIt8EcYMaCKaawHJrutjZ/XUJuI3A==;5:9Dx5NYGNabi9IzPcrazgJvrEKFTCkKmxfM5scjh0vdZyXMJUs1s3XgoBOg0v/edd9n4BjFTVUm3gncawaxICvbkUHcZVKzMCCLEns31IyQmVvNdUqaJkBkCK1Os3ai2sJO06nivBFNMj2I9qy1rz2BXyXRwuIEGdHp+kRfY15x8=;7:GkAmAzZq4rLdT4YTI04eet0b+T/lcrDjlZOfmvVQ8KflodQzh/T/Gy64H0ZHc1AwfudfrS8n3znTDa8XCWktRqj4jK4z57Z9x6gvu4J1dVLc1Ha2a57dTJDlFD5xE0Z+x1K3wtxyGfMzTjJBE3Pu8g==
x-ms-office365-filtering-correlation-id: 328b213e-98ac-4e06-aa86-08d661a159f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-microsoft-antispam-prvs: <DB3PR0402MB36901FAF7B28D8438B65B07EF5A10@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(2501003)(5660300001)(97736004)(66066001)(36756003)(2201001)(71200400001)(6512007)(86362001)(3846002)(6116002)(71190400001)(53936002)(2906002)(305945005)(14454004)(99286004)(4326008)(25786009)(478600001)(6486002)(110136005)(6436002)(50226002)(256004)(8936002)(105586002)(106356001)(81166006)(486006)(316002)(8676002)(81156014)(68736007)(26005)(102836004)(6506007)(386003)(476003)(52116002)(2616005)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hP6L4jWHI1i4C0BAWojloGuaQqcEa8lJ4tWeFtxKqCz1FjIPhy5vbEQ8QJag7vLf9D/jJa4A7JMpOzy/EsWzTa8M1bx23binrEBrXTLtpnsc0ijSgrJIjcBWTdabSlVNdHnlA5iXKaMjfkYsRzZ0gVrY9ZRwuEYxDRdqCZrkGpiI2labeM7ie8NP5v3WY0N/HVuqtZy33cL5APW8L5X1YFTWif8lLQcpgPIP4nKqlU2t1jQ2cqkkvYFKKRpOR6SpLtBSl73OYXQ7g1nvYWGBf21o2JNOMmFt2bQ3mFjpcAaJHwxR2o4IDv1VYoph7ykM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328b213e-98ac-4e06-aa86-08d661a159f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:51:35.0360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP is a new SoC of i.MX family which has 8 kbit eFuse OTP,
enable ocotp driver support for this SoC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index afb429a..90a3982 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -433,6 +433,11 @@ static const struct ocotp_params imx7d_params =3D {
 	.set_timing =3D imx_ocotp_set_imx7_timing,
 };
=20
+static const struct ocotp_params imx7ulp_params =3D {
+	.nregs =3D 256,
+	.bank_address_words =3D 0,
+};
+
 static const struct of_device_id imx_ocotp_dt_ids[] =3D {
 	{ .compatible =3D "fsl,imx6q-ocotp",  .data =3D &imx6q_params },
 	{ .compatible =3D "fsl,imx6sl-ocotp", .data =3D &imx6sl_params },
@@ -440,6 +445,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] =3D=
 {
 	{ .compatible =3D "fsl,imx6ul-ocotp", .data =3D &imx6ul_params },
 	{ .compatible =3D "fsl,imx7d-ocotp",  .data =3D &imx7d_params },
 	{ .compatible =3D "fsl,imx6sll-ocotp", .data =3D &imx6sll_params },
+	{ .compatible =3D "fsl,imx7ulp-ocotp", .data =3D &imx7ulp_params },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
--=20
2.7.4

