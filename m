Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04DDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B7520651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956600;
	bh=2GSmhNgHDxJDqUPISafChk91TEVOjQXYiQGcAdc5Pyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FBxF1KxW5YnliDkcywuPXxQfDkbZHdFjCtluijL6SK0WZLUFWRt8uWBNc7fTN6zV+
	 HmRX/6qf5c22KmdUGfXxLujqK0Fgvc6yFvQTojL//+gOYYGKPVBxLs3USx04BOxszB
	 +1TkuybfM7kcg2CuGBhuAgrK1g3oPdVVJpKDGK80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfBWVQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:16:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729741AbfBWVKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:10:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85E820861;
        Sat, 23 Feb 2019 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956221;
        bh=2GSmhNgHDxJDqUPISafChk91TEVOjQXYiQGcAdc5Pyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAo7aOuadmdN7+GU1K/rXMjOR447mZwz/xvbi/6blareDOVZD/dqH1VI7ITRcyQbK
         uYSTM8J/XqmKn1d4jRg3pycBRMlMdP4bgPSZR06Bi6C2XLmp5fJmJWSzLfjkNkTEMx
         6lG1NI+KqH2dyTHSEsasgfKq1VDJguKyxTUOq/zM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 18/32] net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()
Date:   Sat, 23 Feb 2019 16:09:37 -0500
Message-Id: <20190223210951.202268-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210951.202268-1-sashal@kernel.org>
References: <20190223210951.202268-1-sashal@kernel.org>
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
index d80c88bd2bba8..6e61bccc90b3c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -877,8 +877,10 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 	}
 
 	ret = phy_power_on(bsp_priv, true);
-	if (ret)
+	if (ret) {
+		gmac_clk_enable(bsp_priv, false);
 		return ret;
+	}
 
 	ret = gmac_clk_enable(bsp_priv, true);
 	if (ret)
-- 
2.19.1

