Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C44ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22BE2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="LFqJqUuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22BE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeKHUmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:42:23 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:33459 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeKHUmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:42:23 -0500
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="22538410"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 04:07:26 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 8 Nov 2018 04:07:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujGeNwKnBBNth9TQEarokvBHVcrIHUBSuqugoirl30E=;
 b=LFqJqUucLxpQ28sSQxsZZvRCrtr4qplorYQ7toE6FdistWGP4g2dmYZB76YsK84WZOFHKzHni/fuRuC5d4QM5dNt+DCqoiN0XSsvrg3EoeUffSPq0Krld8vi1fzOJBrk5zkrL/jLKvfP2qbBaoZOOcyRP8yNKyaeCgUY+I1KtmU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1396.namprd11.prod.outlook.com (10.173.33.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Thu, 8 Nov 2018 11:07:19 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:07:18 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 6/7] mtd: spi-nor: ensure memory used for nor->read() is DMA
 safe
Thread-Topic: [PATCH 6/7] mtd: spi-nor: ensure memory used for nor->read() is
 DMA safe
Thread-Index: AQHUd1M2wAqiY3uSNU+NjW/xsbm74g==
Date:   Thu, 8 Nov 2018 11:07:18 +0000
Message-ID: <20181108110653.21063-7-tudor.ambarus@microchip.com>
References: <20181108110653.21063-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181108110653.21063-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0401CA0009.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1396;6:s7di6cv625aeH+0da3i1SAQ384UE5P3BmZWsa/PSmpyMuxxW6oGyh6tyzyi6LivaZh1S3kFeja2pCUB9CMSKgPhBwNZol5NHNl4HF++GL0ErOlh4RGbK1HGXde34MpDfVepTXJAGQLBC6Yzv5htUk7gFsONDxHhMQgJZuil6ZbbUwhma8E99bNm1hfd/3tBpgCAdvXJGPVJXIT2KTWaA1pgDcPWV4DyXZMkmyUjpuCU7wEx6hzBjcersj2vYCVWeFtMtcM3Nm5I/NGS3C3QqxmSn8jDYZ6Gbf/eCXRPllaMLgSN7QqB836dJldorbKHMqCSvlPSYDiGTQF4Ab9qp0lE3Jz/OD6L+YPEuJW6avnHJSVbEwXC+7/pNdJl93aaSvyF9P40AOqfZ1GyGNlnW43Of5gVs8UiTPgqgxH7ne/uuCl/dA5Pb1g+4A+P8+daMr3TgdwPvW6Ik6vtrngw/ww==;5:dHgUkgmXjeZ/2lZgUOk9r0bZXNc8LjiDoWpR5VG6fRd7tq9lDpbJwrEFAOjVsIGa3L/ciyx4odR6Zbn6fLhn7ESvEvGvPndIz8E+K23QBCCESdnkSTjXCercgLzcjsdtwjaAabxnOf/jPy2tSgQbkpGcg8TlzhTEhkkzmz2GNMc=;7:honVUWZ5ukL5LJ66iZzJgAX71XbMMhNqiynPn+sjMRpStp17lbe1ILXEUSQ9gT+XcErWcRc6UAYN+UFfg2jcUYfRs+Nq5WltXHdi6BCHRg10lbVzAQ7xetcr8y8YTnSZXG1tLPpjy8Og+LFhl4FkMQ==
x-ms-office365-filtering-correlation-id: 0342f76e-9a24-4652-9a25-08d6456a5939
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1396;
x-ms-traffictypediagnostic: BN6PR11MB1396:
x-microsoft-antispam-prvs: <BN6PR11MB13961CBCC57EEFB82D4F2CDEF0C50@BN6PR11MB1396.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1396;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1396;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(25786009)(99286004)(2900100001)(6436002)(4326008)(2501003)(76176011)(5660300001)(8936002)(1076002)(6116002)(3846002)(478600001)(81156014)(8676002)(81166006)(97736004)(2201001)(52116002)(86362001)(39060400002)(66066001)(53936002)(71190400001)(72206003)(71200400001)(107886003)(6486002)(305945005)(14454004)(7736002)(6506007)(186003)(256004)(476003)(386003)(102836004)(105586002)(106356001)(26005)(486006)(110136005)(6512007)(68736007)(54906003)(2906002)(2616005)(316002)(36756003)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1396;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MFBS/j63ZVHIL8mrZkJcHNZ32MFZagau0pMhFzNIIUAYhLXJdjdHUtX3soZc0t3nmkDqJGektmpdJLd9Z0q9I+sho8OB3p/Xy95AcmjW3zRcvEMgjul1egXPID0ZHAapzVWF71jTAqQ2mpPylTaP+6X5h4t+aDMWGZGCScOE39TgHwo6esNZ8C2jdyCXUJiqOXtt0/bLgQT67HxzeFvXGg+wnscXMaKQBHf9mY6JJ4S+ZK5ysgK40TAmLTjA71pk3xScd3LdXWYGc5e6FFL8rsdrMitXkDpbdUo/mfBbwxy49hGba4nNrS7sBOxrJget2VJ+G4xZmD5SIf/IwQWjIkFXpbKGRt6HXXwgodgknAE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0342f76e-9a24-4652-9a25-08d6456a5939
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:07:18.9124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1396
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GFP_DMA to ensure that the memory we allocate for transfers in
nor->read() can be DMAed.

spi_nor_read_sfdp() calls spi_nor_read_raw(), which calls nor-read().
The latter might be implemented by the m25p80 driver which is on top
of the spi-mem layer. spi-mem requires DMA-able in/out buffers, let's
make sure they are.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 2eaa21c85483..a13fc82bade5 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2238,7 +2238,7 @@ static int spi_nor_read_sfdp_dma_unsafe(struct spi_no=
r *nor, u32 addr,
 	void *dma_safe_buf;
 	int ret;
=20
-	dma_safe_buf =3D kmalloc(len, GFP_KERNEL);
+	dma_safe_buf =3D kmalloc(len, GFP_KERNEL | GFP_DMA);
 	if (!dma_safe_buf)
 		return -ENOMEM;
=20
@@ -3053,7 +3053,7 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
=20
 	/* Read the Sector Map Parameter Table. */
 	len =3D smpt_header->length * sizeof(*smpt);
-	smpt =3D kzalloc(len, GFP_KERNEL);
+	smpt =3D kzalloc(len, GFP_KERNEL | GFP_DMA);
 	if (!smpt)
 		return -ENOMEM;
=20
@@ -3140,7 +3140,7 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 	if (header.nph) {
 		psize =3D header.nph * sizeof(*param_headers);
=20
-		param_headers =3D kmalloc(psize, GFP_KERNEL);
+		param_headers =3D kmalloc(psize, GFP_KERNEL | GFP_DMA);
 		if (!param_headers)
 			return -ENOMEM;
=20
--=20
2.9.4

