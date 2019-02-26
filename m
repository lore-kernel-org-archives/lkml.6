Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF0AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440E120863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aSScUDq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfBZOc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:32:57 -0500
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:45138
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726475AbfBZOc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tel+gPzG67RqDC5gyo2JGwEJqOEHXOBQVhMENazi8ho=;
 b=aSScUDq0O2dRQ7wD9/g+4YYKqx5nIjx+gHd2WP9nzPlevbvsbALd00xjRIDHgSeg/Au1Gc2EeVYS3gTxYa1n/lD5vmt3r1lGL/dwGXEE+kgTl51GuJkQrkMdUsml5l+bIUPA1cxW3/T0dHtIyav5GBxobUzsyK1p3gBOdshFmbc=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2063.eurprd04.prod.outlook.com (10.166.141.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 14:32:18 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 14:32:18 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Peter Rosin <peda@axentia.se>
CC:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v4 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUzeATzUmo/t7gA0+u/MKC5tapIA==
Date:   Tue, 26 Feb 2019 14:32:18 +0000
Message-ID: <20190226195642.480-2-pankaj.bansal@nxp.com>
References: <20190226195642.480-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190226195642.480-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::32) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a45b73cb-d698-4455-104a-08d69bf735f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2063;
x-ms-traffictypediagnostic: VI1PR0401MB2063:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0401MB2063;23:+p4v81+5uFjnaD2yJG9AO1+jmzOy80oDg4OGD?=
 =?iso-8859-1?Q?p8YX5SVe//CJbp6+3/hh+HOF8Qm31TlbElAeKnOffVHYkAq4AY9mkK89F0?=
 =?iso-8859-1?Q?gCS4jJufjltgH8BymkBpMB8B5d36lN8+6RVHQ7oFH/csh+xqlvdoaxrR69?=
 =?iso-8859-1?Q?iZGbOBfvuq6P0DA4gaV6NFG6tA1NAYZfLfGDZrvJMnnV/85g1WOFlIr3Ai?=
 =?iso-8859-1?Q?ylZzZJqf5CBgn/U8K96oqEbvEKYPJkVGAiBUTmuXmp2YTUBCzLyRZ/m1Q7?=
 =?iso-8859-1?Q?UQFIzw3A44veuVjA6+M+COLPAVcFyo9Lzp1x5PLJOjP2B3+cS/glbaYq6q?=
 =?iso-8859-1?Q?7N+IOXMISK2Hkuf/C1i+7b7q+NwjTP9SaEcJfr3D6I+Nlp3wc/EkAkKQKf?=
 =?iso-8859-1?Q?umm3GNf0MOs8UA9IZPZP19dMCXhYBGsLTmjnm/eEAbcbtFR5sCfTLBFgsY?=
 =?iso-8859-1?Q?BAK9s1f9wEQm1MEpcBGMX+hrg/gi8HYzYnMkSkVpnIbilZndhXTBGPzo3/?=
 =?iso-8859-1?Q?xuz1KnGvd4JJtRhnodfck6KJTWJBh8E9i5ZZYFZq+Qeha6l+tEPozCyFKX?=
 =?iso-8859-1?Q?lNM4hDdo56Swyh0Y9cCVsLwIdfvZyMC1GYH9dkCpM68JS4aw4ZQ1XF1R6j?=
 =?iso-8859-1?Q?eKacsLWTmpQrpUiq7gHHEzXf0TnCsAgAHJXMojqfEvK1YTwfF7gIkjJ0Ww?=
 =?iso-8859-1?Q?/H/fTgy/z6IaJ/kBrZLye3wHtyNTd2/UPTI+cvrvkX9ffGoEkauUsbY0Iq?=
 =?iso-8859-1?Q?Pj8pDOxElqLpThizNqlx8Tu8qdZL6h5t+dU+HvMZAfXxbb+KOiaQgkKhtY?=
 =?iso-8859-1?Q?F2h/TLzR+g0joDRp9hug9OQcLcRGGQZ12tUmDk0DGKhFvhArGX1G/zNIxS?=
 =?iso-8859-1?Q?NUIxu4A14uY3LYul9yXqCAaGwMBWfpSlYOKkhBq/zJXSWp3Iq8jy1zLOb8?=
 =?iso-8859-1?Q?tQaEptTBZEleBXwP8SOL98b3q5JyGav6mITyAhBZ5JSPJ2rQ6oVGrItMs2?=
 =?iso-8859-1?Q?Qh7Z1Z5Qo3qVqjZkAYk93G/HAjNxY3ODAjJxtr4QKZiovORy3IfoqJh7VN?=
 =?iso-8859-1?Q?3RJ5QLcHbDfpPBjvwVeS0xEn5o9tDLWWxyEBKt8PzhNF0E52kRxoZiYmIX?=
 =?iso-8859-1?Q?N90hqkgqXtgmvDUZ3sS98tAP8N6B7iqLfZdn6m3e1FadRbG2hjWYnZbcda?=
 =?iso-8859-1?Q?tLQGnLJKdAADvDVmV06rRnTCs66DFxskAnU/yjiE72TaWdOP8PjnEiZ4Kd?=
 =?iso-8859-1?Q?7qSYRovspzNSjRk0lWyH/xA9WfljIKiPYnyOMiJAMkNLNdXr10wZusO5m+?=
 =?iso-8859-1?Q?YqGg=3D?=
