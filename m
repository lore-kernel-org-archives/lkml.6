Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACF0C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8611D2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OJYoaT3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8611D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeJOVND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:13:03 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:30160
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbeJOVNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQBRp7vsJTa6ayPyk3B/Z980+orKSk7Ted81mJ1JQd0=;
 b=OJYoaT3zeEMYMOScRNsdegWl24kQhxwxxNvhSE+1OmgYKIln2yGn/223v1kTHezKDhp7Ue7jhdtC5MwpSij1jd5TrfDcGCHZKnU923p0Ux+M5cEEpthDNA6HkF2s2kchme7St9dOqwztse919ZUk1yPhliOLFKasinqt5/A/7KA=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4948.eurprd04.prod.outlook.com (20.176.215.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 13:27:37 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 13:27:37 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] crypto: mxs-dcp - Add support for dcp clk
Thread-Topic: [PATCH v2 2/4] crypto: mxs-dcp - Add support for dcp clk
Thread-Index: AQHUZIrWKQehjSTCMkafThAO20dZjw==
Date:   Mon, 15 Oct 2018 13:27:37 +0000
Message-ID: <fda62f939da082d640a27e506e7a3defac4f123f.1539609921.git.leonard.crestez@nxp.com>
References: <cover.1539609921.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1539609921.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0502CA0071.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::48) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4948;6:BCOhHOBenUV5CrQln/ymC6W9imo1hLm046bGJtvz2jq22kKdRk7qspUfn6AFsaOlH2x1swhs/VrS9G/OwYPzpBJ9pWvkf782O1uQLPlqSWMVOMGK+JBj9r2P/xdc/Wz2kuqAN3aI4Utmw0RYCgk41PYlHW01ZGt27ZEgFqv0giEzo2quY0p862dbjhCoUSMd8zoWIzSJpudySfgoGjblpZvjXqqBECj2DFyLarxinDRkvFueS+V+QoKxpLfff4o/mYS7UCObkZSxaZFA9AsoPwqTBkOQTz+ryjZvem4bLfayiwm+85wIHIVkFGVuIDMbXRpxx4T5LLGLN7YLoyumgY0Lp2/wqo4E3RsZ4hFZlM+DtpHiICkbPefSx72IqA/ScbbFW8Cs6ZQrlVGovhLHgLQNqvFndyZqrYRSFo/8UFJxvDCLX21Te5dQphUoaFhQSYPDJoJbDDrSfY0LD5T42g==;5:NiG0pDtRqCjbaWBeVf3TzrZ+0HQO3Y6ZyOCB3hYR/X/dHG99IBxTLWaoCAh+bhfdmN0krXlYiFjTxuatG6Cnk9ag++dMLq7M7E/tFJ/UKAt1XWNfYRxTARybgiopGEiVIlFMq2CTE8zXpsCmwdXSLO6mkcRvg6dexYlwTcj4Eok=;7:VA2Q7V5TusniGHKdarCg4LJd6RpWGS+gSDceQj+XaE4qnbxJY8gdaIbWHn31g0KoS5J0Hl+kLeQQYCEjDpOdfo0706/fth/kg6+6BWcMv2gMmo8Z9shDuMma2tiiJuhNpnNfS60vif3zjEHlHe00mUHjXILsOVFJSwYRsKEA9trF1eHKPS3dvY7yM0oyHNgjZfnTx7HLvICwnK11kJ7EZX2AZ3zCgMzLci8QPFUnbK1l1W+t307St5TC4iW2cV7n
x-ms-office365-filtering-correlation-id: 59d56bcf-daaf-471b-5ebf-08d632a1f941
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4948;
x-ms-traffictypediagnostic: AM0PR04MB4948:
x-microsoft-antispam-prvs: <AM0PR04MB49487C6E1610D8383079B146EEFD0@AM0PR04MB4948.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB4948;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4948;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(97736004)(105586002)(256004)(2906002)(106356001)(53936002)(102836004)(52116002)(6116002)(3846002)(118296001)(36756003)(14444005)(5250100002)(6506007)(386003)(76176011)(66066001)(81156014)(81166006)(305945005)(486006)(8676002)(71200400001)(110136005)(54906003)(99286004)(44832011)(71190400001)(7736002)(478600001)(39060400002)(68736007)(4326008)(6436002)(25786009)(6486002)(446003)(11346002)(5660300001)(316002)(6636002)(7416002)(2616005)(186003)(26005)(8936002)(86362001)(575784001)(14454004)(50226002)(6512007)(2900100001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4948;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XsQsU/+Um/j3yLaxZv20qyJaWewuYvD0U4727DRkuaT+V3Ev4ImpdxJJ7jdDdfQv8iCHStTxstbwVZxva13DnEDwwszYPUStX7SxPMhP0cPJdctFRzpaSAeQBxKdTRo3G43mSZn920NwdlBq/PiUujRwVMotZQJjvzFtdYhAwWVuKZjuQ7Tyqu+5hcQnkDegOGNuvlA0nc13LC1WpKgr/HNuCJHAk64oi2y6WVJf4g4RUn8/vptyUUnGQo/SgqH8Vrk8vf6eo/gqvhRXpqbdFbTzSz6HGtL7yV/6U9+u7TZ9QweVe4wFck1tOY6bUpf1M7x/AezNToReGe6Lhykmup6MsqPFN9tlIWu8Xs93v60=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d56bcf-daaf-471b-5ebf-08d632a1f941
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:27:37.5380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6ull and 6sll the DCP block has a clock which needs to be explicitly
enabled.

Add minimal handling for this at probe/remove time.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/crypto/mxs-dcp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 849a81ece079..fd13787a2a0e 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -18,10 +18,11 @@
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/stmp_device.h>
+#include <linux/clk.h>
=20
 #include <crypto/aes.h>
 #include <crypto/sha.h>
 #include <crypto/internal/hash.h>
 #include <crypto/internal/skcipher.h>
@@ -80,10 +81,11 @@ struct dcp {
=20
 	struct completion		completion[DCP_MAX_CHANS];
 	spinlock_t			lock[DCP_MAX_CHANS];
 	struct task_struct		*thread[DCP_MAX_CHANS];
 	struct crypto_queue		queue[DCP_MAX_CHANS];
+	struct clk *dcp_clk;
 };
=20
 enum dcp_chan {
 	DCP_CHAN_HASH_SHA	=3D 0,
 	DCP_CHAN_CRYPTO		=3D 2,
@@ -1027,10 +1029,24 @@ static int mxs_dcp_probe(struct platform_device *pd=
ev)
 	sdcp->dev =3D dev;
 	sdcp->base =3D devm_ioremap_resource(dev, iores);
 	if (IS_ERR(sdcp->base))
 		return PTR_ERR(sdcp->base);
=20
+	/* DCP clock is optional, only used on some SOCs */
+	sdcp->dcp_clk =3D devm_clk_get(dev, "dcp");
+	if (IS_ERR(sdcp->dcp_clk)) {
+		if (sdcp->dcp_clk !=3D ERR_PTR(-ENOENT))
+			return PTR_ERR(sdcp->dcp_clk);
+		sdcp->dcp_clk =3D NULL;
+	}
+
+	ret =3D clk_prepare(sdcp->dcp_clk);
+	if (ret)
+		return ret;
+	ret =3D clk_enable(sdcp->dcp_clk);
+	if (ret)
+		return ret;
=20
 	ret =3D devm_request_irq(dev, dcp_vmi_irq, mxs_dcp_irq, 0,
 			       "dcp-vmi-irq", sdcp);
 	if (ret) {
 		dev_err(dev, "Failed to claim DCP VMI IRQ!\n");
@@ -1168,10 +1184,12 @@ static int mxs_dcp_remove(struct platform_device *p=
dev)
 		crypto_unregister_algs(dcp_aes_algs, ARRAY_SIZE(dcp_aes_algs));
=20
 	kthread_stop(sdcp->thread[DCP_CHAN_HASH_SHA]);
 	kthread_stop(sdcp->thread[DCP_CHAN_CRYPTO]);
=20
+	clk_disable(sdcp->dcp_clk);
+
 	platform_set_drvdata(pdev, NULL);
=20
 	global_sdcp =3D NULL;
=20
 	return 0;
--=20
2.17.1

