Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF16AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEBE20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="orptZcsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEBE20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392229AbeKVPwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:52:47 -0500
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:31712
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392215AbeKVPwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGntyyAunM0d0633GY9h0hyYQf+tv+Cm5+5g8AMlrPk=;
 b=orptZcsNSkcsR6xFVPGJleXpPXuTUjL+Hj819wSqDjH8OqbnbMk/jHAe6ImTER5U9KNVsGNevKf8IgTUlIgn4qF3swS3IsIiXystSqoNJWyLilYSAcXK3s+nAsStfhhHlfXjXoRa4gWwh8Py/cZ1bqianwriEpX1Ujljvr0gu9I=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3055.eurprd04.prod.outlook.com (10.170.228.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 05:15:00 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 05:15:00 +0000
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
Subject: [PATCH v4 6/7] spi: nxp-fspi: add octo mode flag bit for octal
 support
Thread-Topic: [PATCH v4 6/7] spi: nxp-fspi: add octo mode flag bit for octal
 support
Thread-Index: AQHUgiJRv9f2hn+ys0KIBM6v8T69Mg==
Date:   Thu, 22 Nov 2018 05:15:00 +0000
Message-ID: <1542863544-21257-7-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3055;6:kFvBiOzxazhlr0L+RdPYJmQylXT4Z5T42Zo+htfXsOImLxND5q9/1JOu6MIu1EFqGvclsEhw9Gh1xrmYMYr5shg1+EKEPCsmXAH7bdpj+gVI70Di7BfqS4wfyee2WUiWVxiDdWJUiaQGVxWK/xaEM8Od5IQzzuY/1WWXjwyjLASgWcH1gYHZuux7it/SkaXgIK3Fpm983VHHv/i/QonkJI6AUV+YiDNLe6VjOWXAZgerN6xrJl0PmJm5PShjRhKGUh7FabdSTAJEvDOkP0fY0muXtqOfxGYeajpd0PkSKj+47L3feVS9ny2lpA5gd4YwHQFHz4J3qv7E3cJERZFNlqp2YAyK0Yx1zPYT7jK9KJzyIf0dEh3fonEBJbgf+0HRUyT3NUUIs56bZWNdp6tu3xn0fqgihg98pjmomTvJ1U0G5NMbrTi+ujSrZBa6JXt7QNB7V9xvwRo/gD7ElkO0zA==;5:1ASzz8KvkyoPDKhBK9FrST+enfCtPAZyI1RDG1j1INgbRy72404f3YId/YFfve6StoelCG+sJDPOHJZuuquwxHJV/q4eh/fu0XOMfuE3PssIP3X80GuvJFLfvEulH2SDsmIfDtJIGPiEkW0LndPh0GexQDwBTwgONBnnvPAnx74=;7:nhEPSd+6OIKjLXRFp2iaEUHf8h9fHXRBqPVALewOa8y7ZGtWWrPt+ijTlEm2mZrXIsSQKjgrQBGfkSYGhYz+ev8LEyPDW57TGLJNpNGt9SAvbPbh/ci4POeJWHQKApxQzf74R0R403Quch3nffcyTQ==
x-ms-office365-filtering-correlation-id: 98c285a1-1e0a-4145-c00b-08d650397394
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3055;
x-ms-traffictypediagnostic: VI1PR04MB3055:
x-microsoft-antispam-prvs: <VI1PR04MB3055C6E88ECFE78309A94F8A99DB0@VI1PR04MB3055.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3055;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3055;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(8936002)(25786009)(105586002)(316002)(2906002)(106356001)(52116002)(76176011)(4326008)(14454004)(6436002)(6512007)(6486002)(53936002)(39060400002)(68736007)(2616005)(476003)(486006)(99286004)(478600001)(11346002)(446003)(36756003)(102836004)(54906003)(71190400001)(71200400001)(386003)(6506007)(66066001)(6116002)(3846002)(110136005)(26005)(256004)(186003)(5660300001)(55236004)(81156014)(78486014)(97736004)(2900100001)(81166006)(8676002)(2201001)(2501003)(575784001)(305945005)(86362001)(7736002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3055;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HlIk4O87X7zK0/iwZ3IjrKbanyDhyBeTcxLbUyUliqAIYCswXld67WJEKXSnxlgEQo5HgFTSsDiREIelY+GLtFfruj94lzE4xvYOBkayyAgUjdiLIo2zRPktxDm+hare11x/j+WNC1h08jiwyCGNoNT8ihhLpHXCMyH5fmXVpfh93jd/5o/pK9jEgPbj/75IjPbtpcc18ZMGk5CoqYH8Z+bhJxfK2fvHX0tLiIUKJUFKLxdvKjPplX63qPA5rj6fib5F84XbqaDCqmOSSe8cpc37OPsORrhH1pgDHlJnBMT1TyptEovuTcBXF4X7gQ+EYPzMNPlS03fnGOd+E6kRq0kNh4NCF1MxxcuFVG4/3S4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c285a1-1e0a-4145-c00b-08d650397394
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 05:15:00.5583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add octo mode flags for octal I/O data transfer support.
NXP FlexSPI controller supports 8 lines Rx/Tx data transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- None

 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index a35013b..f0d37e0 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -995,8 +995,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
=20
-	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD |
-			  SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTO |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO;
=20
 	f =3D spi_controller_get_devdata(ctlr);
 	f->dev =3D dev;
--=20
2.7.4

