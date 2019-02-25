Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00BF21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129792;
	bh=la8n3UqZbmrZsiZAS6K266ickcglvxoxVP/Fhbtp/Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YU3Fp0yr4y2UrRCuWXrXrfWws0ShdK0k+iXOe1ztTT5nCl4FSniiv11P4WpKzt8oK
	 6r0QJYhbfBhJYXgjUycZz6CwG+MM/Owv0BpwQql0EdQTw1aJNELxxJR7K9JYw6YSh4
	 1qyP093ElM3jLNJ9FCaeh+6ybggfc+b1MIX2QAl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfBYVXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:23:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730142AbfBYVXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D38521855;
        Mon, 25 Feb 2019 21:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129786;
        bh=la8n3UqZbmrZsiZAS6K266ickcglvxoxVP/Fhbtp/Lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMLQbflA8PAVo/bCeYabjSHvQsWAAjc4sadQhSC9ZyPNsis6OEXX6hiDc3GJijUL2
         I3B7DAh+e0CW0JcDFKNYCYgoVDWIsiHPR2MxLBvzGlANFj5sNjtaUWyV2MqR+6qpf1
         07V/20O/Fr36JcsExwgdLRfHOcMXXQ5jeBtdKCgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/152] net: stmmac: Fix PCI module removal leak
Date:   Mon, 25 Feb 2019 22:10:52 +0100
Message-Id: <20190225195047.614389720@linuxfoundation.org>
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
index c54a50dbd5ac2..d819e8eaba122 100644
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



