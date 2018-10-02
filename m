Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE5C65BAA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7DB208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e4CUmiTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7DB208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJCBqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:46:45 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:56665
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727433AbeJCBqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4c/wD7jqOzPG3Ot7i2iU0XExk+qDN9FsVWLi5JL5wM=;
 b=e4CUmiTxDWQ0edmzkZo/3qCqYSzuSUjWen4N///eNrKF6IMOzY+XCUnBDztv8vU6RAddpTwlKgvGxAmNiHutE7aUXnCcXaoZjjhHEDHMd/ewIfAV6f5hbBwl/02LZIwNJF3UK7tYNSBEFg0tQUKBzhblvA3bPw7QS9F/MNIV70Y=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4066.eurprd04.prod.outlook.com (52.134.125.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Tue, 2 Oct 2018 19:01:52 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 19:01:52 +0000
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
Subject: [PATCH 3/3] crypto: mxs-dcp - Fix AES issues
Thread-Topic: [PATCH 3/3] crypto: mxs-dcp - Fix AES issues
Thread-Index: AQHUWoJh2w8j7EseakaJQGwS8a0M4Q==
Date:   Tue, 2 Oct 2018 19:01:52 +0000
Message-ID: <a032d88bf4cb620f4a2da17c92eb462eb436f7f7.1538505573.git.leonard.crestez@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4066;6:Fz0tKxoscdkO1J4G8Z7Lh8Aa/R9YyoNJ934hcSF14wvflq20fKZ2mPVRlreInqB3uwYX19EySBMT7ffQR8rWx8U3sh82YAYSTagEsmU8TYn7cU7wJnPCi2bahu8vWWeTkUjGSJ9H5dOZA03GyJc3cwlIIuYnyaPvNp3g4pu5qvu+KY1Ex2MYqio/2kN73FK4clCGpkoxNPCZEcL6x4Inv7gbsbZ0WUM1hbPwq1Sh1HWwYVvGB2O3RJ9dPXcj9wqON2CQ8bDZUzU3Ss6iVn/MrYjaOKdrpVQxEchkwDYBFIxopvedWf70CpZuObERewq2n3A4pgBfcePBGvbl8HnIlKTPca9cZedFrmNEyU26QBBq+Flrl1C9nIRU15pfy4YeJq/3PoQJM5FemCEIp2s1fq+ru8mwVgLXx2HfiII9x9NzXdFp578G+c05rCKUBhGirpbi5RH4bdWmVUMh51wIqw==;5:rj8auJVIoiaBkcyiKTYG2vJwI0+gLhPq3IRmpws+N6GEx4RYOrfCe8pJH7f8xw1sTclkpCxxw3YIECsmLNM/RQgqxAhgd/tDS59PkEin3Vt6BOk04VuUWjEPZ4YIMUTsDdYWA/LBMKNBDFBfFHvYEIj6mST9dAJPuqvv01NP3VM=;7:Cfv353HWnE2ycXEPnOD2hr3DM8MpdHi7KYofM3kky9cPE/jbERFviJkZQX6U2xMQa2DBwofMsXfC9/fUJIS6JM/xfsYkKL51v9VWp0LJDkDvZkIFSLzyC0DoA1GOa9UBVEbctfGiUr07VGQuZn8kSSmGIv+ugrn32ygphNSHhh1v5Wqd/+xVKUmdzV7YmGZFDENKBMBTbEZUXtjVituROJB2SzlhXi6MWAFA5ByZeNa82g6sWmYDf5PlCYwPO8eN
x-ms-office365-filtering-correlation-id: 24f5f886-b63b-4700-bddb-08d62899836b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4066;
x-ms-traffictypediagnostic: AM0PR04MB4066:
x-microsoft-antispam-prvs: <AM0PR04MB4066CB32B5921E86E58348F6EEE80@AM0PR04MB4066.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB4066;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4066;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(39060400002)(8676002)(14454004)(110136005)(54906003)(5660300001)(6116002)(3846002)(2616005)(476003)(44832011)(486006)(11346002)(14444005)(446003)(52116002)(6506007)(102836004)(386003)(105586002)(106356001)(478600001)(76176011)(2906002)(256004)(99286004)(186003)(26005)(6512007)(6436002)(81166006)(53936002)(81156014)(2900100001)(5250100002)(68736007)(36756003)(118296001)(97736004)(50226002)(8936002)(6486002)(4326008)(71190400001)(316002)(71200400001)(66066001)(25786009)(305945005)(7736002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4066;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ttrthmfY8U6XGr/TcrEIPnxvVFLzP+lpDr9RmegAcxACbl98ya1by4gGYQQ8T9bYURPZxgeAe7RCI+d8r9aHzcBuuBdKpNCguhLRTgZhtR5wZCg8dIPtjptsucHBzsthoeMXiZyrauibtq/9XWQD6w5A0mpnZzAYubJ7XkjnTK8/YGKsUxwfT07KfakFTUmieefiGOVDn11VyPj6+5Sr3vugtD4HfuPJDv7ivCVdTH034EcD7lEDFY2E2gtEz7+cBJtuu13NTx6jEeyZa/AIXBk1a2RZZHkYoVNAg4v9FbUjjS6IIqzHskmozEUllnj9OKUNeWzEScUEEMCss3LXHmsTrwMTxIk/n8GXiTs+DDA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f5f886-b63b-4700-bddb-08d62899836b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 19:01:52.3510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radu Solea <radu.solea@nxp.com>

The DCP driver does not obey cryptlen, when doing android CTS this
results in passing to hardware input stream lengths which are not
multiple of block size.

Add a check to prevent future erroneous stream lengths from reaching the
hardware and adjust the scatterlist walking code to obey cryptlen.

Also properly copy-out the IV for chaining.

Signed-off-by: Radu Solea <radu.solea@nxp.com>
Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/crypto/mxs-dcp.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 3821cf971b5e..203c682dda99 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -230,10 +230,16 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx=
,
 	dma_addr_t src_phys =3D dma_map_single(sdcp->dev, sdcp->coh->aes_in_buf,
 					     DCP_BUF_SZ, DMA_TO_DEVICE);
 	dma_addr_t dst_phys =3D dma_map_single(sdcp->dev, sdcp->coh->aes_out_buf,
 					     DCP_BUF_SZ, DMA_FROM_DEVICE);
=20
+	if (actx->fill % AES_BLOCK_SIZE) {
+		dev_err(sdcp->dev, "Invalid block size!\n");
+		ret =3D -EINVAL;
+		goto aes_done_run;
+	}
+
 	/* Fill in the DMA descriptor. */
 	desc->control0 =3D MXS_DCP_CONTROL0_DECR_SEMAPHORE |
 		    MXS_DCP_CONTROL0_INTERRUPT |
 		    MXS_DCP_CONTROL0_ENABLE_CIPHER;
=20
@@ -259,10 +265,11 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx=
,
 	desc->payload =3D key_phys;
 	desc->status =3D 0;
=20
 	ret =3D mxs_dcp_start_dma(actx);
=20
+aes_done_run:
 	dma_unmap_single(sdcp->dev, key_phys, 2 * AES_KEYSIZE_128,
 			 DMA_TO_DEVICE);
 	dma_unmap_single(sdcp->dev, src_phys, DCP_BUF_SZ, DMA_TO_DEVICE);
 	dma_unmap_single(sdcp->dev, dst_phys, DCP_BUF_SZ, DMA_FROM_DEVICE);
=20
@@ -285,17 +292,19 @@ static int mxs_dcp_aes_block_crypt(struct crypto_asyn=
c_request *arq)
 	uint8_t *in_buf =3D sdcp->coh->aes_in_buf;
 	uint8_t *out_buf =3D sdcp->coh->aes_out_buf;
=20
 	uint8_t *out_tmp, *src_buf, *dst_buf =3D NULL;
 	uint32_t dst_off =3D 0;
+	uint32_t last_out_len =3D 0;
=20
 	uint8_t *key =3D sdcp->coh->aes_key;
=20
 	int ret =3D 0;
 	int split =3D 0;
-	unsigned int i, len, clen, rem =3D 0;
+	unsigned int i, len, clen, rem =3D 0, tlen =3D 0;
 	int init =3D 0;
+	bool limit_hit =3D false;
=20
 	actx->fill =3D 0;
=20
 	/* Copy the key from the temporary location. */
 	memcpy(key, actx->key, actx->key_len);
@@ -310,10 +319,15 @@ static int mxs_dcp_aes_block_crypt(struct crypto_asyn=
c_request *arq)
 	}
