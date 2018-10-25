Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC80ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD9C20868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohFaBw+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD9C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbeJYWvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbeJYWve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:34 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A23720848;
        Thu, 25 Oct 2018 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477117;
        bh=UaJaWmFhW9ebDo5ZRaS2P4foATnaIxY7sUgIovVjTfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohFaBw+4BDVtdpLexiPENPjS3cPjnPQ0PdFWZ0OccrHkC1SAlvJc4LtbtelMlTWgM
         oP7soD8+KE7XTvURjvG/y7yeuNHCfoClIKLPVOKCbUBW2Cg7bIz4N/m/DPlt6wV6j9
         zVK3ykBSFbhTZ3oxTUYs0wjtf8lONWMK5A1TjG0A=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 59/65] ASoC: spear: fix error return code in spdif_in_probe()
Date:   Thu, 25 Oct 2018 10:16:59 -0400
Message-Id: <20181025141705.213937-59-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

[ Upstream commit 27d30400c448264c1ac9434cb836de0c230af213 ]

platform_get_irq() returns an error code, but the spdif_in driver
ignores it and always returns -EINVAL. This is not correct, and
prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print error message and propagate the return value of platform_get_irq
on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/spear/spdif_in.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 977a078eb92f..7f32527fc3c8 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -223,8 +223,10 @@ static int spdif_in_probe(struct platform_device *pdev)
 
 	host->io_base = io_base;
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0)
-		return -EINVAL;
+	if (host->irq < 0) {
+		dev_warn(&pdev->dev, "failed to get IRQ: %d\n", host->irq);
+		return host->irq;
+	}
 
 	host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk))
-- 
2.17.1

