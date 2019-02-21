Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FDFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864CB20700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760477;
	bh=2Bhg3PGlLaGtv0jg6ntpbtKhn4Xap50YjG+BNdMgrR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hoTqv+fgSipwFdBvWcIRsRTuSNIdXDIyBO1aBvCSzBgLiOpzwDo4J0hutt4Vzh0GS
	 bImO5yERegDvyRXfDh4+/o5vt8vQBLX/L23YFQtvGXoepQFPyFxlnUYaFhhYP7VRM5
	 OSXLFMJerAae2ggDnFnXQ4NFm62yNe/UVLG1FpF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfBUOkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:40:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbfBUOks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:40:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54E922086A;
        Thu, 21 Feb 2019 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760047;
        bh=2Bhg3PGlLaGtv0jg6ntpbtKhn4Xap50YjG+BNdMgrR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0XIP3tQ9CV8Zi5ZkBwp6N0RrnJRvUQ623zFsO3tqr/pIdbvYmPoEO4+QEZ4z4GtL
         GNqiHzGAzyOCgMgnZPHdk7D6h29k5egyPKck3NRNzlBHZbXFohxBYs74Yb+vwi6e8m
         uwesBh1fXcr/xxp8tNOnIzSZLKg+38tHfVrophUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 10/30] net: stmmac: Fix a race in EEE enable callback
Date:   Thu, 21 Feb 2019 15:35:52 +0100
Message-Id: <20190221125251.092809367@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
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

[ Upstream commit 8a7493e58ad688eb23b81e45461c5d314f4402f1 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 5710864fa8090..9caf79ba5ef16 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -692,25 +692,27 @@ static int stmmac_ethtool_op_set_eee(struct net_device *dev,
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
2.19.1



