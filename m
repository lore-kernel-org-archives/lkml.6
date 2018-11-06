Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C582BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784DB2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EzzYqqNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784DB2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbeKFNEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:04:16 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:37270
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387438AbeKFNEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NnwEC0rxVN6NnxOgkYzXxmy+/x5b/Wq0UbA2wKvzEI=;
 b=EzzYqqNWzcmq8QCcant0OyN9YbzKiKU3q9zxKK5e7Le2PklPiuXOlcSKrAYCnmjihiW9TqassnTDrZr9u59Kp9kN2nRqo4f6MtOgDSU9ErJNxJCJ0jdBrI8n1yXzLrn6yibsinMtUXxIH3UeoDJjyxef7MMuDMYckwFuGw0vDuc=
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (52.135.138.28) by
 DB7PR04MB5226.eurprd04.prod.outlook.com (20.176.236.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 6 Nov 2018 03:40:34 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::1d00:effc:853f:267]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::1d00:effc:853f:267%3]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 03:40:34 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3 3/4] dmaengine: imx-sdma: implement channel termination via
 worker
Thread-Topic: [PATCH v3 3/4] dmaengine: imx-sdma: implement channel
 termination via worker
Thread-Index: AQHUdYJ5+b+p8TNZeUq758Hi+4T5ow==
Date:   Tue, 6 Nov 2018 03:40:33 +0000
Message-ID: <1541504525-25720-4-git-send-email-yibin.gong@nxp.com>
References: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:36::16) To DB7PR04MB4538.eurprd04.prod.outlook.com
 (2603:10a6:5:35::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5226;6:qhVWPrpFccFaMfNTldXHLpBOZLlUPXzWxXZw9iBE/b+VRQvzJvGbVP2elLArWpSO1NkiS+q71NxowgS0wYUkExXPLAECkZI5ji83uAiRc4aLBC43z6LRCMx81glC9PiKEOfl5U5XIb74jOqLTGPVYJHhPuO1fdYsHelYkHyWqybM7F2nKCg2a68HmnGSgQJE4WKxJ+paPB7P4hELcsDIYgjuQferwLDLR6AbkmC2FInoGhSdaVm0PZHPDkEFC9YkKLiJtuh8t2lKXOxqrmvbQZwCAOutXXODLo9YXWAvkQex2SGNUYCB4YXXdiMG//U3gTqC4yppwDy33B510OWG1JkqU4Z685kQl2m6FlILaer6lf8Lhnt4SKA9iy37Ae8LhGSrCLay/NKeYYkZMVp5vQ9QzU8Atr7GjyGbf7GpEfEVj4MrihdpKXt7uJshOmoLmkBy0aWx18hWW3mSKHkWXw==;5:xmiUT+Qy10BlhbiHHm3NruZN5viG35S9Tjn0ttH6Hz7WQiMvSWYuQSz+Xe2dg/jUcszrbo17x3XXbTME9u/DrjlDFu7M7xE9jBS0qQFeVr5HR1Q7M9zIAdxtrb68H4JkMIYLSXM4hoXRcea85fMEDoB3El2VsLUghGPc8SKchq0=;7:TDShqoGq6lPCAyCALioFOAI6UTdFgXGKOWTamFlRKszXt5vlrQkbM/qFeE1K9yaMwkOG+2SLeLGgVZt8O5qLA0jB2CcDw/XF9YpWawIKHRNqC3k5IkshEwCDU+4/r14Mz0p8jgrklackzi5VW/j5cQ==
x-ms-office365-filtering-correlation-id: 6f8199df-37ec-4dd8-4ff4-08d643999a99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5226;
x-ms-traffictypediagnostic: DB7PR04MB5226:
x-microsoft-antispam-prvs: <DB7PR04MB52260070247BC6872B37CCD089CB0@DB7PR04MB5226.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5226;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5226;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(81166006)(54906003)(316002)(186003)(446003)(25786009)(478600001)(2501003)(71200400001)(6116002)(3846002)(2906002)(71190400001)(110136005)(99286004)(7736002)(11346002)(305945005)(6486002)(4326008)(476003)(86362001)(50226002)(6506007)(14444005)(486006)(6512007)(106356001)(36756003)(386003)(5660300001)(26005)(105586002)(256004)(2616005)(66066001)(102836004)(8936002)(68736007)(76176011)(53936002)(52116002)(6436002)(14454004)(8676002)(97736004)(81156014)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5226;H:DB7PR04MB4538.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KwdepO45fm6vmCZm2mEu8sp2AIMlGH6Tie7G08PsX4gN2lfMzhqfK/jkhpLvd+XmbC9+f1HA7YjItRQp6dyV23ailkquZbSZy3erbAFJyC9wmyj8Yh9euJz3YVcPk+JbkTxMc6dwOC//nST32aEJkyzHzNaGIud+LnbsWEAj4tBZOQhiFXzL9riS9djF9UCYdHKwf4yBT/iH4cvf32W+jnD/fzS5N4hC61FhWIPSXYL/6oKYFo/JzaCfr2CYyRhxX4lMaLlfWH6WTRiUUuYJPv0ydJ4XET6nxmjvn6jie4kotQo0D+eta050wHB+tHvn49TAXxqPMecTtTtHxXH88ZdVx7EjPUp8tyqpWQjxktg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8199df-37ec-4dd8-4ff4-08d643999a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 03:40:33.9822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The dmaengine documentation states that device_terminate_all may be
asynchronous and need not wait for the active transfers to stop.

This allows us to move most of the functionality currently implemented
in the sdma channel termination function to run in a worker, outside
of any atomic context. Moving this out of atomic context has two
benefits: we can now sleep while waiting for the channel to terminate,
instead of busy waiting and the freeing of the dma descriptors happens
with IRQs enabled, getting rid of a warning in the dma mapping code.

As the termination is now async, we need to implement the
device_synchronize dma engine function which simply waits for the
worker to finish its execution.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 51 +++++++++++++++++++++++++++++++++++++---------=
----
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8d2fec8..03d46f1 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -32,6 +32,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/workqueue.h>
=20
 #include <asm/irq.h>
 #include <linux/platform_data/dma-imx-sdma.h>
@@ -375,6 +376,7 @@ struct sdma_channel {
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
 	struct imx_dma_data		data;
+	struct work_struct		terminate_worker;
 };
=20
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -1025,31 +1027,49 @@ static int sdma_disable_channel(struct dma_chan *ch=
an)
=20
 	return 0;
 }
