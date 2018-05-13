Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeEMXiv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 19:38:51 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:43181 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeEMXit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 19:38:49 -0400
X-Google-Smtp-Source: AB8JxZoqgMhEKU9TVLxD8umdWjGJnQ7uT+Ab5GEshOaiQHRFXXFx+djvcrj5CJa6saIwzHIANLXgnDEVYB8=
MIME-Version: 1.0
Date: Sun, 13 May 2018 16:38:45 -0700
Message-Id: <20180513233845.135290-1-tarick@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2] net/mlx4_core: Fix error handling in mlx4_init_port_info.
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

Fixes: 096335b3f983 ("mlx4_core: Allow dynamic MTU configuration for IB
ports")
Signed-off-by: Tarick Bedeir <tarick@google.com>
---
v1 -> v2: Added "Fixes" tag.
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
