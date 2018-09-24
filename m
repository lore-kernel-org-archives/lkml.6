Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67115ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C80920877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C80920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbeIXSC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:02:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbeIXSC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:02:28 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D8FB2D64;
        Mon, 24 Sep 2018 12:00:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Feras Daoud <ferasda@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.9 003/111] net/mlx5: Fix use-after-free in self-healing flow
Date:   Mon, 24 Sep 2018 13:51:30 +0200
Message-Id: <20180924113104.146388082@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit 76d5581c870454be5f1f1a106c57985902e7ea20 ]

When the mlx5 health mechanism detects a problem while the driver
is in the middle of init_one or remove_one, the driver needs to prevent
the health mechanism from scheduling future work; if future work
is scheduled, there is a problem with use-after-free: the system WQ
tries to run the work item (which has been freed) at the scheduled
future time.

Prevent this by disabling work item scheduling in the health mechanism
when the driver is in the middle of init_one() or remove_one().

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Reviewed-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c |   10 +++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/main.c   |    4 ++--
 include/linux/mlx5/driver.h                      |    2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -339,9 +339,17 @@ void mlx5_start_health_poll(struct mlx5_
 	add_timer(&health->timer);
 }
 
-void mlx5_stop_health_poll(struct mlx5_core_dev *dev)
+void mlx5_stop_health_poll(struct mlx5_core_dev *dev, bool disable_health)
 {
 	struct mlx5_core_health *health = &dev->priv.health;
+	unsigned long flags;
+
+	if (disable_health) {
+		spin_lock_irqsave(&health->wq_lock, flags);
+		set_bit(MLX5_DROP_NEW_HEALTH_WORK, &health->flags);
+		set_bit(MLX5_DROP_NEW_RECOVERY_WORK, &health->flags);
+		spin_unlock_irqrestore(&health->wq_lock, flags);
+	}
 
 	del_timer_sync(&health->timer);
 }
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1130,7 +1130,7 @@ err_cleanup_once:
 		mlx5_cleanup_once(dev);
 
 err_stop_poll:
-	mlx5_stop_health_poll(dev);
+	mlx5_stop_health_poll(dev, boot);
 	if (mlx5_cmd_teardown_hca(dev)) {
 		dev_err(&dev->pdev->dev, "tear_down_hca failed, skip cleanup\n");
 		goto out_err;
@@ -1187,7 +1187,7 @@ static int mlx5_unload_one(struct mlx5_c
 	mlx5_disable_msix(dev);
 	if (cleanup)
 		mlx5_cleanup_once(dev);
-	mlx5_stop_health_poll(dev);
+	mlx5_stop_health_poll(dev, cleanup);
 	err = mlx5_cmd_teardown_hca(dev);
 	if (err) {
 		dev_err(&dev->pdev->dev, "tear_down_hca failed, skip cleanup\n");
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -786,7 +786,7 @@ void mlx5_unmap_free_uar(struct mlx5_cor
 void mlx5_health_cleanup(struct mlx5_core_dev *dev);
 int mlx5_health_init(struct mlx5_core_dev *dev);
 void mlx5_start_health_poll(struct mlx5_core_dev *dev);
-void mlx5_stop_health_poll(struct mlx5_core_dev *dev);
+void mlx5_stop_health_poll(struct mlx5_core_dev *dev, bool disable_health);
 void mlx5_drain_health_wq(struct mlx5_core_dev *dev);
 void mlx5_drain_health_recovery(struct mlx5_core_dev *dev);
 int mlx5_buf_alloc_node(struct mlx5_core_dev *dev, int size,


