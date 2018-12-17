Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EF1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCEB214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KKh4duFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbeLQKCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:02:46 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:11511 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeLQKCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:02:45 -0500
X-IronPort-AV: E=Sophos;i="5.56,364,1539673200"; 
   d="scan'208";a="24016334"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 03:02:44 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 03:02:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYgH7Wolb30SZ9aZnRuIM/cBic9gL2Wr/xm/Q6ip87g=;
 b=KKh4duFvK9vTG58qJSS2VxgwEdaW6XrY77e9UX+3ISADJmOyroNugzgNIyjC5FMGpEmhoQ6U7YsV7lxeq6ddVfIq34XqB0C3uuKjGTIxJ8G8prbvRvINHsCjqzMzq1mHWZ8WuvFEZ4+EpnMBjrDHALDY6drOObrIKzBoqajKjj4=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0584.namprd11.prod.outlook.com (10.163.159.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 10:02:42 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 10:02:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3] net: macb: restart tx after tx used bit read
Thread-Topic: [PATCH v3] net: macb: restart tx after tx used bit read
Thread-Index: AQHUle+mtil0X1BpLkuEXebjAikpjA==
Date:   Mon, 17 Dec 2018 10:02:42 +0000
Message-ID: <1545040937-6583-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::25) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0584;6:tzxQxxgV/qgbs9BpoxlHRy0Cv9sxPvicEOjxLiksAoWgRdZEnNNfZiaxsu86NGQ+aRr1qwjqeWCGepTzyXovGU+QsvtsNDibdgORpvswem8dE9v0mEib/kdpHoyZFqCz9CvRpYZzFmGoLl03PyM604yStau53WrESISatsK1gRX4Vra/BXZcgxUBCh9W7HJRQYxJxUsV+kYhIk534KgWVpfPDpV/v/ZvY126G0EOPJ+9pIfdpvsNM2P1h2ZQEFpGey+M+Ih9rZI/4zFPy7bO5KDf5RX2DKlMNuplwBu3pFs1BHkoFB0/pdDS+pS6YKl6V/7Cb2jayer94s8eKBR5PwMx9w6ey9VFeijYmhxFE1W3YWfL5uYZiWVhQozIW6i7QFI5BLkVBDGWd3dn/1fUAjkPMJiCMV7n3yZbdfZOG55SYnKcZrNBBJl4FHVmvcBWtTyTz6EeiO+pliUWONfBP5Rg6tuR6nDQ0tU5+7lqdSE=;5:guxnjaU3uQbHKVDXAK7N+N1dg/3ZKXXhxV4oo21rDzQ+Z2VLySv9PRce53chw1QGu/YY5vhBtMG5aV2ybLttMROr9R4fNZ3X2yJOEP+izEZfm32Eyq0SozTawKoLrwhhSBbeFDIXbU8JMp3cuRcaPilFK414kMq/hsQllTzBeiM=;7:uVfOrntHaI3fRXTFkddZtq9StbipVBnAonSdCyzClxUK57JRVlOzmY4+W4ZA36rQlhFI4zd6Q0awj7zcHr1QFI2PuKTTSTDL6/p1ton7ouYS1+W/isfxI5QQDWjCJzKZJgYS671gV6lDEWnOKTs10g==
x-ms-office365-filtering-correlation-id: e6a20a8b-604c-4ad1-02db-08d66406c907
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0584;
x-ms-traffictypediagnostic: BY2PR11MB0584:
x-microsoft-antispam-prvs: <BY2PR11MB0584F640E3D4F13B24D0DC1287BC0@BY2PR11MB0584.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0584;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0584;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(189003)(199004)(8676002)(25786009)(68736007)(6506007)(386003)(102836004)(5660300001)(6436002)(6116002)(3846002)(66066001)(478600001)(107886003)(71190400001)(2501003)(72206003)(256004)(305945005)(71200400001)(6486002)(7736002)(186003)(97736004)(26005)(52116002)(54906003)(316002)(4326008)(476003)(486006)(99286004)(14454004)(14444005)(2616005)(2906002)(6512007)(53936002)(36756003)(110136005)(86362001)(8936002)(81156014)(81166006)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0584;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: to0hExVsMqxiR7cnHb1iVv7/O/7sqVPkFDemxTww9rqE2cZAFz3hUeR/ggEsQ8yO4OOP8z+YTn2N33EjGuJW/JZtR89XXNPlfAxP7Y+rMyYfVzMKJcrKRGmokd20OwlohpA6xmEt/iT1bg6IwATBGSUgagBnEuRRLOkbIgSy7TBVCKOHYzKd2DGMagz6BMsqaRiELwk4Du5mSvw5FQIb4F+rV3rXpisUAt2Ih1t9ZMqlG8ORVfmpHRtrAMGGEiyxMw00jNxsOKwSHXdLomXDyXzj1bMV4FRXA9JVeQFRZalUb2e4gxt970FNRLE1IMWz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a20a8b-604c-4ad1-02db-08d66406c907
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 10:02:42.7507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0584
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

Changes in v3:
- remove "inline" keyword

Changes in v2:
- use "static inline" instead of "inline static" for macb_tx_restart()

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
+static void macb_tx_restart(struct macb_queue *queue)
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

