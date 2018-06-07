Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iDazATqFGVv1MgAAmS7hNA
	; Thu, 07 Jun 2018 19:19:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5830A606DD; Thu,  7 Jun 2018 19:19:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A73636063F;
	Thu,  7 Jun 2018 19:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A73636063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753390AbeFGTTW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:19:22 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.91]:27903 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751155AbeFGTTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:19:21 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 69D07400DECD0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 14:19:20 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id R0RMfZ9YIaSeyR0RMfIVDP; Thu, 07 Jun 2018 14:19:20 -0500
X-Authority-Reason: nr=8
Received: from [187.192.46.223] (port=43968 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.89_1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fR0RJ-004BrQ-TY; Thu, 07 Jun 2018 14:19:18 -0500
Date: Thu, 7 Jun 2018 14:19:15 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Raed Salem <raeds@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] IB/mlx5: Fix memory leak in mlx5_ib_create_flow
Message-ID: <20180607191915.GA9092@embeddedor.com>
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
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fR0RJ-004BrQ-TY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.46.223]:43968
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case memory resources for *ucmd* were allocated, release them
before return.

Addresses-Coverity-ID: 1469857 ("Resource leak")
Fixes: 3b3233fbf02e ("IB/mlx5: Add flow counters binding support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/hw/mlx5/main.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e52dd21..0472e6c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3546,29 +3546,35 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
 			return ERR_PTR(-ENOMEM);
 
 		err = ib_copy_from_udata(ucmd, udata, required_ucmd_sz);
-		if (err) {
-			kfree(ucmd);
-			return ERR_PTR(err);
-		}
+		if (err)
+			goto free_ucmd;
 	}
 
-	if (flow_attr->priority > MLX5_IB_FLOW_LAST_PRIO)
-		return ERR_PTR(-ENOMEM);
+	if (flow_attr->priority > MLX5_IB_FLOW_LAST_PRIO) {
+		err = -ENOMEM;
+		goto free_ucmd;
+	}
 
 	if (domain != IB_FLOW_DOMAIN_USER ||
 	    flow_attr->port > dev->num_ports ||
 	    (flow_attr->flags & ~(IB_FLOW_ATTR_FLAGS_DONT_TRAP |
-				  IB_FLOW_ATTR_FLAGS_EGRESS)))
-		return ERR_PTR(-EINVAL);
+				  IB_FLOW_ATTR_FLAGS_EGRESS))) {
+		err = -EINVAL;
+		goto free_ucmd;
+	}
 
 	if (is_egress &&
 	    (flow_attr->type == IB_FLOW_ATTR_ALL_DEFAULT ||
-	     flow_attr->type == IB_FLOW_ATTR_MC_DEFAULT))
-		return ERR_PTR(-EINVAL);
+	     flow_attr->type == IB_FLOW_ATTR_MC_DEFAULT)) {
+		err = -EINVAL;
+		goto free_ucmd;
+	}
 
 	dst = kzalloc(sizeof(*dst), GFP_KERNEL);
-	if (!dst)
-		return ERR_PTR(-ENOMEM);
+	if (!dst) {
+		err = -ENOMEM;
+		goto free_ucmd;
+	}
 
 	mutex_lock(&dev->flow_db->lock);
 
@@ -3640,6 +3646,9 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
 	kfree(ucmd);
 	kfree(handler);
 	return ERR_PTR(err);
+free_ucmd:
+	kfree(ucmd);
+	return ERR_PTR(err);
 }
 
 static u32 mlx5_ib_flow_action_flags_to_accel_xfrm_flags(u32 mlx5_flags)
-- 
2.7.4
