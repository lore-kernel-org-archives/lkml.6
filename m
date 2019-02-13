Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D8CC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6E42175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025991;
	bh=IRkt86I+jtWBYEj1GlCmZscR5wfkoyK8OEbPz/qor4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c+TlmW+HoyZw5bvDEKzqQkiUe/m8HHQhfwv0ZpCKPtY67TjAI9DBzm9Kgpb49aTRE
	 aF1+EccHrCtBTbwMRgIKnP+W/GxfDj7ilI/FE4Zzdm0zu+IDJYDptQjzCvGBKEIg4L
	 wd/Q8UC6MxDAdRYIBMMDOaeOuQI6HJvAQqBijR/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbfBMCq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:46:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389081AbfBMCkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C493C222C9;
        Wed, 13 Feb 2019 02:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025645;
        bh=IRkt86I+jtWBYEj1GlCmZscR5wfkoyK8OEbPz/qor4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyvtBe2PZfKgJe0IaL2DirtncgSsSiINRB8pr9fcCua1Wj+BlS0NgGuTNcVb8GWSk
         4oFun3D7iRfzXGZGxOiPpKgajs7RRaqwDqI3ETn5bPqvwux0Kvxi4z66uvTKqQ3Y6L
         9yttFxCVu0CzWdIh5faLWRMvFlZzVcxQyL9nMOY0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 04/21] mfd: mt6397: Do not call irq_domain_remove if PMIC unsupported
Date:   Tue, 12 Feb 2019 21:40:23 -0500
Message-Id: <20190213024040.21740-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213024040.21740-1-sashal@kernel.org>
References: <20190213024040.21740-1-sashal@kernel.org>
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
index e14d8b058f0c..5d4c10f05450 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -306,8 +306,7 @@ static int mt6397_probe(struct platform_device *pdev)
 
 	default:
 		dev_err(&pdev->dev, "unsupported chip: %d\n", id);
-		ret = -ENODEV;
-		break;
+		return -ENODEV;
 	}
 
 	if (ret) {
-- 
2.19.1

