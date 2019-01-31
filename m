Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE795C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF742085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KZu92Hi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbfAaQPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:15:33 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:10133 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbfAaQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:15:31 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="24072842"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 31 Jan 2019 09:15:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebZoX02BIUVl/c7RPJ/TiAnts4tU9d7VKoLF6wM4x2Q=;
 b=KZu92Hi1MgMl+8MDZ+BBjbg9PhK7FTWBbARnkHcKwsq4ZrC0ImSy5S/n9E69IuR7Z9OH0g57RQcOVP5GDGvsZzbAVvVp9NtDiXcQCpL1X0TAB755lwheN4BJ/FOB1O0G4E17k167tS8WgfvxNsXnii4NWtAuSeodmBpC/v0B91o=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1874.namprd11.prod.outlook.com (10.175.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 16:15:29 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:29 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 01/10] spi: atmel-quadspi: cache MR value to avoid a write
 access
Thread-Topic: [PATCH v2 01/10] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Index: AQHUuYAu+viSD5s94E+u9UEZBRyorg==
Date:   Thu, 31 Jan 2019 16:15:28 +0000
Message-ID: <20190131161515.21605-2-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0046.eurprd02.prod.outlook.com
 (2603:10a6:802:14::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1874;6:BzLNUzNL8RZusRCyEOH7UOV2/cCumLRKc2LZF0IFI67EtzGiX2b2T1LJ2b1qusxQWy8/9u9YXOEe9m8fXmpTwbFskMm7x5Sy7IA9w/njmsfZL1uozURLd27134zj7x9/l9USKu00xlzJn2iUc6k7EUxrQWB926AqtlQ5MGNDedOL2uOfDCeqBV5u2q/CkISaMkTWinnjbf7+QF1i0oWc3/WGxISa1ZQpI7P0U6LS7Okmc8QKcnVr4nWLG6eu+Qwaps+mGRUy8USMkzEsWqLy9NyYcGbMfTSiKc25DoFTXXb1FYsnVJB9eohEZdNuqaaSPx5tNlcNPLplt3+EesGBCfUB/I1oE81rNrbf+KFubR1ZHglifNMA3e0SDkAJ/V4uDxI1d/x3FIUz9HAMwg7ywTwrY/Z46jbJ+jNcuHT16ENE+n6YgHtA7hlrk4szL61tvxjwFHNG7EwuMB3jC75OhA==;5:3UQ5NSXUqZEz4Gw++kdvB1GeSrItnwAaxww7b+bIu8enscOeEqLxJ3PST6Htlgb7nxVNipwQyV2SIQXaKG4zb9YdR6ifX3qjVXr75pImwG5whtgQBItRc5Z6LEVxiUkcCmK3BT//GNB2g02VU6KUOPjbGNWmV33mpXHsGEvdFivp3XSUiH+67W6jwRxtYecT3o4obfYulM/bfIL5bW/1nw==;7:UU1Jmv0ePdPaTYIfwp/TJWIz6F96g8fbItbPRC+Mb9FX1Ci8fE8eNZSSmlP6qzAwvbEKDKuKUSe93PBOk5n7D7CLfyTfAA6E+nV2zhOBLcbuv3dAKQBLcXfudmiLJN1SpumrI+N5dGHAOPPWl/lPEw==
x-ms-office365-filtering-correlation-id: 0c971f3e-7c53-43af-9658-08d6879750e9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1874;
x-ms-traffictypediagnostic: BN6PR11MB1874:
x-microsoft-antispam-prvs: <BN6PR11MB1874A4CFE3FA3123E60D3086F0910@BN6PR11MB1874.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(186003)(107886003)(26005)(4326008)(68736007)(97736004)(14444005)(72206003)(478600001)(256004)(106356001)(105586002)(36756003)(99286004)(54906003)(50226002)(8936002)(7416002)(6116002)(3846002)(7736002)(8676002)(81156014)(81166006)(71200400001)(71190400001)(76176011)(52116002)(2906002)(1076003)(305945005)(2501003)(14454004)(102836004)(6436002)(66066001)(11346002)(446003)(25786009)(476003)(486006)(2616005)(110136005)(316002)(86362001)(53936002)(6486002)(6506007)(386003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1874;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LqntUc5PA8+tCcRQKvjllraJlLQwIWaXFeNitnWXD70kd5g7VfB1YIO1ixhiSTS+Rhxr0Mq8MZWlXw/yJD1e6DiGvp1wneJnzm3ZmcRv1IaIH5inszah1dTfAj56CyJG+cJkoBLa+gX7+ClfQOCOvpekX0qiNfzmFOR9DBobYbqZ+Lw/m+UTjvO4tPpAjL1tUxz5dZ9WdKevrjZY+uzi+IGBOgSVfWkAy+/UCQ5P9JUlwoOqedtvMln7p0eAHAkgG7NzxXSsDVUPnyd2nRcfB+/K4BzVqAXHlKCVKa5T80P/NAw0cc1Hb6l/vdCLTvsvDvgnxtCkh8b8GkqrpMivNppp6zAAQwjfYlVSJere5H44KIx/nzNbivEJT88hhstDIfCKhjkK/yx+tVEW+1c1u1R+SSHoUhkMiqqB7pdTRYo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c971f3e-7c53-43af-9658-08d6879750e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:25.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1874
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Cache MR value to avoid write access when setting the controller
in Serial Memory Mode (SMM). SMM is set in exec_op() and not at
probe time, to let room for future regular SPI support.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: cache MR value instead of moving the write access at probe

 drivers/spi/atmel-quadspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ddc712410812..fe05aee5d845 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -155,6 +155,7 @@ struct atmel_qspi {
 	struct clk		*clk;
 	struct platform_device	*pdev;
 	u32			pending;
+	u32			mr;
 	struct completion	cmd_completion;
 };
=20
@@ -238,7 +239,9 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
 	icr =3D QSPI_ICR_INST(op->cmd.opcode);
 	ifr =3D QSPI_IFR_INSTEN;
=20
-	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+	/* Set the QSPI controller in Serial Memory Mode */
+	if (!(aq->mr & QSPI_MR_SMM))
+		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
=20
 	mode =3D find_mode(op);
 	if (mode < 0)
--=20
2.9.5

