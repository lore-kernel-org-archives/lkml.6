Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932272AbeE3UNS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:13:18 -0400
Received: from ale.deltatee.com ([207.54.116.67]:49592 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932170AbeE3UNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:13:17 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Doug Meyer <dmeyer@gigaio.com>
Date: Wed, 30 May 2018 14:13:11 -0600
Message-Id: <20180530201311.11274-1-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, logang@deltatee.com, bhelgaas@google.com, alex.williamson@redhat.com, dmeyer@gigaio.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v3] PCI: Expand documentation for pci_add_dma_alias()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing there's been some confusion about the use of pci_add_dma_alias(),
expand the comment to describe why it must be called early and how
early it must be called.

Also, expand on the purpose of this function and common reasons it would
be used.

[The comment was reworded to some extent by Alex Williamson]

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Doug Meyer <dmeyer@gigaio.com>
---

v3: Fixed some typos pointed out by Randy
v2: Reworked the patch with Alex's suggested wording

drivers/pci/pci.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dbfe7c4f3776..2d8650253cc9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5395,8 +5395,19 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
  * @dev: the PCI device for which alias is added
  * @devfn: alias slot and function
  *
- * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
- * It should be called early, preferably as PCI fixup header quirk.
+ * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
+ * which is used to program permissible bus-devfn source addresses for DMA
+ * requests in an IOMMU. These aliases factor into IOMMU group creation
+ * and are useful for devices generating DMA requests beyond or different
+ * from their logical bus-devfn. Examples include device quirks where the
+ * device simply uses the wrong devfn, as well as non-transparent bridges
+ * where the alias may be a proxy for devices in another domain.
+ *
+ * IOMMU group creation is performed during device discovery or addition,
+ * prior to any potential DMA mapping and therefore prior to driver probing
+ * (especially for userspace assigned devices where IOMMU group definition
+ * cannot be left as a userspace activity). DMA aliases should therefore
+ * be configured via quirks, such as the PCI fixup header quirk.
  */
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
--
2.11.0
