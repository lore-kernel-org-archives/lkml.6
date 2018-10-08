Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E906C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A682214FA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuBNetKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A682214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeJHWiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbeJHWiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51C86214FA;
        Mon,  8 Oct 2018 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012346;
        bh=m9CKM/MneY3CS+tofhB2Y+GQoaFs8AbArEsR0IMwYcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuBNetKNIH+/IYr1OkGl9sGjDgWhnIQeVP8UoaKtmMp28cAF9BKm/JORrsBIRC/wp
         aEDAjUO+wya2VNgKS/ojMVYyWO0qhQJV6H52F6YY6zSDRsTN8SOo/1hmgfFBQojdrR
         9rD595jeTjWp1c+/YCEAXbjJDKsdFRCHz2Q+Dohc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alaa Hleihel <alaa@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 21/58] net/mlx5: Check for SQ and not RQ state when modifying hairpin SQ
Date:   Mon,  8 Oct 2018 11:24:46 -0400
Message-Id: <20181008152523.70705-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alaa Hleihel <alaa@mellanox.com>

[ Upstream commit 6b359d5550a1ae7a1269c9dc1dd73dfdc4d6fe58 ]

When modifying hairpin SQ, instead of checking if the next state equals
to MLX5_SQC_STATE_RDY, we compare it against the MLX5_RQC_STATE_RDY enum
value.

The code worked since both of MLX5_RQC_STATE_RDY and MLX5_SQC_STATE_RDY
have the same value today.

This patch fixes this issue.

Fixes: 18e568c390c6 ("net/mlx5: Hairpin pair core object setup")
Change-Id: I6758aa7b4bd137966ae28206b70648c5bc223b46
Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/transobj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/transobj.c b/drivers/net/ethernet/mellanox/mlx5/core/transobj.c
index dae1c5c5d27c..d2f76070ea7c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/transobj.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/transobj.c
@@ -509,7 +509,7 @@ static int mlx5_hairpin_modify_sq(struct mlx5_core_dev *peer_mdev, u32 sqn,
 
 	sqc = MLX5_ADDR_OF(modify_sq_in, in, ctx);
 
-	if (next_state == MLX5_RQC_STATE_RDY) {
+	if (next_state == MLX5_SQC_STATE_RDY) {
 		MLX5_SET(sqc, sqc, hairpin_peer_rq, peer_rq);
 		MLX5_SET(sqc, sqc, hairpin_peer_vhca, peer_vhca);
 	}
-- 
2.17.1

