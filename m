Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9BEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0772B20868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiUut1c9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0772B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeJYWvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbeJYWvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:35 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF63520854;
        Thu, 25 Oct 2018 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477118;
        bh=OYuIBogndsQAhCLpqe6DQX/KBX0NHJu20acwwJKlLZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZiUut1c9CZOooGL9uqRr/BM+0KMIVuCknSkMMGvyduQQcxsiW67gRSH6ku0ZGJ5SD
         at1xlgvkjngPftBPHAVjLA+F51hXSY6zNqPTJzTbjgA+AJOKzXMTlEDBUuoeroFAPg
         qG8YwkKldZmhgnU5wOa4Q1+rC3iSXfDr7c18+zT8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 60/65] PM / devfreq: tegra: fix error return code in tegra_devfreq_probe()
Date:   Thu, 25 Oct 2018 10:17:00 -0400
Message-Id: <20181025141705.213937-60-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

[ Upstream commit 9e578b37505018622dfafc40eed7cd78ff2af221 ]

platform_get_irq() returns an error code, but the tegra-devfreq
driver ignores it and always returns -ENODEV. This is not correct,
and prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/tegra-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 848b93ee930f..64a2e02b87d7 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -688,9 +688,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ\n");
-		return -ENODEV;
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+		return irq;
 	}
 
 	platform_set_drvdata(pdev, tegra);
-- 
2.17.1

