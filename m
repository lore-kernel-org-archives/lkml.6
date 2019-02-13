Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96847C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440AA20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026680;
	bh=BdjkY/ri1eljht+oYQVm8OcMR+aArc2nBRsk2IlBV2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pfvpx1CrAYh9YeotbBtGhMRaQTMOHo23V1DxShNWzTL15MBgaXVgy2FoVttQSa1hg
	 HTBwxicBkwinyE4lJnPadtLBxEfgEbT39Tti8wzsyW1X7yDjnqYRJR3xcXwfEtgdLA
	 /1gUMshJliyrg42AKDLgDl9tqqVdHQvizw3bUICw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbfBMC56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731909AbfBMCg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28236222C7;
        Wed, 13 Feb 2019 02:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025417;
        bh=BdjkY/ri1eljht+oYQVm8OcMR+aArc2nBRsk2IlBV2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wp8aFVMwds6jjZwMo00vk9bt++eNPnHCk8eyrOUlf03NhhM6MAvvwoNYABM98u8j
         lISgM1ILJWrjSMS4hFidUKuGXrJMWE57yru52BAbHK4musmpZX9iHL9RYf/e1TLvAi
         zBDJNUTmwR2wZQydouNoQmf8/Hv0fsDMwtJsduKk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 104/105] net/mlx5e: Fix wrong (zero) TX drop counter indication for representor
Date:   Tue, 12 Feb 2019 21:33:35 -0500
Message-Id: <20190213023336.19019-104-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit 7fdc1adc52d3975740547a78c2df329bb207f15d ]

For representors, the TX dropped counter is not folded from the
per-ring counters. Fix it.

Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 820fe85100b0..4dccc84fdcf2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -143,6 +143,7 @@ static void mlx5e_rep_update_sw_counters(struct mlx5e_priv *priv)
 
 			s->tx_packets		+= sq_stats->packets;
 			s->tx_bytes		+= sq_stats->bytes;
+			s->tx_queue_dropped	+= sq_stats->dropped;
 		}
 	}
 }
-- 
2.19.1

