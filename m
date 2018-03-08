Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755932AbeCHNd5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:33:57 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:60617 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755824AbeCHNdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:33:55 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] PCI: designware-ep: Make dw_pcie_ep_reset_bar() handle 64-bit BARs properly
Date: Thu,  8 Mar 2018 14:33:28 +0100
Message-Id: <20180308133331.19464-4-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180308133331.19464-1-niklas.cassel@axis.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a 64-bit BAR consists of a BAR pair, we need to write to both
BARs in the BAR pair to clear the BAR properly.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index 946bbdf53c4d..b20b2651caf9 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -22,11 +22,18 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 {
 	u32 reg;
+	u32 val;
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+	val = dw_pcie_readl_dbi(pci, reg);
 	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writel_dbi2(pci, reg, 0x0);
 	dw_pcie_writel_dbi(pci, reg, 0x0);
+	if (!(val & PCI_BASE_ADDRESS_SPACE_IO) &&
+	    (val & PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+		dw_pcie_writel_dbi2(pci, reg + 4, 0x0);
+		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
+	}
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
-- 
2.14.2
