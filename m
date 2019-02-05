Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD0DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69243217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EsmAUL1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfBERdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:33:11 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:61915 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBERdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:33:09 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="23466282"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 10:33:08 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 10:33:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx9hsF7hwtPJHAJm3dfQIvWLx/MMmmTqgNTWiWIKX6M=;
 b=EsmAUL1JOcCVBxSACuFg/Gf50/LsJ7JZzoaiNw+Zx7qP7F3fWpzaIRfwSF6zebfUY5tqThRaTlHFWC+lQp4IzkcX76djq2aBWe4GdbNGURRaJ85VYQuXgrHrJiS8Y13NVLReH62ft8mc9MS8w2YqB0xKhj5fhFq46f49ALMJ6os=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1681.namprd11.prod.outlook.com (10.173.26.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:33:06 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:33:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v6 01/13] spi: atmel-quadspi: cache MR value to avoid a write
 access
Thread-Topic: [PATCH v6 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Index: AQHUvXjafo7rsA240EGmjwHrAHFLbg==
Date:   Tue, 5 Feb 2019 17:33:06 +0000
Message-ID: <20190205173254.16388-2-tudor.ambarus@microchip.com>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205173254.16388-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1681;6:yx5PqbBVT+83Vmw+MY0yQim4/XfaDvSpf2uYn7z84R0g4frz9c96cgRCy5Y3/Xqbc730/IATUIC+fygYekoaGVjjtXDtHnORazJ847PD34X1DUdLQnR3EC3V2SEcnEIN8BJPR1c0nkV6BWAFqBuIO5s1VO0lwQOMj+hG/wQHcdojIlFJz1llM240p6L8nfwMRRjVa/zh6gEYUAb5a2XASJaavHRzPq4VNutCz3FtbKmA+iU69ZWG9vPvMURQlpRZzQTsHj3JRRqSvJeMMbMrNEgpDl1+67e51UfwKn3V3m6GEe/XadTEZIjjaj5KOImxCFr74HiKPJHjl+XPZgFwUcrJp5oMnza5CgaGuS0OArNF3TO/cuZOoh+V/7MOtwNF0AaJCWwrxDDoRrg+qdGhycgbPrPetRSrKW9VsmEwN/6HVQ+oXmg1xOG4xKbppEAnyOXXcClQoPgmIuK6qtuAvQ==;5:0wMKvItMKGgFuJQX/Z2GOBRj2tA9xxWUUPJtfOt6mUs5J75LEHpXh9YQ28NU4IcR97IBxH/wtFhSrRiqRWF5Sx4kfTkjdzyeRYd9xdm2fKzH8TRdu3yrLpJt8+dXclA42OKasSjfxcTg9a5IiolV08XvZaV84TbmDwJJmeY3GSuRAGy2ixYgBjzipWm8f1TtI3VfccR6zliVtKvbpezbww==;7:B4A7ZtWieig3OhJq6U3vMmBDD4ALq/2o0Sp3KQj8zxkeTyfdQ1F3htpWHFYzy4MwibuZRiPni/uTtbmeZBgTs9fXEXtZyf6bSLosMRhpIc/v1O/QS8tWj9QTubDCWhtCoq2oPScA6pK5ImDHTQqaiw==
x-ms-office365-filtering-correlation-id: b778c038-c14b-46a0-9bdf-08d68b8ffced
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1681;
x-ms-traffictypediagnostic: BN6PR11MB1681:
x-microsoft-antispam-prvs: <BN6PR11MB16819BFD9109648BE3F0CB0FF06E0@BN6PR11MB1681.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(4326008)(186003)(1076003)(36756003)(26005)(110136005)(25786009)(6512007)(316002)(476003)(11346002)(7416002)(54906003)(486006)(2616005)(446003)(86362001)(6486002)(6436002)(66066001)(478600001)(71200400001)(7736002)(97736004)(14454004)(71190400001)(76176011)(14444005)(256004)(52116002)(3846002)(2501003)(305945005)(99286004)(6116002)(53936002)(72206003)(386003)(107886003)(8936002)(106356001)(81156014)(81166006)(105586002)(102836004)(50226002)(68736007)(6506007)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1681;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 76DzDukMwntzdZ7gc6PvZQptNsXo8dE6oRi7tLSNbKn++SA34+AE9yxXRImDUZDAODNGkqZI1rJs5nomv0UImjEWWNB3BEdxZvPP2Jn1A379vzawertkIRCCuaxXrAkrcP5rrFSvswOGR0DN4laTmlGSluzix4gPMqVC+M6ND6yknjb8MCz+ojhYMMpNgemgtQwH76+dk+ep8WJYwBtUuAy26Dkzk4jKZwCVq4j0hAjoUKC69AWzLlJZcl1bs/L2cF4zI6JPuWvh7VASUZhXLeCxyDAqtcYHWUTXT3wVfRgI3SX0bz7bjJaksd/Rp8gEFtH/NheMYwjTbwXW3eJnzexJZfmDhOd+y7b8XYDUJbRHKYQ/IEQxDcgZzYHQcn1fAk6BnfK9SL3EWh8Dv2T7U6A6eci3P+rVk0+MoS2VCYE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b778c038-c14b-46a0-9bdf-08d68b8ffced
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:33:03.7909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1681
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
v6: no change
v5: collect R-b
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

