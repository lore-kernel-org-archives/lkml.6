Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB61C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8C42081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kWtyc6cI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfBDKJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:09:27 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24492 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfBDKJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:09:25 -0500
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="23387561"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Feb 2019 03:09:24 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:09:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWHKIK4fFjTkNuJ6sIdaTUYwPTegVccQ7ogOIV84gQg=;
 b=kWtyc6cIGvIrwYDfANcRwZCVC9eHjff+5BM/yaIN+BT6kl2alpGKnWAttVUh+YEQxi+VhwxBKjpB2DB2PzHX0yTFHt8Fi+5mX9iqUCSkvcKvy0ibxSLIPbHsPVTjpKlLtp8VNPA+T7obEaBxw6S7kl3bjRTkI8qNfwFC3pmiaAU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1473.namprd11.prod.outlook.com (10.172.21.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:09:23 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:09:23 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 01/13] spi: atmel-quadspi: cache MR value to avoid a write
 access
Thread-Topic: [PATCH v4 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Index: AQHUvHGzRPeVO5Si6USSpYr2BTVPaw==
Date:   Mon, 4 Feb 2019 10:09:22 +0000
Message-ID: <20190204100910.26701-2-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190204100910.26701-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0270.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::43) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1473;6:aPUXR5tjg2tH3OAmjHaZvqeqr2LGGV0eeiyyV9FP8Q7FVyGHVBKm63kBiKmq0WuQN2g+wRp1OQ3JHDHfpe/OXnrjvmhlP0S5y4okhYPov+8jHBViB7HI6ice/4ZZok49gdtDMcMp5Ipeyhfm+EpBJkI7IsD34SH1kTGzM5gkoUM/Q55MO3McITC/NpwLmDo+0U4eWHLcjWncBMDwtDHiVdvkx0YecuW5NTMdu7N+gYcmbyQgsIdcOlDAphuV3csxkap0XKHyQqCmbE2y2hAWkElqtAvdFUyv8De5OpSLf/22BqKKzIuzE8xulem7aOAHVTTjhDaS3S118hT6emVicZTxuet4D3rd/jsDCHOQL93wt7H4URXSNzDQL5S34PlkbI31uySUCHci2n1JeixMZnQOI6u7jZU/NUGGAboCSXHr8itMTQSbmH7j1U8FxysLr8sF6i77oqHVda+/kdqY8A==;5:W9fEJB96CvoFUi3G60+3e+iYowS4lkZIVlEmoZ35vBi05nNaZY8PaPsASwBaURg7v8zCnpIVcO66R+ZVsLi84CtMMRZcMKconyGiTHUqjCbFn9K50wo6ThB067+xA0cYA7TohIfqe2heyM9KWC333VWBTCd7c0Ago0uPBKZ8FL4fXnnQXUqdphoI870N9veGLz0+g2MJFkOP7KxPuqs6Vw==;7:wV+fdxcfinPV+l3T0vZVZrDJrLxKarf1tW25t7hdmWkjaRQhqD8u3bj633m7OBOzDeAeJgwIv7kTnK/hAvcwglmITjeIdl4N/yjyb5BolOMDqQu3/XcwattAjuI8ZDC36MRdBn5mxY1rBdxnVeVEfg==
x-ms-office365-filtering-correlation-id: 0fd42ea1-2271-4595-9e3e-08d68a88d5ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1473;
x-ms-traffictypediagnostic: BN6PR11MB1473:
x-microsoft-antispam-prvs: <BN6PR11MB147348383C87A78474627D99F06D0@BN6PR11MB1473.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(52116002)(8676002)(478600001)(2906002)(26005)(2501003)(186003)(50226002)(53936002)(4326008)(81156014)(316002)(66066001)(8936002)(3846002)(81166006)(6116002)(1076003)(386003)(6506007)(106356001)(68736007)(6436002)(6512007)(39060400002)(76176011)(102836004)(107886003)(71200400001)(54906003)(71190400001)(105586002)(476003)(99286004)(36756003)(7736002)(14444005)(6486002)(97736004)(446003)(11346002)(14454004)(2616005)(86362001)(305945005)(7416002)(256004)(72206003)(486006)(110136005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1473;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TnSCwZ0JXxklfTLhPPkmMPRO6yrP1ZVGzCJuvaFZajVJ3HYqtv6AJKlpG27CxIsmWmohUowmHXwKewAWQ6SMNMNOTyaimexiqpivrOI5+M99UGn1xAvr70GbXAQe4p63NUn+Mqk4gmzfuznjh9JvGF7LzPRmjtv1NIdnJWVjqSQOcFOW9Mkj0RnVW3+WOEZISgC4z3bFc37NUfXdLqBiPqDq0zM1WuDiC8a4ropXkNSeCuJIQvBOZsrAdISbeQGGT+DdwO1uy3rBzfPduHqU69ZD89ycfSJ/9Wwjvg15xMXpaZ4tQHbK0uorvZ0i3HuEgHtrwaJo5E2xBGS3BfkowH3eRobhD4gwtQNbv0+0N1DQz53n7kiqcsYe1zzlOkbyQVphLvnB3BcDsRsqI48J45Cr3sGaNkbiUzMoYXNKDzU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd42ea1-2271-4595-9e3e-08d68a88d5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:09:20.3187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1473
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Set the controller by default in Serial Memory Mode (SMM) at probe.
Cache Mode Register (MR) value to avoid write access when setting
the controller in serial memory mode at exec_op().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v4: s/smm/mr, init controller in serial memory mode by default
v3: update smm value when different. rename mr/smm
v2: cache MR value instead of moving the write access at probe

 drivers/spi/atmel-quadspi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ddc712410812..d6864d29f294 100644
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
@@ -238,7 +239,14 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, con=
st struct spi_mem_op *op)
 	icr =3D QSPI_ICR_INST(op->cmd.opcode);
 	ifr =3D QSPI_IFR_INSTEN;
=20
-	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+	/*
+	 * If the QSPI controller is set in regular SPI mode, set it in
+	 * Serial Memory Mode (SMM).
+	 */
+	if (aq->mr !=3D QSPI_MR_SMM) {
+		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+		aq->mr =3D QSPI_MR_SMM;
+	}
=20
 	mode =3D find_mode(op);
 	if (mode < 0)
@@ -381,6 +389,10 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 	/* Reset the QSPI controller */
 	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
=20
+	/* Set the QSPI controller by default in Serial Memory Mode */
+	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+	aq->mr =3D QSPI_MR_SMM;
+
 	/* Enable the QSPI controller */
 	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
=20
--=20
2.9.5

