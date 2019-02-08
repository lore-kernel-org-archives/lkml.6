Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF90C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A2B20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netmodule.onmicrosoft.com header.i=@netmodule.onmicrosoft.com header.b="iLXFBYHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfBHNbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:31:14 -0500
Received: from mail-eopbgr00130.outbound.protection.outlook.com ([40.107.0.130]:31664
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbfBHNbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector1-netmodule-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8FopNCwfvfj6btb8vbIRn3zROm3htSoHfr+6jeqAC8=;
 b=iLXFBYHOLeVcWdibHmBZMPcSQKSz92oKPWTUzrbldwAVxAphytiocXuJZJ9FWrk8vzvQzNqO9d2kUdvuZiMv6U2pZltuIKk1lGMboTPxMrkM5ZT28/1SrDfMI0zB8f82+J+JnpHEG1FWf+FPpGueVxKIQnSkJOkEyusiDSML4jw=
Received: from AM0PR06MB4419.eurprd06.prod.outlook.com (20.176.214.91) by
 AM0PR06MB4148.eurprd06.prod.outlook.com (52.135.149.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 13:31:01 +0000
Received: from AM0PR06MB4419.eurprd06.prod.outlook.com
 ([fe80::df9:4308:d40a:e0f9]) by AM0PR06MB4419.eurprd06.prod.outlook.com
 ([fe80::df9:4308:d40a:e0f9%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 13:31:01 +0000
From:   Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Patrick Zysset <Patrick.Zysset@netmodule.com>
Subject: [PATCH 2/2] can: c_can: configurable amount of D_CAN RX objects
Thread-Topic: [PATCH 2/2] can: c_can: configurable amount of D_CAN RX objects
Thread-Index: AQHUv7KI+h2CDSL+Q06AGE8hlr6fIA==
Date:   Fri, 8 Feb 2019 13:31:01 +0000
Message-ID: <20190208132954.28166-3-andrejs.cainikovs@netmodule.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR06MB4148;6:fRdMY430THeUFNlEJMteIVK1E585xhC2IWQk7nRmJWgC3qeMdO2BKd7pof8DpxByHRW6CA62nmmkfPUzpgqAZF4bsPmJUnZU4zRIMv0rNG4xTCE1zCwvquIGMoUrjTOq7ESiSxBrJb1nqPUCwmHp+VN9h9RVNtycozmdLOnaAgYjC7n1Xy3BDY4QMo3fbSciNQ5RuTbdeFCDWWkRkYC6st2CQbuRKQU+P7IdiNOnko+Ro9dHFyIh2JWgEWabH2FL0+cedeB0fzWd8vrzjCtLT74U1kFE4wgJmcueo8xKuTgO/zJAeJ3gf/ZuIp8h9pFBko65wu/Pq24d+NipgrOlzSjL9cEot08R07oE94PVtScIoC/YpL11PBNulH+T3qc/5IyUD58pj1z9CqtMGiu2pDPvAE+tPG2Xo5i8rOLYjd8IyjFM+MJmmW6Bh8tNmwfBeef29G5ILw7krvA0QDcmWQ==;5:45pa3Ffi5V3XQilGBvQfHZ7MGI3AbbumjSTndms0/CyJiv0eFkAQQof1TQXETbnqTk+CXTnhreyZkDvTgIGTv4HEfUicZCpc1QtF2FlL/PJcTPjbip6OmwHJ/3U3HaJ8AWPuC7Ypatcus2btEyHiQSRZ0MnfvFW7uMwoWUhaQiH1YMt1IINqerzMVsTEWH5Wf7zS01Cn60rhele9eRiHyg==;7:POPDgW9E48rLgnx1cnLwb7vnSAwlmHNwL8QUpc6Wn1Kv4OKRnF/++b3ia5G3xcYvZ0XJ/Sq10UWoDrTCV1a8LLV9zOvhicBa8G0dQhJsi4TNeG6WnEhKWGrdQNDERhbrNxV72KgcyuDi6/XjAeTDWw==
x-ms-office365-filtering-correlation-id: 8e494651-0f5d-49da-b57c-08d68dc9aad9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM0PR06MB4148;
x-ms-traffictypediagnostic: AM0PR06MB4148:
x-microsoft-antispam-prvs: <AM0PR06MB4148CDA89AF388CCAC89F1C4F6690@AM0PR06MB4148.eurprd06.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(376002)(396003)(136003)(39840400004)(366004)(199004)(189003)(52116002)(2616005)(81156014)(36756003)(99286004)(568814002)(6486002)(34290500002)(107886003)(316002)(68736007)(53936002)(76176011)(110136005)(11346002)(305945005)(476003)(7736002)(50226002)(86362001)(8936002)(486006)(6436002)(81166006)(1076003)(44832011)(71190400001)(71200400001)(2201001)(97736004)(8676002)(186003)(26005)(446003)(6512007)(386003)(4326008)(3846002)(2906002)(6506007)(106356001)(105586002)(102836004)(2501003)(14454004)(6116002)(256004)(14444005)(25786009)(72206003)(66066001)(508600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR06MB4148;H:AM0PR06MB4419.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netmodule.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8kUcgtVdPQLe2SfVpIk5tjO0TASY1MSoOUuHmPNS86fcNV3uADZQ/wP3Non6P7+u7h8bNKrtVGkvSBcVD8nmIvZs0pGh3gOZtqn0LEPFqD94cRSSoOIkk67JLiL7vC7XqXm+9xEFxeWn7l9Y5eruzjK1kFVOwtfPgFtVA92D5r1gdIsLPUo7FuiZFSmocd7LtYzjACc8nhgSfv3R9MhE6ChwUCf6uVR5uxLM8d7PFuuOthDxHWlQJ91Pgdf0/1dFI905Q1M8fRn9+0Lf63THEOT8A7LGRfW6VPs9JkDFZ0wz1RHRwduCn/hG+eQdiXIK44Vvyo3qW4DSJEEdp0HhnQ/lEV2aQPNtG9iPB/0MURV3Vfl3FEGJ1S4/JApAZV/tQCXDX4nHUtIp9N7SIJ7GXoTtdLOxIhHXG2UN+trgcnk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e494651-0f5d-49da-b57c-08d68dc9aad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 13:31:00.9448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB4148
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