-
-static int sdma_disable_channel_with_delay(struct dma_chan *chan)
+static void sdma_channel_terminate_work(struct work_struct *work)
 {
-	struct sdma_channel *sdmac =3D to_sdma_chan(chan);
+	struct sdma_channel *sdmac =3D container_of(work, struct sdma_channel,
+						  terminate_worker);
 	unsigned long flags;
 	LIST_HEAD(head);
=20
-	sdma_disable_channel(chan);
-	spin_lock_irqsave(&sdmac->vc.lock, flags);
-	vchan_get_all_descriptors(&sdmac->vc, &head);
-	sdmac->desc =3D NULL;
-	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
-	vchan_dma_desc_free_list(&sdmac->vc, &head);
-
 	/*
 	 * According to NXP R&D team a delay of one BD SDMA cost time
 	 * (maximum is 1ms) should be added after disable of the channel
 	 * bit, to ensure SDMA core has really been stopped after SDMA
 	 * clients call .device_terminate_all.
 	 */
-	mdelay(1);
+	usleep_range(1000, 2000);
+
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vchan_get_all_descriptors(&sdmac->vc, &head);
+	sdmac->desc =3D NULL;
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
+	vchan_dma_desc_free_list(&sdmac->vc, &head);
+}
+
+static int sdma_disable_channel_async(struct dma_chan *chan)
+{
+	struct sdma_channel *sdmac =3D to_sdma_chan(chan);
+
+	sdma_disable_channel(chan);
+
+	if (sdmac->desc)
+		schedule_work(&sdmac->terminate_worker);
=20
 	return 0;
 }
=20
+static void sdma_channel_synchronize(struct dma_chan *chan)
+{
+	struct sdma_channel *sdmac =3D to_sdma_chan(chan);
+
+	vchan_synchronize(&sdmac->vc);
+
+	flush_work(&sdmac->terminate_worker);
+}
+
 static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 {
 	struct sdma_engine *sdma =3D sdmac->sdma;
@@ -1287,7 +1307,9 @@ static void sdma_free_chan_resources(struct dma_chan =
*chan)
 	struct sdma_channel *sdmac =3D to_sdma_chan(chan);
 	struct sdma_engine *sdma =3D sdmac->sdma;
=20
-	sdma_disable_channel_with_delay(chan);
+	sdma_disable_channel_async(chan);
+
+	sdma_channel_synchronize(chan);
=20
 	if (sdmac->event_id0)
 		sdma_event_disable(sdmac, sdmac->event_id0);
@@ -1993,6 +2015,8 @@ static int sdma_probe(struct platform_device *pdev)
=20
 		sdmac->channel =3D i;
 		sdmac->vc.desc_free =3D sdma_desc_free;
+		INIT_WORK(&sdmac->terminate_worker,
+				sdma_channel_terminate_work);
 		/*
 		 * Add the channel to the DMAC list. Do not add channel 0 though
 		 * because we need it internally in the SDMA driver. This also means
@@ -2044,7 +2068,8 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.device_prep_slave_sg =3D sdma_prep_slave_sg;
 	sdma->dma_device.device_prep_dma_cyclic =3D sdma_prep_dma_cyclic;
 	sdma->dma_device.device_config =3D sdma_config;
-	sdma->dma_device.device_terminate_all =3D sdma_disable_channel_with_delay=
;
+	sdma->dma_device.device_terminate_all =3D sdma_disable_channel_async;
+	sdma->dma_device.device_synchronize =3D sdma_channel_synchronize;
 	sdma->dma_device.src_addr_widths =3D SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.dst_addr_widths =3D SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.directions =3D SDMA_DMA_DIRECTIONS;
--=20
2.7.4

