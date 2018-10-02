Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0FFC64EBB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E9F208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C03kEPsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E9F208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeJCBq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:46:56 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:56665
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726881AbeJCBqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvgfVJO2cNtyQIZFqSx9WCKlwouBYdE6XK78ftRrp/Q=;
 b=C03kEPsH/9+HbsVJlhIu59kNpnDQLxb8G2T1DYpWDZ2arwsKUWaoWkwx6pRqpZ1QrSrxBP3DQyj8xJVjF7GiUOYp1i5WxnrGNQa/8TYh/22UZXT5QFf4tl/dUbEuxzxB3m6mPrq/Ds0aonCWVntpuK4YqtRRMNEYn0/ryoOkCvc=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4066.eurprd04.prod.outlook.com (52.134.125.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Tue, 2 Oct 2018 19:01:50 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 19:01:50 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Radu Solea <radu.solea@nxp.com>
Subject: [PATCH 2/3] crypto: mxs-dcp - Fix SHA null hashes and output length
Thread-Topic: [PATCH 2/3] crypto: mxs-dcp - Fix SHA null hashes and output
 length
Thread-Index: AQHUWoJfMH2qLhB6hEiyNlineE7+Hw==
Date:   Tue, 2 Oct 2018 19:01:50 +0000
Message-ID: <7a39a214e7fbeb0d829f10b9e3655597f07900f5.1538505573.git.leonard.crestez@nxp.com>
References: <cover.1538505573.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1538505573.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HE1P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::30)
 To AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4066;6:nQIPyCD+b0yA+kzuhd9I85mjSxQHI65OEBJENj3tsckpFhQ2J/TlABk2KzsUCU6SgHFniBQhOL+yXhZ30ddYQqN8mLDvQheXRFRwEnnbCq4suWVSblCDspkZpvqk1lM506UFY4Q7MvrQNOCnN7ohZ8DSPXGNzgz0d3yTIKAL+8AT1fc6AbT8ACCoMOd9Yg1S3V1V7L8qpXgkoLIi0oDSnKSqfz3qL1R5CxnCiMY98pCe+t9FLHjLCxZ3y8/6HgN3zrY2p7EcIBDXfO0n8i9F5BVSy8hOfA9mk69pAmDQOn0R3fjrpQV9wyPkHoQlez8ncclulCFLf7hJcmU4E5zsrO7+LLHJUWcD2r0a7MpRn99AxpSKm3C3dCaXptM0jtKOliJEP+f4G3TR4ofah/GRw6sXtg6sZeLKXA2lSw3tbKdsYORO/JcAqiYVP/7jBpiDuQ/jmcjuyZZ2PVYUXWz+Fg==;5:Gjq0w/HESFTpdMvObjFe2nlOEyy3ncTMTM3QwhhtQFFiKQPxLecUt9v2jJpSq9/Z35/X9rJcvHIxAxYKbQaWBhwUU9gbYiUIONpKRA6JTV/2nj5O/qwMsjG6NZ5t+jlYsfybOr5xmcyfy8elF57aNglSjC0khb2PNDppJQ4AFBM=;7:uj9OBwKR8hUD/rfQv9nb/qIvBlpJe0I7RgHLBjcX3HUBNe74ILGiB15Ez4vHHBD1PuxaLqa8hC1VihI/3uUpgvraOTdSpYCtSyqzmfzQ57A7m3HnzlXiIWupnu0MZZDpFo0bWYv8sziaKmThJ3yOF1ys/mWWsbNFgtEo6C90GS9skZavZo7ghifcPwVtzJAPvH8C77tkGe4GzxWQgmbvD0UQM3dc/32ALAB+KrNE5VgJeABHZfoOsI4M6gOoYAKa
