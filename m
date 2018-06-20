Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758DCC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257C2205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NnUX2nNx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NnUX2nNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257C2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeFTCOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:14:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44818 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753741AbeFTCOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:14:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B219D6081B; Wed, 20 Jun 2018 02:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529460890;
        bh=GG6iH0tfzd6ErPV6uC89Y8tZh2GVukDY3MwhvjAslJ0=;
        h=From:To:Cc:Subject:Date:From;
        b=NnUX2nNxs9qtJ/SOqKD3UgDxO0OVcv6t5WQW551zX5c1V9S+sm4aOMSkOBPG/UfgQ
         VA8fR6UpLAIE/H308kNQZLdXtG7oYaP4JwgxwoomLUwul00iT367oDB6x0HU0pIsW9
         3n/cwILhWG8LIvft5tyouHzWh+/eZLhUYK1N32cE=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C8AA6081B;
        Wed, 20 Jun 2018 02:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529460890;
        bh=GG6iH0tfzd6ErPV6uC89Y8tZh2GVukDY3MwhvjAslJ0=;
        h=From:To:Cc:Subject:Date:From;
        b=NnUX2nNxs9qtJ/SOqKD3UgDxO0OVcv6t5WQW551zX5c1V9S+sm4aOMSkOBPG/UfgQ
         VA8fR6UpLAIE/H308kNQZLdXtG7oYaP4JwgxwoomLUwul00iT367oDB6x0HU0pIsW9
         3n/cwILhWG8LIvft5tyouHzWh+/eZLhUYK1N32cE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C8AA6081B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org, timur@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2] PCI: Enable PASID when End-to-End TLP is supported by all bridges
Date:   Tue, 19 Jun 2018 22:14:46 -0400
Message-Id: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A PCIe endpoint carries the process address space identifier (PASID) in
the TLP prefix as part of the memory read/write transaction. The address
information in the TLP is relevant only for a given PASID context.

An IOMMU takes PASID value and the address information from the
TLP to look up the physical address in the system.

If a bridge drops the TLP prefix, the translation agent can resolve the
address to an incorrect location and cause data corruption. Prevent
this condition by requiring End-to-End TLP prefix to be supported on the
entire data path between the endpoint and the root port.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/ats.c             |  9 +++++++++
 drivers/pci/probe.c           | 17 +++++++++++++++++
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 28 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 4923a2a..e1b2e6d 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -268,6 +268,7 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
 int pci_enable_pasid(struct pci_dev *pdev, int features)
 {
 	u16 control, supported;
+	struct pci_dev *bridge;
 	int pos;
 
 	if (WARN_ON(pdev->pasid_enabled))
@@ -277,6 +278,14 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pos)
 		return -EINVAL;
 
+	bridge = pci_upstream_bridge(pdev);
+	while (bridge) {
+		if (!bridge->eetlp_prefix)
+			return -EINVAL;
+
+		bridge = pci_upstream_bridge(bridge);
+	}
+
 	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e3..a7f7ac1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2042,6 +2042,22 @@ static void pci_configure_ltr(struct pci_dev *dev)
 #endif
 }
 
+static void pci_configure_eetlp_prefix(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCI_PASID
+	u32 cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+	if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
+		return;
+
+	dev->eetlp_prefix = 1;
+#endif
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	struct hotplug_params hpp;
@@ -2051,6 +2067,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_extended_tags(dev, NULL);
 	pci_configure_relaxed_ordering(dev);
 	pci_configure_ltr(dev);
+	pci_configure_eetlp_prefix(dev);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b..cf88d47 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -350,6 +350,7 @@ struct pci_dev {
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
 #endif
+	unsigned int	eetlp_prefix:1;	/* End-to-End TLP Prefix */
 
 	pci_channel_state_t error_state;	/* Current connectivity state */
 	struct device	dev;			/* Generic device interface */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4da87e2..a617ab2 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -636,6 +636,7 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
+#define PCI_EXP_DEVCAP2_E2ETLP		0x00200000 /* End-to-End TLP Prefix */
 #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
-- 
2.7.4

