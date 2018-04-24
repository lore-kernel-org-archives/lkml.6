Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934461AbeDXNnc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:43:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39557 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933702AbeDXNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:42 -0400
X-Google-Smtp-Source: AIpwx49LeIwpF3Jt+rV+kbAYXwljDBlqkOzcmVR3RXY7YKGfNh8JQGf5pg5Jnf9IzLCRnqHlJMAT3Q==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        netdev@vger.kernel.org
Subject: [PATCH] liquidio: fix lio_vf_rep_pkt_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:39 +0200
Message-Id: <20180424131639.3757-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index 2adafa366..5973a4083 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -31,7 +31,7 @@
 
 static int lio_vf_rep_open(struct net_device *ndev);
 static int lio_vf_rep_stop(struct net_device *ndev);
-static int lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev);
+static netdev_tx_t lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev);
 static void lio_vf_rep_tx_timeout(struct net_device *netdev);
 static int lio_vf_rep_phys_port_name(struct net_device *dev,
 				     char *buf, size_t len);
@@ -379,7 +379,7 @@ lio_vf_rep_packet_sent_callback(struct octeon_device *oct,
 		netif_wake_queue(ndev);
 }
 
-static int
+static netdev_tx_t
 lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct lio_vf_rep_desc *vf_rep = netdev_priv(ndev);
-- 
2.17.0
