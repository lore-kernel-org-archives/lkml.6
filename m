Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeBBPqs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:46:48 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:55139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBBPqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:46:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Or Gerlitz <ogerlitz@mellanox.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: mlx5: remove pointless memcpy
Date: Fri,  2 Feb 2018 16:46:30 +0100
Message-Id: <20180202154636.1624079-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:vW8LgAxomaJzXCYabU0L00RV+JG+Wiz6uUq7kBUNQUS713ZsveX
 tSla9lLLJKhwCIgkY48KDtUM8GCtaop4uH0R2W2WFpX+nJqpbhnCQjW8KHhC5KhTgLk+vYU
 0yz6gfOVAOvezWVFyZ4n4JvWk+KeJVOy2lpc+lxD/bKX3+C019zL82hA41ssL5qQ7BETGRf
 9c5tdEDbPFCuFxng5FBDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hqjj+lDM4gI=:xnCTCd4UY4V7m6kfddhp9h
 HJyTPAziy5WIHhP7DqSsvcBA6M9V1hHrYjBjIy/AsYSwtm68rDuBNgHChjctidC4CQzJCdF2e
 1EaNdB1wD3BHEeJGvxWMTSrSyKz4MsWHaXuC64nMHofcfisbnjodL+M/xOlD+wh0hyrAL193z
 1W6cLehRw9wr1uG0P+M8eXy/6vEyqEkQj64dCYIydkPagamuhndYheMNxhhzgcfWWjlfEN+r1
 9Jkcg+Gar6vn+94fNKIgfwOgcj8h8X5yVabzdi0IfLfNVkp4LNwjLWLmccGH7rA7picIeSF4G
 EvPC86VbBZglNRCxW1kSE6y5qyeDGwoildtuAlWhM5a58TqbR8PeTMNebrBZH37WZ8LcDVLrj
 +zRpQAxj/qmcU88E3cf0uImnx7hyu+u9yAefz4xGewMlsmc21EvPOzOM7DN4D6raO2J2QYCVT
 OElv2xB96XtLXes6qCvcr9PxKgsw5qbGQ27XnTsXegZviCtL0NaKn/SkZrFmEWk+kpX8G5+iP
 ytA6d/4fxRJY621RFkuAWZgoQhaPPaHUZCDSwti+B84DiqP7+BGMCQ/VfoaWsMXfkvrn/Voeo
 /xcMq7DVqvmfsD1djMfBLatGlS0xIqY/MHl7Gf0PBlRHsNwgwY50X93E4SaiLTRlVQPcIzLme
 gRaPA8GjxuDLhuRnDse9m6T6wmzIGBAoSAYPQn47P3eK8dHgaIIatH02UH54GSat8rM6wdcf6
 dGwXa0vf/9a4krXQZ3bbPR5syRaRp11TLybJpw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-8 notices that the memcpy in mlx5_core_query_xsrq() makes no
sense because the source and destination variables are identical:

drivers/net/ethernet/mellanox/mlx5/core/transobj.c: In function 'mlx5_core_query_xsrq':
drivers/net/ethernet/mellanox/mlx5/core/transobj.c:347:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

Either one of the pointers should be something else, or the code is
completely bogus. Removing the memcpy() won't change the behavior
but gets rid of the warning.

Fixes: 01949d0109ee ("net/mlx5_core: Enable XRCs and SRQs when using ISSI > 0")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please review carefully, I have no idea what the author actually
intended here.
---
 drivers/net/ethernet/mellanox/mlx5/core/transobj.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/transobj.c b/drivers/net/ethernet/mellanox/mlx5/core/transobj.c
index 9e38343a951f..75450f7d53bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/transobj.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/transobj.c
@@ -332,20 +332,12 @@ int mlx5_core_destroy_xsrq(struct mlx5_core_dev *dev, u32 xsrqn)
 int mlx5_core_query_xsrq(struct mlx5_core_dev *dev, u32 xsrqn, u32 *out)
 {
 	u32 in[MLX5_ST_SZ_DW(query_xrc_srq_in)] = {0};
-	void *srqc;
-	void *xrc_srqc;
 	int err;
 
 	MLX5_SET(query_xrc_srq_in, in, opcode,   MLX5_CMD_OP_QUERY_XRC_SRQ);
 	MLX5_SET(query_xrc_srq_in, in, xrc_srqn, xsrqn);
 	err = mlx5_cmd_exec(dev, in, sizeof(in), out,
 			    MLX5_ST_SZ_BYTES(query_xrc_srq_out));
-	if (!err) {
-		xrc_srqc = MLX5_ADDR_OF(query_xrc_srq_out, out,
-					xrc_srq_context_entry);
-		srqc = MLX5_ADDR_OF(query_srq_out, out, srq_context_entry);
-		memcpy(srqc, xrc_srqc, MLX5_ST_SZ_BYTES(srqc));
-	}
 
 	return err;
 }
-- 
2.9.0
