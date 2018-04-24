Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934307AbeDXN2y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:28:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37488 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934012AbeDXNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:18:17 -0400
X-Google-Smtp-Source: AIpwx48zqvKIFZOBndbs61/+BbL9FaVrCJE85wk649/xdBM6kLwWtSrhXtQoqcPy0EEMH3AILNjyCQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        netdev@vger.kernel.org
Subject: [PATCH] xen-netfront: fix xennet_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:18:14 +0200
Message-Id: <20180424131815.5064-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/xen-netfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 4dd066800..679da1abd 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -564,7 +564,7 @@ static u16 xennet_select_queue(struct net_device *dev, struct sk_buff *skb,
 
 #define MAX_XEN_SKB_FRAGS (65536 / XEN_PAGE_SIZE + 1)
 
-static int xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netfront_info *np = netdev_priv(dev);
 	struct netfront_stats *tx_stats = this_cpu_ptr(np->tx_stats);
-- 
2.17.0
