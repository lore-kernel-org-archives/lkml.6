Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZrJ+I95HGVvxQAAAmS7hNA
	; Thu, 07 Jun 2018 14:58:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 20A4B608BA; Thu,  7 Jun 2018 14:58:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 86329601C3;
	Thu,  7 Jun 2018 14:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86329601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935523AbeFGO6L (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:58:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41163 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933329AbeFGO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:58:08 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbl-0005Zv-WC; Thu, 07 Jun 2018 15:09:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0002xM-Jq; Thu, 07 Jun 2018 15:09:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jason Gunthorpe" <jgg@mellanox.com>,
        "Majd Dibbiny" <majd@mellanox.com>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "Yuval Shaia" <yuval.shaia@oracle.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.464477338@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 174/410] RDMA/mlx5: Avoid memory leak in case of XRCD
 dealloc failure
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

From: Leon Romanovsky <leonro@mellanox.com>

commit b081808a66345ba725b77ecd8d759bee874cd937 upstream.

Failure in XRCD FW deallocation command leaves memory leaked and
returns error to the user which he can't do anything about it.

This patch changes behavior to always free memory and always return
success to the user.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/mlx5/qp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3050,12 +3050,9 @@ int mlx5_ib_dealloc_xrcd(struct ib_xrcd
 	int err;
 
 	err = mlx5_core_xrcd_dealloc(&dev->mdev, xrcdn);
-	if (err) {
+	if (err)
 		mlx5_ib_warn(dev, "failed to dealloc xrcdn 0x%x\n", xrcdn);
-		return err;
-	}
 
 	kfree(xrcd);
-
 	return 0;
 }
