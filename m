Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934253AbeDXNYR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:24:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39123 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757950AbeDXNTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:19:05 -0400
X-Google-Smtp-Source: AIpwx4/y/U93LVqzhFb/52ImXihvSJ0nXOIap3mO/uq934TeReQYh/IutlogbiikeVbaKYJGxnBx2A==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Casey Leedom <leedom@chelsio.com>, netdev@vger.kernel.org
Subject: [PATCH] cxgb4vf: fix t4vf_eth_xmit()'s return type
Date: Tue, 24 Apr 2018 15:19:02 +0200
Message-Id: <20180424131902.5767-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb4vf/adapter.h | 2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h b/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
index 5883f09e3..e29fc4699 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
@@ -560,7 +560,7 @@ int t4vf_sge_alloc_eth_txq(struct adapter *, struct sge_eth_txq *,
 			   unsigned int);
 void t4vf_free_sge_resources(struct adapter *);
 
-int t4vf_eth_xmit(struct sk_buff *, struct net_device *);
+netdev_tx_t t4vf_eth_xmit(struct sk_buff *, struct net_device *);
 int t4vf_ethrx_handler(struct sge_rspq *, const __be64 *,
 		       const struct pkt_gl *);
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
index dfce5df75..9ce901f49 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -1159,7 +1159,7 @@ static inline void txq_advance(struct sge_txq *tq, unsigned int n)
  *
  *	Add a packet to an SGE Ethernet TX queue.  Runs with softirqs disabled.
  */
-int t4vf_eth_xmit(struct sk_buff *skb, struct net_device *dev)
+netdev_tx_t t4vf_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	u32 wr_mid;
 	u64 cntrl, *end;
-- 
2.17.0
