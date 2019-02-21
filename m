Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B9FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22F220855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C52PF5EK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfBUMsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:48:14 -0500
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:56384
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfBUMsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgzh016OUUFLpDJ9KDJ3tESynBySxVcXc7UxGHZYxuw=;
 b=C52PF5EKI7YYocU5W24VEqN7s9/wf2SZBji7jKiGhST8SxKXmpY+gKeWucKWwARo7lRAI0D27vZ7NriuFmbSVJsArdGe2/+8CsHDn5Jop6ObllpA52AeFMJ0txFlpXOVqG4/i1VDZOPn/EwK44E6h/jlKGay3AKlKqki+z1kJg0=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2464.eurprd04.prod.outlook.com (10.168.64.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 12:48:10 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1622.020; Thu, 21 Feb 2019
 12:48:10 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Peter Rosin <peda@axentia.se>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH v2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUyeOzPrJOZ7UkNky2yNQN5dmaTg==
Date:   Thu, 21 Feb 2019 12:48:10 +0000
Message-ID: <20190221181230.4892-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::19) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcd80d9b-459d-413b-7480-08d697fad56e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2464;
x-ms-traffictypediagnostic: VI1PR0401MB2464:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0401MB2464;23:i1MVQga826owSUs9CrkZ+ZHW5EJdyBecZ40cp?=
 =?iso-8859-1?Q?3zpjeVM2VGsajAkNOisx74L7jP9mYV6DTXR3Z5wLe9jTch7Eq3JPP2O5FA?=
 =?iso-8859-1?Q?vX8WajtdeJeyP9hHMg2X8R8hgembWjVULI1hgue0L4MkMXccxaHv9Bszsp?=
 =?iso-8859-1?Q?jKMLf/wtTwvPB3AeJzW81PyS6UyozcOn19ixKBc8GUknrUhldFrgBggzif?=
 =?iso-8859-1?Q?56+mdm3mXtfHRx38Ku7jPH8NS/i+NV1oupaPBHYv5L6K9bg0Sp3jOGgI9g?=
 =?iso-8859-1?Q?sQBL3NfEc1QMkf8+9OmXdzYSuSlEvMeSPWYRyEuwo0/wFATeSVunQ55+Vj?=
 =?iso-8859-1?Q?EDZ+NYqnfS5kee91gANyuyX2ec769qweOGWXbEuPgBQcEyHHP1+hjjG5nH?=
 =?iso-8859-1?Q?WvzE8yBmsH4rAL1vnfOgcVn5W2ZLnNaAbntr+ae3fZlBRbGIbwnPbEenSz?=
 =?iso-8859-1?Q?KNIa34bbNyFestTrlMmFQKdTm7xsXup90sq7pPXW+rA1Z9YkCpms1K37pr?=
 =?iso-8859-1?Q?5T+eHHJOmCofMZZaFznNXXsJ3a75YfVtjheiNfDS3JOZxWpP/VVNqWdEFn?=
 =?iso-8859-1?Q?gCCpq5fnAJt0oJ2CXUmd//5PIiJoJO8x1L7tzUYuY7qXAnjS0x1qdCoUmQ?=
 =?iso-8859-1?Q?xcS+ej0KQjeZEvKrwUQgTURi2wonI7E37PI4sDcqtmLBAZV3+4Nj4FQ446?=
 =?iso-8859-1?Q?upX/eB/bQgVfhROqTkgos9eq/sQG7/9UlhzjuuBMbM5dFYq5ezVvrVhdqG?=
 =?iso-8859-1?Q?oCMKibizBxSWjUHueLxwMCS0J5WoBv/8MgZS4TUJxVWkE1MX3RAQarFRr3?=
 =?iso-8859-1?Q?azw7xGwvn+LNxmckEeCi87OnjpdqHCwzHTU6gD4SJM1xNufcK1PKayrhDx?=
 =?iso-8859-1?Q?3O9Ax+aWFwCmxpSPZJtKVwexwWavA49ortT7w8Kzcez11Ojd7oSIt11Ijw?=
 =?iso-8859-1?Q?nQn3rI86Svn+HiBxmbECz3ZKqHHZP3vupcAfbQQbgTSNgqKvTGdJR/SIcL?=
 =?iso-8859-1?Q?Z5LOpEF4raUfozukP9gHqupRGqNLtoZOOgb/pJNhsCPZXuB2pp5p08dm2I?=
 =?iso-8859-1?Q?ophc2Nrq+GBvIKy3awMEm5CqhLAnQd0kkIVVKnMUEcu5XX14MR+EGagsPr?=
 =?iso-8859-1?Q?BTmbXW6bOcjVnQyjz986bJiXyI1efa+p7j54LoSSBoGbrSI1sw6SwCd26m?=
 =?iso-8859-1?Q?TMQkvyGYOkBbvcgwNiNUuFEoXPdQugzIc/Sl2ZE8yM2IS1z+X3x0AKlQjY?=
 =?iso-8859-1?Q?Yr5RMqieQiB6OlBCv2X?=
