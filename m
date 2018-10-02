Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777F3C64EBA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC7320666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MfLwcHUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC7320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeJCBqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:46:43 -0400
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:57649
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727569AbeJCBqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVo9hGvvIrY/2AAA/VEtwOUhyU1ANEOMSmjuAV7zRTg=;
 b=MfLwcHUOwhU7iccLg2aQfJ5HiI+p582z17RHWKAh3N/Dw08zkSHxBghOePvdQGyJtLx3P9pGXAy0v1XePtJsXiDOUZbcMWzjQSslUxrxTnqH4EYtct8DtxnANBy5Z/VxFmtFPXx1YQGSjymUbREoLK6ZaQmR0LoCFsiFPnFW75o=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4578.eurprd04.prod.outlook.com (52.135.149.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Tue, 2 Oct 2018 19:01:48 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 19:01:48 +0000
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
        Dan Douglass <dan.douglass@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>
Subject: [PATCH 1/3] crypto: mxs-dcp - Implement sha import/export
Thread-Topic: [PATCH 1/3] crypto: mxs-dcp - Implement sha import/export
Thread-Index: AQHUWoJeTFJ8p3XaakOWssiNQRB5YQ==
Date:   Tue, 2 Oct 2018 19:01:48 +0000
Message-ID: <8c75f5c5dab117430313e0cfd4f2af88c9ed3d57.1538505573.git.leonard.crestez@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4578;6:0yXVl07JDpZJJDvNyAqjoTxeKqSXizcdUwsjUxOC4ski6oOqfkdZnzylFUohiYpg5lyMegmmLWEyHPzELRbGf7bshSZDhetB3FYgKOsegd3BSxOIoXjd3NKTbk4eQ4SZGFbK8hc0FpsljLXBvs+gzSz3d+0oDNVLDvMkT+zh+7kUib4em0ScntbILY7FY+viQl3bvUcCx6NKSVChJziZ0OIGb9CrA2KnBLVHkl6fjdKJSHsrdegEtJ807HnxOp7v6sthnP0DcHNx+WyXS9O9Q6Bsu72LrBdyLREO1/xktwzcVKB6ubf6mptspxoa2XKmFLKM7YxhKaoDsewWxfBL8WylmXYp+UmOIcaV8AAimc+FWzYNR2ssuPR+yqGgyfhS8QCMX5+uWJ8aiIyV2opev+cHuuyFHA1kG/msFnTUB1MciC4MbOQ3/6ONDZnTzGzOwt4ZM29cnDtRmz2uJRX3Bw==;5:tntw2SeKUsHvsMdj5jaCGdxs0AFxPzPzyYLE14IMclsURJ0xyns+3Jv1m65nwjj9BXOlXumRJKMlpvU0EQAaXcsfmV/fHBicW36ZXjs6nHOXsunr2CbH8IrzCB3yk7sRXd5JeEsvf9lPPGxBExs2/uXSTcz9oVmNFJNwaBGQ95Y=;7:y9ld4WQmlEAmgiVmByuvvZQim0DT7QPYWN53vhO1ng9GxQLYEsHz01XkFsAO82OznN4TCJDsNoegz/keMr5OhgW6U6/0fX17w6kwi5xGa/x56IoxPv78BX1E8XvfrJBM5GVnQwU57emllIix1sg7ad7CUw5+OOWHictcU2biSrS8bjinKzEuCuusDeLiXA+D08HSvzxx5N5Cjf0Fr3yHpuHJDET23p57h2fjgEFzVhh9uh6EHd0iY0CgLktkFzgW
x-ms-office365-filtering-correlation-id: fa62c575-beaa-4208-838d-08d628998139
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4578;
x-ms-traffictypediagnostic: AM0PR04MB4578:
x-microsoft-antispam-prvs: <AM0PR04MB457872F177CF8E9F8ED5A3EFEEE80@AM0PR04MB4578.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(101931422205132)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:AM0PR04MB4578;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4578;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(25786009)(6506007)(386003)(71200400001)(71190400001)(8676002)(86362001)(81156014)(26005)(81166006)(66066001)(68736007)(486006)(118296001)(186003)(14444005)(50226002)(102836004)(256004)(2616005)(44832011)(478600001)(305945005)(476003)(7736002)(8936002)(446003)(53936002)(39060400002)(97736004)(5660300001)(36756003)(6512007)(11346002)(2900100001)(52116002)(316002)(76176011)(110136005)(3846002)(99286004)(4326008)(5250100002)(6116002)(54906003)(106356001)(14454004)(6486002)(2906002)(105586002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4578;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +l2+hKDhMi8u8cVz0OLYJI7OaFjQ+FmxgoUM3ZUjj/9Kv8iOzwwlM9iZeF/o71wLGhLPLhd/sLYjuOMZW/Swb+2HLLlb6bp80RNDK74Hsb8PnxTj1VqFjSWLCfaEcAFAUyxY844tqBVTmCn0jrg5xbr6K0a28bYbtDk5rH/YcFMrW/Awhp3hB4d5E7qDu+cVpDyeYkF5t5NFNEDrzAQr3XISl/AioOZRjEMtmgCyiozKzAvK0e4dLOIkZu9RaE9S+DajykrhYnphRu6hM6HCAGRlTeLs4LJYf3HKlADciK0KZaXOBtbB03QP0DwwF/8OHxAzc9udbC6fzjBi0F1Carqmz2KwBSu/6OdKPPPKfEU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa62c575-beaa-4208-838d-08d628998139
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 19:01:48.5893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Douglass <dan.douglass@freescale.com>

The mxs-dcp driver fails to probe if sha1/sha256 are supported:

[    2.455404] mxs-dcp 80028000.dcp: Failed to register sha1 hash!
[    2.464042] mxs-dcp: probe of 80028000.dcp failed with error -22

This happens because since commit 8996eafdcbad ("crypto: ahash - ensure
statesize is non-zero") import/export is mandatory and ahash_prepare_alg
fails on statesize =3D=3D 0.

A set of dummy import/export functions were implemented in commit
9190b6fd5db9 ("crypto: mxs-dcp - Add empty hash export and import") but
statesize is still zero and the driver fails to probe. That change was
apparently part of some unrelated refactoring.

Fix by actually implementing import/export.

Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/crypto/mxs-dcp.c | 41 ++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 4b2b8129cf35..b7f41a6b65a5 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -99,10 +99,15 @@ struct dcp_aes_req_ctx {
 struct dcp_sha_req_ctx {
 	unsigned int	init:1;
 	unsigned int	fini:1;
 };
=20
+struct dcp_export_state {
+	struct dcp_sha_req_ctx req_ctx;
+	struct dcp_async_ctx async_ctx;
+};
+
 /*
  * There can even be only one instance of the MXS DCP due to the
  * design of Linux Crypto API.
  */
 static struct dcp *global_sdcp;
@@ -766,18 +771,36 @@ static int dcp_sha_digest(struct ahash_request *req)
 		return ret;
=20
 	return dcp_sha_finup(req);
 }
=20
-static int dcp_sha_noimport(struct ahash_request *req, const void *in)
+static int dcp_sha_import(struct ahash_request *req, const void *in)
 {
-	return -ENOSYS;
+	struct dcp_sha_req_ctx *rctx =3D ahash_request_ctx(req);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+	struct dcp_async_ctx *actx =3D crypto_ahash_ctx(tfm);
+	const struct dcp_export_state *export =3D in;
+
+	memset(rctx, 0, sizeof(struct dcp_sha_req_ctx));
+	memset(actx, 0, sizeof(struct dcp_async_ctx));
+	memcpy(rctx, &export->req_ctx, sizeof(struct dcp_sha_req_ctx));
+	memcpy(actx, &export->async_ctx, sizeof(struct dcp_async_ctx));
+
+	return 0;
 }
=20
-static int dcp_sha_noexport(struct ahash_request *req, void *out)
+static int dcp_sha_export(struct ahash_request *req, void *out)
 {
-	return -ENOSYS;
+	struct dcp_sha_req_ctx *rctx_state =3D ahash_request_ctx(req);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+	struct dcp_async_ctx *actx_state =3D crypto_ahash_ctx(tfm);
+	struct dcp_export_state *export =3D out;
+
+	memcpy(&export->req_ctx, rctx_state, sizeof(struct dcp_sha_req_ctx));
+	memcpy(&export->async_ctx, actx_state, sizeof(struct dcp_async_ctx));
+
+	return 0;
 }
=20
 static int dcp_sha_cra_init(struct crypto_tfm *tfm)
 {
 	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
@@ -846,14 +869,15 @@ static struct ahash_alg dcp_sha1_alg =3D {
 	.init	=3D dcp_sha_init,
 	.update	=3D dcp_sha_update,
 	.final	=3D dcp_sha_final,
 	.finup	=3D dcp_sha_finup,
 	.digest	=3D dcp_sha_digest,
-	.import =3D dcp_sha_noimport,
-	.export =3D dcp_sha_noexport,
+	.import =3D dcp_sha_import,
+	.export =3D dcp_sha_export,
 	.halg	=3D {
 		.digestsize	=3D SHA1_DIGEST_SIZE,
+		.statesize	=3D sizeof(struct dcp_export_state),
 		.base		=3D {
 			.cra_name		=3D "sha1",
 			.cra_driver_name	=3D "sha1-dcp",
 			.cra_priority		=3D 400,
 			.cra_alignmask		=3D 63,
@@ -872,14 +896,15 @@ static struct ahash_alg dcp_sha256_alg =3D {
 	.init	=3D dcp_sha_init,
 	.update	=3D dcp_sha_update,
 	.final	=3D dcp_sha_final,
 	.finup	=3D dcp_sha_finup,
 	.digest	=3D dcp_sha_digest,
-	.import =3D dcp_sha_noimport,
-	.export =3D dcp_sha_noexport,
+	.import =3D dcp_sha_import,
+	.export =3D dcp_sha_export,
 	.halg	=3D {
 		.digestsize	=3D SHA256_DIGEST_SIZE,
+		.statesize	=3D sizeof(struct dcp_export_state),
 		.base		=3D {
 			.cra_name		=3D "sha256",
 			.cra_driver_name	=3D "sha256-dcp",
 			.cra_priority		=3D 400,
 			.cra_alignmask		=3D 63,
--=20
2.17.1

