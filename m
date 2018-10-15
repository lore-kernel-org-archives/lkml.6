Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D93EC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348B020881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cq4k7voP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348B020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJOTd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:33:26 -0400
Received: from mail-he1eur01on0060.outbound.protection.outlook.com ([104.47.0.60]:54912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbeJOTd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WIJfYaOQP26NVdDckQvWIuYKXtRUkBOzadkxFb8Dxs=;
 b=Cq4k7voPR90EwM36PyLdTEdMJ+JlbRePL7PX3XVl9/LIamwnzIDtdx0ORVNSt6o5CxATw2qrB/FhWXsBGE/NIf5HDo8hb3bx5vrPZasfZ43FK340uh3cahN9UNqdESyKAP0AKrzykI3A1jnrp8V4ifleSIPZ3vFvLMFLNu2HiVk=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (10.164.84.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 11:48:26 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 11:48:26 +0000
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
Subject: [PATCH v2 5/7] spi: spi-mem: add support for octal I/O data transfer
Thread-Topic: [PATCH v2 5/7] spi: spi-mem: add support for octal I/O data
 transfer
Thread-Index: AQHUZHz6nk0xLhiq/UWKm2fQK4r7Ig==
Date:   Mon, 15 Oct 2018 11:48:25 +0000
Message-ID: <1539603969-21076-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1616;6:TgkF7VL9RbfLRrxj1NQ5rK9Va+aaNx0tqPKPUK5wPgBz3Swqru6v0yK9BQqWtF+xNNieuxUGefCjZxzJ8YzIM/vB1NGiH0+7HBUjUKl3K4iuU1vafg7EG+Zbx0/JAM/bHqVyu6FBKRXCnaYRg+wB9QA4q+F5ZWNwE5oubjXTi2m/yjn5MjOASm36J7zNdtfZtFjvp5CgvF8z+wMLMdOF7nlAHUwiVuz5BLyjsRyeGTw73pRtn5ZJrY35MRPEyUOBYnZOqEQ9gKiDFULyN52FJNpxy4SKul5ZUP914oW7wfEkd4hWympX59dnWaR0w8eqwT0t4sVrGPOnvGNC1htpawM7+HJg2CZdw/fH0jTJEkSaxTktZ+73FrubtmUt5eY0haFerE2T9v3zlihxB4chdeqKE/Tf8vUsb++GaoYyWRZsoc531D4YlwOWz8MEldb9ucijGQAxDSRZwg80R5I3MWjt3UMOouWJ5Y9OzAj1tC0=;5:GipfEd8xRS+PMomsJMSSJubBg1gZhub2zfYAXibzbpiE0rnE7OQEd2mowb5YH721dpA39L3n39HBNEGD2lbFXKcFfananNCaKAwTDF4uyZcc173kHXPuWQMd+qmJNl9hpLIxhqT7JvkRRQK5Ut2FGIopwzsZS4rTZphCGVHT2Nc=;7:dDmqm3lxoLqIs6xsYC2jRQDx9bZFLdOUI86gex1SKNBdodh8aDhd4VbnwKhG+yOYy2A06krUxXxoDw7PC+w894idyLBUFjOzzssmJHfpLiUbBxiJ/QY3Z6z8YeOx9H4sWH7O+RQnOLO5PhAime9L93JPCjYYNKvGgQ9mogit7+bFaEVDhSs7qn6mn3mW0PQDvsHrh56G6uG/D2zhEDluuHHR5QLbLIMNXgDPv6yXfhGwyagn6cIUh40g8iTHSD67
x-ms-office365-filtering-correlation-id: 9df28e5d-66e3-47dc-ef45-08d632941d0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
x-ms-traffictypediagnostic: VI1PR04MB1616:
x-microsoft-antispam-prvs: <VI1PR04MB1616F56FE01E343D4E32734299FD0@VI1PR04MB1616.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(81166006)(81156014)(8676002)(7416002)(8936002)(4326008)(2501003)(316002)(66066001)(5250100002)(2201001)(5024004)(53936002)(7736002)(256004)(14444005)(6512007)(25786009)(6486002)(6436002)(86362001)(68736007)(5660300001)(305945005)(52116002)(2906002)(6116002)(3846002)(54906003)(110136005)(76176011)(99286004)(39060400002)(2900100001)(478600001)(476003)(11346002)(2616005)(486006)(446003)(14454004)(106356001)(36756003)(186003)(26005)(55236004)(71200400001)(102836004)(386003)(71190400001)(6506007)(105586002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RseJaGKnzLO3Dyf4E1PmYLEqHd1THZMm0jcr3V7+z0jleGjyt4B+7Xr5MAi2Ag44tNVsaypP9wn2KigXZmeKCJXqs2aSC23bB/wVYh3+ph6RzxlFkqIpNSoPYETAX2+ptvhT+QcjGDZqKGcuvkKjHS6i32tlBfvBNYLPFv6gjAx+HXWKS1lomWkv3y1NzX4VUzsPXuxS4XbkWurG+v0r0g4vHAgiJPufPWX9y5g4zYCeY5+suYnQtZ5fVYLTAKdg07KSW+zG4XVVC/8YDcDB8FFOACVOhOmSsdkvih02VmUUIQtq7AiNkCspmCgsNa+sjdhRVUbTG/l9JDhm8vO+Et1AlidaOtn9ZNalIxN9QFc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df28e5d-66e3-47dc-ef45-08d632941d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 11:48:25.9146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
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

