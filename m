Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1599DC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9C620892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="0zbQDQ6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9C620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLFRow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:44:52 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:31683 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLFRov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:44:51 -0500
X-IronPort-AV: E=Sophos;i="5.56,323,1539673200"; 
   d="scan'208";a="21971154"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Dec 2018 10:44:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 6 Dec 2018 10:44:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imkhcO6MjQGi4YAVPlhWCffcmaoc3dVTSWjLg0R5XzA=;
 b=0zbQDQ6rBQBt/T0zelDOn2EUqAXwZj3jzaSQr0HOOtc+6UjE2l9mcSsSz0xXwXLej+4OGLZtYE6LhqSiSCoe3ud9Pcao6kuEGlkEQ1w3ynvbwSEHIYsWIWno9bYGdV8C78y2UnRHS1hayGaBkmr9aSviSKLyIjeFb7pLRezAhi4=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0743.namprd11.prod.outlook.com (10.163.112.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 17:44:48 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 17:44:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH] net: macb: restart tx after tx used bit read
Thread-Topic: [PATCH] net: macb: restart tx after tx used bit read
Thread-Index: AQHUjYtiHoj39hzsZkOKRFijJQZETQ==
Date:   Thu, 6 Dec 2018 17:44:48 +0000
Message-ID: <1544118265-15356-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0159.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::13) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0743;6:IvZvvq1PYb02lMtwqKLm/FpJeZUzcsD3Qd508Y64J3K9S3SuQUztINQLmZ/ToT/UECj5nvN4AIBsm86TYcILnqsQ9GgKCA8tu6hoyHsN4HEkhd6Wpg49jsPbRSACDze59Fnbr7yo161PNIuGPIBekwNB062dfEZvHygovmzUNdbVf8Li5fZf0bAy729c9e36vEUxW09IYXsvNNgGZJoDBHb/BUGLQE9XLQQ4exRgFHoBaEuzzVI4iYE6YtFrb2l9q4eYqBXA2UHOmqLcGXTK/eyOe4SqzsjJjPlBOFssoMc7sGmL2dj1qakGVbcBVfsygvey7t9F7MKfQvWSGdaU7tyyLNrawkH8eXXBGpxOthIiz1GD5fNuGHAopYuuL1Wl53X5GHaqaW8PhYqdLE6YSm7A9DwFS/c8WXTkOM0Tn87LbexPsbPMdiRhaqW97FIsAMgKmIKdT/BUqRh0+jxPpg==;5:exOIzQ6/fXqJLs4sJNZsGZVXr93GY9pl3VcyZedDqAdLpQXaNsgEA8+6LJF3YlUpHwE1nz5zTsuk3cJo9Ylsr69opr0Q9URWH1kvgvbIV+SVE8HslNMWX5LkGIZCbsqOpCmKwjnd8xgmDOkl0i3RSaLeW0YwltASYadRj80NPvQ=;7:Y1KAmwdQjdrdO/ID3N3uOTUiQ3jcdv0VgJRk5zokR6eLDnIf2pj8JkVfeTvtIk903CAW3ATDpfWlqrJp2CIzHFE93IgbYmOR7fMyBsT7usRs5/th4G+qixO5xq21EG7Zg2Bspds1oidCrdtRnIWTJg==
x-ms-office365-filtering-correlation-id: db274cef-0200-4062-98a4-08d65ba28483
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0743;
x-ms-traffictypediagnostic: BY2PR11MB0743:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-microsoft-antispam-prvs: <BY2PR11MB0743FF37CF99563407D9BD4F87A90@BY2PR11MB0743.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0743;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0743;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39860400002)(136003)(346002)(189003)(199004)(486006)(186003)(476003)(36756003)(6506007)(26005)(71200400001)(66066001)(71190400001)(4326008)(386003)(256004)(97736004)(52116002)(106356001)(14444005)(68736007)(8676002)(14454004)(105586002)(86362001)(2501003)(6512007)(54906003)(99286004)(110136005)(8936002)(6486002)(478600001)(102836004)(6436002)(72206003)(2906002)(53936002)(305945005)(7736002)(316002)(3846002)(81156014)(2616005)(6116002)(107886003)(5660300001)(81166006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0743;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MS09cX1u9Lc+Dd+oqEm0+RDGMzzloKO1w+pxskZKyA1o2ZViyMLS9Wod7/LewpwGTT5YL8sGdsaBLtWc+evVEfNhrpiVzmGsbSNs/8Hi030l5N9pHNz/gP+iDxCr+46uoieF91NgtJPeBy1Yw06IrcqwqGRE4L7+knkQwJB/c16FE0ICNwr+thKzFz3y9s/jILmrWPNkAKJNP/Nd6+8LqTDMKhUCG6jXknOEwDpugjv3RwyEww94Y1xOsFWX9hxa0zJHjxZUwyTw77TRACY2a8AC7xps1TyT/wQuHNlaBYEqLqGis7i/pUOcfgXJBaKrzCSUhZNraAAAX00iUDzosyeoU9WkHF7nCz35TmDaFFI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db274cef-0200-4062-98a4-08d65ba28483
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 17:44:48.8122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0743
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

On some platforms (currently detected only on SAMA5D4) TX might stuck
even the pachets are still present in DMA memories and TX start was
issued for them. This happens due to race condition between MACB driver
updating next TX buffer descriptor to be used and IP reading the same
descriptor. In such a case, the "TX USED BIT READ" interrupt is asserted.
GEM/MACB user guide specifies that if a "TX USED BIT READ" interrupt
is asserted TX must be restarted. Restart TX if used bit is read and
packets are present in software TX queue. Packets are removed from software
TX queue if TX was successful for them (see macb_tx_interrupt()).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/etherne=
t/cadence/macb_main.c
index 1d86b4d5645a..f920230386ee 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -61,7 +61,8 @@
 #define MACB_TX_ERR_FLAGS	(MACB_BIT(ISR_TUND)			\
 					| MACB_BIT(ISR_RLE)		\
 					| MACB_BIT(TXERR))
-#define MACB_TX_INT_FLAGS	(MACB_TX_ERR_FLAGS | MACB_BIT(TCOMP))
+#define MACB_TX_INT_FLAGS	(MACB_TX_ERR_FLAGS | MACB_BIT(TCOMP)	\
+					| MACB_BIT(TXUBR))
=20
 /* Max length of transmit frame must be a multiple of 8 bytes */
 #define MACB_TX_LEN_ALIGN	8
@@ -1312,6 +1313,21 @@ static void macb_hresp_error_task(unsigned long data=
)
 	netif_tx_start_all_queues(dev);
 }
=20
+inline static void macb_tx_restart(struct macb_queue *queue)
+{
+	unsigned int head =3D queue->tx_head;
+	unsigned int tail =3D queue->tx_tail;
+	struct macb *bp =3D queue->bp;
+
+	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+		queue_writel(queue, ISR, MACB_BIT(TXUBR));
+
+	if (head =3D=3D tail)
+		return;
+
+	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+}
+
 static irqreturn_t macb_interrupt(int irq, void *dev_id)
 {
 	struct macb_queue *queue =3D dev_id;
@@ -1369,6 +1385,9 @@ static irqreturn_t macb_interrupt(int irq, void *dev_=
id)
 		if (status & MACB_BIT(TCOMP))
 			macb_tx_interrupt(queue);
=20
+		if (status & MACB_BIT(TXUBR))
+			macb_tx_restart(queue);
+
 		/* Link change detection isn't possible with RMII, so we'll
 		 * add that if/when we get our hands on a full-blown MII PHY.
 		 */
--=20
2.7.4

