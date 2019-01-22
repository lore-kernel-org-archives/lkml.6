Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EC6C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32861217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170312;
	bh=548s8q4iwHXRog+fBXIv1u/MiIcvYBE1as69hC3hbDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WZdCWBvpas0xkQrF5HY6fe42MnEiTr8IS9yL/ncVGZDYbNmkUfMbmF2vI79ImNlYB
	 fnhNY32gNoLJDeD/Cl3keDoelIIuAv/0flmRBSexpq2ElBeoEmsthOOx2sec05IJAn
	 1ZHjdMCEZppfTnhH7oxFu+lbg7kQuEY3YFaEYrNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfAVPSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:18:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfAVPS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:18:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D77B20879;
        Tue, 22 Jan 2019 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170306;
        bh=548s8q4iwHXRog+fBXIv1u/MiIcvYBE1as69hC3hbDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stGD/nYDIDvD/UjVCRIHZs0YvRrD76YXfc0TmI+IrQ/y2OUSl4mqN+8Zv2+FmPDJI
         LDGw3ss8atdHmxPk/hfK9rlqlWy1DID6EJrvufHtKZ94eEtswwBH62WAKjsKDtRGBd
         24lRKbR1IRhqW5e2eKq+xxoVp/2OZvSWTwJQyJhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yuval Shaia <yuval.shaia@oracle.com>
Subject: [PATCH 6/8] infiniband: ocrdma: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:17:58 +0100
Message-Id: <20190122151800.15092-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122151800.15092-1-gregkh@linuxfoundation.org>
References: <20190122151800.15092-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Devesh Sharma <devesh.sharma@broadcom.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 67 +++++++--------------
 1 file changed, 22 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
index 6be0ea109138..a902942adb5d 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -767,88 +767,65 @@ void ocrdma_add_port_stats(struct ocrdma_dev *dev)
 
 	/* Create post stats base dir */
 	dev->dir = debugfs_create_dir(pci_name(pdev), ocrdma_dbgfs_dir);
-	if (!dev->dir)
-		goto err;
 
 	dev->rsrc_stats.type = OCRDMA_RSRC_STATS;
 	dev->rsrc_stats.dev = dev;
-	if (!debugfs_create_file("resource_stats", S_IRUSR, dev->dir,
-				 &dev->rsrc_stats, &ocrdma_dbg_ops))
-		goto err;
+	debugfs_create_file("resource_stats", S_IRUSR, dev->dir,
+			    &dev->rsrc_stats, &ocrdma_dbg_ops);
 
 	dev->rx_stats.type = OCRDMA_RXSTATS;
 	dev->rx_stats.dev = dev;
-	if (!debugfs_create_file("rx_stats", S_IRUSR, dev->dir,
-				 &dev->rx_stats, &ocrdma_dbg_ops))
-		goto err;
+	debugfs_create_file("rx_stats", S_IRUSR, dev->dir, &dev->rx_stats,
+			    &ocrdma_dbg_ops);
 
 	dev->wqe_stats.type = OCRDMA_WQESTATS;
 	dev->wqe_stats.dev = dev;
-	if (!debugfs_create_file("wqe_stats", S_IRUSR, dev->dir,
-				 &dev->wqe_stats, &ocrdma_dbg_ops))
-		goto err;
+	debugfs_create_file("wqe_stats", S_IRUSR, dev->dir, &dev->wqe_stats,
+			    &ocrdma_dbg_ops);
 
 	dev->tx_stats.type = OCRDMA_TXSTATS;
 	dev->tx_stats.dev = dev;
-	if (!debugfs_create_file("tx_stats", S_IRUSR, dev->dir,
-				 &dev->tx_stats, &ocrdma_dbg_ops))
-		goto err;
+	debugfs_create_file("tx_stats", S_IRUSR, dev->dir, &dev->tx_stats,
+			    &ocrdma_dbg_ops);
 
 	dev->db_err_stats.type = OCRDMA_DB_ERRSTATS;
 	dev->db_err_stats.dev = dev;
-	if (!debugfs_create_file("db_err_stats", S_IRUSR, dev->dir,
-				 &dev->db_err_stats, &ocrdma_dbg_ops))
-		goto err;
-
+	debugfs_create_file("db_err_stats", S_IRUSR, dev->dir,
+			    &dev->db_err_stats, &ocrdma_dbg_ops);
 
 	dev->tx_qp_err_stats.type = OCRDMA_TXQP_ERRSTATS;
 	dev->tx_qp_err_stats.dev = dev;
-	if (!debugfs_create_file("tx_qp_err_stats", S_IRUSR, dev->dir,
-				 &dev->tx_qp_err_stats, &ocrdma_dbg_ops))
-		goto err;
+	debugfs_create_file("tx_qp_err_stats", S_IRUSR, dev->dir,
+			    &dev->tx_qp_err_stats, &ocrdma_dbg_ops);
 
 	dev->rx_qp_err_stats.type = OCRDMA_RXQP_ERRSTATS;
 	dev->rx_qp_err_stats.dev = dev;
-	if (!debugfs_create_file("rx_qp_err_stats", S_IRUSR, dev->dir,
-				 &dev->rx_qp_err_stats, &ocrdma_dbg_ops))
-		goto err;
-
+	debugfs_create_file("rx_qp_err_stats", S_IRUSR, dev->dir,
+			    &dev->rx_qp_err_stats, &ocrdma_dbg_ops);
 
 	dev->tx_dbg_stats.type = OCRDMA_TX_DBG_STATS;
 	dev->tx_dbg_stats.dev = dev;
-	if (!debugfs_create_file("tx_dbg_stats", S_IRUSR, dev->dir,
-				 &dev->tx_dbg_stats, &ocrdma_dbg_ops))
-		goto err;
+	debugfs_create_file("tx_dbg_stats", S_IRUSR, dev->dir,
+			    &dev->tx_dbg_stats, &ocrdma_dbg_ops);
 
 	dev->rx_dbg_stats.type = OCRDMA_RX_DBG_STATS;
 	dev->rx_dbg_stats.dev = dev;
-	if (!debugfs_create_file("rx_dbg_stats", S_IRUSR, dev->dir,
-				 &dev->rx_dbg_stats, &ocrdma_dbg_ops))
-		goto err;
+	debugfs_create_file("rx_dbg_stats", S_IRUSR, dev->dir,
+			    &dev->rx_dbg_stats, &ocrdma_dbg_ops);
 
 	dev->driver_stats.type = OCRDMA_DRV_STATS;
 	dev->driver_stats.dev = dev;
-	if (!debugfs_create_file("driver_dbg_stats", S_IRUSR, dev->dir,
-					&dev->driver_stats, &ocrdma_dbg_ops))
-		goto err;
+	debugfs_create_file("driver_dbg_stats", S_IRUSR, dev->dir,
+			    &dev->driver_stats, &ocrdma_dbg_ops);
 
 	dev->reset_stats.type = OCRDMA_RESET_STATS;
 	dev->reset_stats.dev = dev;
-	if (!debugfs_create_file("reset_stats", 0200, dev->dir,
-				&dev->reset_stats, &ocrdma_dbg_ops))
-		goto err;
-
-
-	return;
-err:
-	debugfs_remove_recursive(dev->dir);
-	dev->dir = NULL;
+	debugfs_create_file("reset_stats", 0200, dev->dir, &dev->reset_stats,
+			    &ocrdma_dbg_ops);
 }
 
 void ocrdma_rem_port_stats(struct ocrdma_dev *dev)
 {
-	if (!dev->dir)
-		return;
 	debugfs_remove_recursive(dev->dir);
 }
 
-- 
2.20.1

