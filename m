Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CF9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9206208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9206208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeHWLj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:39:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45684 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbeHWLj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:39:26 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D29F1C83;
        Thu, 23 Aug 2018 08:10:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kamal Heib <kamalheib1@gmail.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 098/130] RDMA/mlx5: Fix memory leak in mlx5_ib_create_srq() error path
Date:   Thu, 23 Aug 2018 09:53:34 +0200
Message-Id: <20180823074933.486834772@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Heib <kamalheib1@gmail.com>

[ Upstream commit d63c46734c545ad0488761059004a65c46efdde3 ]

Fix memory leak in the error path of mlx5_ib_create_srq() by making sure
to free the allocated srq.

Fixes: c2b37f76485f ("IB/mlx5: Fix integer overflows in mlx5_ib_create_srq")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Acked-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/srq.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -268,18 +268,24 @@ struct ib_srq *mlx5_ib_create_srq(struct
 
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
 	in.type = init_attr->srq_type;
 
 	if (pd->uobject)


