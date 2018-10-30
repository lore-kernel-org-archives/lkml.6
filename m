Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554D0C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5F22087A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8KRmq7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5F22087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeJ3WUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:20:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeJ3WUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:20:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA1021104;
        Tue, 30 Oct 2018 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906038;
        bh=mLVzQBNVE/aaU5O9NPKhF0uOOsoxWIQWlilfKE1XkoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8KRmq7nqu4NpeYQoYK/joXqxz1aB+3jC9rafyFF+PcURQMd1Auqa7l3SP/mPIrVH
         QIXhito7lt2n+oEOL0YmhKy+le7U9RUctGC1yiBna5S0eqNt2MszUlWYpKq/iC76DP
         hL0UN0LgMcVj3HefsbfXF/foRLxdaLAtjtCzVc8k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Huy Nguyen <huyn@mellanox.com>, Eli Cohen <eli@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 07/33] net/mlx5: Take only bit 24-26 of wqe.pftype_wq for page fault type
Date:   Tue, 30 Oct 2018 09:26:31 -0400
Message-Id: <20181030132657.217970-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huy Nguyen <huyn@mellanox.com>

[ Upstream commit a48bc513159d4767f9988f0d857b2b0c38a4d614 ]

The HW spec defines only bits 24-26 of pftype_wq as the page fault type,
use the required mask to ensure that.

Fixes: d9aaed838765 ("{net,IB}/mlx5: Refactor page fault handling")
Signed-off-by: Huy Nguyen <huyn@mellanox.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 406c23862f5f..01ccc8201052 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -269,7 +269,7 @@ static void eq_pf_process(struct mlx5_eq *eq)
 		case MLX5_PFAULT_SUBTYPE_WQE:
 			/* WQE based event */
 			pfault->type =
-				be32_to_cpu(pf_eqe->wqe.pftype_wq) >> 24;
+				(be32_to_cpu(pf_eqe->wqe.pftype_wq) >> 24) & 0x7;
 			pfault->token =
 				be32_to_cpu(pf_eqe->wqe.token);
 			pfault->wqe.wq_num =
-- 
2.17.1

