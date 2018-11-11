Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADABC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF4820818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF4820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbeKLFsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49906 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730184AbeKLFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:13 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0000l8-91; Sun, 11 Nov 2018 19:58:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001ie-6T; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Leon Romanovsky" <leonro@mellanox.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "Kamal Heib" <kamalheib1@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.696685279@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 246/366] RDMA/mlx5: Fix memory leak in
 mlx5_ib_create_srq() error path
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Heib <kamalheib1@gmail.com>

commit d63c46734c545ad0488761059004a65c46efdde3 upstream.

Fix memory leak in the error path of mlx5_ib_create_srq() by making sure
to free the allocated srq.

Fixes: c2b37f76485f ("IB/mlx5: Fix integer overflows in mlx5_ib_create_srq")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Acked-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/mlx5/srq.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -261,18 +261,24 @@ struct ib_srq *mlx5_ib_create_srq(struct
 
 	desc_size = sizeof(struct mlx5_wqe_srq_next_seg) +
 		    srq->msrq.max_gs * sizeof(struct mlx5_wqe_data_seg);
-	if (desc_size == 0 || srq->msrq.max_gs > desc_size)
-		return ERR_PTR(-EINVAL);
+	if (desc_size == 0 || srq->msrq.max_gs > desc_size) {
+		err = -EINVAL;
+		goto err_srq;
+	}
 	desc_size = roundup_pow_of_two(desc_size);
 	desc_size = max_t(size_t, 32, desc_size);
-	if (desc_size < sizeof(struct mlx5_wqe_srq_next_seg))
-		return ERR_PTR(-EINVAL);
+	if (desc_size < sizeof(struct mlx5_wqe_srq_next_seg)) {
+		err = -EINVAL;
+		goto err_srq;
+	}
 	srq->msrq.max_avail_gather = (desc_size - sizeof(struct mlx5_wqe_srq_next_seg)) /
 		sizeof(struct mlx5_wqe_data_seg);
 	srq->msrq.wqe_shift = ilog2(desc_size);
 	buf_size = srq->msrq.max * desc_size;
-	if (buf_size < desc_size)
-		return ERR_PTR(-EINVAL);
+	if (buf_size < desc_size) {
+		err = -EINVAL;
+		goto err_srq;
+	}
 
 	if (pd->uobject)
 		err = create_srq_user(pd, srq, &in, udata, buf_size, &inlen);

