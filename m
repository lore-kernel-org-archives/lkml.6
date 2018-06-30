Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0FCC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B19021939
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PPosd7cB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V9SSeNjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B19021939
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbeF3PYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:24:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeF3PY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:24:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE94360274; Sat, 30 Jun 2018 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530372268;
        bh=9AeoW3/v93KLm7UFFGydJ9eTpADr3Fa9DNWAMLw5xH8=;
        h=From:To:Cc:Subject:Date:From;
        b=PPosd7cBslreDELNQjHYI4Akc2nCLtPeUCrTGIhMoiWLZBI1SUqX0TMS3H+WQJJ6c
         QoMhN9oVjWMIzAG3FtBD92Asu9HimkoyUCDAfNIp0dtFcxPafou1rJwBgh71zm+cIz
         Top0jwaQvmWGt9GnsCIlwLAHH3fokRUo/V1mqoEk=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 45AFD6031A;
        Sat, 30 Jun 2018 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530372267;
        bh=9AeoW3/v93KLm7UFFGydJ9eTpADr3Fa9DNWAMLw5xH8=;
        h=From:To:Cc:Subject:Date:From;
        b=V9SSeNjXfBPfxwg++WGOa4BTiXEcGmSdAvGo4SSuqacRvuVYgx07hrPSRCTbZzIyx
         dhGoRR4VxG8MntNP8EEl1Q7BChpTTc46LdWCfBNqfdr91keG6H2fUAiBYB2J5VdYac
         +uyozjqeju/teDSf9JDYIWqdgADg/2ux4A9AZ1Yw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45AFD6031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3] PCI: Enable PASID when End-to-End TLP is supported by all bridges
Date:   Sat, 30 Jun 2018 11:24:24 -0400
Message-Id: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
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

PASID is an End-End TLP Prefix (PCIe r4.0, sec 6.20).  Sec 2.2.10.2 says

  It is an error to receive a TLP with an End-End TLP Prefix by a
  Receiver that does not support End-End TLP Prefixes. A TLP in
  violation of this rule is handled as a Malformed TLP. This is a
  reported error associated with the Receiving Port (see Section 6.2).

Prevent error condition by proactively requiring End-to-End TLP
prefix to be supported on the entire data path between the endpoint and
the root port before enabling PASID.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/ats.c             |  3 +++
 drivers/pci/probe.c           | 24 ++++++++++++++++++++++++
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 29 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 4923a2a..5b78f3b 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -273,6 +273,9 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
+	if (!pdev->eetlp_prefix_path)
+		return -EINVAL;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return -EINVAL;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e3..39fd3ac 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2042,6 +2042,29 @@ static void pci_configure_ltr(struct pci_dev *dev)
 #endif
 }
 
+static void pci_configure_eetlp_prefix(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCI_PASID
+	struct pci_dev *bridge;
+	u32 cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+	if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
+		return;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+		dev->eetlp_prefix_path = 1;
+	else {
+		bridge = pci_upstream_bridge(dev);
+		if (bridge && bridge->eetlp_prefix_path)
+			dev->eetlp_prefix_path = 1;
+	}
+#endif
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	struct hotplug_params hpp;
@@ -2051,6 +2074,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_extended_tags(dev, NULL);
 	pci_configure_relaxed_ordering(dev);
 	pci_configure_ltr(dev);
+	pci_configure_eetlp_prefix(dev);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b..6ba8184 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -350,6 +350,7 @@ struct pci_dev {
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
 #endif
+	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
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

