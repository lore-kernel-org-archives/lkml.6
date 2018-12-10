Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777C62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F2ams2C8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777C62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeLJQuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:50:46 -0500
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:24256
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727121AbeLJQun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkoVm4kdfVirtVH/yGa+3tlpcU6sozT1IqFzresa29Y=;
 b=F2ams2C860ZwJIVokdLg4xFVPrFZ3GWXurTDu3d4P/v/SUOQHBIUeJ5mWMV9bG2xvdqO65F2cJ3WY+IqW55ms1nT5+xdnCzx/9yYPow1WUlCeIffFxDTlajOoRTIlUgU0u8U7RgdENoxttxtoMF1iocPqHcwtYrHl1Bs+ZOwCVM=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB2750.eurprd04.prod.outlook.com (10.175.22.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 16:50:18 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86%11]) with mapi id 15.20.1404.026; Mon, 10 Dec
 2018 16:50:18 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/5] soc: fsl: dpio: store a backpointer to the device backing
 the dpaa2_io
Thread-Topic: [PATCH 3/5] soc: fsl: dpio: store a backpointer to the device
 backing the dpaa2_io
Thread-Index: AQHUkKhuPbioaeRTqk6l3vGVtHGdEQ==
Date:   Mon, 10 Dec 2018 16:50:18 +0000
Message-ID: <1544460591-14888-4-git-send-email-ioana.ciornei@nxp.com>
References: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0145.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::23) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2750;6:YuqWesw23NWIktvpE9yUzX9lx3Pngq7hGnLggyQCukWDy/3eTLfyi4mNtYTu1h/V5jLIRrBEPUy9J4PfnEBhbiN7FB3sJl9u/w0mR0o4S96EHUn3Ei8BTl6aIKxcg/d2cneLIoBNq/LsGGhDXRz0BJ89b01EfCKvsOtq73sxHpqMnJsKKxpnYMUNa1AKztI1baQxfBrfQFt2oOPPTlPRxxG49h9rYeGkBerEcu0+UJqoI+cYkKnWwT2dVtqNF4uPeaiGcovSyXwWHqv8kgTN8im7DhHdXNAvlDM+CWX+uCoKGG57tIO3/ghi51oDxo9wZIcFPwUps+YUwMh6Ij7TX/5+kLkoI4XhN9ePWLN0VTV1gcX1+ddyOF35erScnZmQDFID5AelGgtlIjCs8JZNAz43qQGU2qBpYymHPRGU2vVJ35areVojqdVm6oehjMfO7wQlZXqSd077juPEYipmcQ==;5:uK6x+awDndB2QdTNvIJgtb/L5wvwt3Bpjjg3xoHNgzMZ/KrtOoYyVahPQSawgdS34Cx7NUkHAfwLSnjidWwfGwrI7K46dcvSqTdLNYh5/gt2l8n6fgQ3hh2oeYmGYKzcs98oUFr/EAKhTUm2i8K0Tu2UOCZNu6vfq6HfzJQNPDE=;7:0lwV7v2TLoheqBtkMyixowWmCsbTWDiBi0rHtF2LOh8rJqYX5bFpO/Od/EysNTiWu/sfCUS9RLXSscyIr063e0lFsFNjyRlxYONR8P+Zjmf/azLWR+68BLtYXBCeXxhcsILb/v9r8Z2LatgBauu5bQ==
x-ms-office365-filtering-correlation-id: 9a0aab9d-4f14-43e1-4b5b-08d65ebf90e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2750;
x-ms-traffictypediagnostic: VI1PR0402MB2750:
x-microsoft-antispam-prvs: <VI1PR0402MB2750CA4E001AFC1221135B38E0A50@VI1PR0402MB2750.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2750;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2750;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(186003)(2501003)(11346002)(44832011)(53936002)(2616005)(71190400001)(476003)(2201001)(3846002)(6116002)(71200400001)(66066001)(486006)(305945005)(7736002)(86362001)(68736007)(36756003)(6436002)(81156014)(14444005)(316002)(110136005)(8936002)(14454004)(81166006)(478600001)(446003)(256004)(54906003)(25786009)(8676002)(6486002)(99286004)(76176011)(102836004)(106356001)(26005)(105586002)(386003)(2906002)(97736004)(5660300001)(6506007)(52116002)(6512007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2750;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 84cCxDaWfNA7x3wSHCXcqE5SFohgaauoYNwpJzO49gDMi+hYQkJHxrkr5KRix/gwhGNr0X0sQSeXe2s0Qt0mndrfnI3NXTt7LqQ2AXVPT83ClMhMIYM12iGqXWRlUvsiR4CLboyzUQNDXufAwhJ7upXghODmknrCFFunZqGugmHT5y1A9G3CwmUQCP8WlkrMmuDXWU7rUL/Nxzg7odkJLQoeMC1lgstGB1PAY1D3hf+dyZa8V0u2/HWIxSUJdvwdTck53QIJtoYcvWuszL+J+qwT2y0xyr2Hi0NmGu6ClxRjBTLxF2ZGBpwyfbm6C6UR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0aab9d-4f14-43e1-4b5b-08d65ebf90e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 16:50:18.5088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new field in the dpaa2_io structure to hold a backpointer to the
actual DPIO device.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c  | 2 +-
 drivers/soc/fsl/dpio/dpio-service.c | 7 ++++++-
 include/soc/fsl/dpaa2-io.h          | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio=
-driver.c
index 5286723..2d4af32 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -176,7 +176,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_=
dev)
 	if (err)
 		goto err_register_dpio_irq;
=20
-	priv->io =3D dpaa2_io_create(&desc);
+	priv->io =3D dpaa2_io_create(&desc, dev);
 	if (!priv->io) {
 		dev_err(dev, "dpaa2_io_create failed\n");
 		err =3D -ENOMEM;
diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpi=
o-service.c
index 5583d28..87e01710 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -27,6 +27,7 @@ struct dpaa2_io {
 	/* protect notifications list */
 	spinlock_t lock_notifications;
 	struct list_head notifications;
+	struct device *dev;
 };
=20
 struct dpaa2_io_store {
@@ -98,13 +99,15 @@ struct dpaa2_io *dpaa2_io_service_select(int cpu)
 /**
  * dpaa2_io_create() - create a dpaa2_io object.
  * @desc: the dpaa2_io descriptor
+ * @dev: the actual DPIO device
  *
  * Activates a "struct dpaa2_io" corresponding to the given config of an a=
ctual
  * DPIO object.
  *
  * Return a valid dpaa2_io object for success, or NULL for failure.
  */
-struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc)
+struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
+				 struct device *dev)
 {
 	struct dpaa2_io *obj =3D kmalloc(sizeof(*obj), GFP_KERNEL);
=20
@@ -146,6 +149,8 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_=
desc *desc)
 		dpio_by_cpu[desc->cpu] =3D obj;
 	spin_unlock(&dpio_list_lock);
=20
+	obj->dev =3D dev;
+
 	return obj;
 }
=20
diff --git a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
index e11eed1..5b5ba26 100644
--- a/include/soc/fsl/dpaa2-io.h
+++ b/include/soc/fsl/dpaa2-io.h
@@ -57,7 +57,8 @@ struct dpaa2_io_desc {
 	u32 qman_version;
 };
=20
-struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc);
+struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
+				 struct device *dev);
=20
 void dpaa2_io_down(struct dpaa2_io *d);
=20
--=20
1.9.1

