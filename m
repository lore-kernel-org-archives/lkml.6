Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDDWuU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 18:50:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59576 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeDDWuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 18:50:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79370602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, sulrich@codeaurora.org,
        timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: quirk HT1100 & HT2000 and one HT2100 Root Ports for Extended Tags
Date: Wed,  4 Apr 2018 18:50:09 -0400
Message-Id: <1522882209-9743-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per PCIe r3.1, sec 2.2.6.2 and 7.8.4, a Requester may not use 8-bit Tags
unless its Extended Tag Field Enable is set, but all Receivers/Completers
must handle 8-bit Tags correctly regardless of their Extended Tag Field
Enable.

Some devices do not handle 8-bit Tags as Completers, so add a quirk for
them.  If we find such a device, we disable Extended Tags for the entire
hierarchy to make peer-to-peer DMA possible.

The Broadcom HT1100/HT2000/HT2100 seems to have issues with handling 8-bit
tags.  Mark it as broken.

Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=196197
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8b14bd3..f012742 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4813,9 +4813,13 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
 
 	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0142, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144, quirk_no_ext_tags);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 
 #ifdef CONFIG_PCI_ATS
 /*
-- 
2.7.4
