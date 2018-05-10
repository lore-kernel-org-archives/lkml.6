Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935448AbeEJL0W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:26:22 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:55757 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935393AbeEJL0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:26:18 -0400
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 10 May 2018 13:26:17 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jiri@mellanox.com, idosch@mellanox.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mlxsw: core: Fix an error handling path in 'mlxsw_core_bus_device_register()'
Date: Thu, 10 May 2018 13:26:16 +0200
Message-Id: <20180510112616.20508-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resources are not freed in the reverse order of the allocation.
Labels are also mixed-up.

Fix it and reorder code and labels in the error handling path of
'mlxsw_core_bus_device_register()'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Please review carefully. This patch is proposed because it triggers one of
my coccinelle scripts. I'm not 100% sure if correct.

The script tries to spot wrongly ordered error handling path. It is:
@@
identifier l1, l2;
@@

   if (...) {
      ...
*     goto l1;
   }
   ...
   if (...) {
      ...
*     goto l2;
   }
   ...
*l1:
   ...
*l2:
   ...
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 93ea56620a24..e13ac3b8dff7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -1100,11 +1100,11 @@ int mlxsw_core_bus_device_register(const struct mlxsw_bus_info *mlxsw_bus_info,
 err_alloc_lag_mapping:
 	mlxsw_ports_fini(mlxsw_core);
 err_ports_init:
-	mlxsw_bus->fini(bus_priv);
-err_bus_init:
 	if (!reload)
 		devlink_resources_unregister(devlink, NULL);
 err_register_resources:
+	mlxsw_bus->fini(bus_priv);
+err_bus_init:
 	if (!reload)
 		devlink_free(devlink);
 err_devlink_alloc:
-- 
2.17.0
