Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94973C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AB82098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQujWC8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AB82098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeJPMDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbeJPMDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915512098A;
        Tue, 16 Oct 2018 04:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663283;
        bh=toj2FpVPlBU1/ZH86DBLc6v+vMj4WPIS9O/rtoweyPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQujWC8jPcNApUzr77lKlTil5yLK6+l0CTATABEhro6IzXu5olDWJm7FXnLeiCUdI
         nvosNPVDeQXqfT+E+awST/2zR4eALy5/rJZZRr28uWWAB54Q4zUawV1v/aUawZAZ1Q
         w0Q34DP7Tc8zcmBPp0y0PnDBnPkQgZBOD6KcLhMI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 44/61] net/mlx5: E-Switch, Fix out of bound access when setting vport rate
Date:   Tue, 16 Oct 2018 00:13:46 -0400
Message-Id: <20181016041403.135678-44-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
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
index de72b66df3e5..1af9894abd95 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1922,7 +1922,7 @@ static u32 calculate_vports_min_rate_divider(struct mlx5_eswitch *esw)
 	u32 max_guarantee = 0;
 	int i;
 
-	for (i = 0; i <= esw->total_vports; i++) {
+	for (i = 0; i < esw->total_vports; i++) {
 		evport = &esw->vports[i];
 		if (!evport->enabled || evport->info.min_rate < max_guarantee)
 			continue;
@@ -1942,7 +1942,7 @@ static int normalize_vports_min_rate(struct mlx5_eswitch *esw, u32 divider)
 	int err;
 	int i;
 
-	for (i = 0; i <= esw->total_vports; i++) {
+	for (i = 0; i < esw->total_vports; i++) {
 		evport = &esw->vports[i];
 		if (!evport->enabled)
 			continue;
-- 
2.17.1

