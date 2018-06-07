Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id a05CCto9GVvtRQAAmS7hNA
	; Thu, 07 Jun 2018 14:15:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8D5ED608B8; Thu,  7 Jun 2018 14:15:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 091F7602FC;
	Thu,  7 Jun 2018 14:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 091F7602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932774AbeFGOJY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:09:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39238 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933006AbeFGOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0005a0-CU; Thu, 07 Jun 2018 15:09:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb0-0002oS-V4; Thu, 07 Jun 2018 15:08:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Moshe Shemesh" <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Tariq Toukan" <tariqt@mellanox.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.639714266@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 090/410] net/mlx4_core: Cleanup FMR unmapping flow
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tariq Toukan <tariqt@mellanox.com>

commit fd4a3e2828b4ca35aef40e5bdc1ed7d87b3cb50a upstream.

Remove redundant and not essential operations in fmr unmap/free.
According to device spec, in FMR unmap it is sufficient to set
ownership bit to SW. This allows remapping afterwards.

Fixes: 8ad11fb6b073 ("IB/mlx4: Implement FMRs")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/mellanox/mlx4/mr.c | 40 +++++++++++++------------
 1 file changed, 21 insertions(+), 19 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/mr.c
+++ b/drivers/net/ethernet/mellanox/mlx4/mr.c
@@ -944,30 +944,16 @@ EXPORT_SYMBOL_GPL(mlx4_fmr_enable);
 void mlx4_fmr_unmap(struct mlx4_dev *dev, struct mlx4_fmr *fmr,
 		    u32 *lkey, u32 *rkey)
 {
-	struct mlx4_cmd_mailbox *mailbox;
-	int err;
-
 	if (!fmr->maps)
 		return;
 
-	fmr->maps = 0;
+	/* To unmap: it is sufficient to take back ownership from HW */
+	*(u8 *)fmr->mpt = MLX4_MPT_STATUS_SW;
 
-	mailbox = mlx4_alloc_cmd_mailbox(dev);
-	if (IS_ERR(mailbox)) {
-		err = PTR_ERR(mailbox);
-		pr_warn("mlx4_ib: mlx4_alloc_cmd_mailbox failed (%d)\n", err);
-		return;
-	}
+	/* Make sure MPT status is visible */
+	wmb();
 
-	err = mlx4_HW2SW_MPT(dev, NULL,
-			     key_to_hw_index(fmr->mr.key) &
-			     (dev->caps.num_mpts - 1));
-	mlx4_free_cmd_mailbox(dev, mailbox);
-	if (err) {
-		pr_warn("mlx4_ib: mlx4_HW2SW_MPT failed (%d)\n", err);
-		return;
-	}
-	fmr->mr.enabled = MLX4_MPT_EN_SW;
+	fmr->maps = 0;
 }
 EXPORT_SYMBOL_GPL(mlx4_fmr_unmap);
 
@@ -977,6 +963,22 @@ int mlx4_fmr_free(struct mlx4_dev *dev,
 
 	if (fmr->maps)
 		return -EBUSY;
+	if (fmr->mr.enabled == MLX4_MPT_EN_HW) {
+		/* In case of FMR was enabled and unmapped
+		 * make sure to give ownership of MPT back to HW
+		 * so HW2SW_MPT command will success.
+		 */
+		*(u8 *)fmr->mpt = MLX4_MPT_STATUS_SW;
+		/* Make sure MPT status is visible before changing MPT fields */
+		wmb();
+		fmr->mpt->length = 0;
+		fmr->mpt->start  = 0;
+		/* Make sure MPT data is visible after changing MPT status */
+		wmb();
+		*(u8 *)fmr->mpt = MLX4_MPT_STATUS_HW;
+		/* make sure MPT status is visible */
+		wmb();
+	}
 
 	ret = mlx4_mr_free(dev, &fmr->mr);
 	if (ret)
