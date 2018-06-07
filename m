Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id p94TF2pGGVuvNwAAmS7hNA
	; Thu, 07 Jun 2018 14:52:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2E91D608BF; Thu,  7 Jun 2018 14:52:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8A8586074D;
	Thu,  7 Jun 2018 14:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A8586074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935206AbeFGOwX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:52:23 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40909 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932674AbeFGOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:52:19 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbQ-0005Zj-AN; Thu, 07 Jun 2018 15:09:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003EI-HW; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Doug Ledford" <dledford@redhat.com>,
        "syzkaller" <syzkaller@googlegroups.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "Boris Pismenny" <borisp@mellanox.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.828469315@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 347/410] IB/mlx5: Fix integer overflows in
 mlx5_ib_create_srq
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

From: Boris Pismenny <borisp@mellanox.com>

commit c2b37f76485f073f020e60b5954b6dc4e55f693c upstream.

This patch validates user provided input to prevent integer overflow due
to integer manipulation in the mlx5_ib_create_srq function.

Cc: syzkaller <syzkaller@googlegroups.com>
Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/mlx5/srq.c | 15 +++++++++------
 include/linux/mlx5/driver.h      |  4 ++--
 2 files changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -234,8 +234,8 @@ struct ib_srq *mlx5_ib_create_srq(struct
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_srq *srq;
-	int desc_size;
-	int buf_size;
+	size_t desc_size;
+	size_t buf_size;
 	int err;
 	struct mlx5_create_srq_mbox_in *uninitialized_var(in);
 	int uninitialized_var(inlen);
@@ -261,15 +261,18 @@ struct ib_srq *mlx5_ib_create_srq(struct
 
 	desc_size = sizeof(struct mlx5_wqe_srq_next_seg) +
 		    srq->msrq.max_gs * sizeof(struct mlx5_wqe_data_seg);
+	if (desc_size == 0 || srq->msrq.max_gs > desc_size)
+		return ERR_PTR(-EINVAL);
 	desc_size = roundup_pow_of_two(desc_size);
-	desc_size = max_t(int, 32, desc_size);
+	desc_size = max_t(size_t, 32, desc_size);
+	if (desc_size < sizeof(struct mlx5_wqe_srq_next_seg))
+		return ERR_PTR(-EINVAL);
 	srq->msrq.max_avail_gather = (desc_size - sizeof(struct mlx5_wqe_srq_next_seg)) /
 		sizeof(struct mlx5_wqe_data_seg);
 	srq->msrq.wqe_shift = ilog2(desc_size);
 	buf_size = srq->msrq.max * desc_size;
-	mlx5_ib_dbg(dev, "desc_size 0x%x, req wr 0x%x, srq size 0x%x, max_gs 0x%x, max_avail_gather 0x%x\n",
-		    desc_size, init_attr->attr.max_wr, srq->msrq.max, srq->msrq.max_gs,
-		    srq->msrq.max_avail_gather);
+	if (buf_size < desc_size)
+		return ERR_PTR(-EINVAL);
 
 	if (pd->uobject)
 		err = create_srq_user(pd, srq, &in, udata, buf_size, &inlen);
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -432,8 +432,8 @@ struct mlx5_core_mr {
 struct mlx5_core_srq {
 	u32		srqn;
 	int		max;
-	int		max_gs;
-	int		max_avail_gather;
+	size_t		max_gs;
+	size_t		max_avail_gather;
 	int		wqe_shift;
 	void (*event)	(struct mlx5_core_srq *, enum mlx5_event);
 
