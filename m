Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4B8ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CA920833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vnJY+CTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CA920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeJXLQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:16:44 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:39072
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725896AbeJXLQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88Bk73JhFI8S45jYy2+Xy+cZeA7EfsJEjxfoMVPvu80=;
 b=vnJY+CTG4aojiV9Guf1R6jesFsVUmMJGF8I0/neY9cIDsQxM2iN+j890tMNvoSQCZzXiIY+faxC8ohBfbLGGAx1t5MDTNsBC6Y+/igkCjN8VFgizcAkHb3w7CMjAYBKZwPjykMdVJA1eXJ3HrU6WMOlRAZ/Qf1WE74440qTIgyg=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4358.eurprd04.prod.outlook.com (52.135.169.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Wed, 24 Oct 2018 02:50:32 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643%2]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 02:50:32 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 5/5] spi: lpspi: CLK pin becomes low when CR_RST=1
Thread-Topic: [PATCH 5/5] spi: lpspi: CLK pin becomes low when CR_RST=1
Thread-Index: AQHUa0RU/fO2DSpo+kGys4cA/FBa8A==
Date:   Wed, 24 Oct 2018 02:50:32 +0000
Message-ID: <20181024024808.14485-5-xiaoning.wang@nxp.com>
References: <20181024024808.14485-1-xiaoning.wang@nxp.com>
In-Reply-To: <20181024024808.14485-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0110.apcprd06.prod.outlook.com
 (2603:1096:1:1d::12) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4358;6:1qrJ4MuEq8vrjMUNPRP0uNVq3ctl4ww/oD2qAlycrLFavTz7UQzh7WqDqx+1PhK4SMpU7rLMFMM/26t7csTij0pU/lAZGnemffaNPP0xvTUurVlRSaOcTmj7Yl5NcUPe6pD78EIoeIxbUGH/4SHOFLeVHkor3lX0c5XvGlwl0z3qUitVEGRc59jDjvPZm5pyUmH4WKBc+9Cpw6GSS7FhIEn/njA2NorhBWYkHYvIhL6UnZ2cfpGh/oMWRnfv8MdB/pedkaxvxYTippAAcycYnAOGj98JlHPmyGZ5c3c6FSCBCbffFD4Qxd8BmaG4yaOHvd0V+FwF6TSGFAQGQKwt2HvGYxi0tWTGHy7OyJ92czqajyO4enHBT/HFpEwPMMj3JIRWrzEmbBP5y4ZdNXbVebTK22oC2pzFXSpz+2efzgQatH+AgWInd4iElDNGkZV4ikqFrtZaixgeIJbD2WgprA==;5:lv2eRmzyCq85ugMmVDyUdcXngeKsnh+iq065JJI+4ncy+cm4tTn2dDHgY0gmCkdGK8mMv/daeB1fgoLdfGNZN49g+JGeVMDzBgcGrA3wjmkEd93GY/ekrtOeOHxDnGzIC3CuXSA6XLgN8zEj5eqUp2IUd+T3kiJyqDAo4zberqQ=;7:jBBQIibMHxjXQD5i9EWhLxMIfkHyL2els+XGDe5HxFoGMddaZmMtzakrgVoTRBTrVDdPAlPRqxspmdCFJVCM5axJdT4vHl9c6rOOUV5x7obpMlQtzDtnSLEwLmIeoVlp0A8aEYFppmZJZ3KJGnBu7WL22eiNxDd0CoojV+VHpcHSwSYpX/dfBkNUFkO0biL2yRhxYDCtbXyKUDjTvRbMOwW+HREyNqLX1iMweK0bF+6Z437bA3WkNcdVe/J0bpeR
x-ms-office365-filtering-correlation-id: c38fc723-7cf1-4546-1d04-08d6395b76d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4358;
x-ms-traffictypediagnostic: AM6PR04MB4358:
x-microsoft-antispam-prvs: <AM6PR04MB4358828A8B7390F3274DCA81F3F60@AM6PR04MB4358.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4358;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4358;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(36756003)(53936002)(105586002)(71190400001)(99286004)(256004)(386003)(6506007)(71200400001)(102836004)(8936002)(14454004)(7736002)(4326008)(305945005)(1730700003)(81156014)(316002)(106356001)(5640700003)(81166006)(2351001)(2501003)(478600001)(6436002)(54906003)(3846002)(5660300001)(476003)(8676002)(6116002)(11346002)(66066001)(6916009)(26005)(486006)(446003)(68736007)(76176011)(25786009)(6512007)(6486002)(2900100001)(2616005)(2906002)(97736004)(86362001)(1076002)(52116002)(186003)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4358;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fQWBfxYO0giIzA2V4mHhixN21AWrqHDRsruaVWYFFCvZ9Swm4Rh89NUYps26zEvZlaKN4778A/JFEEGjGfUL9icbG7qNPV4Pce8satpqK60zdkBFOm1uMSTbpsdeaRdJ+uzIGgJW+gdREwMYLJvTxQOc4pwfM7mBEXJI5ZtVfQjAigpHF/75u1t2U5DhGmhxgJqSW5QjoMw2mlx2yCOSfdT3+BoPm2PLuPRl0PsyRyuBSWaQ4sKPo9HmLhK6jXxbYZRUaMwSkOwc0z4DmYuRDqlfRfwboEfjykYbOnI+SlPrhVUl0DCuzY6wUQiHQv6OCHVdbQJnxxaMmbiwp8Fh4rYgLuRTEF6lHgpwhm+e3jQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38fc723-7cf1-4546-1d04-08d6395b76d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 02:50:32.0670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4358
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
 drivers/spi/spi-fsl-lpspi.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a8a6699e2741..844b713553d1 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -281,10 +281,6 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl=
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
@@ -375,6 +371,21 @@ static int fsl_lpspi_wait_for_completion(struct spi_co=
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
@@ -396,9 +407,7 @@ static int fsl_lpspi_transfer_one(struct spi_controller=
 *controller,
 	if (ret)
 		return ret;
=20
-	ret =3D fsl_lpspi_txfifo_empty(fsl_lpspi);
-	if (ret)
-		return ret;
+	fsl_lpspi_reset(fsl_lpspi);
=20
 	return 0;
 }
--=20
2.17.1

