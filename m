Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AA5ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A47A21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A47A21529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbeITSbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:31:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387640AbeITSbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:31:45 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A4ACA63259119;
        Thu, 20 Sep 2018 20:48:19 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 20:48:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dmitry.tarnyagin@lockless.no>,
        <wg@grandegger.com>, <mkl@pengutronix.de>,
        <michal.simek@xilinx.com>, <hsweeten@visionengravers.com>,
        <madalin.bucur@nxp.com>, <pantelis.antoniou@gmail.com>,
        <claudiu.manoil@nxp.com>, <leoyang.li@nxp.com>,
        <linux@armlinux.org.uk>, <sammy@sammy.net>, <ralf@linux-mips.org>,
        <nico@fluxnic.net>, <steve.glendinning@shawell.net>,
        <f.fainelli@gmail.com>, <grygorii.strashko@ti.com>,
        <w-kwok2@ti.com>, <m-karicheri2@ti.com>, <t.sailer@alumni.ethz.ch>,
        <jreuter@yaina.de>, <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu2@citrix.com>, <paul.durrant@citrix.com>,
        <arvid.brodin@alten.se>, <pshelar@ovn.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
        <linux-omap@vger.kernel.org>, <linux-hams@vger.kernel.org>,
        <devel@linuxdriverproject.org>, <linux-usb@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <dev@openvswitch.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 07/22] net: i825xx: fix return type of ndo_start_xmit function
Date:   Thu, 20 Sep 2018 20:32:51 +0800
Message-ID: <20180920123306.14772-8-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
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
 drivers/net/ethernet/i825xx/ether1.c     | 5 +++--
 drivers/net/ethernet/i825xx/lib82596.c   | 4 ++--
 drivers/net/ethernet/i825xx/sun3_82586.c | 6 ++++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/i825xx/ether1.c b/drivers/net/ethernet/i825xx/ether1.c
index dc98345..35f6291 100644
--- a/drivers/net/ethernet/i825xx/ether1.c
+++ b/drivers/net/ethernet/i825xx/ether1.c
@@ -64,7 +64,8 @@
 #define RX_AREA_END	0x0fc00
 
 static int ether1_open(struct net_device *dev);
-static int ether1_sendpacket(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t ether1_sendpacket(struct sk_buff *skb,
+				     struct net_device *dev);
 static irqreturn_t ether1_interrupt(int irq, void *dev_id);
 static int ether1_close(struct net_device *dev);
 static void ether1_setmulticastlist(struct net_device *dev);
@@ -667,7 +668,7 @@
 	netif_wake_queue(dev);
 }
 
-static int
+static netdev_tx_t
 ether1_sendpacket (struct sk_buff *skb, struct net_device *dev)
 {
 	int tmp, tst, nopaddr, txaddr, tbdaddr, dataddr;
diff --git a/drivers/net/ethernet/i825xx/lib82596.c b/drivers/net/ethernet/i825xx/lib82596.c
index f00a1dc..2f7ae11 100644
--- a/drivers/net/ethernet/i825xx/lib82596.c
+++ b/drivers/net/ethernet/i825xx/lib82596.c
@@ -347,7 +347,7 @@ struct i596_private {
 	0x7f /*  *multi IA */ };
 
 static int i596_open(struct net_device *dev);
-static int i596_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t i596_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t i596_interrupt(int irq, void *dev_id);
 static int i596_close(struct net_device *dev);
 static void i596_add_cmd(struct net_device *dev, struct i596_cmd *cmd);
@@ -966,7 +966,7 @@ static void i596_tx_timeout (struct net_device *dev)
 }
 
 
-static int i596_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t i596_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct i596_private *lp = netdev_priv(dev);
 	struct tx_cmd *tx_cmd;
diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index 8bb15a8..1a86184 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -121,7 +121,8 @@
 static irqreturn_t sun3_82586_interrupt(int irq,void *dev_id);
 static int     sun3_82586_open(struct net_device *dev);
 static int     sun3_82586_close(struct net_device *dev);
-static int     sun3_82586_send_packet(struct sk_buff *,struct net_device *);
+static netdev_tx_t     sun3_82586_send_packet(struct sk_buff *,
+					      struct net_device *);
 static struct  net_device_stats *sun3_82586_get_stats(struct net_device *dev);
 static void    set_multicast_list(struct net_device *dev);
 static void    sun3_82586_timeout(struct net_device *dev);
@@ -1002,7 +1003,8 @@ static void sun3_82586_timeout(struct net_device *dev)
  * send frame
  */
 
-static int sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	int len,i;
 #ifndef NO_NOPCOMMANDS
-- 
1.8.3.1


