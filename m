Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9957C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A602821758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A602821758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbeHNAfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:35:04 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731137AbeHNAfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:35:04 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LlHiI-1gQ2fM161u-00b6or; Mon, 13 Aug 2018 23:50:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: mark PM functions as __maybe_unused
Date:   Mon, 13 Aug 2018 23:50:41 +0200
Message-Id: <20180813215046.3663828-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:yHkYOL42QrgSrFmnm4HKk71DoAHMxD4yJJ0Qm/UdpxzCP7w7VsH
 oe/YXbXosXJpEQmYMaAZXP1pPdZC/emuQtI1ZCIrLbOkDWT6rRPQ/I1BPjZSU6KWXgsqR+6
 DG4XEGDdGFlQ3mZ6xTXNcnvtiuD6TgczaZZn0LHpUgwFOPhG/ShwGE6fZw6xHAPTX0FKDlF
 B1G+7A9T8dYluUwl17saw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sSWmrTSKnPo=:RabkFznQLGSLpzQLM66n7J
 83lyhkVgsA918Ns9BalldcXCqiKoQI3lseeO8ZgYkSlunQAgojRICmgAKsrnYnAxIchG5rwYR
 JE/6dRDkrZrtPTW5/g5BUwbvwj8TTHNfuawUjY88LCPTp8V0YddwRjgwLmaLt3BZkVvlJK7zd
 ekZvUSZkniwFfk3SAYCtjvMLxHTCLq1F7dsphY2pH5X9VL460fM69G16JvBsLq8v662B09lEJ
 xd0jNsqsrrRJT9gIAxF2IhoOi/+HA8uZ4jjpuSh14ISQ46lx4GMCf78edJKlTcH+N5ZuQAYVj
 p8xnQHm0vEG7fJi2zoUysOkMhXtGR9KxTbHa0664CIZ4iFObRFln2Cog7bByxwrc/iZM8+8d3
 ATZ3ttF+ta1cNZ+yqBoLk62fR1D/PS5RNlK4xbdL0RDl5Jfca0k64ye1/l/8REB/TkXbKq4xo
 91eHo0C2YuQgYOYsvvNcuWr1mnPPcn8nPpuImRGkgwnKAYLsJUZumL8XokupxlFuEWITnyVs+
 XZ/rAhQ9L6K9G8uR1xdIMyMkFkZxjzC1M0kpqd7sdQL4jPFisrVeWWGvpIkXLRmIDI+FypLtj
 /E4fcJsObIyVTUpM9Uo3FWA/Pt+dgzw9xNydsMFFKGUuuuyc2C/fburxem6PZnqLP82aolZ04
 a40f3ps6e9feLZm33WEvqbzIC1SlpZe1zYDq5/nBhUWQZCoLb3PZLa4DIKJcDi52ZF5g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added suspend/resume functions cause a build warning
when CONFIG_PM is disabled:

drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:324:12: error: 'stmmac_pci_resume' defined but not used [-Werror=unused-function]
drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:306:12: error: 'stmmac_pci_suspend' defined but not used [-Werror=unused-function]

Mark them as __maybe_unused so gcc can drop them silently.

Fixes: b7d0f08e9129 ("net: stmmac: Fix WoL for PCI-based setups")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 6a393b16a1fc..c54a50dbd5ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -303,7 +303,7 @@ static void stmmac_pci_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-static int stmmac_pci_suspend(struct device *dev)
+static int __maybe_unused stmmac_pci_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	int ret;
@@ -321,7 +321,7 @@ static int stmmac_pci_suspend(struct device *dev)
 	return 0;
 }
 
-static int stmmac_pci_resume(struct device *dev)
+static int __maybe_unused stmmac_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	int ret;
-- 
2.18.0

