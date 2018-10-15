Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4162AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF43820881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H0qpy5ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF43820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeJOTdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:33:32 -0400
Received: from mail-he1eur01on0082.outbound.protection.outlook.com ([104.47.0.82]:1216
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbeJOTdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zo8AWgVIPohKPkaxItV4rZx7dVTrfVzyCBq6uTe+8U=;
 b=H0qpy5utFgrea78jUwxQMgChK7RLCwHqqeOhredELSsIMS/M544DAbzMw5/p7bnVJYQje6ID7toDLje+GuOae69c8gL2mUhhlAruOC/b34DDFHELZzxC1tE0ZxGsinBg3nozRtYF65d4gVan1LcJAK4Dux0W+2DfGkBRpcSpnvc=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (10.164.84.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 11:48:31 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 11:48:31 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
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
Subject: [PATCH v2 6/7] spi: nxp-fspi: add mode flag bit for octal support
Thread-Topic: [PATCH v2 6/7] spi: nxp-fspi: add mode flag bit for octal
 support
Thread-Index: AQHUZHz+LQlNXeoqgECfJrRyb8GFHQ==
Date:   Mon, 15 Oct 2018 11:48:31 +0000
Message-ID: <1539603969-21076-7-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1616;6:JzQlcuGnTGO+EXJ6Pqkun0kLJhRXSneq89uTC/qjLfxXgT91SrnPeOmmFcj5bP6EkOMYaCc2qjtY95wQlb2HytQEfDH/kcZ2ipmFI2ldwK4ccmhWTxj5YLr85fwXXMg23d0UOburYSrJhBOnMdHUGKc/G+LRE3vO43RYo4mK5rh6cm2a/YICyVGhjh2Xk0d+V5jZFnCGmb93KbMveRbw4Bw/9NeySVrr3GVTPb8JHyTBALEHJ7czXMmlvtvbIf974yoGf6/+p/X2bbXOWUFN/TBldUeSBDCuHibOxCsByYhjuEgpoGJ2AoE2qu0KPgoYLBYjACUFKQgPcQQtJlhz+2TNn79vz3JO8xF17UOLS8Em/4dKTTh9J4b8EzuCo3FCSf3WWEoBDo+bKpzoxnLQX/wnUm3MWF0j48S2Y0kckZcUtZNTqeJTgyXMrRUie5lSB0coS5kTw03lxdPQLKxH4aX4Xg9bszmVIcsHEtEyFcw=;5:wHfO7G6XN8ihkRSDjzcr9tsZ+/REexC1LTazOD8FO/R8RXTK2sdAlMITfHPX0Xf+QpTRNZmWZR0i1KuiMrcuki3eU5HdtiaErzbxl7cNquGUBK/BuolU0ZogYbc4ITzYq55gSq6Xqgpy+WxtY2rPi5U3odcS6+TCBCxOxr+Voes=;7:B7Mg9zwh0ZJxpwsCfjUWDimP3ULC/EmsPLX/XtUOfUxeC0OPYsN6f8TtUBbtfKRQ1E4v+GUPlrblR1jAjNa5kdigIWKs+KsgDTbmMg+n79TMdaMPc2cqcU+xy8d4TxJkpf51BF6a9JQC6RpSiyP4ejbZ5zTBI3koazBwB8UfNJJORDpEq8/Cyn5lZrxunPK+tlT2kIiSmIyOsnGh7L4zfoRcrbFkQ9fi5rHMA5M/3EFcJylvU/2hsFxFalgt5rwm
x-ms-office365-filtering-correlation-id: 04016c7e-6cea-4b03-e5dd-08d632942117
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
x-ms-traffictypediagnostic: VI1PR04MB1616:
x-microsoft-antispam-prvs: <VI1PR04MB1616989CE57F7F4C61C6E28299FD0@VI1PR04MB1616.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(81166006)(81156014)(8676002)(7416002)(8936002)(4326008)(2501003)(316002)(66066001)(5250100002)(2201001)(53936002)(7736002)(256004)(6512007)(25786009)(6486002)(6436002)(86362001)(68736007)(5660300001)(305945005)(52116002)(2906002)(6116002)(3846002)(54906003)(110136005)(76176011)(99286004)(39060400002)(2900100001)(478600001)(476003)(11346002)(2616005)(486006)(446003)(14454004)(106356001)(36756003)(186003)(26005)(55236004)(71200400001)(102836004)(386003)(71190400001)(6506007)(105586002)(97736004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cmqj3TF2GO7STqdXMvBGUuxqIQhu1BGOumfKSPO26J7/XPZhxxWpHAiQgZYHuseh+tDrDwxN7tgk4r9SXi220Jefi4UHpeQ5UUNvN9cFa67u4LXqQrJju8ds67Q17KJ0kBY0fa74EtoeQPe3d/zrawTYbbOa7qq0s6WxPnMuUWtRlXWGNA+13o3pjm3err3ONst6PjvIgKisWmG0eOQ9OuoXoHqttfZOuxueqDhS3hjJ4395LyBbRLANqdk+OGaNZZpRDirNN6F9csvzEGbJfJ3JEL3lOGxRh5qdZcy4/zHRo5CwY8FLGFYAWxVprYRkTCaHivQ4HoceuHax8EIDBXJcdwxBMPgA4IZo5rNz2RY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04016c7e-6cea-4b03-e5dd-08d632942117
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 11:48:31.7461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mode flags for octal I/O data transfer support.
NXP FlexSPI controller supports octal mode data transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
 None

 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 67eea88..c48ca94 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -993,8 +993,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
=20
-	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD |
-			  SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
=20
 	f =3D spi_controller_get_devdata(ctlr);
 	f->dev =3D dev;
--=20
2.7.4

