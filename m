Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35636C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E268920851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HLGIgAs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E268920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLCIjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:39:35 -0500
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:28530
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbeLCIje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f41rnt96SvdthS7O5jlUA/vrvi9zMYYN/scOWbrhfgE=;
 b=HLGIgAs9aLe7bmaEat013P7r9NuEvUIuWfXbArGaLElB7kE+vSrsQ1BT2d+4BZYtb6Y/59sCgk1Lp90Wfq6BkPQ9kWM5WhjK3Xyw85LlS1PeMeJx0P7oLyVtf7AwVAlRGnNqnXVRfIaeGtu6lv0cMgAxZtMzxrBpNJEXaz7osTs=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4718.eurprd04.prod.outlook.com (20.177.48.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 08:39:12 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:39:12 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
Subject: [PATCH v5 2/7] spi: spi-mem: add support for octal mode I/O data
 transfer
Thread-Topic: [PATCH v5 2/7] spi: spi-mem: add support for octal mode I/O data
 transfer
Thread-Index: AQHUiuOqs754sHK/OUuJcru4Pd1jiw==
Date:   Mon, 3 Dec 2018 08:39:12 +0000
Message-ID: <1543826226-30898-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0143.apcprd04.prod.outlook.com
 (2603:1096:3:16::27) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4718;6:Qx+cV9ne6KQA2sf6U1Hp5Eo74OJmBsiQT9+0yTvRaFD1Pg8DRX/UJgN2NfoapLwJu+sggqCtA2dzD3pC9B4GI/88XfLnyj7i8TxV8L6ioriBu30umurLv/+PMImvM7P4SmfkmICwrKWKdy/uGF37WoaMw5iRVYthlcIjXe5WZR4ID2GoCNkM2XtOkzRod2WEXgp/Ao+LbQN4blYCxag/36koeeo6Q2jx3dLaUwIcp9U05tZO4x8oeHxPPfc2K8INycjF+G3zewDRAM9luNS3ZgZXh113N4T/cvzK2BPKLsVzluHMPsDdR9wmoHv2t3cQrNzWv3RBPV2avPj4Xp2rAehbmfvRjDew5TMfzzshQ6x+25KTN2u9+LZfFZErYYvPTUesX87zQ53g3zVB0ffnib5Buq4B2p/LgXR0wXDmkjGfoISkuXE8ZuijfdX414M/Q2aBdAvJzfJS8hbtAQYWWw==;5:Wa8h98BENLIXRZsHtfvRi+4E0ZKAn4I67E/nnlYm55/IOB9k6rPGtJ1Y6MVfPyviJe087AIqLVZbRdVE3MZpnD9bZ0wFp9bHS6+sjZo9jUiIzOFlNGCXlPhnfbi3FDHi4fQ3vOYrb5biExveqvKO5J/Qi4EwfIjGA+32VC1Gfm4=;7:hSQrowTCPOUKVJvZZ0DZ9YfHxsBYHCahuc4LtL/7+4oaTKdoa/6VYHsvNQ8Vf/Tb8lZQx+c6EUhsec2+vrT0tS9DagwGaqgZMAYogRneH5wQEpDoeiOqI0xr6BO7Bhogaw3KQbqT3MtUlhuN/G/elA==
x-ms-office365-filtering-correlation-id: 046d275f-e531-4ae5-708c-08d658facce3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4718;
x-ms-traffictypediagnostic: VI1PR04MB4718:
x-microsoft-antispam-prvs: <VI1PR04MB47180DDDA0DCF8168454ED6399AE0@VI1PR04MB4718.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4718;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4718;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(7736002)(99286004)(6486002)(76176011)(305945005)(6512007)(6506007)(53936002)(66066001)(386003)(105586002)(106356001)(68736007)(256004)(71190400001)(71200400001)(5660300001)(5024004)(110136005)(55236004)(14444005)(54906003)(7416002)(14454004)(86362001)(478600001)(6116002)(3846002)(25786009)(186003)(2201001)(2501003)(97736004)(2906002)(81156014)(81166006)(6436002)(8676002)(4326008)(486006)(78486014)(36756003)(102836004)(52116002)(26005)(39060400002)(2616005)(8936002)(446003)(11346002)(316002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4718;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EpIN1i1cKiXAcYZrEm1wX+XfNHKAGtaq+M+4gJxEJP//HQO8DjM9G1TnuWLxP2JfqboKfoY4NvwV04T5SQborFDz8FmGIh3JH2g3gB1z1Kz3+AkGcLYO2+W0nxGOY4/OdT7tufWidgdrhB+wMJktfr7QFvh6M18Gasr1l1WhfhtO2Hw09yB7RTN/TeQlQYd700989pWI1luk+lT1enFawUhiIa54379ONz8qgwgbOzXkP+opUc2JQXF1Zn7Ryzd9MgUmSiYUl+oqrayL274CSZL8zR4r/oeCKwGzdM4llz6F+QpFRR2ENDLxAc7VajV3nbwl7/ZvbvSSDNKyPpTu/ewaY5PjVxMYWytPU3S/ick=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046d275f-e531-4ae5-708c-08d658facce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:39:12.5942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal mode I/O data transfer in spi-mem framework.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Patch added in v2 version.

 drivers/spi/spi-mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 62a7b80..5e15d62 100644
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

