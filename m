Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950D4C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E0E21934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026411;
	bh=tHqfUanSKFBXC7jmBlPYykEeDrnbGfgEw8RaKA7Brlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tqccAaUz1xQk+n5hGFj/zJvric6j6ioJGOQEimzNMZ5w6ZfLQTxmSp8dY4GeVEg8C
	 MVkrLl3uJEqb8S964A+KGOQ9zsRjrVqsxSDO1wA+inGDZOMq7WknWAngGS9hl8jWDx
	 ovc5XhRUBVMUR4ZDOSN5z41xipmWQLH+aS3uXx/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbfBMCx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:53:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732851AbfBMCiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A48E222CA;
        Wed, 13 Feb 2019 02:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025498;
        bh=tHqfUanSKFBXC7jmBlPYykEeDrnbGfgEw8RaKA7Brlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEJe5KY+w9PdNT1VH74GgXBqsAl0pNFJuzufKYSZvLCAE9Nt5RjUc7j+CTj2LNWMV
         uDcUBh0WNHkh77hBjXzwHzHnkAhQMwhuafrUyiYZ5Z5ZRNApibdTAqFxAs6QIitY2Q
         unJQVfgk2V8ze5dEwHkujXK8+Mhzr1Hr5cibQyzc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 45/83] net: stmmac: Fix PCI module removal leak
Date:   Tue, 12 Feb 2019 21:36:23 -0500
Message-Id: <20190213023701.20286-45-sashal@kernel.org>
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
index c54a50dbd5ac..d819e8eaba12 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -299,7 +299,17 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
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

