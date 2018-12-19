Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6D820874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YvzsHYlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeLSIjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:39:16 -0500
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:28016
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728498AbeLSIjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pixVpbyP6F6zwXhp8QmtdYmcavrGfrdvN8Zph1CHJA=;
 b=YvzsHYlqJ0ketIIZis7bwiyHbzXk9/dUp6LB3DCjPS6Iuc0SD0+dYcXTQBUA03b64XZb9Ep6cEsk5B56hbQsettnCgtcEycRx85yS2sT9nULyBpt2Q6vChJC3/EKvDVQXJvknZzBvbLaPBq38TuTBB/IwRCsGgv4nRP4Ct7jl5k=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5226.eurprd04.prod.outlook.com (20.176.236.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 19 Dec 2018 08:39:03 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9%4]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 08:39:03 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 2/3] can: flexcan: add CAN FD mode support
Thread-Topic: [PATCH 2/3] can: flexcan: add CAN FD mode support
Thread-Index: AQHUl3ZLqGOkAG4wt0uK7OPQk9eyzw==
Date:   Wed, 19 Dec 2018 08:39:03 +0000
Message-ID: <20181219083637.641-3-qiangqing.zhang@nxp.com>
References: <20181219083637.641-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181219083637.641-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR0601CA0014.apcprd06.prod.outlook.com (2603:1096:3::24)
 To DB7PR04MB4618.eurprd04.prod.outlook.com (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5226;6:tQNwe0/SGNFwcQQuHxIGANk7qtp+ZO6NZOyj1PYppBhgtrZcirjqRz7ie8CYQK5MLdptnzVSVc1sNnw3Yi3WT3uYOY03PWNvzLY5Ez2M9ob0VaJZ0Uv2Oy83QJrlNIKdpgXiv3GLf9KEWjyh+rrl2AK81F4bBCcmNfjKjk9u7Ok1/UxebOEIFTEyNlG1uUsGGN/xwFYvqox3WH8oSs9j69+YCkn9unaFM1pekvg1nrvuEk5P6T23dqOzkL9sJFhdyRUP1+7Gj7D3tjm4l2PWMAnztfhnOWvigBExtXwjIJeuvo1/bWByDQ5/efxBJBGra0PzW5bB9M9Je+rssq4C18qseCXTYqjCtgcJk4cX3Kq6pymZKodsl/drm/tZs3BU38zDlZwaq6pC/puVNUIIL0rt0lQEtlqKmprXmATehcuB8LP8EEIhHN9McXVDVfILtY8iIKyvTZbyDBXtfaGs/Q==;5:dHxVThB+NIBU4ZBQnX5s4ljfqbzHyIsnSac09LJyOpK9kHp5Cd6VGAMNaSDHKKVCExOtIg00i9iGWUfSijV4Wos7tfSYLIce2JB92008r2oSqOKXPPfVCMPyaYeYg0tYBrLKtWUo4tQCitgiLot4bXyrhxTHgESNdAPa3uvstJg=;7:3JGhUUZJkRur9/kyNzbIGSlAf+65w54aQeFxoyLsJ2yy76kWzV02+5CmAXbno8iWUNPdNfONcsKTJPvQYDqoiGEEW+mMlHOhwdpC3MSab8ye8zdzrJn4NeLErVP+akpsRIbxJEnH5xZOxMK3lStUVQ==
x-ms-office365-filtering-correlation-id: 41fae17c-7eb2-4efa-d8c2-08d6658d6e45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5226;
x-ms-traffictypediagnostic: DB7PR04MB5226:
x-microsoft-antispam-prvs: <DB7PR04MB52264BC6455E188CA176F50AE6BE0@DB7PR04MB5226.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5226;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5226;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(316002)(110136005)(54906003)(14444005)(186003)(26005)(97736004)(8676002)(6436002)(7736002)(6486002)(50226002)(2501003)(81166006)(8936002)(6116002)(575784001)(52116002)(6506007)(76176011)(86362001)(102836004)(386003)(3846002)(2906002)(36756003)(81156014)(53936002)(71190400001)(6512007)(71200400001)(66066001)(1076003)(68736007)(105586002)(305945005)(106356001)(4326008)(446003)(486006)(2616005)(476003)(11346002)(25786009)(99286004)(5660300001)(14454004)(256004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5226;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RqeO3yLDpCQ+RIL7ioENo/WUrVyUSgqbcdAKwFtA8gzQs6g8AZWT0sgAnFeADmPhNnysH/XExPK9+2urlw1jaVb5MPx+GAGx42etv9QDL7YF9aDp92Jc4yct8okhhhAbAQOPT13jaFgF+ur85xaiC0VTMmo6/sHUukbzf7NZmYOCbdq0ztH7GwIsieFrMV1KEa/F7XpPASkRnTVkraUkdlv5YFrJKa7CdXUaxFqYMek4ibSV4AAgDYgZ9w8+eOEsb0EzMaUvUeh/AmwtxXf6F6tm3WeT0Dv8jEhVMbwQhjP4sFJGcUi9zGodZKRhx6Zo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fae17c-7eb2-4efa-d8c2-08d6658d6e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 08:39:03.7271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

This patch intends to add CAN FD mode support in driver, it means that
payload size can extend up to 64 bytes.

NOTE: Bit rate switch (BRS) enabled by system reset when it enables CAN
FD mode. So CAN hardware has support BRS, but now driver has not support
it due to bit timing must set in CBT register other than CTRL1 register.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 107 ++++++++++++++++++++++++++++++++++----
 1 file changed, 97 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eafe3ac1..0fc77d4e8ade 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -51,6 +51,7 @@
 #define FLEXCAN_MCR_IRMQ		BIT(16)
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
+#define FLEXCAN_MCR_FDEN		BIT(11)
 /* MCR_MAXMB: maximum used MBs is MAXMB + 1 */
 #define FLEXCAN_MCR_MAXMB(x)		((x) & 0x7f)
 #define FLEXCAN_MCR_IDAM_A		(0x0 << 8)
@@ -136,6 +137,19 @@
 	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
 	 FLEXCAN_ESR_WAK_INT)
=20
+/* FLEXCAN FD control register (FDCTRL) bits */
+#define FLEXCAN_FDCTRL_MBDSR3(x)	(((x) & 0x3) << 25)
+#define FLEXCAN_FDCTRL_MBDSR2(x)	(((x) & 0x3) << 22)
+#define FLEXCAN_FDCTRL_MBDSR1(x)	(((x) & 0x3) << 19)
+#define FLEXCAN_FDCTRL_MBDSR0(x)	(((x) & 0x3) << 16)
+
+/* FLEXCAN FD Bit Timing register (FDCBT) bits */
+#define FLEXCAN_FDCBT_FPRESDIV(x)	(((x) & 0x3ff) << 20)
+#define FLEXCAN_FDCBT_FRJW(x)		(((x) & 0x07) << 16)
+#define FLEXCAN_FDCBT_FPROPSEG(x)	(((x) & 0x1f) << 10)
+#define FLEXCAN_FDCBT_FPSEG1(x)		(((x) & 0x07) << 5)
+#define FLEXCAN_FDCBT_FPSEG2(x)		((x) & 0x07)
+
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
 #define FLEXCAN_TX_MB_RESERVED_OFF_FIFO		8
@@ -147,6 +161,10 @@
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
=20
 /* FLEXCAN message buffers */
+#define FLEXCAN_MB_CNT_EDL		BIT(31)
+#define FLEXCAN_MB_CNT_BRS		BIT(30)
+#define FLEXCAN_MB_CNT_ESI		BIT(29)
+
 #define FLEXCAN_MB_CODE_MASK		(0xf << 24)
 #define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
 #define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
@@ -191,6 +209,7 @@
 #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error p=
assive */
 #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE register =
access */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE		BIT(8) /* Setup stop mode to suppor=
t wakeup */
+#define FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD	BIT(9) /* Use timestamp then su=
pport can fd mode */
=20
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -249,6 +268,9 @@ struct flexcan_regs {
 	u32 rerrdr;		/* 0xaf4 */
 	u32 rerrsynr;		/* 0xaf8 */
 	u32 errsr;		/* 0xafc */
+	u32 _reserved7[64];     /* 0xb00 */
+	u32 fdctrl;             /* 0xc00 */
+	u32 fdcbt;              /* 0xc04 */
 };
=20
 struct flexcan_devtype_data {
@@ -333,6 +355,18 @@ static const struct can_bittiming_const flexcan_bittim=
ing_const =3D {
 	.brp_inc =3D 1,
 };
=20
+static const struct can_bittiming_const flexcan_fd_data_bittiming_const =
=3D {
+	.name =3D DRV_NAME,
+	.tseg1_min =3D 1,
+	.tseg1_max =3D 39,
+	.tseg2_min =3D 1,
+	.tseg2_max =3D 8,
+	.sjw_max =3D 8,
+	.brp_min =3D 1,
+	.brp_max =3D 1024,
+	.brp_inc =3D 1,
+};
+
 /* FlexCAN module is essentially modelled as a little-endian IP in most
  * SoCs, i.e the registers as well as the message buffer areas are
  * implemented in a little-endian fashion.
@@ -590,10 +624,10 @@ static int flexcan_get_berr_counter(const struct net_=
device *dev,
 static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
 {
 	const struct flexcan_priv *priv =3D netdev_priv(dev);
-	struct can_frame *cf =3D (struct can_frame *)skb->data;
+	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
 	u32 can_id;
 	u32 data;
-	u32 ctrl =3D FLEXCAN_MB_CODE_TX_DATA | (cf->can_dlc << 16);
+	u32 ctrl =3D FLEXCAN_MB_CODE_TX_DATA | ((can_len2dlc(cf->len)) << 16);
 	int i;
=20
 	if (can_dropped_invalid_skb(dev, skb))
@@ -611,7 +645,10 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *=
skb, struct net_device *de
 	if (cf->can_id & CAN_RTR_FLAG)
 		ctrl |=3D FLEXCAN_MB_CNT_RTR;
=20
-	for (i =3D 0; i < cf->can_dlc; i +=3D sizeof(u32)) {
+	if (can_is_canfd_skb(skb))
+		ctrl |=3D FLEXCAN_MB_CNT_EDL;
+
+	for (i =3D 0; i < cf->len; i +=3D sizeof(u32)) {
 		data =3D be32_to_cpup((__be32 *)&cf->data[i]);
 		priv->write(data, &priv->tx_mb->data[i / sizeof(u32)]);
 	}
@@ -741,7 +778,7 @@ static inline struct flexcan_priv *rx_offload_to_priv(s=
truct can_rx_offload *off
 }
=20
 static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload,
-					 struct can_frame *cf,
+					 struct canfd_frame *cf,
 					 u32 *timestamp, unsigned int n)
 {
 	struct flexcan_priv *priv =3D rx_offload_to_priv(offload);
@@ -787,11 +824,21 @@ static unsigned int flexcan_mailbox_read(struct can_r=
x_offload *offload,
 	else
 		cf->can_id =3D (reg_id >> 18) & CAN_SFF_MASK;
=20
-	if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
-		cf->can_id |=3D CAN_RTR_FLAG;
-	cf->can_dlc =3D get_can_dlc((reg_ctrl >> 16) & 0xf);
+	if (reg_ctrl & FLEXCAN_MB_CNT_EDL) {
+		cf->len =3D can_dlc2len((reg_ctrl >> 16) & 0x0F);
+	} else {
+		cf->len =3D get_can_dlc((reg_ctrl >> 16) & 0x0F);
+
+		if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
+			cf->can_id |=3D CAN_RTR_FLAG;
+	}
+
+	if (reg_ctrl & FLEXCAN_MB_CNT_ESI) {
+		cf->flags |=3D CANFD_ESI;
+		netdev_warn(priv->can.dev, "ESI Error\n");
+	}
=20
-	for (i =3D 0; i < cf->can_dlc; i +=3D sizeof(u32)) {
+	for (i =3D 0; i < cf->len; i +=3D sizeof(u32)) {
 		__be32 data =3D cpu_to_be32(priv->read(&mb->data[i / sizeof(u32)]));
 		*(__be32 *)(cf->data + i) =3D data;
 	}
@@ -953,6 +1000,7 @@ static void flexcan_set_bittiming(struct net_device *d=
ev)
 {
 	const struct flexcan_priv *priv =3D netdev_priv(dev);
 	const struct can_bittiming *bt =3D &priv->can.bittiming;
+	const struct can_bittiming *dbt =3D &priv->can.data_bittiming;
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	u32 reg;
=20
@@ -982,6 +1030,15 @@ static void flexcan_set_bittiming(struct net_device *=
dev)
 	netdev_dbg(dev, "writing ctrl=3D0x%08x\n", reg);
 	priv->write(reg, &regs->ctrl);
=20
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		reg =3D FLEXCAN_FDCBT_FPRESDIV(dbt->brp - 1) |
+			FLEXCAN_FDCBT_FPSEG1(dbt->phase_seg1 - 1) |
+			FLEXCAN_FDCBT_FPSEG2(dbt->phase_seg2 - 1) |
+			FLEXCAN_FDCBT_FRJW(dbt->sjw - 1) |
+			FLEXCAN_FDCBT_FPROPSEG(dbt->prop_seg);
+		priv->write(reg, &regs->fdcbt);
+	}
+
 	/* print chip status */
 	netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,
 		   priv->read(&regs->mcr), priv->read(&regs->ctrl));
@@ -996,7 +1053,7 @@ static int flexcan_chip_start(struct net_device *dev)
 {
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	struct flexcan_regs __iomem *regs =3D priv->regs;
-	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr;
+	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr, reg_fdctrl;
 	int err, i;
 	struct flexcan_mb __iomem *mb;
=20
@@ -1092,6 +1149,21 @@ static int flexcan_chip_start(struct net_device *dev=
)
 	netdev_dbg(dev, "%s: writing ctrl=3D0x%08x", __func__, reg_ctrl);
 	priv->write(reg_ctrl, &regs->ctrl);
=20
+	/* FDCTRL
+	 *
+	 * BRS enabled by system reset when enable CAN FD mode
+	 * 64 bytes payload per MB and 7 MBs per RAM block by default
+	 * enable CAN FD mode
+	 */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		reg_fdctrl =3D priv->read(&regs->fdctrl);
+		reg_fdctrl |=3D FLEXCAN_FDCTRL_MBDSR3(3) | FLEXCAN_FDCTRL_MBDSR2(3) |
+				FLEXCAN_FDCTRL_MBDSR1(3) | FLEXCAN_FDCTRL_MBDSR0(3);
+		priv->write(reg_fdctrl, &regs->fdctrl);
+		reg_mcr =3D priv->read(&regs->mcr);
+		priv->write(reg_mcr | FLEXCAN_MCR_FDEN, &regs->mcr);
+	}
+
 	if ((priv->devtype_data->quirks & FLEXCAN_QUIRK_ENABLE_EACEN_RRS)) {
 		reg_ctrl2 =3D priv->read(&regs->ctrl2);
 		reg_ctrl2 |=3D FLEXCAN_CTRL2_EACEN | FLEXCAN_CTRL2_RRS;
@@ -1231,7 +1303,10 @@ static int flexcan_open(struct net_device *dev)
 	if (err)
 		goto out_close;
=20
-	priv->mb_size =3D sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+		priv->mb_size =3D sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
+	else
+		priv->mb_size =3D sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
 	priv->mb_count =3D (sizeof(priv->regs->mb[0]) / priv->mb_size) +
 			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
=20
@@ -1568,6 +1643,18 @@ static int flexcan_probe(struct platform_device *pde=
v)
 	priv->clk_per =3D clk_per;
 	priv->devtype_data =3D devtype_data;
 	priv->reg_xceiver =3D reg_xceiver;
+	priv->offload.is_canfd =3D false;
+
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD) {
+		if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+			priv->offload.is_canfd =3D true;
+			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD;
+			priv->can.data_bittiming_const =3D &flexcan_fd_data_bittiming_const;
+		} else {
+			dev_err(&pdev->dev, "canfd mode can't work on fifo mode\n");
+			err =3D -EINVAL;
+		}
+	}
=20
 	err =3D register_flexcandev(dev);
 	if (err) {
--=20
2.17.1

