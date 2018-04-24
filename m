Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756970AbeDXLvo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:51:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50449 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756556AbeDXLvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:51:41 -0400
From: Colin King <colin.king@canonical.com>
To: Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mlxsw: spectrum_switchdev: remove duplicated check on multicast_enable
Date: Tue, 24 Apr 2018 12:51:39 +0100
Message-Id: <20180424115139.21134-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check on bridge_port->bridge_device->multicast_enable is performed
twice in two nested if statements. I can't see any reason for this, the
second check is redundant and can be removed.

Detected by cppcheck:
drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:1722]:
(warning) Identical inner 'if' condition is always true.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index c11c9a635866..989ed19e25c9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1719,12 +1719,9 @@ __mlxsw_sp_port_mdb_del(struct mlxsw_sp_port *mlxsw_sp_port,
 	int err;
 
 	if (bridge_port->bridge_device->multicast_enabled) {
-		if (bridge_port->bridge_device->multicast_enabled) {
-			err = mlxsw_sp_port_smid_set(mlxsw_sp_port, mid->mid,
-						     false);
-			if (err)
-				netdev_err(dev, "Unable to remove port from SMID\n");
-		}
+		err = mlxsw_sp_port_smid_set(mlxsw_sp_port, mid->mid, false);
+		if (err)
+			netdev_err(dev, "Unable to remove port from SMID\n");
 	}
 
 	err = mlxsw_sp_port_remove_from_mid(mlxsw_sp_port, mid);
-- 
2.17.0
