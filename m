Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1890DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEB82075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEB82075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeIHB4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:56:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbeIHB4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:56:54 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4AB5F1026;
        Fri,  7 Sep 2018 21:14:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.18 041/145] IB/mlx5: Fix leaking stack memory to userspace
Date:   Fri,  7 Sep 2018 23:08:27 +0200
Message-Id: <20180907210907.921492252@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@mellanox.com>

commit 0625b4ba1a5d4703c7fb01c497bd6c156908af00 upstream.

mlx5_ib_create_qp_resp was never initialized and only the first 4 bytes
were written.

Fixes: 41d902cb7c32 ("RDMA/mlx5: Fix definition of mlx5_ib_create_qp_resp")
Cc: <stable@vger.kernel.org>
Acked-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/qp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1626,7 +1626,7 @@ static int create_qp_common(struct mlx5_
 	struct mlx5_ib_resources *devr = &dev->devr;
 	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
 	struct mlx5_core_dev *mdev = dev->mdev;
-	struct mlx5_ib_create_qp_resp resp;
+	struct mlx5_ib_create_qp_resp resp = {};
 	struct mlx5_ib_cq *send_cq;
 	struct mlx5_ib_cq *recv_cq;
 	unsigned long flags;


