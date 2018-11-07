Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E120C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D121D2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="efHgzZD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D121D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbeKHBE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:04:28 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:2145
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727387AbeKHBE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=an8U3VRPbhjqVtfaFbm5zPzkH/aKI0GGHhq44Ic8kKk=;
 b=efHgzZD5cZcj+wJtDnRYRShk+oNy4kLJ6EQIaF+P2EbFdxpldwhsTMmeCLIo6HXSE9+GvPjm8jm8kE7g1i8gUpIfoTNVgliXcugBk/6r3yv4MHemIn6ejM0hRLLm2VpNT4ow/h/jV+TirxTU1tovD2LVmMCcDD3lG0vN11fa+c8=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4962.eurprd04.prod.outlook.com (20.176.215.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 15:33:32 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 15:33:32 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller " <davem@davemloft.net>,
        Marek Vasut <marek.vasut@gmail.com>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RESEND 2/2] crypto: mxs-dcp - Add support for dcp clk
Thread-Topic: [RESEND 2/2] crypto: mxs-dcp - Add support for dcp clk
Thread-Index: AQHUdq89AqAM4y1B+0GiCHEkkSl5iw==
Date:   Wed, 7 Nov 2018 15:33:32 +0000
Message-ID: <d59eb933624a2da6432a31cdab7616629fe6ac71.1541604742.git.leonard.crestez@nxp.com>
References: <cover.1541604742.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1541604742.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0701CA0008.eurprd07.prod.outlook.com
 (2603:10a6:203:51::18) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4962;6:Gyw6GYkjKJ0vt4AJpNGW9EyvUlQ+N6R/6tzMczGt1b8iVH+L0Toe5S3+pqQuq1M7v/psP5YNabncGoLQlzNFyLD5QAyLzDl9VSyktdIVIaiPjmRA7SCKPoJSHBK0plpGZPlQayLHyXJmqfuCKHsSaLk0PuBUbxewaZ3jYuwUJu3R9fUrF5+LGTeGSR7Qk83C447D7JrBIdp6++NtG2CcuypnOjNs529cmU86QKdFOMJ93kziFK/s/xHSVFHhkMVge5Y9tUQkaoViGFwlyK3qTbB3ImVg9w1vL9vElKws7Ohg/s19O8lslRscxx1IiHvrMJGaCjSvExUmEK3N2oKmU0QXr2XPmeLxmMdQv5Nf1oQJIBetnlrDppcAKAZ0W+t++2NsLYB7pKLBJnL0YqZHYGVTxirP3frgsBafm7IgtVUo3PNPcGvreBGyzfJXEGCxgRh1Gkqn6fRN2VS0uh5NSw==;5:m0NEtZUmmHYR2YdhbULoFpqxej4r1z7rItQrNgZe7ehZOXU2MKkmSYJocGbSU96DbtIRxnahKwQzI8l5JnPefSbxhCmhiHqqftfzypTH08iC0+U+Ull5X0Z5Hsli1x7yh1RUq1/e3bud6cdygdhp5B1NoY9dyq9XR9F63pAa/JM=;7:PDraW6tV/RWvX4fD0VvKMGZXAloReXp2vQihzv3Z26n6M0IkTdQQSyqnjgZSpoqyIX0fMs50QZ+TgFlJwbDkBrPtKJuQbULk/WVIlOhIetmSZ9IagVtaz7Ek3r00fmB0xnQV37Vp952cMFn4Bbo3aQ==
x-ms-office365-filtering-correlation-id: 8dfcb6a9-8711-4390-e391-08d644c65fce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4962;
x-ms-traffictypediagnostic: AM0PR04MB4962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB4962C8D4D516364E22D35B2FEEC40@AM0PR04MB4962.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4962;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4962;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(2616005)(54906003)(186003)(25786009)(102836004)(2900100001)(5660300001)(71190400001)(316002)(76176011)(2906002)(36756003)(97736004)(71200400001)(81156014)(8676002)(6506007)(118296001)(39060400002)(66066001)(68736007)(386003)(81166006)(110136005)(6486002)(4326008)(6512007)(7736002)(99286004)(26005)(105586002)(106356001)(256004)(8936002)(53936002)(50226002)(86362001)(6436002)(3846002)(305945005)(446003)(52116002)(14454004)(6116002)(478600001)(486006)(11346002)(44832011)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4962;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +tpzYHNCi/V40qvp4JFiGhf3LJk3xgXdHDk9oyvhZ2lpUps8P5Q/+fsBhSSwwNeWWVxcB77rosfVv336NJqKJsLYQD8HhkFmU2AWFRwZPPmxyMj0pLc7s+lbEuD+q8sx575FfKl274XBhwdzpR1zoknqdbG4S1OzoB9m4UMFFiP6nhN7LBgLjxuFJ0Ggr1rDatTzMTEmKSsWC5PLXhL++/xmjZsOFYKwxh/0lTiHMZHPDR8fJIX/27IRzX33vz1laF2NsDqkvMKLcg/keuRZtcIG2JkF6kPZqGdKfyd4m4TIAeTVVPKfpFog1X4JOzIA/TfX8mM2s00TV7+vfage/5pQE9P9a3LUQBjT+Th0PSo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfcb6a9-8711-4390-e391-08d644c65fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 15:33:32.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6ull and 6sll the DCP block has a clock which needs to be explicitly
enabled.

