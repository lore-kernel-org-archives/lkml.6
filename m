Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EE4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20B720868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570322;
	bh=/88wGj2gn0duzdGZ5wGZDivJ+dHcRlb25Gw7vA5hBCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mg4VJTKwxGkjryyPjt5fMAML0QsZ1tW+YLmK8Tx0N+iOv0A0uFhFs0h76pbeOxFFQ
	 MustDXxlznsXnQSiBXwOGWyPpfyQZUnSohlvu8btsbUAhFUFRunXzF1hHXzO9mQUPM
	 9/9cwfedUmEQnCAyv18dP3LPX6bZmfplExutaO7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfAOQil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732132AbfAOQig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 955F92087E;
        Tue, 15 Jan 2019 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570315;
        bh=/88wGj2gn0duzdGZ5wGZDivJ+dHcRlb25Gw7vA5hBCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v3foDDf21BuC0ziKuS6L6Wj30fKS3IcHdZnA5Bovd+Q3cg+GeuJa1FjDH0hflekZN
         ucmChbm+xVLH99mrAF0tALiQ6bThNstC6H5t2FmUrQ6Z8LfyPw5DROZvBdvz1mu3YX
         WZmKYyUKWMdtU32yE0MxOuk3Rt3+3jrnnz/ESPSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Claudius Heine <claudius.heine.ext@siemens.com>
Subject: [PATCH 4.4 46/51] PCI: altera: Move retrain from fixup to altera_pcie_host_init()
Date:   Tue, 15 Jan 2019 17:35:42 +0100
Message-Id: <20190115154853.746418462@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ley Foon Tan <lftan@altera.com>

commit ce4f1c7ad490aa7129bde5632d6e53943f8a866c upstream.

Previously we used a PCI early fixup to initiate a link retrain on Altera
devices.  But Altera PCIe IP can be configured as either a Root Port or an
Endpoint, and they might have same vendor ID, so the fixup would be run for
both.

We only want to initiate a link retrain for Altera Root Port devices, not
for Endpoints, so move the link retrain functionality from the fixup to
altera_pcie_host_init().

[bhelgaas: changelog]
Signed-off-by: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Claudius Heine <claudius.heine.ext@siemens.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pcie-altera.c |  151 ++++++++++++++++++++++++-----------------
 1 file changed, 91 insertions(+), 60 deletions(-)

--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -43,6 +43,7 @@
 #define RP_LTSSM_MASK			0x1f
 #define LTSSM_L0			0xf
 
+#define PCIE_CAP_OFFSET			0x80
 /* TLP configuration type 0 and 1 */
 #define TLP_FMTTYPE_CFGRD0		0x04	/* Configuration Read Type 0 */
 #define TLP_FMTTYPE_CFGWR0		0x44	/* Configuration Write Type 0 */
@@ -100,66 +101,6 @@ static bool altera_pcie_link_is_up(struc
 	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
 }
 
