Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CF20AC004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769E5208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Af8tAT77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769E5208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934672AbeFLAV3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:21:29 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34017 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934625AbeFLAV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:21:26 -0400
Received: by mail-qt0-f195.google.com with SMTP id d3-v6so22162448qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iP6AbfiWeNEKpQjP3offaSqR26PzJ/i8yHSP9WMZMPY=;
        b=Af8tAT77k9+ZYn4FIt5ob2R3agxznvrY/krYRFRNWIAFsgPETenJOR7OtC/jlIGCFA
         AuUKRDwfDgjX0uABZTMIy2qSSG7VcCrnigNAW6K+4Izbzo3WJUXEx/H8G+/xG+c0ExPe
         CYAxr95tx0iiTl7kDJlhMBI4w8ecHdo67l6e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iP6AbfiWeNEKpQjP3offaSqR26PzJ/i8yHSP9WMZMPY=;
        b=qR/AxX8Z8SS8WT6Os78G7RBu1yGonNZcF0qpsicD7CAJtFUySgrw2OUSKYIK9mZ80N
         d/tcnXza3TXBDMIRrPVxZA1UR8Pkcwaph7q2DSFMBSUF0otUTPRXJ86R7zjb2FdX2i7h
         pGCV3YLaKoJcHHzSuvzbCbjY5Kc136qj0D5O8s8vj+7+Uv8fY+abOw5fNyu/K2bRDQzu
         N7RoiYqYjYkQRx6+XVCgSiElCddqE6vU5I/5uQTGsmbBys+hvjk/cJ6vp0Fpiq58ZvkY
         XumEloj3ezJIEAiEy62Z9R512+0QsGHKrxTOEJSXnG8p3YHVfhStdL2EyacjLFIh/OV7
         B8Rg==
X-Gm-Message-State: APt69E0a41x+iMWAwme2QBq99lAlIwwXyIIo6Cmp2l6k/ZNB3IE7F6JJ
        6PWFZYVrpR9fUzdLaG9nTMJg29QRs/8=
X-Google-Smtp-Source: ADUXVKIeHpF3/4OYypzVqeshkZndOLZ1Is1c9dPsKFpT/3lzgBQq1SZIXZ0lUKhkcK/HlDQdwj4oXQ==
X-Received: by 2002:a0c:b203:: with SMTP id x3-v6mr1395586qvd.86.1528762885296;
        Mon, 11 Jun 2018 17:21:25 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v26-v6sm31470299qtc.12.2018.06.11.17.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 17:21:24 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH v2 2/5] PCI: iproc: Fix up corrupted PAXC root complex config registers
Date:   Mon, 11 Jun 2018 17:21:04 -0700
Message-Id: <1528762867-16823-3-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On certain versions of Broadcom PAXC based root complexes, certain
regions of the configuration space are corrupted. As a result, it
prevents the Linux PCIe stack from traversing the linked list of the
capability registers completely and therefore the root complex is
not advertised as "PCIe capable". This prevents the correct PCIe RID
from being parsed in the kernel PCIe stack. A correct RID is required
for mapping to a stream ID from the SMMU or the device ID from the
GICv3 ITS

This patch fixes up the issue by manually populating the related
PCIe capabilities

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 65 +++++++++++++++++++++++++++++++++++++++----
 drivers/pci/host/pcie-iproc.h |  3 ++
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 3c76c5f..680f6b1 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -85,6 +85,8 @@
 #define IMAP_VALID_SHIFT		0
 #define IMAP_VALID			BIT(IMAP_VALID_SHIFT)
 
+#define IPROC_PCI_PM_CAP		0x48
+#define IPROC_PCI_PM_CAP_MASK		0xffff
 #define IPROC_PCI_EXP_CAP		0xac
 
 #define IPROC_PCIE_REG_INVALID		0xffff
@@ -375,6 +377,17 @@ static const u16 iproc_pcie_reg_paxc_v2[] = {
 	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
 };
 
+/*
+ * List of device IDs of controllers that have corrupted capability list that
+ * require SW fixup
+ */
+static const u16 iproc_pcie_corrupt_cap_did[] = {
+	0x16cd,
+	0x16f0,
+	0xd802,
+	0xd804
+};
+
 static inline struct iproc_pcie *iproc_data(struct pci_bus *bus)
 {
 	struct iproc_pcie *pcie = bus->sysdata;
@@ -495,6 +508,49 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
 	return data;
 }
 
+static void iproc_pcie_fix_cap(struct iproc_pcie *pcie, int where, u32 *val)
+{
+	u32 i, dev_id;
+
+	switch (where & ~0x3) {
+	case PCI_VENDOR_ID:
+		dev_id = *val >> 16;
+
+		/*
+		 * Activate fixup for those controllers that have corrupted
+		 * capability list registers
+		 */
+		for (i = 0; i < ARRAY_SIZE(iproc_pcie_corrupt_cap_did); i++)
+			if (dev_id == iproc_pcie_corrupt_cap_did[i])
+				pcie->fix_paxc_cap = true;
+		break;
+
+	case IPROC_PCI_PM_CAP:
+		if (pcie->fix_paxc_cap) {
+			/* advertise PM, force next capability to PCIe */
+			*val &= ~IPROC_PCI_PM_CAP_MASK;
+			*val |= IPROC_PCI_EXP_CAP << 8 | PCI_CAP_ID_PM;
+		}
+		break;
+
+	case IPROC_PCI_EXP_CAP:
+		if (pcie->fix_paxc_cap) {
+			/* advertise root port, version 2, terminate here */
+			*val = (PCI_EXP_TYPE_ROOT_PORT << 4 | 2) << 16 |
+				PCI_CAP_ID_EXP;
+		}
+		break;
+
+	case IPROC_PCI_EXP_CAP + PCI_EXP_RTCTL:
+		/* Don't advertise CRS SV support */
+		*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
+		break;
+
+	default:
+		break;
+	}
+}
+
 static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 *val)
 {
@@ -509,13 +565,10 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	/* root complex access */
 	if (busno == 0) {
 		ret = pci_generic_config_read32(bus, devfn, where, size, val);
-		if (ret != PCIBIOS_SUCCESSFUL)
-			return ret;
+		if (ret == PCIBIOS_SUCCESSFUL)
+			iproc_pcie_fix_cap(pcie, where, val);
 
-		/* Don't advertise CRS SV support */
-		if ((where & ~0x3) == IPROC_PCI_EXP_CAP + PCI_EXP_RTCTL)
-			*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
-		return PCIBIOS_SUCCESSFUL;
+		return ret;
 	}
 
 	cfg_data_p = iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index 814b600..9d5cfee 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -60,6 +60,8 @@ struct iproc_msi;
  * @ep_is_internal: indicates an internal emulated endpoint device is connected
  * @has_apb_err_disable: indicates the controller can be configured to prevent
  * unsupported request from being forwarded as an APB bus error
+ * @fix_paxc_cap: indicates the controller has corrupted capability list in its
+ * config space registers and requires SW based fixup
  *
  * @need_ob_cfg: indicates SW needs to configure the outbound mapping window
  * @ob: outbound mapping related parameters
@@ -85,6 +87,7 @@ struct iproc_pcie {
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	bool ep_is_internal;
 	bool has_apb_err_disable;
+	bool fix_paxc_cap;
 
 	bool need_ob_cfg;
 	struct iproc_pcie_ob ob;
-- 
2.1.4

