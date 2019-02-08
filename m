Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5C4C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6875F20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netmodule.onmicrosoft.com header.i=@netmodule.onmicrosoft.com header.b="Bw8E7Yxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfBHNbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:31:10 -0500
Received: from mail-eopbgr00130.outbound.protection.outlook.com ([40.107.0.130]:31664
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726600AbfBHNbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector1-netmodule-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Po4d8KdGZjFGcHpUQIvblsu22Ia/68rz9Y34tNjwok=;
 b=Bw8E7YxpWQ+86tZu/yQKVSX+KMM87thW/uX/aVDOpr9Euxo+vMp0FnecQsqprTm1c0BWjzZ9VPPiPl3etEdmVTygkz38SpmUmmyAmcOPV2eHVONjoQhAgj7SnYy8Dh0lU0p/UU55ZA34lgc6ByL8XdzQL+kol7mZyY5JAzed7vQ=
Received: from AM0PR06MB4419.eurprd06.prod.outlook.com (20.176.214.91) by
 AM0PR06MB4148.eurprd06.prod.outlook.com (52.135.149.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 13:31:00 +0000
Received: from AM0PR06MB4419.eurprd06.prod.outlook.com
 ([fe80::df9:4308:d40a:e0f9]) by AM0PR06MB4419.eurprd06.prod.outlook.com
 ([fe80::df9:4308:d40a:e0f9%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 13:31:00 +0000
From:   Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Patrick Zysset <Patrick.Zysset@netmodule.com>
Subject: [PATCH 1/2] can: c_can: support 64 message objects for D_CAN
Thread-Topic: [PATCH 1/2] can: c_can: support 64 message objects for D_CAN
Thread-Index: AQHUv7KIJmH81DwGaUGzeGUutsDCCQ==
Date:   Fri, 8 Feb 2019 13:31:00 +0000
Message-ID: <20190208132954.28166-2-andrejs.cainikovs@netmodule.com>
References: <20190208132954.28166-1-andrejs.cainikovs@netmodule.com>
In-Reply-To: <20190208132954.28166-1-andrejs.cainikovs@netmodule.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0007.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::17) To AM0PR06MB4419.eurprd06.prod.outlook.com
 (2603:10a6:208:bf::27)
x-mailer: git-send-email 2.11.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrejs.Cainikovs@netmodule.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.130.140.44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR06MB4148;6:BasvOrdA2wfLNPIhGUy778+WBBFUGIqWzJDiUUCuprsGT2x+LNYqYht4KRSq0eNPRyipOW1/cDTOtm+WSY+R3WUdEYPW11KDM3JY03atvPnbZy+TZrFq+rmqtR5hzVVLPGAAqi7mP26jHpyTs9xkiq0s1mxTaElyr0x3B+EUKYlWMylkzUUAVPXQC3ZAO7n0D+2YR9HitHhTQUyJEKYs+7biK1T3C22UxcDCHW8dzy2Hi8S3cs3eCQSYOxzF5gd1aZjVAk99qfwB3HPnMqXtswCcfVv9hA9jvSweiSQNlpF+FdntMahwB7Dex9MKO4mimK7uL2m7oHNMrJYrpqSlJkYL6O0CnFSXXV6nzhyTjGbD2J3BxaiPMZiz2U2RAkEvOYshjlVKKm1QreB3gRUGM8D8a5Ajzmyu968ng2cZCl54SxplQp3d5l8DmAE14t1AiPSOtONmZy3t2v9KedyAkw==;5:v347yN3bD+SxnXZXsaFm62+WnR7U95vEZHrQ5LDBUhIAFBMH/z/L649HShP/WVPFdUP0plGilKkkDaOlrb/ehOMvB5RPCucs+ZQpUcTVu9EzMP5WZ1w390F7EQmT9C/bnMnuD2J/Vqp4RQclV13C0KRWGp2y1GXgZXbe2WfitmfS8F9QKqKHdQRiikBJyYka/6Gy06w/odHfJt9R6RE2xA==;7:tk+KKh5MTt13ekklGPo8bqiJRser8pnscUBXmM3vCB9NwPsqDZJwWdtjErK13+jieawYslxmpC3IYyCNAgcLP7ji166diqKnEWcu3UUvbuMGHwUqq2n0vvorqGiunNTNqKLcc0763LazCUWHcC0ZeA==
x-ms-office365-filtering-correlation-id: ceabccf4-d4cb-4f4c-27f9-08d68dc9aa6b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM0PR06MB4148;
x-ms-traffictypediagnostic: AM0PR06MB4148:
x-microsoft-antispam-prvs: <AM0PR06MB4148916D5CB89B780640CC13F6690@AM0PR06MB4148.eurprd06.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39840400004)(366004)(199004)(189003)(52116002)(2616005)(81156014)(36756003)(99286004)(6486002)(107886003)(316002)(68736007)(53936002)(76176011)(110136005)(11346002)(305945005)(476003)(7736002)(50226002)(86362001)(8936002)(486006)(6436002)(81166006)(1076003)(44832011)(71190400001)(71200400001)(2201001)(97736004)(8676002)(186003)(26005)(446003)(6512007)(386003)(4326008)(3846002)(2906002)(6506007)(106356001)(105586002)(102836004)(2501003)(14454004)(15650500001)(6116002)(256004)(14444005)(25786009)(72206003)(66066001)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR06MB4148;H:AM0PR06MB4419.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netmodule.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1A7YOZip5md4rOeiusqWSuvYRE338aAnjMlU66h4fB+yZOfvomFTJVo/wtsTiyGA6kz7+LB6Yk3jwqllJKWUlTIUs3RfaUUtaApFONBUrS0CaBIqEp90zRb/bgfKDxJM7LOa7foOqlQh3GF3UEiOsev8Aa3q4Q6EyeKqliCR+XltyotLfuE3lXokahSKVqyu2Ao50HFtrAF4Bq5gVwKhbuW6+9XWcY5if5ijInhkxGb1EZwwlQxHNZAaL3DJ483kn3nye8JsNPZDiQZHJCIgLarNAhYcIXU4HRriLLLMUE1zPfW6hZSfvLfZm7kzpSEtSJVhRSVOIv5dt//okXp7LTEvToRk9t8IrDivezsD70bcpl3FjhqhzY9ZsdM+5mOL0iskAtaG+/1OoDYQgYRcYedTeOLL0G0UK8vkmAtuSzE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceabccf4-d4cb-4f4c-27f9-08d68dc9aa6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 13:31:00.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB4148
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

