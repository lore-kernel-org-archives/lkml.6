Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933762AbeDXNQ5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:16:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52077 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933721AbeDXNQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:49 -0400
X-Google-Smtp-Source: AIpwx48i5Vw0DvwpsLK2DPgfco1kY+NNc892AImYTRO4pjJ1nSoRi6Bvp/KRoKQgeXi/XOEapWGzBA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>, netdev@vger.kernel.org
Subject: [PATCH] net: hip04: fix hip04_mac_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:46 +0200
Message-Id: <20180424131647.3905-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/hisilicon/hip04_eth.c    | 2 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index 340e28211..8acf615cd 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -422,7 +422,7 @@ static void hip04_start_tx_timer(struct hip04_priv *priv)
 			       ns, HRTIMER_MODE_REL);
 }
 
-static int hip04_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t hip04_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct hip04_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 25a6c8722..aab6fb10a 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -736,7 +736,7 @@ static int hix5hd2_fill_sg_desc(struct hix5hd2_priv *priv,
 	return 0;
 }
 
-static int hix5hd2_net_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t hix5hd2_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct hix5hd2_priv *priv = netdev_priv(dev);
 	struct hix5hd2_desc *desc;
-- 
2.17.0
