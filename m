Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23328C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7C4217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netmodule.onmicrosoft.com header.i=@netmodule.onmicrosoft.com header.b="pkfUi1/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfBHNSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:18:01 -0500
Received: from mail-eopbgr40133.outbound.protection.outlook.com ([40.107.4.133]:6160
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726568AbfBHNR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector1-netmodule-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8FopNCwfvfj6btb8vbIRn3zROm3htSoHfr+6jeqAC8=;
 b=pkfUi1/yTpgOiJ5+UmfzdIFsuzNl7nPjg4g7HKdAHrd9DptQcqQWSAnvedc6jlH+VO48fJcjkms66GLdLE2ZZtDQBpyFCBbXnfruNqGsT/LSh6MqP7PiKBTvVrj0zovhrmL//xv3Mrbk7sLebmjgDT0qOjRW28OedfmI01ycYj0=
Received: from AM0PR06MB4419.eurprd06.prod.outlook.com (20.176.214.91) by
 AM0PR06MB5826.eurprd06.prod.outlook.com (20.178.83.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 13:17:51 +0000
Received: from AM0PR06MB4419.eurprd06.prod.outlook.com
 ([fe80::df9:4308:d40a:e0f9]) by AM0PR06MB4419.eurprd06.prod.outlook.com
 ([fe80::df9:4308:d40a:e0f9%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 13:17:51 +0000
From:   Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Patrick Zysset <Patrick.Zysset@netmodule.com>
Subject: [PATCH 2/2] can: c_can: configurable amount of D_CAN RX objects
Thread-Topic: [PATCH 2/2] can: c_can: configurable amount of D_CAN RX objects
Thread-Index: AQHUv7CxQedJvANyU0OiPWNcCgLqpQ==
Date:   Fri, 8 Feb 2019 13:17:50 +0000
Message-ID: <20190208131738.27668-3-andrejs.cainikovs@netmodule.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR06MB5826;6:lAbZP1bOXM0q0BlTMg4pkpgjTq2dQSwLn19S0pUTZh6hjOU45FnOwS9sfVNR8kE+kqubyL3wBO5TN3v6HG5SeBXUKJklbDPt/WM4PtrP1fg3M+e4/CnkebsctYOckt6NAmLSiHupoNUpVmUU1y44hMRQQCr43y1cnpEr2aLGdXbbkWKqMpw1txCJL37VklZGhB++RyAnYO/A2JFtll1wBr2h2xyP346rENYU9lbmfM7M9x8cyEdAerZHJCYjmJH+7JI5o1JycXsOFKnFiIQof5MsaqSe6Gsf8hJF9BvjE+/+Swb9ABNF63fzvQxzOiIN7BQ7dY+wFikbD4P/8+LTiDfvOFx06WAC1NH37Qf7HGy7JEqoZCbbIdvt3GNPQ0OKXdBecC3/vRcSRMzRFf6ta1HpMQfIuMIwTyxob+C+LUDjagBh7oDvAV6EIZx5u+J84t0jATlplxBZEQv1ZKOAIA==;5:GD9U0Q21tae4eV0xVJIxgLT61kruq9YP9RYi67Es51VT7zkqCgXjWTf10A66ib/n8a3uWElJMqJKt4OZ2myY445/QH0qt8UtbLsjY/7o6fzKxfEzXtQONayhnVeKpW+ASa1X7OH4qTuKnTvjghEgvlw/8to+tL4xytph516AIqWMfEgY+mEVXplZznHVqyhcpf6892A9ftBNh7tojYfMRg==;7:emyDlEEVEQr5sXyBKi9AGfYCytm4PyaNkmgMZs9NzeCD7h7N2HWKRGwQDEqP/MD8pR6tluJYMZP+4NGL5aSFiUYxYZtOjF6knx3JMwiJW9ZWpzAshLTIEGYj0MagqWIa69xlVRV+zTyf6GY7yK3FFw==
x-ms-office365-filtering-correlation-id: 045fab26-911c-4704-c630-08d68dc7d38d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM0PR06MB5826;
x-ms-traffictypediagnostic: AM0PR06MB5826:
x-microsoft-antispam-prvs: <AM0PR06MB58267EC74C0A7B70402C99C5F6690@AM0PR06MB5826.eurprd06.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(366004)(396003)(136003)(376002)(346002)(199004)(189003)(99286004)(97736004)(3846002)(6116002)(476003)(107886003)(14454004)(4326008)(53936002)(2906002)(508600001)(52116002)(25786009)(72206003)(446003)(76176011)(486006)(2501003)(44832011)(386003)(68736007)(6506007)(11346002)(26005)(2616005)(316002)(71200400001)(71190400001)(568814002)(7736002)(6512007)(34290500002)(50226002)(6486002)(102836004)(105586002)(8676002)(81156014)(81166006)(6436002)(1076003)(8936002)(186003)(106356001)(86362001)(36756003)(2201001)(110136005)(66066001)(256004)(14444005)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR06MB5826;H:AM0PR06MB4419.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netmodule.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X+4T2PgIxvz9Sziur3EIa+wzbifAl3vUPfDLTdHMgqEMc26qRq8a5Bqb1vdLkY8qq+axkg9B2/fq4xGsR/VqizjYLZ+BhH04hhdap8gF6nx6lzjM48tiCIpuO3nM0bXAtlHqVJ0BkXvS/SbSqeCWYpKbLqbtVXdlQ9Y446nZQN7eQ3IpU1UV6uViK6cd9z1yTzsKuoxz5HuyVgHq30CMF7GwYEi+y6W+KEKTF5xtqw9apQttkoaVuuXdFZgeruLKK6Hw+Z3g9KfN2Yv17BtBReddg+4f9AuLnY4EBmaJde+cr0FIy0YBVwzPw/jDEavDMJGF3ftJksE0KiPjM3RPv3RynZR2EFk0lbOwZEiSg3LhTrORNUuAuWfZp1JYhREDU5M417gFnr1FNW9+nJXGTcoU0K9mpVMPBVz/v4crsDM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045fab26-911c-4704-c630-08d68dc7d38d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 13:17:50.2382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB5826
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make number of D_CAN RX message objects configurable. This will allow
having bigger (or smaller) RX buffer instead of 50/50 split for RX/TX.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>
---
 drivers/net/can/c_can/Kconfig |  8 ++++++
 drivers/net/can/c_can/c_can.c | 64 +++++++++++++++++++++++++++++----------=
----
 drivers/net/can/c_can/c_can.h | 16 +++++------
 3 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/drivers/net/can/c_can/Kconfig b/drivers/net/can/c_can/Kconfig
index 6c1ada7291df..949d2d12d71e 100644
--- a/drivers/net/can/c_can/Kconfig
+++ b/drivers/net/can/c_can/Kconfig
@@ -32,4 +32,12 @@ config CAN_C_CAN_DCAN_64_MSG_OBJECTS
 	  Enabling this option extends max D_CAN message objects up to
 	  64.
=20
+config CAN_C_CAN_DCAN_RX_MSG_OBJECTS
+	int "Specify amount of D_CAN RX message objects"
+	depends on CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	default 32
+	---help---
+	  Use specific number of message objects for RX, instead of
+	  50/50 split between RX/TX.
+
 endif
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 5d695b89b459..675bc223e222 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -208,6 +208,26 @@ static const struct can_bittiming_const c_can_bittimin=
g_const =3D {
 	.brp_inc =3D 1,
 };
=20
+static inline u64 c_can_get_mask(int bits)
+{
+	return ((u64)1 << bits) - 1;
+}
+
+static inline int c_can_ffs64(u64 x)
+{
+	int b;
+
+	b =3D ffs(x);
+
+	if (!b) {
+		b =3D ffs(x >> 32);
+		if (b)
+			b +=3D 32;
+	}
+
+	return b;
+}
+
 static inline void c_can_pm_runtime_enable(const struct c_can_priv *priv)
 {
 	if (priv->device)
@@ -695,24 +715,23 @@ static void c_can_do_tx(struct net_device *dev)
 {
 	struct c_can_priv *priv =3D netdev_priv(dev);
 	struct net_device_stats *stats =3D &dev->stats;
-	u32 idx, obj, pkts =3D 0, bytes =3D 0, pend, clr;
+	u32 idx, obj, pkts =3D 0, bytes =3D 0;
+	u64 pend, clr;
=20
+	/* Mask interrupt pending bits */
+	pend =3D priv->read_reg32(priv, C_CAN_INTPND1_REG);
 #ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
 	if (priv->type =3D=3D BOSCH_D_CAN) {
-		pend =3D priv->read_reg32(priv, C_CAN_INTPND3_REG);
-	} else {
-#endif
-		pend =3D priv->read_reg(priv, C_CAN_INTPND2_REG);
-#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+		pend |=3D (u64)priv->read_reg32(priv, C_CAN_INTPND3_REG) << 32;
 	}
 #endif
-	clr =3D pend;
+	pend &=3D ~c_can_get_mask(C_CAN_MSG_OBJ_RX_NUM);
+	clr =3D pend >> C_CAN_MSG_OBJ_RX_NUM;
=20
-	while ((idx =3D ffs(pend))) {
-		idx--;
-		pend &=3D ~(1 << idx);
-		obj =3D idx + C_CAN_MSG_OBJ_TX_FIRST;
+	while ((obj =3D c_can_ffs64(pend))) {
+		pend &=3D ~((u64)1 << (obj - 1));
 		c_can_inval_tx_object(dev, IF_RX, obj);
+		idx =3D obj - C_CAN_MSG_OBJ_TX_FIRST;
 		can_get_echo_skb(dev, idx);
 		bytes +=3D priv->dlc[idx];
 		pkts++;
@@ -736,19 +755,19 @@ static void c_can_do_tx(struct net_device *dev)
  * raced with the hardware or failed to readout all upper
  * objects in the last run due to quota limit.
  */
-static u32 c_can_adjust_pending(u32 pend)
+static u64 c_can_adjust_pending(u64 pend)
 {
-	u32 weight, lasts;
+	u64 weight, lasts;
=20
-	if (pend =3D=3D RECEIVE_OBJECT_BITS)
+	if (pend =3D=3D c_can_get_mask(C_CAN_MSG_OBJ_RX_NUM))
 		return pend;
=20
 	/*
 	 * If the last set bit is larger than the number of pending
 	 * bits we have a gap.
 	 */
-	weight =3D hweight32(pend);
-	lasts =3D fls(pend);
+	weight =3D hweight64(pend);
+	lasts =3D fls64(pend);
=20
 	/* If the bits are linear, nothing to do */
 	if (lasts =3D=3D weight)
@@ -777,11 +796,11 @@ static inline void c_can_rx_finalize(struct net_devic=
e *dev,
 }
=20
 static int c_can_read_objects(struct net_device *dev, struct c_can_priv *p=
riv,
-			      u32 pend, int quota)
+			      u64 pend, int quota)
 {
 	u32 pkts =3D 0, ctrl, obj;
=20
-	while ((obj =3D ffs(pend)) && quota > 0) {
+	while ((obj =3D c_can_ffs64(pend)) && quota > 0) {
 		pend &=3D ~BIT(obj - 1);
=20
 		c_can_rx_object_get(dev, priv, obj);
@@ -815,13 +834,15 @@ static int c_can_read_objects(struct net_device *dev,=
 struct c_can_priv *priv,
 	return pkts;
 }
=20
-static inline u32 c_can_get_pending(struct c_can_priv *priv)
+static inline u64 c_can_get_pending(struct c_can_priv *priv)
 {
-	u32 pend;
+	u64 pend;
=20
 #ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
 	if (priv->type =3D=3D BOSCH_D_CAN) {
 		pend =3D priv->read_reg32(priv, C_CAN_NEWDAT1_REG);
+		pend |=3D (u64)priv->read_reg32(priv, C_CAN_NEWDAT3_REG) << 32;
+		pend &=3D c_can_get_mask(C_CAN_MSG_OBJ_RX_NUM);
 	} else {
 #endif
 		pend =3D priv->read_reg(priv, C_CAN_NEWDAT1_REG);
@@ -847,7 +868,8 @@ static inline u32 c_can_get_pending(struct c_can_priv *=
priv)
 static int c_can_do_rx_poll(struct net_device *dev, int quota)
 {
 	struct c_can_priv *priv =3D netdev_priv(dev);
-	u32 pkts =3D 0, pend =3D 0, toread, n;
+	u32 pkts =3D 0, n;
+	u64 pend =3D 0, toread;
=20
 	while (quota > 0) {
 		if (!pend) {
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index e44b686a70a2..4a0759ee249d 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -26,12 +26,12 @@
=20
 #ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
 #define C_CAN_NO_OF_OBJECTS	64
+#define C_CAN_MSG_OBJ_RX_NUM	CONFIG_CAN_C_CAN_DCAN_RX_MSG_OBJECTS
 #else
 #define C_CAN_NO_OF_OBJECTS	32
+#define C_CAN_MSG_OBJ_RX_NUM	16
 #endif
-
-#define C_CAN_MSG_OBJ_TX_NUM	(C_CAN_NO_OF_OBJECTS >> 1)
-#define C_CAN_MSG_OBJ_RX_NUM	(C_CAN_NO_OF_OBJECTS - C_CAN_MSG_OBJ_TX_NUM)
+#define C_CAN_MSG_OBJ_TX_NUM	(C_CAN_NO_OF_OBJECTS - C_CAN_MSG_OBJ_RX_NUM)
=20
 #define C_CAN_MSG_OBJ_RX_FIRST	1
 #define C_CAN_MSG_OBJ_RX_LAST	(C_CAN_MSG_OBJ_RX_FIRST + \
@@ -41,12 +41,6 @@
 #define C_CAN_MSG_OBJ_TX_LAST	(C_CAN_MSG_OBJ_TX_FIRST + \
 				C_CAN_MSG_OBJ_TX_NUM - 1)
=20
-#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
-#define RECEIVE_OBJECT_BITS	0xffffffff
-#else
-#define RECEIVE_OBJECT_BITS	0x0000ffff
-#endif
-
 enum reg {
 	C_CAN_CTRL_REG =3D 0,
 	C_CAN_CTRL_EX_REG,
@@ -82,6 +76,8 @@ enum reg {
 	C_CAN_TXRQST2_REG,
 	C_CAN_NEWDAT1_REG,
 	C_CAN_NEWDAT2_REG,
+	C_CAN_NEWDAT3_REG,
+	C_CAN_NEWDAT4_REG,
 	C_CAN_INTPND1_REG,
 	C_CAN_INTPND2_REG,
 	C_CAN_INTPND3_REG,
@@ -145,6 +141,8 @@ static const u16 reg_map_d_can[] =3D {
 	[C_CAN_TXRQST2_REG]	=3D 0x8A,
 	[C_CAN_NEWDAT1_REG]	=3D 0x9C,
 	[C_CAN_NEWDAT2_REG]	=3D 0x9E,
+	[C_CAN_NEWDAT3_REG]	=3D 0xA0,
+	[C_CAN_NEWDAT4_REG]	=3D 0xA2,
 	[C_CAN_INTPND1_REG]	=3D 0xB0,
 	[C_CAN_INTPND2_REG]	=3D 0xB2,
 	[C_CAN_INTPND3_REG]	=3D 0xB4,
--=20
2.11.0

