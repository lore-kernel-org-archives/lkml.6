Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C1AC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFDE214FA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhzqRLB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFDE214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeJHWi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbeJHWi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78EA21479;
        Mon,  8 Oct 2018 15:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012371;
        bh=Wzg5sKqqs0bmMjMTJcZGyxc9xKzlGhbKxGMrpUGLHBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhzqRLB8Zf9bmHzY/CmY0poiY7CrBqdMIs1USIfKAGyI2hdyUR1+XjXZK75Lqs6Gl
         6DOf84Z7Tb24qQ4/EllgfVnAeN75QyI4heNezOGE6s6qC50IJlAk21ID7l8dAiRUk3
         G9kC5gnKS6/Ta03v+LAEyKf1AKKRhQbAM55cTezU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 47/58] net/mlx4: Use cpumask_available for eq->affinity_mask
Date:   Mon,  8 Oct 2018 11:25:12 -0400
Message-Id: <20181008152523.70705-47-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 8ac1ee6f4d62e781e3b3fd8b9c42b70371427669 ]

Clang warns that the address of a pointer will always evaluated as true
in a boolean context:

drivers/net/ethernet/mellanox/mlx4/eq.c:243:11: warning: address of
array 'eq->affinity_mask' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (!eq->affinity_mask || cpumask_empty(eq->affinity_mask))
            ~~~~~^~~~~~~~~~~~~
1 warning generated.

Use cpumask_available, introduced in commit f7e30f01a9e2 ("cpumask: Add
helper cpumask_available()"), which does the proper checking and avoids
this warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/86
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx4/eq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/mellanox/mlx4/eq.c
index 1f3372c1802e..2df92dbd38e1 100644
--- a/drivers/net/ethernet/mellanox/mlx4/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
@@ -240,7 +240,8 @@ static void mlx4_set_eq_affinity_hint(struct mlx4_priv *priv, int vec)
 	struct mlx4_dev *dev = &priv->dev;
 	struct mlx4_eq *eq = &priv->eq_table.eq[vec];
 
-	if (!eq->affinity_mask || cpumask_empty(eq->affinity_mask))
+	if (!cpumask_available(eq->affinity_mask) ||
+	    cpumask_empty(eq->affinity_mask))
 		return;
 
 	hint_err = irq_set_affinity_hint(eq->irq, eq->affinity_mask);
-- 
2.17.1

