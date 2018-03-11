Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeCKWpd convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:45:33 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:45815 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbeCKWpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:45:31 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Mar 2018 23:45:30 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: tariqt@mellanox.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net/mlx4_en: Fix a memory leak in case of error in 'mlx4_en_init_netdev()'
Date: Sun, 11 Mar 2018 23:45:29 +0100
Message-Id: <20180311224529.4427-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'kzalloc' fails, we must free some memory before returning.

Fixes: 67f8b1dcb9ee ("net/mlx4_en: Refactor the XDP forwarding rings scheme")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 8fc51bc29003..f9db018e858f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3327,7 +3327,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 		if (!priv->tx_cq[t]) {
 			kfree(priv->tx_ring[t]);
 			err = -ENOMEM;
-			goto out;
+			goto err_free_tx;
 		}
 	}
 	priv->rx_ring_num = prof->rx_ring_num;
-- 
2.14.1


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
