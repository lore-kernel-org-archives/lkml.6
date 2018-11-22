Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAE1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E3320820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ChauO0Hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E3320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392170AbeKVPwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:52:24 -0500
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:36633
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbeKVPwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g77+c0OWftWLAiih6FN11rLnuHLZQdqRCaErV3JZbsw=;
 b=ChauO0HmoyJuaosw72rMoznG/BnZfb8DNF+R9Rrzung2HhSpRDPM/5JGBL0jMEfh/4zbtfaQkqaNJIcV8Jx8woeh0CxTnDw4Oz8kiLQgkvHEjrD7NR8mSXbDmj/q8MA9xKMB4mw7Q2XTqHjIntAIFTdtBFbRod5/FbvjiYg/fdo=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3055.eurprd04.prod.outlook.com (10.170.228.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 05:14:37 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 05:14:37 +0000
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
Subject: [PATCH v4 2/7] spi: spi-mem: add support for octo mode I/O data
 transfer
Thread-Topic: [PATCH v4 2/7] spi: spi-mem: add support for octo mode I/O data
 transfer
Thread-Index: AQHUgiJDzVTsDPXnB0mQxujUB5Eyqg==
Date:   Thu, 22 Nov 2018 05:14:37 +0000
Message-ID: <1542863544-21257-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0106.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::32) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3055;6:IVXVeG6pixivckQKjD2u5rQ1qorKblnMYtN+ug71p9JRDG0rVdgx9kO3SLsPkOOfUeCziZONkhywY+lrqUYlCKoqWMcWN57i1pdN30MXdyEy4cpoQLcuGe78PYdgg4CI20MUKAx3I9wA/BWWDiOLWtJVgBExusPGxjD0caj8MorF8BAmVKMWSYiGsxBN9mz8r+Klm3hHM8NIRTrpE5t+SzmkkDZps0DuUIlNPC4iiSEvRTqrovJjM517mswhjbCQbV/jPH+mYYxO6WwPL+tAcwx5E0WlB6TR6goA8DaYFY3d2dz5Hk2Eh78ICiHLd3D8nkFBdkWkXGS3HNHkxAz+SegRAk+sOa5cHSKUWEG2fs3289qNciACO41Bmbl6td0M3zbbHM+sjzeCNw3wq5Qp+VFyq/Sk0ZYPR8fk71o2bdr/rbkg6w8iW+Am96aCd2Z5NDYw/hl4vFbrSewScLqXXQ==;5:bUBV+ypGyDiZi1UOacTNNoim+AypSw/9NQmE7R2ktNJcS6ymlgjAoqGKecgaQck0KxszWDoToKGD5Ehg2JtHnEBrG4yGTwBZUcuLkKErv4NXpfXY4RkTWFOR316kS1gA7jGbG7MRtmbg7oWJWavKTa8AElvVVe3MLy7IiSuuT+I=;7:51M67rZf/WUZlGAUme3d+k4IZ/RGviSqnLaaefh8ajAx/pY8gha1ffK8OKX6BTzIBaaQyI+hth4ZqLXOzm2iOYAXaLouOgmsf9dMtF7ev5I8Y6kuFYIzCT3M7MOc6DUSE0K5eQjrAgDa6MR693qptg==
x-ms-office365-filtering-correlation-id: 96b39f25-1999-4cd3-bdba-08d6503965c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3055;
x-ms-traffictypediagnostic: VI1PR04MB3055:
x-microsoft-antispam-prvs: <VI1PR04MB305556431475712931DB4AC899DB0@VI1PR04MB3055.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3055;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3055;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(8936002)(25786009)(105586002)(316002)(2906002)(106356001)(52116002)(76176011)(4326008)(14454004)(6436002)(6512007)(6486002)(53936002)(39060400002)(68736007)(2616005)(476003)(486006)(99286004)(478600001)(11346002)(446003)(36756003)(102836004)(54906003)(71190400001)(71200400001)(386003)(6506007)(66066001)(6116002)(3846002)(110136005)(26005)(256004)(186003)(5024004)(14444005)(5660300001)(55236004)(81156014)(78486014)(97736004)(2900100001)(81166006)(8676002)(2201001)(2501003)(305945005)(86362001)(7736002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3055;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UzbpL3bxVnjA4sRp4Fa6Pf6dlta14HAz739gxg7L0lfWyP3zeWF+48OdkIBSjMxooiuf03p7mTRDnIPFLAcwzlBJMRLC4QYOYsGzFJ1FBJDAiHUCg+z8CETaQAa0DaVsPd6dn3FVUEiwCcsbAD3jyYE7Hk7vzYEReQf2kqJK76D3mOo5MzCPVBDIphyvwWZK+Z42NNoOdxtg+IY4R7HqcsWshTNEh9pebJs3jyDKoxvRZ27N93g0gvUBM72OaX21DTZMMMcvu0gnlxCLzCsx2UP0zQPex98ZnYfFy4J8lKc9ieYXSwwei5kaBMtMBZY9g119VHbwvIjS9Zb6JtHojy297BrUVX0EKEx2xAi7vKw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b39f25-1999-4cd3-bdba-08d6503965c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 05:14:37.4331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octo mode I/O data transfer in spi-mem framework.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Patch added in v2 version.

 drivers/spi/spi-mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 62a7b80..388f849 100644
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

