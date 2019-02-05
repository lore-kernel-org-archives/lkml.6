Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C42C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B19217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="YVxaFcY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfBEPnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:43:14 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27276 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfBEPnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:43:13 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="24251437"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 08:43:12 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 08:43:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvaFAVtxh1FzCS9vTA5F9tv8KSJbbKczIA7KA0A8KUc=;
 b=YVxaFcY+kah1Yjcvs4BQeLbm+CLqp3Wy8mojR6QSETH8GfWBKdNkrrBev6dByfdX5XweS9i4k1R05eH5UHyy5T9kP8cCLoSARie6VB6g/RhZTkLtWtJa2bbjT0lp+Br67hLYZJJ4q/UtcLiQgeFy3wqd+McpB29hEBf3Lr0nb5Q=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB2019.namprd11.prod.outlook.com (10.173.27.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Tue, 5 Feb 2019 15:43:10 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:43:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 01/13] spi: atmel-quadspi: cache MR value to avoid a write
 access
Thread-Topic: [PATCH v5 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Index: AQHUvWl/HvQyFcNUUkq4L8FUfCKzJA==
Date:   Tue, 5 Feb 2019 15:43:10 +0000
Message-ID: <20190205154257.29529-2-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB2019;6:VOytPV+hvnzmPI0U5oc0/lWquecAzS5Hq6E5QyD6YQeL/4qy5Y1GlFRSl205HBwvjfRXW2ZlAf1nYD9yyg8BiWBNtPrd9h4JX+/gwQxdnHFsf35mD2ydeA3DPDekGd/8y++vKbEYopnlhv7Q8nydr6l/Rl+Hz7zm9/zyOw1lSpRvVIfXXzn6PkRKETgB70Y4CJNloOz4Xh0MT8cu1O62oeCBt1sXF5pyVwvTqKKFK0eI8dZBKUgQ/79+ztdwrG2UNJ0VDVL5uC0n/fpD4IwqTcibXF3yWV6vgMdYX1AgAuJyALrNfPyjCqa5Pk6VWLgIZ465najy2eX8jwCX2mX+yXYXPuUa0lRcTFsXlX5Orc37Cm6BskXTNquiIcV7txwUpZCt2xi1GrPkJzUWAsyQFylD9CkMb2pcQ/6JF81nwJDOhpwYlYDjH+Ngvp0xKGtG2HtlbhD7DhNSxSHK6kgLow==;5:sqk9aBC04lt9ZE0EyGWWWwXHW7s7mO+PhAoE+31lDIXy3UwEMeRz3qWYplRlPMhf07VTEZ3vxDAmrBdtgzwwRviMJbZ6frZVrt+lpYrxHKKDRR6qOUsiiXzSl+BKSoku0OCQn/UXJKFCX2+sSs1Ymb5x7MvVwOaOaJPjFr4iu0u+AwXU/Vs5BeR/qwzXarCbdKSH0mWc635DFKkcUUmJDg==;7:v5vRr5pTQ4OwLKktknAw2HHp3h/ByL0+Q6ihR9XR8rRVeUzcCpVGUALob5/0GHvXS4DvdtfJrrL+3XtvZppK2XlB4HxSFOHstyg/4zERLyabfxkAv5BEsNRVFM9aE/ftICs4aACQ31wFYFmbZSa6rQ==
x-ms-office365-filtering-correlation-id: 02a8755a-57e7-494d-1de3-08d68b80a183
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB2019;
x-ms-traffictypediagnostic: BN6PR11MB2019:
x-microsoft-antispam-prvs: <BN6PR11MB2019E916C70FA84658D89992F06E0@BN6PR11MB2019.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(366004)(199004)(189003)(7416002)(72206003)(478600001)(8676002)(81166006)(71190400001)(71200400001)(256004)(14444005)(97736004)(305945005)(186003)(86362001)(6486002)(53936002)(52116002)(2501003)(8936002)(6512007)(6436002)(50226002)(110136005)(25786009)(11346002)(1076003)(54906003)(68736007)(102836004)(6506007)(316002)(386003)(81156014)(105586002)(4326008)(106356001)(7736002)(486006)(6116002)(36756003)(3846002)(446003)(26005)(2906002)(476003)(14454004)(107886003)(66066001)(99286004)(76176011)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB2019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UQMelGuJzE/d1OvgIxHqwyIVKv3u1BQjy3HfmxppLcu9p9Ib70P4bK3PG3IOnUr7qTDcLjiY78Hn+G9v+WiPaAEgn9lhZRj4n4AG9MAqiPgDNxV9TDOjEgW25qzLIuWIcGWNwV7E3RMFW3eyaea/i9r/Rmv/OkiIeBejLlWBmEGBiIlGltoZwxVeQVFPglyBK+c1XhKJfQ1YPG5ZmYL5/XLUkjcoNWI6YVhWOKmMgfveEL5MEEAKp6/ZQNULgWd1lcke/VIv52ZF5VaYVMrN12yucwud13DAm781abEDUvoGKHIZ8UeYwICoVCdB/94Q1//0xq1aMY4vNJae2VtoCk7dLVIYyLWy77ZbwbXlB6v2NwDbrKshy4c/wXzItJHuO8D0yX10N3Qwt3qkDykBP0MuJKI+Js3prYoJES2uCOo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a8755a-57e7-494d-1de3-08d68b80a183
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:07.5301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2019
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
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
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

