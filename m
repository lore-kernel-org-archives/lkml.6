Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F338BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9609821872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SxdKqNu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfBRNfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:35:40 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:48252 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfBRNfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:35:39 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6D60D10C1693;
        Mon, 18 Feb 2019 05:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550496939; bh=umQdu2aKo5CP8wJUTQ3xvEBMGvVTx8vmvPme3Z21eK8=;
        h=From:To:Cc:Subject:Date:From;
        b=SxdKqNu2zsCnMK6bRwksGFmVtn7mL4W+LhJORrlmMnvZMUU3XQ1DyATr4clm2KOHy
         hX304CxkHC6v3ZcU8ZEoYzNAvxU+mCv6W8tbjznHhZkeyuwj3aq5TWpQ1kmHmjliTj
         yzwag8dA59mICyFP6d8aU6aoyOCPMruU8m6JNgssYybET5OcNtRDlsVOuIRrM3mequ
         flaGk7G4Z9eZrHgHHKuHn+4jWMCLYZnJCZo4DB6tAFG0xgaKbyirCSOEamufyXHSE9
         TGMdaOxI/4xiacA4f/u7WpGlFWmAevf8zq5zZW4P8U1VngTKN59KSIsEaQB2RIbxvQ
         PpeI5BdXahpJQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 5E5A653A7;
        Mon, 18 Feb 2019 05:35:06 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net] net: stmmac: Fix a race in EEE enable callback
Date:   Mon, 18 Feb 2019 14:35:03 +0100
Message-Id: <fb866bb5dd8a11326fab8e6d393f2a37eed5073f.1550496861.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are saving the status of EEE even before we try to enable it. This
leads to a race with XMIT function that tries to arm EEE timer before we
set it up.

Fix this by only saving the EEE parameters after all operations are
performed with success.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Fixes: d765955d2ae0 ("stmmac: add the Energy Efficient Ethernet support")
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 5d85742a2be0..3c749c327cbd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -696,25 +696,27 @@ static int stmmac_ethtool_op_set_eee(struct net_device *dev,
 				     struct ethtool_eee *edata)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	int ret;
 
-	priv->eee_enabled = edata->eee_enabled;
-
-	if (!priv->eee_enabled)
+	if (!edata->eee_enabled) {
 		stmmac_disable_eee_mode(priv);
-	else {
+	} else {
 		/* We are asking for enabling the EEE but it is safe
 		 * to verify all by invoking the eee_init function.
 		 * In case of failure it will return an error.
 		 */
-		priv->eee_enabled = stmmac_eee_init(priv);
-		if (!priv->eee_enabled)
+		edata->eee_enabled = stmmac_eee_init(priv);
+		if (!edata->eee_enabled)
 			return -EOPNOTSUPP;
-
-		/* Do not change tx_lpi_timer in case of failure */
-		priv->tx_lpi_timer = edata->tx_lpi_timer;
 	}
 
-	return phy_ethtool_set_eee(dev->phydev, edata);
+	ret = phy_ethtool_set_eee(dev->phydev, edata);
+	if (ret)
+		return ret;
+
+	priv->eee_enabled = edata->eee_enabled;
+	priv->tx_lpi_timer = edata->tx_lpi_timer;
+	return 0;
 }
 
 static u32 stmmac_usec2riwt(u32 usec, struct stmmac_priv *priv)
-- 
2.7.4

