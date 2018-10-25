Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD0CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10262084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1Ipl0SS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10262084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeJYWov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbeJYWou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:50 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C93C20848;
        Thu, 25 Oct 2018 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476715;
        bh=B2QTmEZixvlvUtgeh6v/k8Y0XDg4ZjFGjpTt9H+xO/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1Ipl0SSzLCwfLNYIdRwnbnX8BTC8mP8T9yc49JEGw6o5Nrzv/UvUEkAWxqCbAsjL
         ksYuacRsUy98VCNdHN6gKq+E770Wk3+JdQSSJUi9cLib3BvIFAqo+HzlcXYI79CIaE
         Pf1B9SEcMXfPrZejZALUZdyBjcGvsH1FKD8vlHJ0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 43/46] net: stmmac: mark PM functions as __maybe_unused
Date:   Thu, 25 Oct 2018 10:10:50 -0400
Message-Id: <20181025141053.213330-43-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 81a8b0799632627b587af31ecd06112397e4ec36 ]

The newly added suspend/resume functions cause a build warning
when CONFIG_PM is disabled:

drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:324:12: error: 'stmmac_pci_resume' defined but not used [-Werror=unused-function]
drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:306:12: error: 'stmmac_pci_suspend' defined but not used [-Werror=unused-function]

Mark them as __maybe_unused so gcc can drop them silently.

Fixes: b7d0f08e9129 ("net: stmmac: Fix WoL for PCI-based setups")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.17.1

