Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FC4ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6E4208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lve6w1gJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6E4208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbeJYWx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbeJYWx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:26 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68AE62086D;
        Thu, 25 Oct 2018 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477228;
        bh=QLk4qvPUhRG2AAItDTXPgzGYXlAWhY3f4PwJPWFnXHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lve6w1gJPYSQFYFC9xuUNjyXjB1sPiu0zhp6X6AoGkdBndTVUWZzF5Bm1kganJJbf
         Y6/ctvwiFeVlrZUuz9P+2dpeEuJuJk1ySCQQyeKpd/L4TanJqWepA4IN0waV1YZrne
         XleEs5tZvTf54R/x4Y/0jThU34zgU3e6EqVuH28s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eugenia Emantayev <eugenia@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 62/98] net/mlx4_en: Remove dependency between timestamping capability and service_task
Date:   Thu, 25 Oct 2018 10:18:17 -0400
Message-Id: <20181025141853.214051-62-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugenia Emantayev <eugenia@mellanox.com>

[ Upstream commit fc9f5ea9b4ecbe9b7839c92f0a54261809c723d3 ]

Service task is responsible for other tasks in addition to timestamping
overflow check. Launch it even if timestamping is not supported by device.

Fixes: 07841f9d94c1 ('net/mlx4_en: Schedule napi when RX buffers allocation fails')
Signed-off-by: Eugenia Emantayev <eugenia@mellanox.com>
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index f31814293d3c..980dd359e3f7 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -2638,9 +2638,8 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 	}
 	queue_delayed_work(mdev->workqueue, &priv->stats_task, STATS_DELAY);
 
-	if (mdev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_TS)
-		queue_delayed_work(mdev->workqueue, &priv->service_task,
-				   SERVICE_TASK_DELAY);
+	queue_delayed_work(mdev->workqueue, &priv->service_task,
+			   SERVICE_TASK_DELAY);
 
 	err = register_netdev(dev);
 	if (err) {
-- 
2.17.1

