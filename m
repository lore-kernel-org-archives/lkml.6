Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934051AbeDXNS0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:18:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54894 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934011AbeDXNSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:18:15 -0400
X-Google-Smtp-Source: AIpwx4/LBj3nqbOGLfgMHKLmVVJ1akg76k+c2j1PpWMpbMC+oFZE+kEdA7uC+ZpQS0YvzPlHXEgbQQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Wei Liu <wei.liu2@citrix.com>, Paul Durrant <paul.durrant@citrix.com>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Subject: [PATCH] xen-netback: fix xenvif_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:18:12 +0200
Message-Id: <20180424131812.5014-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/xen-netback/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 78ebe494f..bb944aa09 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -165,7 +165,7 @@ static u16 xenvif_select_queue(struct net_device *dev, struct sk_buff *skb,
 	return vif->hash.mapping[skb_get_hash_raw(skb) % size];
 }
 
-static int xenvif_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t xenvif_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct xenvif *vif = netdev_priv(dev);
 	struct xenvif_queue *queue = NULL;
-- 
2.17.0
