Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F2C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE282086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C+qG9foi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE282086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLLGqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:46:40 -0500
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:4544
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbeLLGqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzzR4ccIZcJW5D2BfN0VXG1UiyWdqossgn0sP+bqAbI=;
 b=C+qG9foiYE+39hX8ezaiB4OHoDotOi/UbR4tOvKi2cAkA5Qy/EZoEJ+qxP9UwHoFOWmn/EV0HmHS56QHibWQC4mjZcVtdl9pwKnAVVUNMRnrQDrffBr4ME7Cg0YSlfTzkUvKj5sqs0RAhb6fm73ZFodjDBjnUNiz/wmN659t1l0=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5420.eurprd04.prod.outlook.com (20.178.104.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 06:46:35 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%5]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 06:46:35 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: add TX support for variable payload size
Thread-Topic: [PATCH] can: flexcan: add TX support for variable payload size
Thread-Index: AQHUkeZs7DN/5MKD9Eu238RlkbDYTA==
Date:   Wed, 12 Dec 2018 06:46:34 +0000
Message-ID: <20181212064419.18613-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5420;6:9RpW9U5ORT+2JP224xvggRM2cTbxsizRdGLCPslQ7UJ4HaiSQ2f1NMJOu3nvXVFLwYuEsppuNuwkx0B0CswR+Y+qEIS9d5rf4RQW7sa/x+tgFP5Z9A8wFuFnaG5kRj4nWMPtjIHeEF2+rG3V70tTYxojgxQR3rjT02WeaX123nYrO1wpFOyXIElh3YBE6lVkPQ62IRUeTiRyac1PrSvPwLdFBlk7WWTPZB6Y33lHR4dOiBPJ7BlOPITblDCVaxarAI4/o9H5OakA0uekJZXiGMP8sKZEa48fY7d1PHWW991wWxE+bgzHEpCQJVgPEcpYoCjp6AdczDyWNHQ2/lUbcjIn8aW+AEOOeU+akYhJ8pWENP9b5DwSyKh7ri3fYlt5+6R96KkAVNWMURkixY+NM3/xLd6jZKC/OOxv8FqTRDkHkkEsXQF0Ex9wRxPNrIYQCkg42+/slnYXCtxcRqooDA==;5:rSDgllWfSVPNG8HuB/pN/PVapyOBf8+2iPxMELTCgQSXq11E8ZzMB0dWq6j3S+QRtuGhMplAFH6EqEWDlfJMqwAUfWqRl6OLybiHO3+LDLjTvPIwvppah6357KaGDaVVr1OsF6U4G8iuRxDiLFa4MUnS9Jo4krzgA44ZgKvEgUo=;7:3uauC9HzCCBJrvUii4c0oWHoBTSHm8hfhRhXhp1F4Ai7WxyrJhYirbB+c8gBKILQJ+JPYBd9bv+xkwB2blZPsQoet40Eq6DguGhjGKqY5ltMFxV4TnLxzvfoOhgFtCNP2AHnZr0DAN+TDDYphMkRpw==
x-ms-office365-filtering-correlation-id: 324a28ec-88d2-4c90-9664-08d65ffd8dc1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5420;
x-ms-traffictypediagnostic: DB7PR04MB5420:
x-microsoft-antispam-prvs: <DB7PR04MB54202B61C4C6649B9C3507D7E6A70@DB7PR04MB5420.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5420;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5420;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(199004)(189003)(106356001)(97736004)(316002)(105586002)(110136005)(4326008)(53936002)(54906003)(2501003)(6512007)(99286004)(5660300001)(478600001)(14454004)(476003)(486006)(2616005)(7736002)(81156014)(8676002)(8936002)(81166006)(50226002)(305945005)(256004)(6486002)(6436002)(36756003)(1076002)(25786009)(3846002)(66066001)(6116002)(186003)(2906002)(52116002)(6506007)(86362001)(102836004)(26005)(386003)(68736007)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5420;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wbkLX/Fv+QFwMeElDvLVQkYIwKHAmbKu5PoaPd476z5HX87iv9lOVxgTEdBcdb64GdwxKog2ls4HHWjbkT4UU/jEPK1+JXbWkQDv7VwBmCo4g9/ZNN05mWh5Oc4A5nPiYbjVnG4Wsu/G4GayIoalADzy2UjRuIXcsi7bW9gppNea+JyDqndqhyHwcdfR2gwIwYVWv1Zd+u3+0D0ffzxAvn/ME6rKSmGrzZhIfwn4LkUon/toT6k++SNx29ft4sghziqlVTu5LXR2oCmZ7ObRJE40CrJpMZSLJrWQ4KLbrJ4l0g+zRY3u3qsowk7iFePa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324a28ec-88d2-4c90-9664-08d65ffd8dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 06:46:35.4340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5420
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the FlexCAN driver always use last mailbox for TX, it will work well
when MB payload size is 8/16 bytes.
TX mailbox would change to 13 when MB payload size is 64 bytes to
support CANFD. So we may need to set iflag register to add support for
variable payload size.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 42 +++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eafe3ac1..13fd085fcf84 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -141,7 +141,9 @@
 #define FLEXCAN_TX_MB_RESERVED_OFF_FIFO		8
 #define FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP	0
 #define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_RESERVED_OFF_TIME=
