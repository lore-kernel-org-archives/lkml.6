Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162056AbeE1KfX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162025AbeE1KfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:35:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 184/329] IB/mlx4: Include GID type when deleting GIDs from HW table under RoCE
Date: Mon, 28 May 2018 12:01:53 +0200
Message-Id: <20180528100257.639128060@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack M <jackm@dev.mellanox.co.il>

[ Upstream commit a18177925c252da7801149abe217c05b80884798 ]

The commit cited below added a gid_type field (RoCEv1 or RoCEv2)
to GID properties.

When adding GIDs, this gid_type field was copied over to the
hardware gid table. However, when deleting GIDs, the gid_type field
was not copied over to the hardware gid table.

As a result, when running RoCEv2, all RoCEv2 gids in the
hardware gid table were set to type RoCEv1 when any gid was deleted.

This problem would persist until the next gid was added (which would again
restore the gid_type field for all the gids in the hardware gid table).

Fix this by copying over the gid_type field to the hardware gid table
when deleting gids, so that the gid_type of all remaining gids is
preserved when a gid is deleted.

Fixes: b699a859d17b ("IB/mlx4: Add gid_type to GID properties")
Reviewed-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx4/main.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -361,8 +361,13 @@ static int mlx4_ib_del_gid(struct ib_dev
 		if (!gids) {
 			ret = -ENOMEM;
 		} else {
-			for (i = 0; i < MLX4_MAX_PORT_GIDS; i++)
-				memcpy(&gids[i].gid, &port_gid_table->gids[i].gid, sizeof(union ib_gid));
+			for (i = 0; i < MLX4_MAX_PORT_GIDS; i++) {
+				memcpy(&gids[i].gid,
+				       &port_gid_table->gids[i].gid,
+				       sizeof(union ib_gid));
+				gids[i].gid_type =
+				    port_gid_table->gids[i].gid_type;
+			}
 		}
 	}
 	spin_unlock_bh(&iboe->lock);
