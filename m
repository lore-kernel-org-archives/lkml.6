Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754794AbeCPQSW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:18:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754758AbeCPQRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:17:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A19060F78
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/18] IB/mlx4: Eliminate duplicate barriers on weakly-ordered archs
Date: Fri, 16 Mar 2018 12:16:29 -0400
Message-Id: <1521216991-28706-17-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code includes wmb() followed by writel(). writel() already has a barrier on
some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/infiniband/hw/mlx4/qp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index f045491..74b27b0 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -3880,8 +3880,8 @@ int mlx4_ib_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 		 */
 		wmb();
 
-		writel(qp->doorbell_qpn,
-		       to_mdev(ibqp->device)->uar_map + MLX4_SEND_DOORBELL);
+		writel_relaxed(qp->doorbell_qpn,
+			to_mdev(ibqp->device)->uar_map + MLX4_SEND_DOORBELL);
 
 		/*
 		 * Make sure doorbells don't leak out of SQ spinlock
-- 
2.7.4