x-microsoft-antispam-prvs: <VI1PR0401MB2063879C59C1DFDE44DC560FF17B0@VI1PR0401MB2063.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(39860400002)(376002)(199004)(189003)(110136005)(66066001)(71190400001)(71200400001)(2906002)(478600001)(6512007)(97736004)(50226002)(54906003)(5660300002)(102836004)(386003)(76176011)(8936002)(53936002)(52116002)(99286004)(6506007)(68736007)(1076003)(86362001)(6436002)(316002)(2616005)(11346002)(486006)(7736002)(44832011)(186003)(476003)(81166006)(8676002)(81156014)(3846002)(6486002)(6116002)(446003)(4326008)(25786009)(256004)(106356001)(36756003)(305945005)(26005)(105586002)(14454004)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2063;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZKV09SXyBj5sq6NtocRk+trI9Qqe4POX59GAGjEPv+LEsz8zTCYGm2hFsyL/aVhY/+0NfGjBbyKkq9ArwPLxjRlhvmBJdyMJ9+YoQAshWl+mXD5H5fDJpGg2HzlX7yabpP57L5fiU7HP+byjXeaFYwm+yaJwj0CM1CrFCnyIoqW0sycAp1sW/82bY5bK+6Ab2CXDs87404Bdu7Npq3fmXHhFCLj+0PXrAVNYG4TkNz9FEst5Oeu20TYO7uhxnRVsaCIAbfSNZq3MEfiJkB3OqnfXz6RLQWDA6tT+fOxypmK2P1a9850sdk6s8CvpC3T7PbeSgT9mafU7v4BV+IEpGYDT2p+cZVUgxSom3O8VcSQ5ZeKmN4OaZSfnDONqJPE3zaGfgpzrV9DdBF+NKjhvQFsphF0WUuO1ZA+W7PP0Fas=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45b73cb-d698-4455-104a-08d69bf735f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 14:32:17.4108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2063
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
    V4:
    - As per Peter's suggestion fixup the NULL from dev_get_regmap as early=
 as
      possible using ternary operator.
    V3:
    - Added the patch in series with device tree binding patch
    - Added the NULL return handling for regmap
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
index 935ac44aa209..44a7a0e885b8 100644
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
+		regmap =3D dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
 	if (IS_ERR(regmap)) {
 		ret =3D PTR_ERR(regmap);
 		dev_err(dev, "failed to get regmap: %d\n", ret);
--=20
2.17.1

