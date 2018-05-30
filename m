Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeE3LHu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:07:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60688 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751896AbeE3LG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:58 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ivan Vecera" <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Amir Vadai" <amirv@mellanox.com>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.697497168@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 149/153] net/mlx4_en: do not ignore autoneg in
 mlx4_en_set_pauseparam()
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

commit 278d436a476f69fc95d5c82bf61b6c2d02f4d44e upstream.

The driver does not support pause autonegotiation so it should return
-EINVAL when the function is called with non-zero autoneg.

Cc: Amir Vadai <amirv@mellanox.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -364,6 +364,9 @@ static int mlx4_en_set_pauseparam(struct
 	struct mlx4_en_dev *mdev = priv->mdev;
 	int err;
 
+	if (pause->autoneg)
+		return -EINVAL;
+
 	priv->prof->tx_pause = pause->tx_pause != 0;
 	priv->prof->rx_pause = pause->rx_pause != 0;
 	err = mlx4_SET_PORT_general(mdev->dev, priv->port,
