Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655A7ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DB821529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DB821529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388053AbeITSbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:31:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387874AbeITSbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:31:35 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A8DE4404C1F6D;
        Thu, 20 Sep 2018 20:48:11 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 20:48:02 +0800
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
Subject: [PATCH net-next 03/22] net: seeq: fix return type of ndo_start_xmit function
Date:   Thu, 20 Sep 2018 20:32:47 +0800
Message-ID: <20180920123306.14772-4-yuehaibing@huawei.com>
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
 drivers/net/ethernet/seeq/ether3.c  | 5 +++--
 drivers/net/ethernet/seeq/sgiseeq.c | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
index c5bc124..d1bb73b 100644
--- a/drivers/net/ethernet/seeq/ether3.c
+++ b/drivers/net/ethernet/seeq/ether3.c
@@ -77,7 +77,8 @@
 static int	ether3_rx(struct net_device *dev, unsigned int maxcnt);
 static void	ether3_tx(struct net_device *dev);
 static int	ether3_open (struct net_device *dev);
-static int	ether3_sendpacket (struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t	ether3_sendpacket(struct sk_buff *skb,
+					  struct net_device *dev);
 static irqreturn_t ether3_interrupt (int irq, void *dev_id);
 static int	ether3_close (struct net_device *dev);
 static void	ether3_setmulticastlist (struct net_device *dev);
@@ -481,7 +482,7 @@ static void ether3_timeout(struct net_device *dev)
 /*
  * Transmit a packet
  */
-static int
+static netdev_tx_t
 ether3_sendpacket(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned long flags;
diff --git a/drivers/net/ethernet/seeq/sgiseeq.c b/drivers/net/ethernet/seeq/sgiseeq.c
index 573691b..70cce63 100644
--- a/drivers/net/ethernet/seeq/sgiseeq.c
+++ b/drivers/net/ethernet/seeq/sgiseeq.c
@@ -578,7 +578,8 @@ static inline int sgiseeq_reset(struct net_device *dev)
 	return 0;
 }
 
-static int sgiseeq_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+sgiseeq_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sgiseeq_private *sp = netdev_priv(dev);
 	struct hpc3_ethregs *hregs = sp->hregs;
-- 
1.8.3.1


