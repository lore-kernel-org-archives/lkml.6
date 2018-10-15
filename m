Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEED4C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A847C2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q/rVXpu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A847C2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJOT7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:59:10 -0400
Received: from mail-db5eur01on0073.outbound.protection.outlook.com ([104.47.2.73]:61824
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbeJOT7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcWVntAi4IsR1DyHqW4HMz12ZIYgg87aIYfzgghftaE=;
 b=Q/rVXpu7Ijg/Lfgymf5CboqRUI1pn7C01JSnUhRs0v/s0bTnA4COTMzrtpFq3zKf+SMYRDvwOFRUHqySxA3HyMdIXrWFJmwAA0xHuBpHf5HrRQdS2rHQOsw0xZ7pKUv2Wym2DFo4OxHkYCtoHbRAXTdTMMKx/Gh/IizXpvOg3Vs=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4240.eurprd04.prod.outlook.com (52.134.31.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 12:14:03 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 12:14:03 +0000
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
Subject: [PATCH v2 1/7] spi: add support for octal I/O data transfer
Thread-Topic: [PATCH v2 1/7] spi: add support for octal I/O data transfer
Thread-Index: AQHUZICPNsdsi3ykQUSBnx4/l32i7g==
Date:   Mon, 15 Oct 2018 12:14:03 +0000
Message-ID: <1539605534-22302-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4240;6:GIwzpbkVyPq9b6VToEf4x67S0IDSMhrhyZQWPwsHzdCBXKsva4DJ4gdkDvcpZZwxMhHY/TYjjx3fTvfBSVltMObeHqvGmSRo6oHoTONfFxR/rbpItLSVY9EMk59aZNbK7W1sBCdj1iQq+bZEkAAuBaaJUNMlstyGm5EyAtNyHhJ2tUl03xYikIZRCkeY/b0+yq1tanPSoVss+pBYQAhN2NBHKAxGFI8QV2in8tjBmBlRrn885Qbyd5pcYo9pNHiPFhUh4d+2weZtR9wyxBQcUrv1eRMsBMQafcj/bShG1ELAgOSRGKllSp2z0tqfcPsC//p6wxLw4gJsjEzdO//sYCE7QMfiqGN4gvaNnd9YsSaAee8j8jrJ58HXucpkTJDDxqsbct+mmErV7ek6rI6hvEHj9g30kXlzL/iJrfgMPOM7UKyPEGw/jZDSocRBZSlooafM/5YXAifDQLS1QMSlyg==;5:2+eCl3TbOwaQ08l7+AVdruqXXi86MM3ItJk7lhliEtsfOczmbYMwkaqbBuhndwqBU/ndASNRJ3tmcL31Bi7r5yb2v7s3vZ95PzEfgVInSrHxQg+Eu5au1HxBqPUPQ6yKTetCtaPC3dfjaQfzaaNhhk3sCJJxh2IqMxMNnN7i1N0=;7:yG0dBInHPPcyauonaOv598A+A0SXLbOdPtXtueQ7gXMlsqyrb8T8EUPE8YEqexT0cozeZGBKOyr917hR7OT9BlT8xaLuorPJ2txl8zskP2mbarVYB+nbpYWDXTi4EmfCM9Z9nRp127nB65970aeILtKb4RXZiLs201ZbtaIK0ZoTrEtt5aQ3p6Vk6279pvCEDzMbXQmIjy21Sn5n6IDxA1+OSr0cVa+7b2dMwPBQKeCXFgCOXzILAAZeNOgB/pCX
x-ms-office365-filtering-correlation-id: 4d607e64-75df-4c9c-79f9-08d63297b21e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4240;
x-ms-traffictypediagnostic: VI1PR04MB4240:
x-microsoft-antispam-prvs: <VI1PR04MB42408F47512DA40A0AF9F61799FD0@VI1PR04MB4240.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB4240;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4240;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(86362001)(575784001)(102836004)(106356001)(99286004)(105586002)(6486002)(39060400002)(26005)(6436002)(476003)(446003)(71190400001)(71200400001)(2201001)(186003)(5660300001)(66066001)(486006)(11346002)(2616005)(14454004)(97736004)(305945005)(55236004)(52116002)(76176011)(478600001)(4326008)(5250100002)(36756003)(81156014)(81166006)(54906003)(7736002)(53936002)(6512007)(68736007)(2501003)(8676002)(8936002)(6506007)(386003)(256004)(2906002)(110136005)(7416002)(316002)(2900100001)(25786009)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4240;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RbV/9qig4LdW95dAfX48R979y+nm2fDpYA0g6pOzTOXzxK2fjoy1k0PiKhG8am1IZ3OQyflfwbm/Ivxdqj5kEcM6GVJVxE1AaRG7mf1ZXE2eh3w8LyQ+dgyTsE6kYYE8SpRcq+UMOa+1ByUBjme8dlzh8TrUdidK2PrMV40wtQ3oNIklr+GCT5dsWCMoCILZls42VDp62i5oBN7vg8+EH741iOJA3zs3Ztiszrmon+w8diV0PW5SWCzW0EPB5k6OfupaQ4eXWs7km1Vjn8SxfDtWoufDo5EVAFsrpWT1VF/LXOIaPL2bGuLJJ7PVXFhGYBRQqQX/ym4NEeddh5xg8EfrwvIAnwto6PVZIU0j65Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d607e64-75df-4c9c-79f9-08d63297b21e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 12:14:03.6081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flags for Octal I/O data transfer
Required for the SPI controller which can do the data transfer (TX/RX)
on 8 data lines e.g. NXP FlexSPI controller.
 SPI_TX_OCTAL: transmit with 8 wires
 SPI_RX_OCTAL: receive with 8 wires

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
 Incorporated review comments of Boris.

 drivers/spi/spi.c       | 6 ++++++
 include/linux/spi/spi.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec395a6..80f672f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1573,6 +1573,9 @@ static int of_spi_parse_dt(struct spi_controller *ctl=
r, struct spi_device *spi,
 		case 4:
 			spi->mode |=3D SPI_TX_QUAD;
 			break;
+		case 8:
+			spi->mode |=3D SPI_TX_OCTAL;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-tx-bus-width %d not supported\n",
@@ -1591,6 +1594,9 @@ static int of_spi_parse_dt(struct spi_controller *ctl=
r, struct spi_device *spi,
 		case 4:
 			spi->mode |=3D SPI_RX_QUAD;
 			break;
+		case 8:
+			spi->mode |=3D SPI_RX_OCTAL;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-rx-bus-width %d not supported\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e..2d21307 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -163,6 +163,8 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
+#define	SPI_TX_OCTAL	0x1000			/* transmit with 8 wires */
+#define	SPI_RX_OCTAL	0x2000			/* receive with 8 wires */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
--=20
2.7.4

