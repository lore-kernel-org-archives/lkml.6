Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeCVSo7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:44:59 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.4]:31669 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751745AbeCVSo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:44:58 -0400
Date: Thu, 22 Mar 2018 13:44:56 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Yuval Shaia <yuval.shaia@oracle.com>, Ilan Tayari <ilant@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>, Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] net/mlx5: Fix use-after-free
Message-ID: <20180322184456.GA22259@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1ez5Cr-0002im-4L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.145.54.187]:53018
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 37
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_rule_ is being freed and then dereferenced by accessing rule->ctx

Fix this by copying the value returned by PTR_ERR(rule->ctx) into a local
variable for its safe use after freeing _rule_

Addresses-Coverity-ID: 1466041 ("Read from pointer after free")
Fixes: 05564d0ae075 ("net/mlx5: Add flow-steering commands for FPGA IPSec implementation")
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Use a short subject prefix as suggested by Yuval Shaia.
 - Add Yuval's Reviewed-by.

 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
index 4f15685..0f5da49 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
@@ -1061,8 +1061,9 @@ static int fpga_ipsec_fs_create_fte(struct mlx5_core_dev *dev,
 
 	rule->ctx = mlx5_fpga_ipsec_fs_create_sa_ctx(dev, fte, is_egress);
 	if (IS_ERR(rule->ctx)) {
+		int err = PTR_ERR(rule->ctx);
 		kfree(rule);
-		return PTR_ERR(rule->ctx);
+		return err;
 	}
 
 	rule->fte = fte;
-- 
2.7.4
