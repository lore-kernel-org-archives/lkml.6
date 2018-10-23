Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DE5C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664C520671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DRqwWpxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664C520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeJWSAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:00:18 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:47104
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728646AbeJWSAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYfNJEqoy0zjNNu1S2MCDXob7rykTjNz2DScZH9CYBA=;
 b=DRqwWpxcPkOG7OKRcEvEwz93RPO/mehGSOUCgtxccbGKWkwSs+Qt044WgBfPUHnUBcSZOTzyD+EnNtSPPe91siVwTc+jKwN4LFQXPJE3TDQ57hmzrzizUcjiV4f4rIboooN6ArUSMU6p58IF+AwYPpJSzNg4PAqg7pJ4TMfPypw=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5022.eurprd04.prod.outlook.com (20.177.50.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:37:13 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:37:13 +0000
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
Subject: [PATCH v3 2/7] spi: spi-mem: add support for octo mode I/O data
 transfer
Thread-Topic: [PATCH v3 2/7] spi: spi-mem: add support for octo mode I/O data
 transfer
Thread-Index: AQHUarP6iu1ZGhKqmk2kqXdraHyfvA==
Date:   Tue, 23 Oct 2018 09:37:13 +0000
Message-ID: <1540287311-1572-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0141.apcprd04.prod.outlook.com
 (2603:1096:3:16::25) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5022;6:vk1yfHMjECl0GnhHpOaV9D32X0cywSxl5SGQ9jWpnZ4iJvqyYEr4nu3tKI3BhwEkoCq4MfQNuC4wNML/WUfu7qkamJEKkcbP3+h7t/skSME8hYazTVgfM6QqXobF8PTKRRYfcq/+93Q1t5eAK8J2+incwc8pLsnCvLGqsAJ6NcTZTMrdDo7qVZ6/BI2tsHWcaBXjzSmaeU6Ow3aCI93GsW9c2iRKB73YJh1IThqRMo2C1VKqV1nL+cHTSE6fppDqD5LhGucuA1BPBa+eQ8ixzeMsBOubixJ+oFK/URMoMrRZqMJvZDSIVpbt7j+ItAMEk/kKBJnZBVaMeCKYeDkYEFETrXuqOTXbu1t55tsz4TCw6l2ZrnWBfaQX0d6UevNrUbP8p0pRaZpGyVMEbUBu5Wa5YWrVJbrdqLush5gK8A0Ncuzm5NXShDRiKx3oFHl76tpth5DT8JHy1WndbMf0Zw==;5:EYtMGJjUzrkQDuhz3t5HuiioGk6t6vS18h1t5gKHPuPSKUHGk8TXp7TNM7BXjmSrECpLD1yShDN8iMlgigzPeLyY+MZqa4857JSer+ziQuVlOF4zn+XyQeovte7KSJwMY6ttXAgpW5tGpliELTkMlo7NLrLmEJ0FFdGY4X0ONsw=;7:3VuFe8KyNBpXSwBKWfhSzjIGApe2z+nGGT0ESTmP5x9nYtJQ5OQsIY6Zp0C6zYZAFVs1vubDwzWxTFuyRIbQMpFXfx1EZacd2EPYNvX2L1iAf6nsL7IHs/h+nWERnWWGm700LQaU4x+QGS729YVINdDi9va9tn5xiXvkm/IpPupd6ewsDEaY9bL1ZnRg8OVCOhfJQaoq9eXteBt0Xdjh2GgECZebSfLnwP43BYv+CbVbWHcKMTbH9VWhEW9OjjVR
x-ms-office365-filtering-correlation-id: fce4ddb0-81f8-4a53-1450-08d638cb1c43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5022;
x-ms-traffictypediagnostic: VI1PR04MB5022:
x-microsoft-antispam-prvs: <VI1PR04MB5022654BCECC4FA4CCE2C3D799F50@VI1PR04MB5022.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5022;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5022;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(8936002)(256004)(6512007)(106356001)(102836004)(446003)(53936002)(71190400001)(4326008)(71200400001)(2616005)(54906003)(2906002)(26005)(55236004)(110136005)(476003)(105586002)(99286004)(3846002)(81156014)(7736002)(6436002)(305945005)(81166006)(7416002)(6486002)(2201001)(86362001)(186003)(6506007)(386003)(2900100001)(52116002)(11346002)(478600001)(14454004)(6116002)(8676002)(66066001)(486006)(36756003)(97736004)(5660300001)(39060400002)(316002)(76176011)(2501003)(5250100002)(14444005)(5024004)(68736007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5022;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PunxgnseFNJX/ivF3Ezrwrjv4db3x+zG+ATHpfxYshVn2I4pF03UVNqEnM8PwK6Ie3EbolzEs62S/96nI4ZLzMq5ltxvKu837IbTphmGDxVdy0g57JvosVvEfoHPknhAv8R6bVjPKl/XdWg9JmWI5Yw8A8FVKmtK2adFdYh8cpLCilpPVex31rA9Zcu9s+EkTnwb+7e/myNc+rgIvZ6U4Trnj8c13C55mx4yfXt60Tp5LH0Q+F3MtP8Yy0PlmZFk9vqwpCuqC+kUlPxbTLaPPhPig1zksru/HX74tHndswh+gP0CLYm/mE8vhKVyNLGgCp5eE3vDah6Ru7X5QIwTR3tl7tu/W+u9n1z5eFfyAd0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce4ddb0-81f8-4a53-1450-08d638cb1c43
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:37:13.0764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octo mode I/O data transfer in spi-mem framework.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Patch added in v2 version.

 drivers/spi/spi-mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c6bdea7..2379efc 100644
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
+		if ((tx && (mode & SPI_TX_OCTO)) ||
+		    (!tx && (mode & SPI_RX_OCTO)))
+			return 0;
+
+		break;
+
 	default:
 		break;
 	}
--=20
2.7.4