STAMP + 1)
-#define FLEXCAN_IFLAG_MB(x)		BIT((x) & 0x1f)
+#define FLEXCAN_IFLAG1_MB_NUM		32
+#define FLEXCAN_IFLAG1_MB(x)		BIT(x)
+#define FLEXCAN_IFLAG2_MB(x)		BIT((x) & 0x1f)
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
@@ -822,9 +824,15 @@ static inline u64 flexcan_read_reg_iflag_rx(struct fle=
xcan_priv *priv)
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	u32 iflag1, iflag2;
=20
-	iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default &
-		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
-	iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default;
+	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
+		iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default &
+			~FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
+		iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default;
+	} else {
+		iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default;
+		iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default &
+			~FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
+	}
=20
 	return (u64)iflag2 << 32 | iflag1;
 }
@@ -836,7 +844,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	irqreturn_t handled =3D IRQ_NONE;
-	u32 reg_iflag2, reg_esr;
+	u32 reg_tx_iflag, tx_iflag_idx, reg_esr;
+	void __iomem *reg_iflag;
 	enum can_state last_state =3D priv->can.state;
=20
 	/* reception interrupt */
@@ -870,10 +879,18 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		}
 	}
=20
-	reg_iflag2 =3D priv->read(&regs->iflag2);
+	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
+		reg_tx_iflag =3D priv->read(&regs->iflag2);
+		tx_iflag_idx =3D FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
+		reg_iflag =3D &regs->iflag2;
+	} else {
+		reg_tx_iflag =3D priv->read(&regs->iflag1);
+		tx_iflag_idx =3D FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
+		reg_iflag =3D &regs->iflag1;
+	}
=20
 	/* transmission complete interrupt */
-	if (reg_iflag2 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
+	if (reg_tx_iflag & tx_iflag_idx) {
 		u32 reg_ctrl =3D priv->read(&priv->tx_mb->can_ctrl);
=20
 		handled =3D IRQ_HANDLED;
@@ -885,7 +902,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			    &priv->tx_mb->can_ctrl);
-		priv->write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag2);
+		priv->write(tx_iflag_idx, reg_iflag);
 		netif_wake_queue(dev);
 	}
=20
@@ -1244,8 +1261,13 @@ static int flexcan_open(struct net_device *dev)
 	priv->tx_mb_idx =3D priv->mb_count - 1;
 	priv->tx_mb =3D flexcan_get_mb(priv, priv->tx_mb_idx);
=20
-	priv->reg_imask1_default =3D 0;
-	priv->reg_imask2_default =3D FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
+		priv->reg_imask1_default =3D 0;
+		priv->reg_imask2_default =3D FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
+	} else {
+		priv->reg_imask1_default =3D FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
+		priv->reg_imask2_default =3D 0;
+	}
=20
 	priv->offload.mailbox_read =3D flexcan_mailbox_read;
=20
--=20
2.17.1

