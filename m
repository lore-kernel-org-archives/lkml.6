Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162133AbeE1Kfv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162111AbeE1Kfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:35:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 185/329] IB/mlx5: Fix an error code in __mlx5_ib_modify_qp()
Date: Mon, 28 May 2018 12:01:54 +0200
Message-Id: <20180528100257.696672207@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5d414b178e950ce9685c253994cc730893d5d887 ]

"err" is either zero or possibly uninitialized here.  It should be
-EINVAL.

Fixes: 427c1e7bcd7e ("{IB, net}/mlx5: Move the modify QP operation table to mlx5_ib")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/qp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2809,8 +2809,10 @@ static int __mlx5_ib_modify_qp(struct ib
 		mlx5_ib_qp_disable_pagefaults(qp);
 
 	if (mlx5_cur >= MLX5_QP_NUM_STATE || mlx5_new >= MLX5_QP_NUM_STATE ||
-	    !optab[mlx5_cur][mlx5_new])
+	    !optab[mlx5_cur][mlx5_new]) {
+		err = -EINVAL;
 		goto out;
+	}
 
 	op = optab[mlx5_cur][mlx5_new];
 	optpar = ib_mask_to_mlx5_opt(attr_mask);