x-microsoft-antispam-prvs: <VI1PR0401MB2464505CE81B3F7F2F33DB43F17E0@VI1PR0401MB2464.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(8936002)(54906003)(110136005)(53936002)(36756003)(316002)(14454004)(6346003)(99286004)(486006)(386003)(6506007)(102836004)(68736007)(106356001)(105586002)(2616005)(52116002)(476003)(256004)(71200400001)(6512007)(6436002)(26005)(186003)(66066001)(44832011)(97736004)(71190400001)(4326008)(6486002)(305945005)(1076003)(3846002)(86362001)(2906002)(6116002)(7736002)(8676002)(81166006)(5660300002)(478600001)(81156014)(50226002)(25786009)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2464;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IlSXQ7fbaiyqwAp46IdrPqcjhc3PyUMV0MaSjd+8mQ66FONxHs4U0+vfINTnnaTuQSckQQ81mR8P5FIxNqceCVtcOkgbh3zxWNiR0klMGMYtOzn7/aNK/kMPFuRulSUVwz7Fz0CVivpwvDNViVn1mpp3dtS8Ct/xHRiSjLJzmrPTot1eVvtpQ8eNI2vNPNd58M+KHVZzgYfnyKsCF34iG12sArKRwV++a3SeqIhkkf9emoCNraTPfEbhtleynr1eQS1Xci700O0xqdN2kCnrbIr9OKMqJ7J8S74ZqJDg/PsF+zDYmp+cw5XJs4BKUQx695RqILDbt5RUEok3KgPugQt7n71jk8PbA/cWR8U4MlQClUqx/1Xkgjkhaj8UO7UI6UHPpahPn8XTyqJBBdH/Pz+lSS9Q5lmYKH8Z77dWbmA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd80d9b-459d-413b-7480-08d697fad56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 12:48:08.8480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic register bitfield-based multiplexer that controls the multiplexer
producer defined under a parent node.
The driver corresponding to parent node provides register read/write
capabilities.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---

Notes:
    V2:
    - removed seperate driver regmap.c and added the regmap function in mmi=
o.c
      based on compatible field, the syscon or regmap function would be cal=
led
    - Modified the KConfig as per Peter's comments

 drivers/mux/Kconfig | 12 ++++++------
 drivers/mux/mmio.c  |  6 +++++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 7659d6c5f718..e5c571fd232c 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -46,14 +46,14 @@ config MUX_GPIO
 	  be called mux-gpio.
=20
 config MUX_MMIO
-	tristate "MMIO register bitfield-controlled Multiplexer"
-	depends on (OF && MFD_SYSCON) || COMPILE_TEST
+	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
+	depends on OF || COMPILE_TEST
 	help
-	  MMIO register bitfield-controlled Multiplexer controller.
+	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
=20
-	  The driver builds multiplexer controllers for bitfields in a syscon
-	  register. For N bit wide bitfields, there will be 2^N possible
-	  multiplexer states.
+	  The driver builds multiplexer controllers for bitfields in either
+	  a syscon register or a driver regmap register. For N bit wide
+	  bitfields, there will be 2^N possible multiplexer states.
=20
 	  To compile the driver as a module, choose M here: the module will
 	  be called mux-mmio.
diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 935ac44aa209..37fbcde7f1fc 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -28,6 +28,7 @@ static const struct mux_control_ops mux_mmio_ops =3D {
=20
 static const struct of_device_id mux_mmio_dt_ids[] =3D {
 	{ .compatible =3D "mmio-mux", },
+	{ .compatible =3D "reg-mux", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mux_mmio_dt_ids);
@@ -43,7 +44,10 @@ static int mux_mmio_probe(struct platform_device *pdev)
 	int ret;
 	int i;
=20
-	regmap =3D syscon_node_to_regmap(np->parent);
+	if (of_device_is_compatible(np, "mmio-mux"))
+		regmap =3D syscon_node_to_regmap(np->parent);
+	else
+		regmap =3D dev_get_regmap(dev->parent, NULL);
 	if (IS_ERR(regmap)) {
 		ret =3D PTR_ERR(regmap);
 		dev_err(dev, "failed to get regmap: %d\n", ret);
--=20
2.17.1

