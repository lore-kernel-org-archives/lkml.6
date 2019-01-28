Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2936C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95AD2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692447;
	bh=XMCt/Am89DSH2OqT69hpegTGT7rZbwrgd6n7iSi0E8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t4lkGsZY64jWfWTCbhhmA7Gol+TypZeRTwnHsGqTMQhTcxz+1XHNf7Z5DdOE/W7wg
	 dctAuHqIIthUZUftsSIO4eNrAZJKoyV4q8f+Cpj87zamSU/qvlIZUYoaNmcN5hotUp
	 gYQBCkVHzTh7iaPG9aORdFRo/cKwM1oN3XC/QKNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbfA1QUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:20:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387966AbfA1QUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:20:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E24942184D;
        Mon, 28 Jan 2019 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692443;
        bh=XMCt/Am89DSH2OqT69hpegTGT7rZbwrgd6n7iSi0E8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=loaYOB6QAVR3RHsmr5hww9m0A26O2qedDh1UBOMZMIavK61GS9l9QB0ET5Ie3pG4J
         QU+rlCbwOpEg+pOeRSZ6g5FZZy1/ujyibLYDF4cBATpCGU13WwfpZ4/0cH5lN3wsxd
         NQgmM8D10t8a9ZAE2F2YSoGAy6WC5GlZeaAiQseY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 021/107] soc/tegra: Don't leak device tree node reference
Date:   Mon, 28 Jan 2019 11:18:21 -0500
Message-Id: <20190128161947.57405-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
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

