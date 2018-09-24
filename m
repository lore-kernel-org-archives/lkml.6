Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32F2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77681208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77681208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbeIXSOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:14:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbeIXSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:14:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E34E41088;
        Mon, 24 Sep 2018 12:12:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Daniel Jurgens <danielj@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 006/173] net/mlx5: Fix debugfs cleanup in the device init/remove flow
Date:   Mon, 24 Sep 2018 13:50:40 +0200
Message-Id: <20180924113115.075005428@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit 5df816e7f43f1297c40021ef17ec6e722b45c82f ]

When initializing the device (procedure init_one), the driver
calls mlx5_pci_init to perform pci initialization. As part of this
initialization, mlx5_pci_init creates a debugfs directory.
If this creation fails, init_one aborts, returning failure to
the caller (which is the probe method caller).

The main reason for such a failure to occur is if the debugfs
directory already exists. This can happen if the last time
mlx5_pci_close was called, debugfs_remove (silently) failed due
to the debugfs directory not being empty.

Guarantee that such a debugfs_remove failure will not occur by
instead calling debugfs_remove_recursive in procedure mlx5_pci_close.

Fixes: 59211bd3b632 ("net/mlx5: Split the load/unload flow into hardware and software flows")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -857,8 +857,10 @@ static int mlx5_pci_init(struct mlx5_cor
 	priv->numa_node = dev_to_node(&dev->pdev->dev);
 
 	priv->dbg_root = debugfs_create_dir(dev_name(&pdev->dev), mlx5_debugfs_root);
-	if (!priv->dbg_root)
+	if (!priv->dbg_root) {
+		dev_err(&pdev->dev, "Cannot create debugfs dir, aborting\n");
 		return -ENOMEM;
+	}
 
 	err = mlx5_pci_enable_device(dev);
 	if (err) {
@@ -907,7 +909,7 @@ static void mlx5_pci_close(struct mlx5_c
 	pci_clear_master(dev->pdev);
 	release_bar(dev->pdev);
 	mlx5_pci_disable_device(dev);
-	debugfs_remove(priv->dbg_root);
+	debugfs_remove_recursive(priv->dbg_root);
 }
 
 static int mlx5_init_once(struct mlx5_core_dev *dev, struct mlx5_priv *priv)