x-ms-office365-filtering-correlation-id: 2c62855f-ebe5-4eee-c3fe-08d628998254
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4066;
x-ms-traffictypediagnostic: AM0PR04MB4066:
x-microsoft-antispam-prvs: <AM0PR04MB40666B767605D7B5BC633231EEE80@AM0PR04MB4066.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB4066;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4066;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(39060400002)(8676002)(14454004)(110136005)(54906003)(5660300001)(6116002)(3846002)(2616005)(476003)(44832011)(486006)(11346002)(14444005)(446003)(52116002)(6506007)(102836004)(386003)(105586002)(106356001)(478600001)(76176011)(2906002)(256004)(99286004)(186003)(26005)(6512007)(6436002)(81166006)(53936002)(81156014)(2900100001)(5250100002)(68736007)(36756003)(118296001)(97736004)(50226002)(8936002)(6486002)(4326008)(71190400001)(316002)(71200400001)(66066001)(25786009)(305945005)(7736002)(575784001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4066;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dlNaBzls7gbi4IVtuHIfh55MyjMy/YqAUNfqBvE9Vy5oxnB/RlJnfnEWHmgu14BxXpiM5nsAAjb+6JoaiJcF5JDDByhxp44EgbmtecplrbyhxEIIvRFJP8diUp9jIyQDD1GbBDbjPNabcQuB2zZ6PJHG5yDPEgnZAJ2jVx6S+droXh1nprVEMCg+51b6u1xqL4A+IyZlU938TGbu+Z6/7QzHhXYFORRiKSwBfIoKWE64O7CbhP4QDbx4cGc84gO9fFdaFw+xU30S0ONLLwzN0p81Hq03KMJ9lM9cnlDbEAWHgRyayIZ1lfL6H+9fOGEQmn4xO4xkqvYI9dBlj6gRCXvW+pIysuVuoHTtFjXek4Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c62855f-ebe5-4eee-c3fe-08d628998254
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 19:01:50.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radu Solea <radu.solea@nxp.com>

DCP writes at least 32 bytes in the output buffer instead of hash length
as documented. Add intermediate buffer to prevent write out of bounds.

When requested to produce null hashes DCP fails to produce valid output.
Add software workaround to bypass hardware and return valid output.

Signed-off-by: Radu Solea <radu.solea@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/crypto/mxs-dcp.c | 47 +++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index b7f41a6b65a5..3821cf971b5e 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -27,13 +27,28 @@
 #include <crypto/internal/hash.h>
 #include <crypto/internal/skcipher.h>
=20
 #define DCP_MAX_CHANS	4
 #define DCP_BUF_SZ	PAGE_SIZE
+#define DCP_SHA_PAY_SZ  64
=20
 #define DCP_ALIGNMENT	64
=20
+/*
+ * Null hashes to align with hw behavior on imx6sl and ull
+ * these are flipped for consistency with hw output
+ */
+const uint8_t sha1_null_hash[] =3D
+	"\x09\x07\xd8\xaf\x90\x18\x60\x95\xef\xbf"
+	"\x55\x32\x0d\x4b\x6b\x5e\xee\xa3\x39\xda";
+
+const uint8_t sha256_null_hash[] =3D
+	"\x55\xb8\x52\x78\x1b\x99\x95\xa4"
+	"\x4c\x93\x9b\x64\xe4\x41\xae\x27"
+	"\x24\xb9\x6f\x99\xc8\xf4\xfb\x9a"
+	"\x14\x1c\xfc\x98\x42\xc4\xb0\xe3";
+
 /* DCP DMA descriptor. */
 struct dcp_dma_desc {
 	uint32_t	next_cmd_addr;
 	uint32_t	control0;
 	uint32_t	control1;
@@ -47,10 +62,11 @@ struct dcp_dma_desc {
 /* Coherent aligned block for bounce buffering. */
 struct dcp_coherent_block {
 	uint8_t			aes_in_buf[DCP_BUF_SZ];
 	uint8_t			aes_out_buf[DCP_BUF_SZ];
 	uint8_t			sha_in_buf[DCP_BUF_SZ];
+	uint8_t			sha_out_buf[DCP_SHA_PAY_SZ];
=20
 	uint8_t			aes_key[2 * AES_KEYSIZE_128];
=20
 	struct dcp_dma_desc	desc[DCP_MAX_CHANS];
 };
@@ -518,12 +534,10 @@ static int mxs_dcp_run_sha(struct ahash_request *req)
 	int ret;
=20
 	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
 	struct dcp_async_ctx *actx =3D crypto_ahash_ctx(tfm);
 	struct dcp_sha_req_ctx *rctx =3D ahash_request_ctx(req);
-	struct hash_alg_common *halg =3D crypto_hash_alg_common(tfm);
-
 	struct dcp_dma_desc *desc =3D &sdcp->coh->desc[actx->chan];
=20
 	dma_addr_t digest_phys =3D 0;
 	dma_addr_t buf_phys =3D dma_map_single(sdcp->dev, sdcp->coh->sha_in_buf,
 					     DCP_BUF_SZ, DMA_TO_DEVICE);
@@ -541,24 +555,38 @@ static int mxs_dcp_run_sha(struct ahash_request *req)
 	desc->destination =3D 0;
 	desc->size =3D actx->fill;
 	desc->payload =3D 0;
 	desc->status =3D 0;
=20
+	/*
+	 * Align driver with hw behavior when generating null hashes
+	 */
+	if (rctx->init && rctx->fini && desc->size =3D=3D 0) {
+		struct hash_alg_common *halg =3D crypto_hash_alg_common(tfm);
+		const uint8_t *sha_buf =3D
+			(actx->alg =3D=3D MXS_DCP_CONTROL1_HASH_SELECT_SHA1) ?
+			sha1_null_hash : sha256_null_hash;
+		memcpy(sdcp->coh->sha_out_buf, sha_buf, halg->digestsize);
+		ret =3D 0;
+		goto done_run;
+	}
+
 	/* Set HASH_TERM bit for last transfer block. */
 	if (rctx->fini) {
-		digest_phys =3D dma_map_single(sdcp->dev, req->result,
-					     halg->digestsize, DMA_FROM_DEVICE);
+		digest_phys =3D dma_map_single(sdcp->dev, sdcp->coh->sha_out_buf,
+					     DCP_SHA_PAY_SZ, DMA_FROM_DEVICE);
 		desc->control0 |=3D MXS_DCP_CONTROL0_HASH_TERM;
 		desc->payload =3D digest_phys;
 	}
=20
 	ret =3D mxs_dcp_start_dma(actx);
=20
 	if (rctx->fini)
-		dma_unmap_single(sdcp->dev, digest_phys, halg->digestsize,
+		dma_unmap_single(sdcp->dev, digest_phys, DCP_SHA_PAY_SZ,
 				 DMA_FROM_DEVICE);
=20
+done_run:
 	dma_unmap_single(sdcp->dev, buf_phys, DCP_BUF_SZ, DMA_TO_DEVICE);
=20
 	return ret;
 }
=20
@@ -572,10 +600,11 @@ static int dcp_sha_req_to_buf(struct crypto_async_req=
uest *arq)
 	struct dcp_sha_req_ctx *rctx =3D ahash_request_ctx(req);
 	struct hash_alg_common *halg =3D crypto_hash_alg_common(tfm);
 	const int nents =3D sg_nents(req->src);
=20
 	uint8_t *in_buf =3D sdcp->coh->sha_in_buf;
+	uint8_t *out_buf =3D sdcp->coh->sha_out_buf;
=20
 	uint8_t *src_buf;
=20
 	struct scatterlist *src;
=20
@@ -626,15 +655,13 @@ static int dcp_sha_req_to_buf(struct crypto_async_req=
uest *arq)
 		if (ret)
 			return ret;
=20
 		actx->fill =3D 0;
=20
-		/* For some reason, the result is flipped. */
-		for (i =3D 0; i < halg->digestsize / 2; i++) {
-			swap(req->result[i],
-			     req->result[halg->digestsize - i - 1]);
-		}
+		/* For some reason the result is flipped */
+		for (i =3D 0; i < halg->digestsize; i++)
+			req->result[i] =3D out_buf[halg->digestsize - i - 1];
 	}
=20
 	return 0;
 }
=20
--=20
2.17.1

