Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83FDC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFFB218F0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="k5ec38+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfBBEHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:07:17 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:28843 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfBBEHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:07:16 -0500
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="23335987"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 21:07:15 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rxlCOv40W7jFAfqNY4lvVhJcaiajAM9zDTOjWkm6sU=;
 b=k5ec38+xq9fHgAlYGfhCq1aQpoQYz72qgmhebRdpmSyCKzUxbED2bs1CsMtSXeHGnvjeNJrolMthPFWHSFtQMNMTFP1seVrEMxXfrWm3KdH1QwsNuzvdJ9GJUi4KnsaNHthbZQw9umeyy2z5eRGSxmlDtz7lo+nSuO/oqgG00Jk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1300.namprd11.prod.outlook.com (10.173.26.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:13 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 01/13] spi: atmel-quadspi: cache MR value to avoid a write
 access
Thread-Topic: [PATCH v3 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Index: AQHUuqzGfGfknscimE6zODgQQX/E9w==
Date:   Sat, 2 Feb 2019 04:07:13 +0000
Message-ID: <20190202040653.1217-2-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0062.eurprd09.prod.outlook.com
 (2603:10a6:802:28::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1300;6:FjPg9bQQXdLxRWflJHRzEwnZVvhzor/SCAoI86QAqjTHIUiG9/vQHO4fXIhCTbA4f21fGCZAWUFZA6Z1q77rmPGf8NLoL5IKrcwhg8DsBYIGWyX/3J0Bs7BTXXy+xQDTelmF2EmEDXqf9tU+yzoo006O4+myo1+aZMk0S2Yl9xkTeBUbdwETcO6XmYeFLIWL+o5Cfm40BB+iToEL9+1bP4vhtdx4TDtSMbZG4f70jGTuklfNV44Qz2Ef6Y1dFghmkW6NBYciogwAOx/8EzM57xuDSQpYwySKgNY9wjXKAjkC7reRGOyMVfnop+TwMLnDxSY3rcZBsL8mwVOIxRa8jQbKYWDgmu7nlBEhZVhRGkIg5hu7nzhXH3pQj3nhp9n6IQ5yqa0awHks+l8GrKAGzCa9DeLkcCtoGXMJVSxX89qGoTTO4SWbaWWJkWzAvbSXTNzZySX1UILhqnRUGRseoQ==;5:ZAInrhYkqmGNH3MF6MTbcgREKWZ6I0SYPVqcN8USTR+H5wu2n4oRFIyoOeEHiDVS27LbaRU29eZlaJD534FkGBuLurmJbm4a+XNCLeu2jdkxlWts5sOg8qs1rCg+sGauWfRSwf71XrZvt1HSuO5AZu+wi856TEWj2DfOn469U9JSljeFc2jyB9kCFVgyTzNuYns7ZVTHiKdKlT8p2Xe1Aw==;7:dW6uFLFtCbzxb2btsK/FiedtQP06khDo4+LdrdxJJFNfWHGLmHPDGRYGHFZvIwZkW+WHLUndx+taw8tuV0PxO963m+klAvgija08KAQIDy5CXkkQ4s9N/miKIvlgdcgRBhE+ZShdF0kWeIUoYYAKuw==
x-ms-office365-filtering-correlation-id: 01cc9d58-3a81-42a3-abe7-08d688c3e927
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1300;
x-ms-traffictypediagnostic: BN6PR11MB1300:
x-microsoft-antispam-prvs: <BN6PR11MB13001EC8308535D2CBDF0D81F0930@BN6PR11MB1300.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(14454004)(52116002)(50226002)(105586002)(6436002)(102836004)(72206003)(81156014)(81166006)(2906002)(26005)(7736002)(478600001)(3846002)(6116002)(53936002)(256004)(14444005)(106356001)(8936002)(68736007)(36756003)(97736004)(76176011)(107886003)(4326008)(39060400002)(2616005)(99286004)(476003)(446003)(86362001)(66066001)(71200400001)(11346002)(7416002)(71190400001)(6486002)(6512007)(316002)(110136005)(1076003)(305945005)(186003)(8676002)(2501003)(25786009)(486006)(54906003)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1300;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kVHmo5wh59+ZPJbuyFsGJiwrDhgzUre3FdP9PF44cXK5oejCu6wSGXHQ4YhOplSWmnhC3iJz2/wduUAMpwJT75is+uC1eVuU02EsiqvWAc9i5wa/Fb5pcw6+iE/qI9Av8LFPtv7IEWu2Nv4qFePfY/jpdehhsFuniN9Roe77pmY+3baD/r7cbBMqmC1Td8tXt11gCP7tmHLpPJbWA4bS9/zuNNUs6A0xTjqN8Jo1FLcVn1s/m99nU1kizQUrKhzs31WnOp4y9X49LIVrorRZeMm3ao60Evf2Z5o20LZYpDobvcaW+z1Gs/IAtgw+BwvsYYwr83GOu3B4uQ+Z0SQBg2YgDBLGd1VOp5ZB2CF98YS8fnfvHkDiTUvhtAcVXvI+la+ArSWFKSaOaI3z9JbMmWEVtWVrow8jqdRRwpxTfAI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cc9d58-3a81-42a3-abe7-08d688c3e927
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:11.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1300
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Cache Serial Memory Mode (SMM) value to avoid write access when
setting the controller in serial memory mode. SMM is set in
exec_op() and not at probe time, to let room for future regular
SPI support.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: update smm value when different. rename mr/smm
v2: cache MR value instead of moving the write access at probe

 drivers/spi/atmel-quadspi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ddc712410812..645284c6ec9a 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -155,6 +155,7 @@ struct atmel_qspi {
 	struct clk		*clk;
 	struct platform_device	*pdev;
 	u32			pending;
+	u32			smm;
 	struct completion	cmd_completion;
 };
=20
@@ -238,7 +239,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, con=
st struct spi_mem_op *op)
 	icr =3D QSPI_ICR_INST(op->cmd.opcode);
 	ifr =3D QSPI_IFR_INSTEN;
=20
-	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+	/* Set the QSPI controller in Serial Memory Mode */
+	if (aq->smm !=3D QSPI_MR_SMM) {
+		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+		aq->smm =3D QSPI_MR_SMM;
+	}
=20
 	mode =3D find_mode(op);
 	if (mode < 0)
--=20
2.9.5

