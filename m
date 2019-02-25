Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286522146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129899;
	bh=mHfTEobW5LBtwK2AYZ6lytrLHDLvmHlhFVMElGA54m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yt06icAr50CPM0s5mEuZWMlTy5MSDDntC+GM3UVUAopOfKuiPI8x/PrJ8nLNfi6xJ
	 ri3YPtIympiMZmtg7cgUMZm9+PZU5O0USpejE3YUORvuk19ySAxLzgrk5bNSveKaH4
	 Zcm/iDBJSaNnvndkgOc7rrYSNXwo/VYhOxcUg80o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbfBYVY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730833AbfBYVYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:24:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63A221734;
        Mon, 25 Feb 2019 21:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129891;
        bh=mHfTEobW5LBtwK2AYZ6lytrLHDLvmHlhFVMElGA54m0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W25EtqsZ0CBvT8qzJugOFSVqr1Jvnn6xd0q5opnSMw/r6zH3NduUru46JBKAVrzQR
         4IPv6CakQNLdCS5bgICqdNARe8uOZt8kSj0hyyE94f6K3SHtlrZYwXK9xh1Bm+LvHr
         GE3o9JwvblrDmvpl6dZL+PI9SydvULQfrI4XoyHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/152] net: stmmac: Fix the logic of checking if RX Watchdog must be enabled
Date:   Mon, 25 Feb 2019 22:10:55 +0100
Message-Id: <20190225195047.764477480@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 2103b865726ac..24ae244c2ee33 100644
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



