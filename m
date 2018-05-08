Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754854AbeEHJfa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:35:30 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:51556 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754817AbeEHJe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:34:29 -0400
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 08 May 2018 11:34:27 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: davem@davemloft.net, tariqt@mellanox.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net/mlx4_en: Fix an error handling path in 'mlx4_en_init_netdev()'
Date: Tue,  8 May 2018 11:34:26 +0200
Message-Id: <20180508093426.11550-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the 2nd memory allocation of the loop fails, we must undo the
memory allocation done so far.

Fixes: 67f8b1dcb9ee ("net/mlx4_en: Refactor the XDP forwarding rings scheme")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index e0adac4a9a19..bf078244e467 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3331,7 +3331,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 		if (!priv->tx_cq[t]) {
 			kfree(priv->tx_ring[t]);
 			err = -ENOMEM;
-			goto out;
+			goto err_free_tx;
 		}
 	}
 	priv->rx_ring_num = prof->rx_ring_num;
-- 
2.17.0
