Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163791AbeE1KvN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163763AbeE1KvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 222/496] IB/mlx4: Fix corruption of RoCEv2 IPv4 GIDs
Date: Mon, 28 May 2018 12:00:07 +0200
Message-Id: <20180528100329.268326981@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit 0077416a3d529baccbe07ab3242e8db541cfadf6 ]

When using IPv4 addresses in RoCEv2, the GID format for the mapped
IPv4 address should be: ::ffff:<4-byte IPv4 address>.

In the cited commit, IPv4 mapped IPV6 addresses had the 3 upper dwords
zeroed out by memset, which resulted in deleting the ffff field.

However, since procedure ipv6_addr_v4mapped() already verifies that the
gid has format ::ffff:<ipv4 address>, no change is needed for the gid,
and the memset can simply be removed.

Fixes: 7e57b85c444c ("IB/mlx4: Add support for setting RoCEv2 gids in hardware")
Reviewed-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx4/main.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -219,8 +219,6 @@ static int mlx4_ib_update_gids_v1_v2(str
 			gid_tbl[i].version = 2;
 			if (!ipv6_addr_v4mapped((struct in6_addr *)&gids[i].gid))
 				gid_tbl[i].type = 1;
-			else
-				memset(&gid_tbl[i].gid, 0, 12);
 		}
 	}
 
