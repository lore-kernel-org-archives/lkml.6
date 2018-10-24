Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF447C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D217206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XmoU2BWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D217206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJXQZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:25:39 -0400
Received: from mail-ve1eur01on0053.outbound.protection.outlook.com ([104.47.1.53]:60224
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727516AbeJXQZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCG9BOMnWQUyaXP/3lItJ1tPKC+HjyDEqnAvDvcgxsM=;
 b=XmoU2BWz3/y8T7pnV8t6tTb7eEsFXYDotIFEp7uHhKHvEg3sD7fNNmulv3sxhSRaXcr56yhKaGhv/VAhXxmv+DuFgT9mhSbyxhVNQwd2ozAKc3MNFrKiPXYYCRxu84O+vCk1fCLjlBd7h40B960w+c3Rq76lHpHAr5RvB45W8vQ=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5176.eurprd04.prod.outlook.com (20.177.35.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Wed, 24 Oct 2018 07:58:32 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643%2]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 07:58:32 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 5/5] spi: lpspi: CLK pin becomes low when CR_RST=1
Thread-Topic: [PATCH V2 5/5] spi: lpspi: CLK pin becomes low when CR_RST=1
Thread-Index: AQHUa29bpHE8NVY0gUiMwK+WYwTSaw==
Date:   Wed, 24 Oct 2018 07:58:32 +0000
Message-ID: <20181024075617.19548-5-xiaoning.wang@nxp.com>
References: <20181024075617.19548-1-xiaoning.wang@nxp.com>
In-Reply-To: <20181024075617.19548-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0127.apcprd06.prod.outlook.com
 (2603:1096:1:1d::29) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5176;6:9luw0lbFrUzrMd5ArY+jdOJecBOkSkn9J+Kuu0hHO0z7nkmW0kxnYggoexWUTg0EY4DeZl/pku+zBLhgXV1YHwtZmzSKZdT6jYty33I08atNaB56yIDYoq3diTSAfXVtz9CvvWLTq9ZMhIFf6JI0WFAvHVp0INwn/Q64dG5fG4+FdVJN7+R2T1J770nYBv4dYLx5A2uFb54ZuMHrh8wiPfsN/z+QjkSA5D/95zk5C4tkPEuD6K7yYWqKFgA0Sloky1QySPNRFXqnG2D9Finv/XU/W0T+ErNNRLrCfn5Z/5HS5yf2jCa36tIcFlGXZ2IYidX+y99fobAKNy2F9Wdwitqw0ADS5whA+LPjlgLnj+bc6sF/fR7YEtDlLJKaDaI8B8mgyRNBIsmsMZnnKpumDqLzPjpa6xcZmqImqRsnCa+KcaVAasbBcaiN+EVTt438BJnKgrj1VVJEgFjQi5YdTg==;5:dhEEMkZ1lSA5Gi6RoPnxXQ9uVbTXZT81DNRzH8qYeCIJ2IELqWRr8EHU25p5QP0cE9Zfjg18/43vlzkSp7sPaCi8y743/Xg32ii10ZGnhm1f5hb7iCP1YUbN2R8Stpyy2dphj2iKfVc3xjsb4WzXzd91jN1rJBVT+DqfnU3Cq2M=;7:8TwfLwkzqXGlMP8lSa4VXuDy7vt1BbB78MYJWY7nrgtfbjRVLrG0SllKMcxieS78w8x6Fq/TmIfSdLtdtc5hKrgOMuciD+q3312z2CFeqHKWY7ZOpHKbqtykPior+k0Uje8yXXer+Lu2MKT2JYFWDQ==
x-ms-office365-filtering-correlation-id: 08b0333b-a1d4-478f-cf8a-08d639867df3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5176;
x-ms-traffictypediagnostic: AM6PR04MB5176:
x-microsoft-antispam-prvs: <AM6PR04MB517696F05307A8F283FBD790F3F60@AM6PR04MB5176.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5176;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5176;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(6512007)(26005)(71190400001)(5640700003)(36756003)(6916009)(68736007)(71200400001)(256004)(4326008)(6486002)(6436002)(53936002)(305945005)(7736002)(25786009)(102836004)(81166006)(81156014)(1730700003)(14454004)(6506007)(386003)(2501003)(2900100001)(54906003)(97736004)(8676002)(8936002)(5250100002)(476003)(86362001)(76176011)(186003)(486006)(2616005)(2906002)(52116002)(446003)(3846002)(6116002)(478600001)(11346002)(105586002)(106356001)(66066001)(316002)(99286004)(2351001)(1076002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5176;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2y+xCrMpiMr3ToPD2xXw0xvdY5Y568QEQ9gnmwXgc+KUenmAS93iS+uPVm7xIwsR0JgFTwDeXQ98t+ADOUHqiX7M+3D8Jx+TZdqR19vRdm8AyO0TNHsXMT04/6f1oMVdh0s/gQQTWZ/LUeOjfvQmKpbC9R2I23YX4uEL/bwJXVLsGYhIpCxVFFp68NVk6dDe9I4+L9iBzFdD/8rntiXWkF6zdczURByAaFbfKgno0xqo/Mx2flLKqzPwETCA3BnIAzJiRTcuLUK2aWarE0R8xe4G4XYBEDeK9fVaX0+sQ5A0TyotNqh2J497vnn+SJtlNbX6tDly7n3QqYhg9ymms6TY4DYMzR6MxVG5WOyMWDo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b0333b-a1d4-478f-cf8a-08d639867df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 07:58:32.4003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Reset operation in fsl_lpspi_config(). This RST may cause both CLK
and CS pins go from high to low level under cs-gpio mode.
Add fsl_lpspi_reset() function after one message transfer to clear all
flags in use.

Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
---
V2:
 - Wrong place to remove fsl_lpspi_txfifo_empty() code when I split patch
   from my work git tree Although the final code which after applying all
   these five patches is correct.
---
 drivers/spi/spi-fsl-lpspi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1be29daa9f92..3a7fe1c83aaa 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -282,10 +282,6 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl=
_lpspi)
 	u32 temp;
 	int ret;
=20
-	temp =3D CR_RST;
-	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
-	writel(0, fsl_lpspi->base + IMX7ULP_CR);
-
 	if (!fsl_lpspi->is_slave) {
 		ret =3D fsl_lpspi_set_bitrate(fsl_lpspi);
 		if (ret)
@@ -376,6 +372,21 @@ static int fsl_lpspi_wait_for_completion(struct spi_co=
ntroller *controller)
 	return 0;
 }
=20
+static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
+{
+	u32 temp;
+
+	/* W1C for all flags in SR */
+	temp =3D 0x3F << 8;
+	writel(temp, fsl_lpspi->base + IMX7ULP_SR);
+
+	/* Clear FIFO and disable module */
+	temp =3D CR_RRF | CR_RTF;
+	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
+
+	return 0;
+}
+
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
@@ -397,6 +408,8 @@ static int fsl_lpspi_transfer_one(struct spi_controller=
 *controller,
 	if (ret)
 		return ret;
=20
+	fsl_lpspi_reset(fsl_lpspi);
+
 	return 0;
 }
=20
--=20
2.17.1

