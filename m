Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A58C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373A220844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693583;
	bh=XMCt/Am89DSH2OqT69hpegTGT7rZbwrgd6n7iSi0E8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YbVXeNO4GH5L5F7LPZTyblojE9z/foe0O/gx/vMK4Eag4jZjTt1M7fv0f7LxLbKEQ
	 ofWVUUCs8PIFvHwMyOR08g5tuBoClB16BpgKPCADcmhNAzgSUtURvyjkusSQL4FZsO
	 c65/B4H89Rlt5qYuGwatnKcDJTi+dVmKx66IMPZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390250AbfA1Qjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389728AbfA1QYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CC582147A;
        Mon, 28 Jan 2019 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692671;
        bh=XMCt/Am89DSH2OqT69hpegTGT7rZbwrgd6n7iSi0E8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4TFfbT0MPvalKIo6vCn4tvd4UMsXDtgt2AxmMjBj1YE6pSYzBlGNdVNfu1TWKmTI
         iIeBEisTP987ZN6mcX+mhqMbIyt9FbF0JN9pKgU0B2/fcjb6wIuElPZ1FG9ddot3Cd
         F2xK4PDnsh+hNc6nHNMTBaXqVI7+vnQUOZm0/lfc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 19/80] soc/tegra: Don't leak device tree node reference
Date:   Mon, 28 Jan 2019 11:23:00 -0500
Message-Id: <20190128162401.58841-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 9eb40fa2cd2d1f6829e7b49bb22692f754b9cfe0 ]

of_find_node_by_path() acquires a reference to the node returned by it
and that reference needs to be dropped by its caller. soc_is_tegra()
doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
[treding: slightly rewrite to avoid inline comparison]
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index cd8f41351add..7bfb154d6fa5 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -22,11 +22,15 @@ static const struct of_device_id tegra_machine_match[] = {
 
 bool soc_is_tegra(void)
 {
+	const struct of_device_id *match;
 	struct device_node *root;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return false;
 
-	return of_match_node(tegra_machine_match, root) != NULL;
+	match = of_match_node(tegra_machine_match, root);
+	of_node_put(root);
+
+	return match != NULL;
 }
-- 
2.19.1

