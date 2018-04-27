Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933745AbeD0PU4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:20:56 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:38897 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932850AbeD0PUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:20:49 -0400
X-Google-Smtp-Source: AB8JxZptdwLWTttSQylk/BJAwodPLPuh12+Bxbb9utNEnJ/Nkw1510HW2L4ns/YIZ9X0ITwYN38VWSxreNY=
MIME-Version: 1.0
Date: Fri, 27 Apr 2018 08:20:15 -0700
Message-Id: <20180427152015.185861-1-tarick@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH] net/mlx4_core: Fix error handling in mlx4_init_port_info.
From: Tarick Bedeir <tarick@google.com>
To: tariqt@mellanox.com, gthelen@google.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        tarick@google.com
Cc: Greg Thelen <gthelen@google.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tarick Bedeir <tarick@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid exiting the function with a lingering sysfs file (if the first
call to device_create_file() fails while the second succeeds), and avoid
calling devlink_port_unregister() twice.

In other words, either mlx4_init_port_info() succeeds and returns zero, or
it fails, returns non-zero, and requires no cleanup.

Signed-off-by: Tarick Bedeir <tarick@google.com>
---
 drivers/net/ethernet/mellanox/mlx4/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 4d84cab77105..e8a3a45d0b53 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -3007,6 +3007,7 @@ static int mlx4_init_port_info(struct mlx4_dev *dev, int port)
 		mlx4_err(dev, "Failed to create file for port %d\n", port);
 		devlink_port_unregister(&info->devlink_port);
 		info->port = -1;
+		return err;
 	}
 
 	sprintf(info->dev_mtu_name, "mlx4_port%d_mtu", port);
@@ -3028,9 +3029,10 @@ static int mlx4_init_port_info(struct mlx4_dev *dev, int port)
 				   &info->port_attr);
 		devlink_port_unregister(&info->devlink_port);
 		info->port = -1;
+		return err;
 	}
 
-	return err;
+	return 0;
 }
 
 static void mlx4_cleanup_port_info(struct mlx4_port_info *info)
-- 
2.17.0.441.gb46fe60e1d-goog
