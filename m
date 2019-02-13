Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0BDC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0D621934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026361;
	bh=2fpj8rqhltr6vA8HfUDuTo7mlykthD0oMJawmK0VAjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0wx9KQFcLOk2cKo57fKEHdx5S9ltCDabAHBvqU2a0tR5u2Ph+gkRqa5+AjpUuiaZS
	 d/ypGDlDVllzzzPueKsQAlLXEr67NPHs8zZPg5HqKLU/LCb/UBFYGHzFpWt1lHoH8E
	 H6UMTZ0qpAH3kv7Mg95cnGqDdXyKE+rD7AY2H9rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbfBMCi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388509AbfBMCiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1185222C9;
        Wed, 13 Feb 2019 02:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025502;
        bh=2fpj8rqhltr6vA8HfUDuTo7mlykthD0oMJawmK0VAjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTYSrUvFJRS5xP4vkzAm1YdFjf9+irx6PIv4ADL2QwXbH/Uc59obFIQ4zAhYAa3w/
         Mry3FDLkj6Xd6UU7MOz8PNdGgSv/zKRlh+PGqShPT1jz61TOTIkNyKx0s+LTVjQD4V
         Mg/bSRPxY5r5smYbgIqJvTlWhkzKbPgJNT0I0WLI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 48/83] net: stmmac: Fix the logic of checking if RX Watchdog must be enabled
Date:   Tue, 12 Feb 2019 21:36:26 -0500
Message-Id: <20190213023701.20286-48-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <jose.abreu@synopsys.com>

[ Upstream commit 3b5094665e273c4a2a99f7f5f16977c0f1e19095 ]

RX Watchdog can be disabled by platform definitions but currently we are
initializing the descriptors before checking if Watchdog must be
disabled or not.

Fix this by checking earlier if user wants Watchdog disabled or not.

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2103b865726a..24ae244c2ee3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4191,6 +4191,18 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 			return ret;
 	}
 
+	/* Rx Watchdog is available in the COREs newer than the 3.40.
+	 * In some case, for example on bugged HW this feature
+	 * has to be disable and this can be done by passing the
+	 * riwt_off field from the platform.
+	 */
+	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
+	    (priv->plat->has_xgmac)) && (!priv->plat->riwt_off)) {
+		priv->use_riwt = 1;
+		dev_info(priv->device,
+			 "Enable RX Mitigation via HW Watchdog Timer\n");
+	}
+
 	return 0;
 }
 
@@ -4323,18 +4335,6 @@ int stmmac_dvr_probe(struct device *device,
 	if (flow_ctrl)
 		priv->flow_ctrl = FLOW_AUTO;	/* RX/TX pause on */
 
-	/* Rx Watchdog is available in the COREs newer than the 3.40.
-	 * In some case, for example on bugged HW this feature
-	 * has to be disable and this can be done by passing the
-	 * riwt_off field from the platform.
-	 */
-	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
-	    (priv->plat->has_xgmac)) && (!priv->plat->riwt_off)) {
-		priv->use_riwt = 1;
-		dev_info(priv->device,
-			 "Enable RX Mitigation via HW Watchdog Timer\n");
-	}
-
 	/* Setup channels NAPI */
 	maxq = max(priv->plat->rx_queues_to_use, priv->plat->tx_queues_to_use);
 
-- 
2.19.1

