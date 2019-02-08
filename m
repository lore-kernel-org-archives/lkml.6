Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CDFC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF69E217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netmodule.onmicrosoft.com header.i=@netmodule.onmicrosoft.com header.b="YHIwO9Vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfBHNRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:17:53 -0500
Received: from mail-eopbgr40115.outbound.protection.outlook.com ([40.107.4.115]:52505
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726568AbfBHNRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector1-netmodule-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Po4d8KdGZjFGcHpUQIvblsu22Ia/68rz9Y34tNjwok=;
 b=YHIwO9Vd5vs8Evs3UO5b+Y1a/XcZdQOuqOl07JRcltsiTeV9sFUuAxfUjUteIduTwUmWwXf6keElvTJmKwEaO/ZSIP37kdyagOrSRUSnEY3ukTe8lR3NHjpcz1ix1wQo7B4QVO4/PkUbsEOlsPDwgfBZNluG9P8r8wf6Hk8yCw4=
Received: from AM0PR06MB4419.eurprd06.prod.outlook.com (20.176.214.91) by
 AM0PR06MB5826.eurprd06.prod.outlook.com (20.178.83.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 13:17:46 +0000
Received: from AM0PR06MB4419.eurprd06.prod.outlook.com
 ([fe80::df9:4308:d40a:e0f9]) by AM0PR06MB4419.eurprd06.prod.outlook.com
 ([fe80::df9:4308:d40a:e0f9%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 13:17:46 +0000
From:   Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Patrick Zysset <Patrick.Zysset@netmodule.com>
Subject: [PATCH 1/2] can: c_can: support 64 message objects for D_CAN
Thread-Topic: [PATCH 1/2] can: c_can: support 64 message objects for D_CAN
Thread-Index: AQHUv7CuvqZcYG2ZME2mD8A7bKLzlw==
Date:   Fri, 8 Feb 2019 13:17:46 +0000
Message-ID: <20190208131738.27668-2-andrejs.cainikovs@netmodule.com>
References: <20190208131738.27668-1-andrejs.cainikovs@netmodule.com>
In-Reply-To: <20190208131738.27668-1-andrejs.cainikovs@netmodule.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::32) To AM0PR06MB4419.eurprd06.prod.outlook.com
 (2603:10a6:208:bf::27)
x-mailer: git-send-email 2.11.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrejs.Cainikovs@netmodule.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.130.140.44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR06MB5826;6:+EV1rjBKJFHSdiOTXU+tiDakJeF+jd9nzAQTj6x3fxhn0MOGd5dOcCGOhBNzdVyPXpFdee754XGZibyjnZm5C1rcKHNs5ldoBwAmggHMwblrNMxqtMZWDy4LrQIuJxbP0Gk4/yySlcinbAjO7/DDWkLW+REteJ9mMpHX+c11Zulx5pYx/ZDZrlk8Jcucu19yIfEHnao+1/aFTYnXIfcLzaLhTbsY9wUbbncDqis8QCuG+P3T4AQfHnolh4ENd6TtoCnk2Ew3ptilxvVM/DHlwomzBQG/0WL1qgj6lW1CNaLdBgYFdE8OqZdhFhOZtJlqsLRqs74vxDX3PJZOGY4SDbvFtjjIki55V625jaFWXjQbZ9GAxLmub4h8cy0RMKV3ksEifWrTaWdJHVKcGrt1FXAB/E0wUU11y4cQ59SPsdt6HTWGqCu6wnlMt6Hjo7KbxkeLNHCJA97X//hsOXQGJg==;5:qlsZ+j5trEJW0ftfPy1YUKXvKF6AdzhUmhT8WcPy09hr7UvVMhBY/LoQ8Zk32YU0i5pa/z5mfXX6IOSDQhsNVXxWswSBQnotM9ktaJdI/eKRSqTQ2t8ip1idGPgr+pFb5XV6f4jNeddi/KZFD2qsU1p+yumeC58F8MdH3z9gLVdWFJht3m1T+5MIf9TOgVYmIQPhYyFSVnbBjMxbVh76fw==;7:a80GrDMXAbbLZO2Y0ZdMYvp4pj9nTlmUra9JMSYA8+tJSaD1Na1mSuYBILDva4sDUMpyqy8cQmLRGjXKtH7+bgnsllf12MhcgJrwrFEF/Eiz1spmFkIFlrB4ZIZjIewSacr5ydDa+LgfV96YqE0Drw==
x-ms-office365-filtering-correlation-id: c5e1ecda-2798-49fe-09e3-08d68dc7d0dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM0PR06MB5826;
x-ms-traffictypediagnostic: AM0PR06MB5826:
x-microsoft-antispam-prvs: <AM0PR06MB582619E63EAC263A08F03A28F6690@AM0PR06MB5826.eurprd06.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(346002)(39830400003)(199004)(189003)(99286004)(97736004)(3846002)(6116002)(476003)(107886003)(14454004)(4326008)(53936002)(2906002)(508600001)(52116002)(25786009)(72206003)(446003)(76176011)(486006)(2501003)(44832011)(386003)(68736007)(6506007)(11346002)(26005)(2616005)(316002)(71200400001)(71190400001)(7736002)(6512007)(50226002)(6486002)(102836004)(105586002)(8676002)(81156014)(81166006)(6436002)(1076003)(8936002)(186003)(106356001)(86362001)(36756003)(2201001)(110136005)(15650500001)(66066001)(256004)(14444005)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR06MB5826;H:AM0PR06MB4419.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netmodule.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ckeN0qKK4G1PHJa+ajTonlGzOg17a6647VRkHRQvnqUmCDEED1MleHuFIczyxHOuwxAMRQSUE/jbCMb/PTZFUHdI/B/BxalxpLHFBVSTdXM5kZhD8rV3gqe0ek0OFPojBLbHgOL2fq5Y5bg7mqx84J5AFx68wJZVDUQgqoYGF5A5kjv2cdUWw6rlkm3vM7OqhszdiEjKfxP9WDnb1uIKkXXLLcTpiz3W1GOnJfSxuYGs2CFhjli3UTt2/h5U+6CPqtTAcJdnz75WMeohh98gWQFElCuPEQH/gZ5H74ZXn2n6XAonIkIrBW6czIJFonEKnCm7VZ6TcEw7HNYem4gkRXSae4UGMt1SfGM3xqJGjhTA8r3n4WAfMONV4InTwq3cOfQwTvV0a6tvBrr4NS4x41wbFa7fBIIUotWICQ7uDIE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e1ecda-2798-49fe-09e3-08d68dc7d0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 13:17:45.7200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB5826
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D_CAN supports up to 128 message objects, comparing to 32 on C_CAN.
However, some CPUs with D_CAN controller have their own limits:
TI AM335x Sitara CPU, for example, supports max of 64 message objects.

This patch extends max D_CAN message objects up to 64.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>
---
 drivers/net/can/c_can/Kconfig | 12 ++++++++++++
 drivers/net/can/c_can/c_can.c | 42 ++++++++++++++++++++++-----------------=
---
 drivers/net/can/c_can/c_can.h | 20 ++++++++++++++++----
 3 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/c_can/Kconfig b/drivers/net/can/c_can/Kconfig
index 61ffc12d8fd8..6c1ada7291df 100644
--- a/drivers/net/can/c_can/Kconfig
+++ b/drivers/net/can/c_can/Kconfig
@@ -20,4 +20,16 @@ config CAN_C_CAN_PCI
 	---help---
 	  This driver adds support for the C_CAN/D_CAN chips connected
 	  to the PCI bus.
+
+config CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	bool "Use 64 message objects for D_CAN"
+	default n
+	---help---
+	  D_CAN supports up to 128 message objects, comparing to 32 on
+	  C_CAN. However, some CPUs with D_CAN controller have their
+	  own limits: TI AM335x Sitara CPU, for example, supports max
+	  of 64 message objects.
+	  Enabling this option extends max D_CAN message objects up to
+	  64.
+
 endif
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 606b7d8ffe13..5d695b89b459 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -352,15 +352,6 @@ static void c_can_setup_tx_object(struct net_device *d=
ev, int iface,
 	}
 }
=20
-static inline void c_can_activate_all_lower_rx_msg_obj(struct net_device *=
dev,
-						       int iface)
-{
-	int i;
-
-	for (i =3D C_CAN_MSG_OBJ_RX_FIRST; i <=3D C_CAN_MSG_RX_LOW_LAST; i++)
-		c_can_object_get(dev, iface, i, IF_COMM_CLR_NEWDAT);
-}
-
 static int c_can_handle_lost_msg_obj(struct net_device *dev,
 				     int iface, int objno, u32 ctrl)
 {
@@ -706,7 +697,16 @@ static void c_can_do_tx(struct net_device *dev)
 	struct net_device_stats *stats =3D &dev->stats;
 	u32 idx, obj, pkts =3D 0, bytes =3D 0, pend, clr;
=20
-	clr =3D pend =3D priv->read_reg(priv, C_CAN_INTPND2_REG);
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	if (priv->type =3D=3D BOSCH_D_CAN) {
+		pend =3D priv->read_reg32(priv, C_CAN_INTPND3_REG);
+	} else {
+#endif
+		pend =3D priv->read_reg(priv, C_CAN_INTPND2_REG);
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	}
+#endif
+	clr =3D pend;
=20
 	while ((idx =3D ffs(pend))) {
 		idx--;
@@ -817,7 +817,17 @@ static int c_can_read_objects(struct net_device *dev, =
struct c_can_priv *priv,
=20
 static inline u32 c_can_get_pending(struct c_can_priv *priv)
 {
-	u32 pend =3D priv->read_reg(priv, C_CAN_NEWDAT1_REG);
+	u32 pend;
+
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	if (priv->type =3D=3D BOSCH_D_CAN) {
+		pend =3D priv->read_reg32(priv, C_CAN_NEWDAT1_REG);
+	} else {
+#endif
+		pend =3D priv->read_reg(priv, C_CAN_NEWDAT1_REG);
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	}
+#endif
=20
 	return pend;
 }
@@ -828,8 +838,7 @@ static inline u32 c_can_get_pending(struct c_can_priv *=
priv)
  * c_can core saves a received CAN message into the first free message
  * object it finds free (starting with the lowest). Bits NEWDAT and
  * INTPND are set for this message object indicating that a new message
- * has arrived. To work-around this issue, we keep two groups of message
- * objects whose partitioning is defined by C_CAN_MSG_OBJ_RX_SPLIT.
+ * has arrived.
  *
  * We clear the newdat bit right away.
  *
@@ -840,13 +849,6 @@ static int c_can_do_rx_poll(struct net_device *dev, in=
t quota)
 	struct c_can_priv *priv =3D netdev_priv(dev);
 	u32 pkts =3D 0, pend =3D 0, toread, n;
=20
-	/*
-	 * It is faster to read only one 16bit register. This is only possible
-	 * for a maximum number of 16 objects.
-	 */
-	BUILD_BUG_ON_MSG(C_CAN_MSG_OBJ_RX_LAST > 16,
-			"Implementation does not support more message objects than 16");
-
 	while (quota > 0) {
 		if (!pend) {
 			pend =3D c_can_get_pending(priv);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8acdc7fa4792..e44b686a70a2 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -23,9 +23,15 @@
 #define C_CAN_H
=20
 /* message object split */
+
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+#define C_CAN_NO_OF_OBJECTS	64
+#else
 #define C_CAN_NO_OF_OBJECTS	32
-#define C_CAN_MSG_OBJ_RX_NUM	16
-#define C_CAN_MSG_OBJ_TX_NUM	16
+#endif
+
+#define C_CAN_MSG_OBJ_TX_NUM	(C_CAN_NO_OF_OBJECTS >> 1)
+#define C_CAN_MSG_OBJ_RX_NUM	(C_CAN_NO_OF_OBJECTS - C_CAN_MSG_OBJ_TX_NUM)
=20
 #define C_CAN_MSG_OBJ_RX_FIRST	1
 #define C_CAN_MSG_OBJ_RX_LAST	(C_CAN_MSG_OBJ_RX_FIRST + \
@@ -35,9 +41,11 @@
 #define C_CAN_MSG_OBJ_TX_LAST	(C_CAN_MSG_OBJ_TX_FIRST + \
 				C_CAN_MSG_OBJ_TX_NUM - 1)
=20
-#define C_CAN_MSG_OBJ_RX_SPLIT	9
-#define C_CAN_MSG_RX_LOW_LAST	(C_CAN_MSG_OBJ_RX_SPLIT - 1)
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+#define RECEIVE_OBJECT_BITS	0xffffffff
+#else
 #define RECEIVE_OBJECT_BITS	0x0000ffff
+#endif
=20
 enum reg {
 	C_CAN_CTRL_REG =3D 0,
@@ -76,6 +84,8 @@ enum reg {
 	C_CAN_NEWDAT2_REG,
 	C_CAN_INTPND1_REG,
 	C_CAN_INTPND2_REG,
+	C_CAN_INTPND3_REG,
+	C_CAN_INTPND4_REG,
 	C_CAN_MSGVAL1_REG,
 	C_CAN_MSGVAL2_REG,
 	C_CAN_FUNCTION_REG,
@@ -137,6 +147,8 @@ static const u16 reg_map_d_can[] =3D {
 	[C_CAN_NEWDAT2_REG]	=3D 0x9E,
 	[C_CAN_INTPND1_REG]	=3D 0xB0,
 	[C_CAN_INTPND2_REG]	=3D 0xB2,
+	[C_CAN_INTPND3_REG]	=3D 0xB4,
+	[C_CAN_INTPND4_REG]	=3D 0xB6,
 	[C_CAN_MSGVAL1_REG]	=3D 0xC4,
 	[C_CAN_MSGVAL2_REG]	=3D 0xC6,
 	[C_CAN_IF1_COMREQ_REG]	=3D 0x100,
--=20
2.11.0

