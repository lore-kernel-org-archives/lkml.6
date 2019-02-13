Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01960C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B6A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025893;
	bh=BOXTLD+g4sdF2+QerHLBGqRFVwT7e7uNzoBe8kAVqgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sELIfHzbQLfNoJiL1gyLZwFGTapxD+I0L5GG5Um6pW4UiLTz4+3L24FZPM6njMm2P
	 HxH+YzFn34IbEENpPnpGjPXMJlY+XLqbHTN+8s8cePEjPBoR2L12D/tywerlA6rAqM
	 EFZXwJPYm3HS2jMbC/JwyIYgaS0oTrcogLYn26Xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389205AbfBMClO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:41:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387405AbfBMClD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:41:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E008222C7;
        Wed, 13 Feb 2019 02:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025662;
        bh=BOXTLD+g4sdF2+QerHLBGqRFVwT7e7uNzoBe8kAVqgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1k1qKTGXcPs+oGBUg2S22Ir+LaBsHBYi6mul1qFhNkP5GDrlDn6oLQPshYkihI62s
         VP9y0y9QJKxg70hf1+U+2CNzUusHNGox4BB4fNZo4/+F8IzXvHc571g5kd6BfYOrOR
         4sCoor9Vs8ABRv0KMjKjvcjdEXiVZ01hvEa5CAjU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 15/21] net: stmmac: Fix PCI module removal leak
Date:   Tue, 12 Feb 2019 21:40:34 -0500
Message-Id: <20190213024040.21740-15-sashal@kernel.org>
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

From: Jose Abreu <jose.abreu@synopsys.com>

[ Upstream commit 6dea7e1881fd86b80da64e476ac398008daed857 ]

Since commit b7d0f08e9129, the enable / disable of PCI device is not
managed which will result in IO regions not being automatically unmapped.
As regions continue mapped it is currently not possible to remove and
then probe again the PCI module of stmmac.

Fix this by manually unmapping regions on remove callback.

Changes from v1:
- Fix build error

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Fixes: b7d0f08e9129 ("net: stmmac: Fix WoL for PCI-based setups")
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index eafc28142cd2..49eaede34eea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -231,7 +231,17 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
  */
 static void stmmac_pci_remove(struct pci_dev *pdev)
 {
+	int i;
+
 	stmmac_dvr_remove(&pdev->dev);
+
+	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
+		if (pci_resource_len(pdev, i) == 0)
+			continue;
+		pcim_iounmap_regions(pdev, BIT(i));
+		break;
+	}
+
 	pci_disable_device(pdev);
 }
 
-- 
2.19.1