Add minimal handling for this at probe/remove time.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/crypto/mxs-dcp.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 4e6ff32f8a7e..a2105cf33abb 100644
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
+	struct clk			*dcp_clk;
 };
=20
 enum dcp_chan {
 	DCP_CHAN_HASH_SHA	=3D 0,
 	DCP_CHAN_CRYPTO		=3D 2,
@@ -1051,15 +1053,28 @@ static int mxs_dcp_probe(struct platform_device *pd=
ev)
 		return -ENOMEM;
=20
 	/* Re-align the structure so it fits the DCP constraints. */
 	sdcp->coh =3D PTR_ALIGN(sdcp->coh, DCP_ALIGNMENT);
=20
-	/* Restart the DCP block. */
-	ret =3D stmp_reset_block(sdcp->base);
+	/* DCP clock is optional, only used on some SOCs */
+	sdcp->dcp_clk =3D devm_clk_get(dev, "dcp");
+	if (IS_ERR(sdcp->dcp_clk)) {
+		if (sdcp->dcp_clk !=3D ERR_PTR(-ENOENT))
+			return PTR_ERR(sdcp->dcp_clk);
+		sdcp->dcp_clk =3D NULL;
+	}
+	ret =3D clk_prepare_enable(sdcp->dcp_clk);
 	if (ret)
 		return ret;
=20
+	/* Restart the DCP block. */
+	ret =3D stmp_reset_block(sdcp->base);
+	if (ret) {
+		dev_err(dev, "Failed reset\n");
+		goto err_disable_unprepare_clk;
+	}
+
 	/* Initialize control register. */
 	writel(MXS_DCP_CTRL_GATHER_RESIDUAL_WRITES |
 	       MXS_DCP_CTRL_ENABLE_CONTEXT_CACHING | 0xf,
 	       sdcp->base + MXS_DCP_CTRL);
=20
@@ -1092,11 +1107,12 @@ static int mxs_dcp_probe(struct platform_device *pd=
ev)
 	/* Create the SHA and AES handler threads. */
 	sdcp->thread[DCP_CHAN_HASH_SHA] =3D kthread_run(dcp_chan_thread_sha,
 						      NULL, "mxs_dcp_chan/sha");
 	if (IS_ERR(sdcp->thread[DCP_CHAN_HASH_SHA])) {
 		dev_err(dev, "Error starting SHA thread!\n");
-		return PTR_ERR(sdcp->thread[DCP_CHAN_HASH_SHA]);
+		ret =3D PTR_ERR(sdcp->thread[DCP_CHAN_HASH_SHA]);
+		goto err_disable_unprepare_clk;
 	}
=20
 	sdcp->thread[DCP_CHAN_CRYPTO] =3D kthread_run(dcp_chan_thread_aes,
 						    NULL, "mxs_dcp_chan/aes");
 	if (IS_ERR(sdcp->thread[DCP_CHAN_CRYPTO])) {
@@ -1149,10 +1165,14 @@ static int mxs_dcp_probe(struct platform_device *pd=
ev)
 err_destroy_aes_thread:
 	kthread_stop(sdcp->thread[DCP_CHAN_CRYPTO]);
=20
 err_destroy_sha_thread:
 	kthread_stop(sdcp->thread[DCP_CHAN_HASH_SHA]);
+
+err_disable_unprepare_clk:
+	clk_disable_unprepare(sdcp->dcp_clk);
+
 	return ret;
 }
=20
 static int mxs_dcp_remove(struct platform_device *pdev)
 {
@@ -1168,10 +1188,12 @@ static int mxs_dcp_remove(struct platform_device *p=
dev)
 		crypto_unregister_algs(dcp_aes_algs, ARRAY_SIZE(dcp_aes_algs));
=20
 	kthread_stop(sdcp->thread[DCP_CHAN_HASH_SHA]);
 	kthread_stop(sdcp->thread[DCP_CHAN_CRYPTO]);
=20
+	clk_disable_unprepare(sdcp->dcp_clk);
+
 	platform_set_drvdata(pdev, NULL);
=20
 	global_sdcp =3D NULL;
=20
 	return 0;
--=20
2.17.1

