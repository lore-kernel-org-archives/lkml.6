Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682F1C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A66520881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lD61Kir2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A66520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJOT7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:59:16 -0400
Received: from mail-db5eur01on0043.outbound.protection.outlook.com ([104.47.2.43]:39611
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbeJOT7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WIJfYaOQP26NVdDckQvWIuYKXtRUkBOzadkxFb8Dxs=;
 b=lD61Kir2f9TBirVw0JEG8o8oRxVzmWrnaqNwxouoWh9O4Uxa/qJIjZzokYQgb47Nm0f4L5FzBqgb5+P5MQ2Gyc6+zNw63G91Yj6oSYSNqDJxTPGe+5S3U5E3jMj6+TqEZUE09t3algv+sYpkN5L+mXqHxMzdlK6neJpPRpW1f6Y=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4240.eurprd04.prod.outlook.com (52.134.31.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 12:14:09 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 12:14:09 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 2/7] spi: spi-mem: add support for octal I/O data transfer
Thread-Topic: [PATCH v2 2/7] spi: spi-mem: add support for octal I/O data
 transfer
Thread-Index: AQHUZICTa6RwRe/NVkSs0dOf/wyRDQ==
Date:   Mon, 15 Oct 2018 12:14:09 +0000
Message-ID: <1539605534-22302-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4240;6:1qnh1ZcFTxNJ/CtAftwOFygfSDG9s+WU2qBNoXGhag6JY9dv+9b5bhPR1Qk5dM6PdHiVWjFSZhOVCIneNYrITAKYLzZ4SM/CIhLLqU1ZVCbkoJ+GrmL6Th1hnyRJ4kFnf7BR4e8F70QXjRBBLelPIBTZ0V1LaN8NS3dJ5B97lZ/9kUwylJKafGKpE3se24AWosofnhrEEiIn4YBsga7ENzIiDGuVttkaNIww4xIWorHmckhAqMKKYBFzzhtjYiS6JIuihRL2T/1OmKibHXiTXEkZhK3hQU73V+CTf9lKAoDU3vJmVXDkSLhaM4oexD860eBUoee+C3Qh9fF7QqpKXODSIQu/z/NgycQQv+WJpZlyeZLuK3Kx8LuxLHROnKGh22ke4K3FJYCf3x10BKEFZBvFhDlDcGKY1N0fSmIkFtGpIIdRAr1Pf/J6hJHuXwFt25sOXqsaA6k6oinnacVqEg==;5:5wkozz3Q/WXHkJ7BmxdbPZjw59qEfNeeEA0K9RB/VBsbIzCUMrHdjWnz2FVYQ6KyY0VYq3z3F/C+Ea6kVw0oaUS1SFwyxUrKMGfwb8Veggv9KzdR0FbMQ2Nx7t1+qatQ7I9QuF7WOH7/Q0dki03K6QWxXH378bipf38hFTSyBNg=;7:u6CvCiKxoAj/LRuNd3TiCwn8gKnoseR2iKPtVymBP74ceBPiwrmlkzLkaFXIPwT0LM+r9C1PdcM7ncyN1ZaXFcWg80W8Goy1Nx1DKXrCjHkpndT3lHK50XqNUsc0i2oIEtFRyLYv1j7zfy8D/2CogQI/9xnbqxMUSOnKShckRmoM4kuJjACbwc2dq6F7MKgYYg44Z2btHVyCQ/P/ultNDcyBALi9hawayo4wFCGltkgrUUTJLVI6jFxc1+1xQ4O/
x-ms-office365-filtering-correlation-id: 5c64a2e9-c642-48fa-15c8-08d63297b5b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4240;
x-ms-traffictypediagnostic: VI1PR04MB4240:
x-microsoft-antispam-prvs: <VI1PR04MB4240BB145C04F6BAFC9BC1CC99FD0@VI1PR04MB4240.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB4240;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4240;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(86362001)(102836004)(106356001)(99286004)(105586002)(6486002)(39060400002)(26005)(6436002)(476003)(446003)(71190400001)(71200400001)(2201001)(186003)(5660300001)(66066001)(486006)(11346002)(2616005)(14454004)(97736004)(305945005)(55236004)(52116002)(76176011)(478600001)(4326008)(5250100002)(36756003)(81156014)(81166006)(54906003)(7736002)(53936002)(6512007)(68736007)(2501003)(8676002)(8936002)(6506007)(5024004)(386003)(14444005)(256004)(2906002)(110136005)(7416002)(316002)(2900100001)(25786009)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4240;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MyTOdpL4AXZtLNLhxuVnTN84t1/CLm3NQLsF7MTFbUPwaROi3lnBxV1SDMn7MrTSE2RAdL9CrsTtOvdbd2VbKfCT3VhgOk0LJB5lR5DThtaQwal/OU0A+qrHi6zmgNmbHrQTXmtUKXCPyMLB5tutpfZbdSFICqRoVuRGwB8LBGRVz/i86NJz/WVVu2Rf5C0tZxZbV4vR16YqT0N6fgFLFphyJFLHk7vK3r9LlKyXMr7FvHjymAcI9D9kbuf22GG/FltgWQtmsmtTxj2BEPWVj/Z03thzi2Ff2FnsnU7jDGLDV5mvc0dLB9e91CfAvqcZ1FKCXw+NjmRGE/C+GxuS2xG8omxPr6T8PggRWxWM8d0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c64a2e9-c642-48fa-15c8-08d63297b5b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 12:14:09.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal I/O data transfer in spi-mem framework.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
 Patch added in v2 version.

 drivers/spi/spi-mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c6bdea7..6fa95f8 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -12,7 +12,7 @@
=20
 #include "internals.h"
=20
-#define SPI_MEM_MAX_BUSWIDTH		4
+#define SPI_MEM_MAX_BUSWIDTH		8
=20
 /**
  * spi_controller_dma_map_mem_op_data() - DMA-map the buffer attached to a
@@ -121,6 +121,13 @@ static int spi_check_buswidth_req(struct spi_mem *mem,=
 u8 buswidth, bool tx)
=20
 		break;
=20
+	case 8:
+		if ((tx && (mode & SPI_TX_OCTAL)) ||
+		    (!tx && (mode & SPI_RX_OCTAL)))
+			return 0;
+
+		break;
+
 	default:
 		break;
 	}
--=20
2.7.4

