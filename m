Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A0ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F2521533
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F2521533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbeIUIi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:38:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50499 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbeIUIi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:38:27 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C489CDFC2C906;
        Fri, 21 Sep 2018 10:51:44 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 10:51:35 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <madalin.bucur@nxp.com>,
        <pantelis.antoniou@gmail.com>, <claudiu.manoil@nxp.com>,
        <leoyang.li@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: freescale: fix return type of ndo_start_xmit function
Date:   Fri, 21 Sep 2018 10:50:32 +0800
Message-ID: <20180921025032.18652-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c        | 3 ++-
 drivers/net/ethernet/freescale/fec_mpc52xx.c          | 3 ++-
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 3 ++-
 drivers/net/ethernet/freescale/gianfar.c              | 4 ++--
 drivers/net/ethernet/freescale/ucc_geth.c             | 3 ++-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index a5131a5..84843de 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2044,7 +2044,8 @@ static inline int dpaa_xmit(struct dpaa_priv *priv,
 	return 0;
 }
 
-static int dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
+static netdev_tx_t
+dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 {
 	const int queue_mapping = skb_get_queue_mapping(skb);
 	bool nonlinear = skb_is_nonlinear(skb);
diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
index 6d7269d..b90bab7 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -305,7 +305,8 @@ static int mpc52xx_fec_close(struct net_device *dev)
  * invariant will hold if you make sure that the netif_*_queue()
  * calls are done at the proper times.
  */
-static int mpc52xx_fec_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+mpc52xx_fec_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 	struct bcom_fec_bd *bd;
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 2c2976a..7c548ed 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -481,7 +481,8 @@ static struct sk_buff *tx_skb_align_workaround(struct net_device *dev,
 }
 #endif
 
-static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
 	cbd_t __iomem *bdp;
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index c488d31..0bd21a4 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -110,7 +110,7 @@
 const char gfar_driver_version[] = "2.0";
 
 static int gfar_enet_open(struct net_device *dev);
-static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t gfar_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void gfar_reset_task(struct work_struct *work);
 static void gfar_timeout(struct net_device *dev);
 static int gfar_close(struct net_device *dev);
@@ -2332,7 +2332,7 @@ static inline bool gfar_csum_errata_76(struct gfar_private *priv,
 /* This is called by the kernel when a frame is ready for transmission.
  * It is pointed to by the dev->hard_start_xmit function pointer
  */
-static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct gfar_private *priv = netdev_priv(dev);
 	struct gfar_priv_tx_q *tx_queue = NULL;
diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 9600837..32e0270 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3078,7 +3078,8 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 
 /* This is called by the kernel when a frame is ready for transmission. */
 /* It is pointed to by the dev->hard_start_xmit function pointer */
-static int ucc_geth_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+ucc_geth_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ucc_geth_private *ugeth = netdev_priv(dev);
 #ifdef CONFIG_UGETH_TX_ON_DEMAND
-- 
1.8.3.1


