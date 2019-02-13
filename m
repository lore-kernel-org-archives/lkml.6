Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DA8C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2362080A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025859;
	bh=FiJ9h5LQVN4gBWsdWvfnuS7QNw+1Pp55w3h0gdd+5s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S9kczInYpscDHK6h5C0qtkH0sx5HaxzxY1zZT+Mg/dtWEVgKfFo+UFdP6FfayDQwP
	 RuZO+J1TzpsGnIOk3fP1VZc+obI+9f3ehy0vksaRM/vrn1v458qosKN8hLew2/DtpA
	 BOirSpPrUtajcMrcWhsrqfg8bONxFatuOzjfbj0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbfBMClT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389163AbfBMClK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:41:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBEA32175B;
        Wed, 13 Feb 2019 02:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025669;
        bh=FiJ9h5LQVN4gBWsdWvfnuS7QNw+1Pp55w3h0gdd+5s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byJe3JBDNePwPwj5sqG+0Qln++zE/hCvjRh6BwTRMBHZlJdLgP+Jf9hAPwT+1Luzd
         938A6rxEh6rgUGDS8LtbRP+3vlOvlWRGDrFc7iDGKeqxdwyzlsjaMrKBHL8gLnMeVm
         HHjcyhIUiaw0H7exInurtihy6tsuBWWsDSxlFRBQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 20/21] net/mlx5e: Fix wrong (zero) TX drop counter indication for representor
Date:   Tue, 12 Feb 2019 21:40:39 -0500
Message-Id: <20190213024040.21740-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213024040.21740-1-sashal@kernel.org>
References: <20190213024040.21740-1-sashal@kernel.org>
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
index bf1c09ca73c0..b210c171a380 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -91,6 +91,7 @@ static void mlx5e_update_sw_rep_counters(struct mlx5e_priv *priv)
 
 			s->tx_packets		+= sq_stats->packets;
 			s->tx_bytes		+= sq_stats->bytes;
+			s->tx_queue_dropped	+= sq_stats->dropped;
 		}
 	}
 }
-- 
2.19.1

