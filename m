Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E36C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147462086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="McbuRRpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147462086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeKHUmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:42:08 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50301 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeKHUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:42:06 -0500
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="22845569"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 04:07:09 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 8 Nov 2018 04:07:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASi5Fmj6AX0Q6OYYTUspcMMb7NDI/ZNaJaRtYs+wyiQ=;
 b=McbuRRpf/rah98GpT90x4ekVFIAPIP8dwWlxsPKSwOZs5c3mdMi9F15zCnOokjHnTUawZkaX1KAcRdJpOFK3y3X+NPhdGG6b+XE6Qba489px8wLVCiGLnfXu+js/+vx8k9D+ksAPAG73c3DETnq6hgmTPmrIc2+hqqR1oo22ZjY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1987.namprd11.prod.outlook.com (10.173.32.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Thu, 8 Nov 2018 11:07:07 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:07:07 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 1/7] mtd: spi-nor: don't drop sfdp data if optional parsers
 fail
Thread-Topic: [PATCH 1/7] mtd: spi-nor: don't drop sfdp data if optional
 parsers fail
Thread-Index: AQHUd1MwxOj+DG4k4UK2QltFtrMtEA==
Date:   Thu, 8 Nov 2018 11:07:07 +0000
Message-ID: <20181108110653.21063-2-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1987;6:TaKQJUDG6O+LzYrGQFK7KB2DG2fCwZyVos0FE8prinCyk3FD6mz6SoFtb61KHSV7AeVEsAUfUR9W3Nd0a6jqmraRNByTRjmjyEGQslgWQn7wghbZEAOmsfrK60ro2iVkKem8huiVo1mGOwFnYvD63ccu0OCHZYN6fl6sMRsDDkvYe6xYrq+fOC5QapxPZZMa0XnTmJBDyo4zwat/EIKIVFyhg/RR90PchfJphRIdk4Njck+h/z/SIBaJvvRlxAchWg5JO6IB1sOU+Q8N6AoINBW7A6hR+SURep4xo7c6HocuTc6C+5/3Lx0pjOa8XFpZWxi9DUOnVmpJgcGdpZ8S9R45ZTPLK6eMS5AC7iC9i8T9xf2NcUTUyJOsxq37+H8Yd7WOrPO6JmbXDkfdMlTwuIhJmjFNe2mG2P7Gii6/Nuz7Mp2DAfqAA3ML8M0wdIpCkLf+0wNJOo4fOpvTHuanxA==;5:/BSWn2yChk/QhxPjQzSN4UFFhboHPJyulLdBN6nYsGsZnB+/MGPNO6ZI/RcswJ0Pc7lFKy0Q+kq8rmTx3uZEOPLNoPJ0yRlO0L1oHmvVDQWtrY2VtM5v6teMMTTo4rDDPCMiLy9ohxNr39F7j7W4o5bBMVpwGYMuVrf2I4LaSGs=;7:LTLHcnUooWgpRtHECZNisa8J4lDvrJ14Sa64hcKqSDfvcSon6hLubOKUDLukoFSP/UXhXmbDEO3SJlVE1dXXyhKLDGzJSmmO6qr4MOy7DtK7QlDl8/7llc6EvnsE8syBJOP9sx1i/3VtPbhZZGC/gA==
x-ms-office365-filtering-correlation-id: c95ff61e-e1a9-491f-8d51-08d6456a5250
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1987;
x-ms-traffictypediagnostic: BN6PR11MB1987:
x-microsoft-antispam-prvs: <BN6PR11MB19876D368BCD4F5384B9AF55F0C50@BN6PR11MB1987.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1987;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1987;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(72206003)(8676002)(81166006)(5660300001)(81156014)(102836004)(14454004)(68736007)(305945005)(26005)(86362001)(1076002)(2201001)(39060400002)(7736002)(8936002)(2906002)(2900100001)(36756003)(3846002)(6116002)(71200400001)(71190400001)(107886003)(97736004)(6436002)(6486002)(110136005)(54906003)(2501003)(2616005)(11346002)(446003)(99286004)(53936002)(6512007)(256004)(4326008)(478600001)(66066001)(52116002)(386003)(6506007)(186003)(25786009)(316002)(105586002)(76176011)(476003)(486006)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1987;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bsvhDtt27wTyHfuSk0y0GECdMkg2V5OTM/EDWcx4Q1qIIhl0IbsDTaM6IfhCRzOIVISe1/Il/pMO2SGt/l0qE0b0FxO57dZYYTZ22qUsQ5+ryFC0T1d+DTnS1CHKiOOuyYrbHmbICdacUPtItGOvpAQj0zTgNQoLbg7CPjJCH9HKnY06fDsHrYbwzsge+V2eWbNUozi1s3loDl2wfLBJSiwmkIw2K/alIW3ERSrQehN2Ey+DXG8kYyC80NiP39UKh5mUSY0IUy6QzuAxnJfZW+92puBP5WFM1fwmdEKFTHUb5C1llGgV8ToFycBSlLH1M/SqfVqe29vDgXVdEi2wlol/prlLeFduA2Dva6mBJ5c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c95ff61e-e1a9-491f-8d51-08d6456a5250
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:07:07.2847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1987
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JESD216C states that just the Basic Flash Parameter Table is mandatory.
Already defined (or future) additional parameter headers and tables are
optional.

Don't drop already collected sfdp data in case an optional table
parser fails. In case of failing, each optional parser is responsible
to roll back to the previously known spi_nor data.

Fixes: 5390a8df769e ("mtd: spi-nor: add support to non-uniform SFDP SPI NOR=
 flash memories")
Reported-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 4a96ee719e5a..2cdf96013689 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -3130,7 +3130,7 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 	if (err)
 		goto exit;
=20
-	/* Parse other parameter headers. */
+	/* Parse optional parameter tables. */
 	for (i =3D 0; i < header.nph; i++) {
 		param_header =3D &param_headers[i];
=20
@@ -3143,8 +3143,17 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 			break;
 		}
=20
-		if (err)
-			goto exit;
+		if (err) {
+			dev_warn(dev, "Failed to parse optional parameter table: %04x\n",
+				 SFDP_PARAM_HEADER_ID(param_header));
+			/*
+			 * Let's not drop all information we extracted so far
+			 * if optional table parsers fail. In case of failing,
+			 * each optional parser is responsible to roll back to
+			 * the previously known spi_nor data.
+			 */
+			err =3D 0;
+		}
 	}
=20
 exit:
--=20
2.9.4

