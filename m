Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8919CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BD420675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957162;
	bh=0wAdm/E95RxO/zPIMzhmA/PQ9elJXJ4NPAQ5bRbnkdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vvjYcwC3Mj0Na8sFGYMN0sW15JdJa1WRJDxbMAnXVmz27ZgccGReebQdlIpNouXXh
	 uH3cjc1B/dFegpbZTBH8b1mB6M9FIuuxz1cglCig7dUtIqjaCEGLGhz1lsze51oIVk
	 pboGIPoxvg0sJSIR+cUGjSng9UtcYw90GhZYA7qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfBWV0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:26:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbfBWVHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD44620866;
        Sat, 23 Feb 2019 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956056;
        bh=0wAdm/E95RxO/zPIMzhmA/PQ9elJXJ4NPAQ5bRbnkdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glp6usp3bRAqHRGj+OniPyTmIFs4yEghAugLQnY7Nqq8MoMeSQGr0y8ZPA0eWpy4g
         Ep35JZ2EyJTu9TBt4gVrsS2vmXWxGMF6ggNtNjBsK0dfp8w8R9bkJyo5hxFfZbESyc
         KjtwakGeAGGn2J8tKL94Y6bR2bWc86KAxWDocJvg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 32/65] net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()
Date:   Sat, 23 Feb 2019 16:06:07 -0500
Message-Id: <20190223210640.200911-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit c69c29a1a0a8f68cd87e98ba4a5a79fb8ef2a58c ]

If phy_power_on() fails in rk_gmac_powerup(), clocks are left enabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7b923362ee550..3b174eae77c10 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1342,8 +1342,10 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 	}
 
 	ret = phy_power_on(bsp_priv, true);
-	if (ret)
+	if (ret) {
+		gmac_clk_enable(bsp_priv, false);
 		return ret;
+	}
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
-- 
2.19.1

