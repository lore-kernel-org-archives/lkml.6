Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933840AbeDXNRO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:17:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53337 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933817AbeDXNRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:17:07 -0400
X-Google-Smtp-Source: AIpwx4+YURxxsY+Scr9deTSzQAteKmM/Mav1kBlw5kC9qoIL7AnAQD5JM+LQNazdrUsUpJJ6HZpDzg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
        netdev@vger.kernel.org
Subject: [PATCH] net: ks8851: fix ks_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:17:02 +0200
Message-Id: <20180424131705.4155-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/micrel/ks8851_mll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_mll.c b/drivers/net/ethernet/micrel/ks8851_mll.c
index f3e9dd47b..a732fdeb5 100644
--- a/drivers/net/ethernet/micrel/ks8851_mll.c
+++ b/drivers/net/ethernet/micrel/ks8851_mll.c
@@ -1020,7 +1020,7 @@ static void ks_write_qmu(struct ks_net *ks, u8 *pdata, u16 len)
  * spin_lock_irqsave is required because tx and rx should be mutual exclusive.
  * So while tx is in-progress, prevent IRQ interrupt from happenning.
  */
-static int ks_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t ks_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	int retv = NETDEV_TX_OK;
 	struct ks_net *ks = netdev_priv(netdev);
-- 
2.17.0