-static void altera_wait_link_retrain(struct pci_dev *dev)
-{
-	u16 reg16;
-	unsigned long start_jiffies;
-	struct altera_pcie *pcie = dev->bus->sysdata;
-
-	/* Wait for link training end. */
-	start_jiffies = jiffies;
-	for (;;) {
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
-			break;
-
-		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT)) {
-			dev_err(&pcie->pdev->dev, "link retrain timeout\n");
-			break;
-		}
-		udelay(100);
-	}
-
-	/* Wait for link is up */
-	start_jiffies = jiffies;
-	for (;;) {
-		if (altera_pcie_link_is_up(pcie))
-			break;
-
-		if (time_after(jiffies, start_jiffies + LINK_UP_TIMEOUT)) {
-			dev_err(&pcie->pdev->dev, "link up timeout\n");
-			break;
-		}
-		udelay(100);
-	}
-}
-
-static void altera_pcie_retrain(struct pci_dev *dev)
-{
-	u16 linkcap, linkstat;
-	struct altera_pcie *pcie = dev->bus->sysdata;
-
-	if (!altera_pcie_link_is_up(pcie))
-		return;
-
-	/*
-	 * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but
-	 * current speed is 2.5 GB/s.
-	 */
-	pcie_capability_read_word(dev, PCI_EXP_LNKCAP, &linkcap);
-
-	if ((linkcap & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
-		return;
-
-	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
-	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
-		pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
-					 PCI_EXP_LNKCTL_RL);
-		altera_wait_link_retrain(dev);
-	}
-}
-DECLARE_PCI_FIXUP_EARLY(0x1172, PCI_ANY_ID, altera_pcie_retrain);
-
 /*
  * Altera PCIe port uses BAR0 of RC's configuration space as the translation
  * from PCI bus to native BUS.  Entire DDR region is mapped into PCIe space
@@ -434,6 +375,90 @@ static struct pci_ops altera_pcie_ops =
 	.write = altera_pcie_cfg_write,
 };
 
+static int altera_read_cap_word(struct altera_pcie *pcie, u8 busno,
+				unsigned int devfn, int offset, u16 *value)
+{
+	u32 data;
+	int ret;
+
+	ret = _altera_pcie_cfg_read(pcie, busno, devfn,
+				    PCIE_CAP_OFFSET + offset, sizeof(*value),
+				    &data);
+	*value = data;
+	return ret;
+}
+
+static int altera_write_cap_word(struct altera_pcie *pcie, u8 busno,
+				 unsigned int devfn, int offset, u16 value)
+{
+	return _altera_pcie_cfg_write(pcie, busno, devfn,
+				      PCIE_CAP_OFFSET + offset, sizeof(value),
+				      value);
+}
+
+static void altera_wait_link_retrain(struct altera_pcie *pcie)
+{
+	u16 reg16;
+	unsigned long start_jiffies;
+
+	/* Wait for link training end. */
+	start_jiffies = jiffies;
+	for (;;) {
+		altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN,
+				     PCI_EXP_LNKSTA, &reg16);
+		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+			break;
+
+		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT)) {
+			dev_err(&pcie->pdev->dev, "link retrain timeout\n");
+			break;
+		}
+		udelay(100);
+	}
+
+	/* Wait for link is up */
+	start_jiffies = jiffies;
+	for (;;) {
+		if (altera_pcie_link_is_up(pcie))
+			break;
+
+		if (time_after(jiffies, start_jiffies + LINK_UP_TIMEOUT)) {
+			dev_err(&pcie->pdev->dev, "link up timeout\n");
+			break;
+		}
+		udelay(100);
+	}
+}
+
+static void altera_pcie_retrain(struct altera_pcie *pcie)
+{
+	u16 linkcap, linkstat, linkctl;
+
+	if (!altera_pcie_link_is_up(pcie))
+		return;
+
+	/*
+	 * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but
+	 * current speed is 2.5 GB/s.
+	 */
+	altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN, PCI_EXP_LNKCAP,
+			     &linkcap);
+	if ((linkcap & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
+		return;
+
+	altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN, PCI_EXP_LNKSTA,
+			     &linkstat);
+	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
+		altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN,
+				     PCI_EXP_LNKCTL, &linkctl);
+		linkctl |= PCI_EXP_LNKCTL_RL;
+		altera_write_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN,
+				      PCI_EXP_LNKCTL, linkctl);
+
+		altera_wait_link_retrain(pcie);
+	}
+}
+
 static int altera_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 				irq_hw_number_t hwirq)
 {
@@ -568,6 +593,11 @@ static int altera_pcie_parse_dt(struct a
 	return 0;
 }
 
+static void altera_pcie_host_init(struct altera_pcie *pcie)
+{
+	altera_pcie_retrain(pcie);
+}
+
 static int altera_pcie_probe(struct platform_device *pdev)
 {
 	struct altera_pcie *pcie;
@@ -605,6 +635,7 @@ static int altera_pcie_probe(struct plat
 	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
 	/* enable all interrupts */
 	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
+	altera_pcie_host_init(pcie);
 
 	bus = pci_scan_root_bus(&pdev->dev, pcie->root_bus_nr, &altera_pcie_ops,
 				pcie, &pcie->resources);


