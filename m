Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8FBC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02082085A
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfAZTtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 14:49:16 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37816 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfAZTtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 14:49:16 -0500
Received: from localhost.localdomain (109-252-62-199.nat.spd-mgts.ru [109.252.62.199])
        by mail.ispras.ru (Postfix) with ESMTPSA id 50449540082;
        Sat, 26 Jan 2019 22:49:12 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     David Wu <david.wu@rock-chips.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()
Date:   Sat, 26 Jan 2019 22:48:57 +0300
Message-Id: <1548532137-15618-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If phy_power_on() fails in rk_gmac_powerup(), clocks are left enabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7b923362ee55..3b174eae77c1 100644
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
2.7.4

