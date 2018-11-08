Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93368C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5428320818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ4OhMsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5428320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbeKIH6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbeKIHn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:26 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2E220892;
        Thu,  8 Nov 2018 22:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714756;
        bh=DVoUi4tWamRKu1Czsfrvv9+rJkWxgCXhZEymfhVMqG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJ4OhMsJBmuczmnjuQa6O/pSnfcHt8tWNJ4dVn2714G87nNTNgZprvHKtpPR5Kvkf
         B9mi54UazFxkvLupYo+/iqLGJ8i07Ykdzhl86iiDvhzuN7ulqFV5Vbrn1NzhZf9Eg0
         BWwxIWFVzoowC/cQ7Hq4Xsmb/gJa+CPENrbU1C0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 078/171] net/mlx5: Fix health work queue spin lock to IRQ safe
Date:   Thu,  8 Nov 2018 13:50:48 -0800
Message-Id: <20181108215133.199210073@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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



