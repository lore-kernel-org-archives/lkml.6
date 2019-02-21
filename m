Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E673C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF032080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759980;
	bh=VUich4jzqii1URLjDBRR43geCX8ciEhhc/CTjZvUqig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jw/IOKs4q3CiEHdQADgyU3IpVfBcEFlhQyQpKdwfkx/AABlA79r3vnnWAfGssBu7Z
	 TOztLkos6g+tzRwemOWlLG3LMMHBbm45c836axUSzx4vRIi8ICD95X8AWk8rfNSRvz
	 QXpiuPsA8BHpT4YySh7e8Wsfk5qf4Yuw1WccWdZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfBUOjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:39:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbfBUOjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:39:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5212080D;
        Thu, 21 Feb 2019 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759976;
        bh=VUich4jzqii1URLjDBRR43geCX8ciEhhc/CTjZvUqig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MpxxTe6VQgBMz4Q/6damMtafElkXalTcO5P6axQ/CgRVA1N7G8IBILfJLkvN/1CX5
         XfhqL8NWi7Cxsj2uRVMRsazSBed3yGNEZUPefG9I50XJjtSNf0aitOiMl8w/CCEtvn
         nbRp7GFy9X1V3/TN+r4k6m1+cr4jM3/7IcGtuySs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 4.14 11/23] net: stmmac: Fix a race in EEE enable callback
Date:   Thu, 21 Feb 2019 15:35:53 +0100
Message-Id: <20190221125247.156333658@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
References: <20190221125246.162644302@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jose Abreu <jose.abreu@synopsys.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c |   22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -675,25 +675,27 @@ static int stmmac_ethtool_op_set_eee(str
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


