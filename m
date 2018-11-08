Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C64CC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EB420844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0MXLn4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EB420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeKIITp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbeKIHdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:36 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97AE62089F;
        Thu,  8 Nov 2018 21:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714169;
        bh=4ahfbmkkkQrF2f6xjKNzKiwGTykqHPGjPhD8kby+wDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0MXLn4zAqhDwn0u1mGFDNu6cAj7f2tv/+8itGT2HyQ0SsFqmL38VLII7fskX0hiM
         ZDtXYlVdKL73rTonB2meo96YEFSK1M6yxPXufYekruOKZqf9n06i5fEFAo5PV5ifb4
         w+05URIbc5LDS19M4PpnwYfe34KccDdPa08Oht2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugenia Emantayev <eugenia@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 091/144] net/mlx4_en: Remove dependency between timestamping capability and service_task
Date:   Thu,  8 Nov 2018 13:51:02 -0800
Message-Id: <20181108215102.042478643@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



