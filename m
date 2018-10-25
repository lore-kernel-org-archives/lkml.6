Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535DEECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198E020869
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMTyWIJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198E020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeJYWsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbeJYWsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:32 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 024992086D;
        Thu, 25 Oct 2018 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476936;
        bh=LjWtmFqNqpFx6I16LDdQj4nGNLhzrKpYdftU7P9BTJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMTyWIJ3W5a5E2dkP5n9cOxmbdyPxOzy4TCnD/5RK4ITH1xZf2mZh62PIG1GL82O0
         Xc+BjDvGvw7psPQkQHPDnbVOeVDgLSkVuPgbO4zDp9HmKPSwb3mXOhrap9YGLsrXs5
         189rTh5XjVAXKpT5oCrp59GZlH05gu1ZXqCbKk54=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 48/98] net/mlx5: Fix health work queue spin lock to IRQ safe
Date:   Thu, 25 Oct 2018 10:13:33 -0400
Message-Id: <20181025141423.213774-48-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit 6377ed0bbae6fa28853e1679d068a9106c8a8908 ]

spin_lock/unlock of health->wq_lock should be IRQ safe.
It was changed to spin_lock_irqsave since adding commit 0179720d6be2
("net/mlx5: Introduce trigger_health_work function") which uses
spin_lock from asynchronous event (IRQ) context.
Thus, all spin_lock/unlock of health->wq_lock should have been moved
to IRQ safe mode.
However, one occurrence on new code using this lock missed that
change, resulting in possible deadlock:
  kernel: Possible unsafe locking scenario:
  kernel:       CPU0
  kernel:       ----
  kernel:  lock(&(&health->wq_lock)->rlock);
  kernel:  <Interrupt>
  kernel:    lock(&(&health->wq_lock)->rlock);
  kernel: #012 *** DEADLOCK ***

Fixes: 2a0165a034ac ("net/mlx5: Cancel delayed recovery work when unloading the driver")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 448e71e07668..264f51b3409d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -369,10 +369,11 @@ void mlx5_drain_health_wq(struct mlx5_core_dev *dev)
 void mlx5_drain_health_recovery(struct mlx5_core_dev *dev)
 {
 	struct mlx5_core_health *health = &dev->priv.health;
+	unsigned long flags;
 
-	spin_lock(&health->wq_lock);
+	spin_lock_irqsave(&health->wq_lock, flags);
 	set_bit(MLX5_DROP_NEW_RECOVERY_WORK, &health->flags);
-	spin_unlock(&health->wq_lock);
+	spin_unlock_irqrestore(&health->wq_lock, flags);
 	cancel_delayed_work_sync(&dev->priv.health.recover_work);
 }
 
-- 
2.17.1

