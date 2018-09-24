Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48ACECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A214214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A214214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbeIXSOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:14:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55074 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbeIXSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:14:38 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79ABD1081;
        Mon, 24 Sep 2018 12:12:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huy Nguyen <huyn@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 005/173] net/mlx5: Check for error in mlx5_attach_interface
Date:   Mon, 24 Sep 2018 13:50:39 +0200
Message-Id: <20180924113114.988646553@linuxfoundation.org>
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

From: Huy Nguyen <huyn@mellanox.com>

[ Upstream commit 47bc94b82291e007da61ee1b3d18c77871f3e158 ]

Currently, mlx5_attach_interface does not check for error
after calling intf->attach or intf->add. When these two calls
fails, the client is not initialized and will cause issues such as
kernel panic on invalid address in the teardown path (mlx5_detach_interface)

Fixes: 737a234bb638 ("net/mlx5: Introduce attach/detach to interface API")
Signed-off-by: Huy Nguyen <huyn@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -132,11 +132,11 @@ void mlx5_add_device(struct mlx5_interfa
 	delayed_event_start(priv);
 
 	dev_ctx->context = intf->add(dev);
-	set_bit(MLX5_INTERFACE_ADDED, &dev_ctx->state);
-	if (intf->attach)
-		set_bit(MLX5_INTERFACE_ATTACHED, &dev_ctx->state);
-
 	if (dev_ctx->context) {
+		set_bit(MLX5_INTERFACE_ADDED, &dev_ctx->state);
+		if (intf->attach)
+			set_bit(MLX5_INTERFACE_ATTACHED, &dev_ctx->state);
+
 		spin_lock_irq(&priv->ctx_lock);
 		list_add_tail(&dev_ctx->list, &priv->ctx_list);
 
@@ -211,12 +211,17 @@ static void mlx5_attach_interface(struct
 	if (intf->attach) {
 		if (test_bit(MLX5_INTERFACE_ATTACHED, &dev_ctx->state))
 			goto out;
-		intf->attach(dev, dev_ctx->context);
+		if (intf->attach(dev, dev_ctx->context))
+			goto out;
+
 		set_bit(MLX5_INTERFACE_ATTACHED, &dev_ctx->state);
 	} else {
 		if (test_bit(MLX5_INTERFACE_ADDED, &dev_ctx->state))
 			goto out;
 		dev_ctx->context = intf->add(dev);
+		if (!dev_ctx->context)
+			goto out;
+
 		set_bit(MLX5_INTERFACE_ADDED, &dev_ctx->state);
 	}
 


