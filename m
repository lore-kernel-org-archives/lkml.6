Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D18C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4444621934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026210;
	bh=t+XiMneW0cid8WXW+9B0x76GTuxULL2etOXRntrVyqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZpxBF7unnkscPJfeUpAO4xshdKqjD/agPrrhm23783tJtBWkAIxqPvtQVz4fkY4eS
	 jiwPmlwFuzyVmIbPwMtY6q8WcRq6lXtTdKbE/mY/PsZR8AlJBvcrZNu9NufmD5l++c
	 dQM2WJZhEdU8mflaEhX/yOS86ovlHoHKDfZRGLe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389823AbfBMCuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:50:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388853AbfBMCj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6430A222C9;
        Wed, 13 Feb 2019 02:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025599;
        bh=t+XiMneW0cid8WXW+9B0x76GTuxULL2etOXRntrVyqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcpiTDAuK8X+ERyWbTMvV9z05G7fy1GQdj9kqSKxnr/F0FDbHKoz6rGgpMPxie9QP
         zgQyz7iKBW3YM97mjrA2AD7c86d2Qv0A1u+9QjGs1vFKjQqqRlPjyvLWkpJwGO375V
         OD1vXNjVsCqdfoc2QE3oau7WhZFHZ5S0Y5P1ba2w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 05/34] mfd: mt6397: Do not call irq_domain_remove if PMIC unsupported
Date:   Tue, 12 Feb 2019 21:39:23 -0500
Message-Id: <20190213023952.21311-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

[ Upstream commit a177276aa098aa47a100d51a13eaaef029604b6d ]

If the PMIC ID is unknown, the current code would call
irq_domain_remove and panic, as pmic->irq_domain is only
initialized by mt6397_irq_init.

Return immediately with an error, if the chip ID is unsupported.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/mt6397-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 04a601f6aebe..0afadea996bb 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -309,8 +309,7 @@ static int mt6397_probe(struct platform_device *pdev)
 
 	default:
 		dev_err(&pdev->dev, "unsupported chip: %d\n", id);
-		ret = -ENODEV;
-		break;
+		return -ENODEV;
 	}
 
 	if (ret) {
-- 
2.19.1

