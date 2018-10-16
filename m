Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D137BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907B821476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4qBghQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907B821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeJPMBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbeJPMBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F60421480;
        Tue, 16 Oct 2018 04:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663196;
        bh=pt6VbHSF1qlyR4HD7JJ3zDDNGz+72gdUMID4ct3MBas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4qBghQkboliOZp+ltkqDHqqdlPWlKShiEw5WKYf7paZDcQ7EbiDRaux5E2cMGSgI
         brJrgxQQ1nNwa3/9hkoyCN6XysL0p/7n66GCEamWXQV7nAKpwwXmI6YdM2GDdV+W0c
         DqZHeyFAMfgSKedD1OXV3R/xWIwu2enfQo7OaK2Q=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 060/100] net/mlx5: E-Switch, Fix out of bound access when setting vport rate
Date:   Tue, 16 Oct 2018 00:11:41 -0400
Message-Id: <20181016041221.135528-60-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit 11aa5800ed66ed0415b7509f02881c76417d212a ]

The code that deals with eswitch vport bw guarantee was going beyond the
eswitch vport array limit, fix that.  This was pointed out by the kernel
address sanitizer (KASAN).

The error from KASAN log:
[2018-09-15 15:04:45] BUG: KASAN: slab-out-of-bounds in
mlx5_eswitch_set_vport_rate+0x8c1/0xae0 [mlx5_core]

Fixes: c9497c98901c ("net/mlx5: Add support for setting VF min rate")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 40dba9e8af92..69f356f5f8f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2000,7 +2000,7 @@ static u32 calculate_vports_min_rate_divider(struct mlx5_eswitch *esw)
 	u32 max_guarantee = 0;
 	int i;
 
-	for (i = 0; i <= esw->total_vports; i++) {
+	for (i = 0; i < esw->total_vports; i++) {
 		evport = &esw->vports[i];
 		if (!evport->enabled || evport->info.min_rate < max_guarantee)
 			continue;
@@ -2020,7 +2020,7 @@ static int normalize_vports_min_rate(struct mlx5_eswitch *esw, u32 divider)
 	int err;
 	int i;
 
-	for (i = 0; i <= esw->total_vports; i++) {
+	for (i = 0; i < esw->total_vports; i++) {
 		evport = &esw->vports[i];
 		if (!evport->enabled)
 			continue;
-- 
2.17.1

