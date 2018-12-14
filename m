Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C84DC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8D72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="sst5XLW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8D72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeLNKku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:40:50 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:51281 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:40:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,352,1539673200"; 
   d="scan'208";a="21498986"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Dec 2018 03:40:49 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 14 Dec 2018 03:40:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z88zrRguLz6PrgZTT+pt0IsGbmJucqYcmCiA+8A2ugg=;
 b=sst5XLW0iFB7/UFQi/v3OUObSrH3wRm5GucQgvFqgSe/OOW9wHYaQmnEb727ueXhyRY0ZvuP2lQl7ll9gZXBo0FZCAyJmpfRJWgag9+sXZQEj8FXRjw/ekNAKQ4MSZUdKSPuhMVJNRFlY16CJRSzYj9QnPVT+2JYu5iyTML6IVc=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0616.namprd11.prod.outlook.com (10.163.159.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 10:40:47 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 10:40:47 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2] net: macb: restart tx after tx used bit read
Thread-Topic: [PATCH v2] net: macb: restart tx after tx used bit read
Thread-Index: AQHUk5l58GyLIDDY90iLZauiHF6IKw==
Date:   Fri, 14 Dec 2018 10:40:47 +0000
Message-ID: <1544784033-16390-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0070.eurprd03.prod.outlook.com
 (2603:10a6:803:50::41) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0616;6:FszkRSGcCKUZi3ZaQD0nsAPGzSxui4lULLJs5iiBvbBYaXxNpcHjiJYkvzjJGK3OlWj11TfGiLOw7jPYNAN26oJ+llIuOOqRKqaFRtjADB7Ldj0ZrqMrizNOW+ay3aaLjtriPQ7rXboZGP2h6p40ffpDgXB6Eyy4khf+lLqg2HxFIwOcBezGXg7vWQ62l9Hv1rB1E6VDDS5LWKKVmZ7zSEEV2rGPqeZKLCHqBGnazgSaP4aN0Q1Ai0NDVkeWa28iZskxqUozfGevo1sATl2Ho0FMAQy4WIIk0nYhwDsnFeC+p9/yUJeg3L08rurjDT9FcKVb3uJiac3DVQZiu/bxnRtEdAYvYFqYkY0BYDV8xdhpZMAV4XMbCJw7mHrQQ397CyFx1JyeiYUemkhIHKwAFq2S5Gla0j+kfO9cWWVXtfMnXq+n2NHHJOCunSxvErbCVBULFpJlcUWZ2ZMiQcK1Vn2riKfnVAfkkkeUxkGhivM=;5:FqVrX4Z82auhT4Y4eV7ezyjC4ik9IiRZvt5pogPXEYj/bSSUoxCeyJy9LM8dZAinDjahDti9xYXN2vLeYb0CHqSF1PrfmpH1f9NiEK+fERLDBFHbPpUgOEwr1BGFmtTmSsVu2Jpt1J5ShKy88+SXHbjI80jA+LZLRO6MgLIx5Rs=;7:5LAveczfTQPIdQNWyhq5S1jDnb5EWcz4dAk4QdzqYI6rwnAuwkpAwmwBE4vplVMpFIJ+OFhSZX4lu5v9Cb862j7uT41DbQxEKzGnWOi/XUZNFmfhfjkenPxfdv8wUaUPWEE1UfMkP1eGb1p9PNORAA==
x-ms-office365-filtering-correlation-id: 022cda52-e2f7-4d2e-5bf6-08d661b09b86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0616;
x-ms-traffictypediagnostic: BY2PR11MB0616:
x-microsoft-antispam-prvs: <BY2PR11MB0616B0F517E87217181DE8F687A10@BY2PR11MB0616.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0616;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0616;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(36756003)(105586002)(106356001)(86362001)(66066001)(26005)(186003)(14444005)(68736007)(256004)(6116002)(3846002)(2501003)(2906002)(99286004)(54906003)(110136005)(316002)(71190400001)(81166006)(8676002)(81156014)(71200400001)(8936002)(6486002)(478600001)(72206003)(25786009)(14454004)(4326008)(52116002)(107886003)(386003)(486006)(102836004)(97736004)(6506007)(305945005)(6436002)(476003)(2616005)(53936002)(7736002)(6512007)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0616;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Uw3a8K7lK+yNTeH9r0TqI94rFmRIrHZOhe3iZisOk4LetHJyJOgIWvJMLYVDuTydZSdfe0YaGXBdtJwGOMX63O73jtylne26+bynhNLp2bEuewXN8oKCTMtCN7IC6rhUZq7eovbSYC9MxIW6TpfIjradjgongrF34l0ZEN+2uLy9JeP1L9jHjQYGmjYpv/eHzB2TTqGNaxm3OG4SxuaviyUdUI+ytMkP1B1rb9RvZ7azGTJZcquIPoR+6HTWcE5JZmxfY3Rl3WuwGm8/G1kOvZ1zMN36oHrHfjfDtEiBR0mvQCTnzb4O6rfawIuVo0gL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 022cda52-e2f7-4d2e-5bf6-08d661b09b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 10:40:47.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0616
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

changes in v2:
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
+static inline void macb_tx_restart(struct macb_queue *queue)
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

