Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D0F20835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jZ4ya187"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D0F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeJJRyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:54:19 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:44942
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbeJJRyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2IwfdEbhElU7TA6uhIiNMMvBlonsEVXXXXiQ02Q8tg=;
 b=jZ4ya1872H/fLCl3b5hc4uhMRNVCq8SgHBE9egcmARfKbhvu6TiMFG82VDWrYP253rRkTfYpiog8UdLHdaVMEuXolc8uJVINkWsZEXH0j7UBg/vm4h79Rs8IITptLGPVr6mxq9ZpgLurLyZoNOoDEF3hvgL5Pdk9P+kVbcsFxV0=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB1088.eurprd04.prod.outlook.com (10.161.109.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.22; Wed, 10 Oct 2018 10:32:42 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::b0a6:19e5:90b1:5831]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::b0a6:19e5:90b1:5831%2]) with mapi id 15.20.1207.029; Wed, 10 Oct 2018
 10:32:42 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v1 1/3] spi: imx: move wml setting to later than
 setup_transfer
Thread-Topic: [PATCH v1 1/3] spi: imx: move wml setting to later than
 setup_transfer
Thread-Index: AQHUYISTA8eX7rwNJEmGe+4t1djsHA==
Date:   Wed, 10 Oct 2018 10:32:42 +0000
Message-ID: <1539196453-8704-2-git-send-email-yibin.gong@nxp.com>
References: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:203:36::34) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1088;6:gNRCnh6NuQm+AMsLLf4GKZxnhSNWlrTU97Su8nIe1MuVdtX8eIF1Dsk7yMXozLOfFucDGkox3/iYwwTGqXftyPL8SiOHjjvQOOksZK3HfIZdOQ1YtmGXF7nYwQHra/WX8mE4Gm39YCQ+j5cyYu+Gtim/1clK6QDanZY6xpsU3xKATky8mV1CKeSp4vNZwaYYapEpRE4cqvl5nJi/8RQ0BGn2/TFzkTbk+kKSNiLyfVdFqycbSfrbwGrLmGALw0D2iSftUSHV2dde0Td9p8lsKv9G8UJJ8ac1ROHg+Xa+6w+rgFjerjzCt7ZK+lXYsuqkn2hDpWEmlM9pWddO2axrGfPqXHPpuSo/PVru2aQDkGRfCPFQXdOSoDVXiYW6TM3jsHXvQPifECcIOJcGHpxwyyHyDgf8XmtyUVSPXDTqOauFqHFF/ytxLZk7bImGv0dfwCgbFd33ynjkIfkG9BUL1iIjNlAB4qX+6aBF5bSjBTw=;5:yM9t+M9Op1yU9K9846z2HY7pVcLhwjcwJL3gQZM9lzYQ5iVGtVG4dtCfufRU4qM4SKb5b6oKkEE6nLol5jLB5o244dApO9giF9Dwls62Q4mliUMAHoWbCewPkYbI58oW/wufrLweSxfm4/fkYaL1FW8GadHy6KTsjMW+JfyEn7c=;7:7UVIV2OUVhD41SHYSl1wkN4NQi25OCsI91OuHV3P9+X2CC+a4GMbjBAeZQYyTm2s77Bt6U+sKxSXyeNkbxv17VKqS1zwW7NT5YJfFVuxF12s64Z2w9qSSPcCsTT+ES5OUa72dQ+2gZC+J8I4tEDx6jLM7jXu8F6k7Cz4h5BWaMdlWm86nNCSLDQQaU6SteC21S4S66yYboxbsK8tFeUB6xM59zdLw07boE3k2c3a/fqG/L8osEljXoA6roKZPnBd
x-ms-office365-filtering-correlation-id: 10388360-5ede-484b-f293-08d62e9bb56a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1088;
x-ms-traffictypediagnostic: VI1PR04MB1088:
x-microsoft-antispam-prvs: <VI1PR04MB10887634706392598F1014BE89E00@VI1PR04MB1088.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB1088;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1088;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(376002)(396003)(199004)(189003)(486006)(5640700003)(71190400001)(11346002)(71200400001)(446003)(476003)(7736002)(305945005)(186003)(2616005)(26005)(6486002)(102836004)(66066001)(2900100001)(6436002)(6512007)(86362001)(6116002)(25786009)(4326008)(106356001)(3846002)(105586002)(2906002)(478600001)(99286004)(14454004)(2351001)(76176011)(52116002)(6506007)(386003)(54906003)(5250100002)(2501003)(316002)(97736004)(8676002)(1730700003)(81156014)(81166006)(8936002)(68736007)(6916009)(36756003)(5660300001)(14444005)(50226002)(256004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1088;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pLAcwb957QqLGK9/3neMVA1pwRDdPjloQJjeHHFjnxZet/O359VUcIwRwjw8Y8bc9NqYcmMUIownKnDYivw/nMy/PRcjNPF5oBaOSuiH2QGqC4+MNzjWIny6pXiflApXk/FOOHfEfgsA8rbPf2Wn+1WCPdf94C+DJguvaZq0H0DhlDWoilMYzVyU6EJL0kTvAemhqWhpxoUwQHWB4EMjzhLz7R3RZc/iw6W97r0u7octzI+pAYwAKOHTxme2jZW54J84/eiKoEIvfxDseM0JAfGKYQ+45VdQIruirtQEFMCjfG7BVzGXNxjWjZczaf4UQ21FKvA+3HqXkV5haGFv+seHvkbHWxi3H1OWS1T/Njs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10388360-5ede-484b-f293-08d62e9bb56a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 10:32:42.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dynamic burst length is based on the whole transfer length,
that's ok if there is only one sg, but is not right in case multi sgs
in one transfer,because the tail data should be based on the last sg
length instead of the whole transfer length. Move wml setting for DMA
to the later place, thus, the next patch could get the right last sg
length for wml setting. This patch is a preparation one, no any
function change involved.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/spi/spi-imx.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 08dd3a3..e861157 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -63,6 +63,7 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	void (*setup_wml)(struct spi_imx_data *);
 	void (*disable)(struct spi_imx_data *);
 	bool has_dmamode;
 	bool has_slavemode;
@@ -583,6 +584,11 @@ static int mx51_ecspi_config(struct spi_device *spi)
 	else			/* SCLK is _very_ slow */
 		usleep_range(delay, delay + 10);
=20
+	return 0;
+}
+
+static void mx51_setup_wml(struct spi_imx_data *spi_imx)
+{
 	/*
 	 * Configure the DMA register: setup the watermark
 	 * and enable DMA request.
@@ -593,8 +599,6 @@ static int mx51_ecspi_config(struct spi_device *spi)
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
-
-	return 0;
 }
=20
 static int mx51_ecspi_rx_available(struct spi_imx_data *spi_imx)
@@ -931,6 +935,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_=
data =3D {
 	.trigger =3D mx51_ecspi_trigger,
 	.rx_available =3D mx51_ecspi_rx_available,
 	.reset =3D mx51_ecspi_reset,
+	.setup_wml =3D mx51_setup_wml,
 	.fifo_size =3D 64,
 	.has_dmamode =3D true,
 	.dynamic_burst =3D true,
@@ -1138,7 +1143,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 				 struct spi_transfer *t)
 {
 	struct spi_imx_data *spi_imx =3D spi_master_get_devdata(spi->master);
-	int ret;
=20
 	if (!t)
 		return 0;
@@ -1179,12 +1183,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	else
 		spi_imx->usedma =3D 0;
=20
-	if (spi_imx->usedma) {
-		ret =3D spi_imx_dma_configure(spi->master);
-		if (ret)
-			return ret;
-	}
-
 	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
 		spi_imx->rx =3D mx53_ecspi_rx_slave;
 		spi_imx->tx =3D mx53_ecspi_tx_slave;
@@ -1289,6 +1287,13 @@ static int spi_imx_dma_transfer(struct spi_imx_data =
*spi_imx,
 	unsigned long timeout;
 	struct spi_master *master =3D spi_imx->bitbang.master;
 	struct sg_table *tx =3D &transfer->tx_sg, *rx =3D &transfer->rx_sg;
+	int ret;
+
+	ret =3D spi_imx_dma_configure(master);
+	if (ret)
+		return ret;
+
+	spi_imx->devtype_data->setup_wml(spi_imx);
=20
 	/*
 	 * The TX DMA setup starts the transfer, so make sure RX is configured
--=20
2.7.4

