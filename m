Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6494C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B75222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899529;
	bh=2XyTmJuyRXWTrVdY5BH80z4KBiZ23Mv/qNU24VN8O+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rClykgJhG88SJyGF2LR3qCuAlTqM606UHQgNcCy1RtD/E0BR7huOM9Gv3gMzNh/rg
	 fzeyK5gCHl9WoBBBu7QB2ffbOdDkeEKDeuioUf/Iz69F2OChWVVFwiiptFzWh0oqin
	 VW0uox/RiSXY1aotcUndbMRGQkj4lvIihezWBQ+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbfBKOuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387961AbfBKOtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:49:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01D4120700;
        Mon, 11 Feb 2019 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896591;
        bh=2XyTmJuyRXWTrVdY5BH80z4KBiZ23Mv/qNU24VN8O+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezEJ+PChq+GYLBY0UqIkd1QhqK6ZNfq7M/AkRowTBfbzExd2D3FM3UuB6omi6rZa2
         fWCe1LPePDwxp+Wxt8OWzb4PCTJmLKRQUN0o32hBwA1/muze1d1czmLyuGal9R/CtX
         aEASxI8PVZ1501BIND1rZNqnHRk4fMnZdCBOkVcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sven Van Asbroeck <TheSven73@googlemail.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 236/313] PCI: imx: Enable MSI from downstream components
Date:   Mon, 11 Feb 2019 15:18:36 +0100
Message-Id: <20190211141909.200237439@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit 75cb8d20c112aba70f23d98e3f8d0a38ace16006 ]

The MSI Enable bit in the MSI Capability (PCIe r4.0, sec 7.7.1.2) controls
whether a Function can request service using MSI.

i.MX6 Root Ports implement the MSI Capability and may use MSI to request
service for events like PME, hotplug, AER, etc.  In addition, on i.MX6, the
MSI Enable bit controls delivery of MSI interrupts from components below
the Root Port.

Prior to f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of
CONFIG_PCIEPORTBUS"), enabling CONFIG_PCI_IMX6 automatically also enabled
CONFIG_PCIEPORTBUS, and when portdrv claimed the Root Ports, it set the MSI
Enable bit so it could use PME, hotplug, AER, etc.  As a side effect, that
also enabled delivery of MSI interrupts from downstream components.

The imx6q-pcie driver itself does not depend on portdrv, so set MSI Enable
in imx6q-pcie so MSI from downstream components works even if nobody uses
MSI for the Root Port events.

Fixes: f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of CONFIG_PCIEPORTBUS")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Sven Van Asbroeck <TheSven73@googlemail.com>
Tested-by: Trent Piepho <tpiepho@impinj.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 975050a69494..3826b444298c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -66,6 +66,7 @@ struct imx6_pcie {
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
 
 /* PCIe Root Complex registers (memory-mapped) */
+#define PCIE_RC_IMX6_MSI_CAP			0x50
 #define PCIE_RC_LCR				0x7c
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
@@ -682,6 +683,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
 	int ret;
+	u16 val;
 
 	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
 	if (!imx6_pcie)
@@ -816,6 +818,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	if (pci_msi_enabled()) {
+		val = dw_pcie_readw_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
+					PCI_MSI_FLAGS);
+		val |= PCI_MSI_FLAGS_ENABLE;
+		dw_pcie_writew_dbi(pci, PCIE_RC_IMX6_MSI_CAP + PCI_MSI_FLAGS,
+				   val);
+	}
+
 	return 0;
 }
 
-- 
2.19.1



