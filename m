Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA029ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAD120869
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jspm4Nr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAD120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeJYWs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbeJYWsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:24 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9C820868;
        Thu, 25 Oct 2018 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476928;
        bh=53xX52h4Yw/EFt8jdx9HH4IU29b7TeImviG7Gapl6kI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jspm4Nr5VlUi4QGAAQuVDu0wm4nkf0zfvcV1cHPOkAK1i4c0SGaWbynTZQoBBlZl+
         mUlvAaOWN1oI6/lzt7GfAzjODDM8M4ozMUxogBPKsJLSmb2yZ/eNOewtjeEtvGjPu4
         0Rx6g8OFQmsM/RU/jrjjj7ViaVHC4T7BUZV1ElgU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Talat Batheesh <talatb@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 43/98] net/mlx5e: Fix fixpoint divide exception in mlx5e_am_stats_compare
Date:   Thu, 25 Oct 2018 10:13:28 -0400
Message-Id: <20181025141423.213774-43-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Talat Batheesh <talatb@mellanox.com>

[ Upstream commit e58edaa4863583b54409444f11b4f80dff0af1cd ]

Helmut reported a bug about division by zero while
running traffic and doing physical cable pull test.

When the cable unplugged the ppms become zero, so when
dividing the current ppms by the previous ppms in the
next dim iteration there is division by zero.

This patch prevent this division for both ppms and epms.

Fixes: c3164d2fc48f ("net/mlx5e: Added BW check for DIM decision mechanism")
Reported-by: Helmut Grauer <helmut.grauer@de.ibm.com>
Signed-off-by: Talat Batheesh <talatb@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c
index 23ccec4cb7f5..a1f3556307c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c
@@ -197,9 +197,15 @@ static int mlx5e_am_stats_compare(struct mlx5e_rx_am_stats *curr,
 		return (curr->bpms > prev->bpms) ? MLX5E_AM_STATS_BETTER :
 						   MLX5E_AM_STATS_WORSE;
 
+	if (!prev->ppms)
+		return curr->ppms ? MLX5E_AM_STATS_BETTER :
+				    MLX5E_AM_STATS_SAME;
+
 	if (IS_SIGNIFICANT_DIFF(curr->ppms, prev->ppms))
 		return (curr->ppms > prev->ppms) ? MLX5E_AM_STATS_BETTER :
 						   MLX5E_AM_STATS_WORSE;
+	if (!prev->epms)
+		return MLX5E_AM_STATS_SAME;
 
 	if (IS_SIGNIFICANT_DIFF(curr->epms, prev->epms))
 		return (curr->epms < prev->epms) ? MLX5E_AM_STATS_BETTER :
-- 
2.17.1