=20
 	for_each_sg(req->src, src, nents, i) {
 		src_buf =3D sg_virt(src);
 		len =3D sg_dma_len(src);
+		tlen +=3D len;
+		limit_hit =3D tlen > req->nbytes;
+
+		if (limit_hit)
+			len =3D req->nbytes - (tlen - len);
=20
 		do {
 			if (actx->fill + len > out_off)
 				clen =3D out_off - actx->fill;
 			else
@@ -326,17 +340,19 @@ static int mxs_dcp_aes_block_crypt(struct crypto_asyn=
c_request *arq)
=20
 			/*
 			 * If we filled the buffer or this is the last SG,
 			 * submit the buffer.
 			 */
-			if (actx->fill =3D=3D out_off || sg_is_last(src)) {
+			if (actx->fill =3D=3D out_off || sg_is_last(src) ||
+				limit_hit) {
 				ret =3D mxs_dcp_run_aes(actx, req, init);
 				if (ret)
 					return ret;
 				init =3D 0;
=20
 				out_tmp =3D out_buf;
+				last_out_len =3D actx->fill;
 				while (dst && actx->fill) {
 					if (!split) {
 						dst_buf =3D sg_virt(dst);
 						dst_off =3D 0;
 					}
@@ -355,10 +371,23 @@ static int mxs_dcp_aes_block_crypt(struct crypto_asyn=
c_request *arq)
 						split =3D 1;
 					}
 				}
 			}
 		} while (len);
+
+		if (limit_hit)
+			break;
+	}
+
+	/* Copy the IV for CBC for chaining */
+	if (!rctx->ecb) {
+		if (rctx->enc)
+			memcpy(req->info, out_buf+(last_out_len-AES_BLOCK_SIZE),
+				AES_BLOCK_SIZE);
+		else
+			memcpy(req->info, in_buf+(last_out_len-AES_BLOCK_SIZE),
+				AES_BLOCK_SIZE);
 	}
=20
 	return ret;
 }
=20
--=20
2.17.1

