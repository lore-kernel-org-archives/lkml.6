Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423883AbeE1LyJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423673AbeE1LIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 108/272] net/mlx5e: Move all TX timeout logic to be under state lock
Date: Mon, 28 May 2018 12:02:21 +0200
Message-Id: <20180528100250.187792719@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit bfc647d52e67dc756c605e9a50d45b71054c2533 ]

Driver callback for handling TX timeout should access some internal
resources (SQ, CQ) in order to decide if the tx timeout work should be
scheduled.  These resources might be unavailable if channels are closed
in parallel (ifdown for example).

The state lock is the mechanism to protect from such races.
Move all TX timeout logic to be in the work under a state lock.

In addition, Move the work from the global WQ to mlx5e WQ to make sure
this work is flushed when device is detached..

Also, move the mlx5e_tx_timeout_work code to be next to the TX timeout
NDO for better code locality.

Fixes: 3947ca185999 ("net/mlx5e: Implement ndo_tx_timeout callback")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |   61 ++++++++++++----------
 1 file changed, 34 insertions(+), 27 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -153,26 +153,6 @@ static void mlx5e_update_carrier_work(st
 	mutex_unlock(&priv->state_lock);
 }
 
-static void mlx5e_tx_timeout_work(struct work_struct *work)
-{
-	struct mlx5e_priv *priv = container_of(work, struct mlx5e_priv,
-					       tx_timeout_work);
-	int err;
-
-	rtnl_lock();
-	mutex_lock(&priv->state_lock);
-	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
-		goto unlock;
-	mlx5e_close_locked(priv->netdev);
-	err = mlx5e_open_locked(priv->netdev);
-	if (err)
-		netdev_err(priv->netdev, "mlx5e_open_locked failed recovering from a tx_timeout, err(%d).\n",
-			   err);
-unlock:
-	mutex_unlock(&priv->state_lock);
-	rtnl_unlock();
-}
-
 void mlx5e_update_stats(struct mlx5e_priv *priv)
 {
 	int i;
@@ -3632,13 +3612,19 @@ static bool mlx5e_tx_timeout_eq_recover(
 	return true;
 }
 
-static void mlx5e_tx_timeout(struct net_device *dev)
+static void mlx5e_tx_timeout_work(struct work_struct *work)
 {
-	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_priv *priv = container_of(work, struct mlx5e_priv,
+					       tx_timeout_work);
+	struct net_device *dev = priv->netdev;
 	bool reopen_channels = false;
-	int i;
+	int i, err;
 
-	netdev_err(dev, "TX timeout detected\n");
+	rtnl_lock();
+	mutex_lock(&priv->state_lock);
+
+	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
+		goto unlock;
 
 	for (i = 0; i < priv->channels.num * priv->channels.params.num_tc; i++) {
 		struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, i);
@@ -3646,7 +3632,9 @@ static void mlx5e_tx_timeout(struct net_
 
 		if (!netif_xmit_stopped(dev_queue))
 			continue;
-		netdev_err(dev, "TX timeout on queue: %d, SQ: 0x%x, CQ: 0x%x, SQ Cons: 0x%x SQ Prod: 0x%x, usecs since last trans: %u\n",
+
+		netdev_err(dev,
+			   "TX timeout on queue: %d, SQ: 0x%x, CQ: 0x%x, SQ Cons: 0x%x SQ Prod: 0x%x, usecs since last trans: %u\n",
 			   i, sq->sqn, sq->cq.mcq.cqn, sq->cc, sq->pc,
 			   jiffies_to_usecs(jiffies - dev_queue->trans_start));
 
@@ -3659,8 +3647,27 @@ static void mlx5e_tx_timeout(struct net_
 		}
 	}
 
-	if (reopen_channels && test_bit(MLX5E_STATE_OPENED, &priv->state))
-		schedule_work(&priv->tx_timeout_work);
+	if (!reopen_channels)
+		goto unlock;
+
+	mlx5e_close_locked(dev);
+	err = mlx5e_open_locked(dev);
+	if (err)
+		netdev_err(priv->netdev,
+			   "mlx5e_open_locked failed recovering from a tx_timeout, err(%d).\n",
+			   err);
+
+unlock:
+	mutex_unlock(&priv->state_lock);
+	rtnl_unlock();
+}
+
+static void mlx5e_tx_timeout(struct net_device *dev)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	netdev_err(dev, "TX timeout detected\n");
+	queue_work(priv->wq, &priv->tx_timeout_work);
 }
 
 static int mlx5e_xdp_set(struct net_device *netdev, struct bpf_prog *prog)
