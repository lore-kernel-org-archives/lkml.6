Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FEFC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F162539D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F162539D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031937AbeGAQki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:40:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031925AbeGAQkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:40:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A9A6AA6;
        Sun,  1 Jul 2018 16:40:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.17 088/220] IB/mlx5: Fetch soft WQEs on fatal error state
Date:   Sun,  1 Jul 2018 18:21:52 +0200
Message-Id: <20180701160912.095929257@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erez Shitrit <erezsh@mellanox.com>

commit 7b74a83cf54a3747e22c57e25712bd70eef8acee upstream.

On fatal error the driver simulates CQE's for ULPs that rely on
completion of all their posted work-request.

For the GSI traffic, the mlx5 has its own mechanism that sends the
completions via software CQE's directly to the relevant CQ.

This should be kept in fatal error too, so the driver should simulate
such CQE's with the specified error state in order to complete GSI QP
work requests.

Without the fix the next deadlock might appears:
        schedule_timeout+0x274/0x350
        wait_for_common+0xec/0x240
        mcast_remove_one+0xd0/0x120 [ib_core]
        ib_unregister_device+0x12c/0x230 [ib_core]
        mlx5_ib_remove+0xc4/0x270 [mlx5_ib]
        mlx5_detach_device+0x184/0x1a0 [mlx5_core]
        mlx5_unload_one+0x308/0x340 [mlx5_core]
        mlx5_pci_err_detected+0x74/0xe0 [mlx5_core]

Cc: <stable@vger.kernel.org> # 4.7
Fixes: 89ea94a7b6c4 ("IB/mlx5: Reset flow support for IB kernel ULPs")
Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/cq.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -637,7 +637,7 @@ repoll:
 }
 
 static int poll_soft_wc(struct mlx5_ib_cq *cq, int num_entries,
-			struct ib_wc *wc)
+			struct ib_wc *wc, bool is_fatal_err)
 {
 	struct mlx5_ib_dev *dev = to_mdev(cq->ibcq.device);
 	struct mlx5_ib_wc *soft_wc, *next;
@@ -650,6 +650,10 @@ static int poll_soft_wc(struct mlx5_ib_c
 		mlx5_ib_dbg(dev, "polled software generated completion on CQ 0x%x\n",
 			    cq->mcq.cqn);
 
+		if (unlikely(is_fatal_err)) {
+			soft_wc->wc.status = IB_WC_WR_FLUSH_ERR;
+			soft_wc->wc.vendor_err = MLX5_CQE_SYNDROME_WR_FLUSH_ERR;
+		}
 		wc[npolled++] = soft_wc->wc;
 		list_del(&soft_wc->list);
 		kfree(soft_wc);
@@ -670,12 +674,17 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq,
 
 	spin_lock_irqsave(&cq->lock, flags);
 	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR) {
-		mlx5_ib_poll_sw_comp(cq, num_entries, wc, &npolled);
+		/* make sure no soft wqe's are waiting */
+		if (unlikely(!list_empty(&cq->wc_list)))
+			soft_polled = poll_soft_wc(cq, num_entries, wc, true);
+
+		mlx5_ib_poll_sw_comp(cq, num_entries - soft_polled,
+				     wc + soft_polled, &npolled);
 		goto out;
 	}
 
 	if (unlikely(!list_empty(&cq->wc_list)))
-		soft_polled = poll_soft_wc(cq, num_entries, wc);
+		soft_polled = poll_soft_wc(cq, num_entries, wc, false);
 
 	for (npolled = 0; npolled < num_entries - soft_polled; npolled++) {
 		if (mlx5_poll_one(cq, &cur_qp, wc + soft_polled + npolled))


