Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C04DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC7523C52
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC7523C52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934318AbeGCReR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:34:17 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:56421 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933677AbeGCReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:34:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 98C6118029590;
        Tue,  3 Jul 2018 17:34:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jeans10_24fe5e47ef451
X-Filterd-Recvd-Size: 11534
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Jul 2018 17:34:14 +0000 (UTC)
Message-ID: <cb5702b95b8d4914612526125f625c4bc2cedfcc.camel@perches.com>
Subject: Re: [PATCH] iommu/amd: fix missing tag from dev_err message
From:   Joe Perches <joe@perches.com>
To:     Walter Harms <wharms@bfs.de>, "Hook, Gary" <ghook@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Jul 2018 10:34:12 -0700
In-Reply-To: <1540588259.84011.1530637026831@ox-groupware.bfs.de>
References: <1540588259.84011.1530637026831@ox-groupware.bfs.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 18:57 +0200, Walter Harms wrote:
> It is only cosmetics but even the author got lost about the loose bracket.
> I would suggest to remove all the brackets or if needed to move the [ in the
> message. We have enought memory this days.

My suggestion would be to remove the separate dev_err
and use "Event log [" in each dev_err.

So here's an actual suggested patch that does a few things:

o Coalesce formats and realigns arguments
o Uses pr_fmt and dev_fmt to prefix "AMD-Vi: " to all messages
o Remove embedded "AMD-Vi: " from various formats

Some existing pr_<level> uses now are prefixed too.
---
 drivers/iommu/amd_iommu.c | 69 +++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 596b95c50051..01583a8ccaf9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -17,6 +17,9 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#define pr_fmt(fmt) "AMD-Vi: " fmt
+#define dev_fmt pr_fmt
+
 #include <linux/ratelimit.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
@@ -273,9 +276,8 @@ static u16 get_alias(struct device *dev)
 		return pci_alias;
 	}
 
-	pr_info("AMD-Vi: Using IVRS reported alias %02x:%02x.%d "
-		"for device %s[%04x:%04x], kernel reported alias "
-		"%02x:%02x.%d\n", PCI_BUS_NUM(ivrs_alias), PCI_SLOT(ivrs_alias),
+	pr_info("Using IVRS reported alias %02x:%02x.%d for device %s[%04x:%04x], kernel reported alias %02x:%02x.%d\n",
+		PCI_BUS_NUM(ivrs_alias), PCI_SLOT(ivrs_alias),
 		PCI_FUNC(ivrs_alias), dev_name(dev), pdev->vendor, pdev->device,
 		PCI_BUS_NUM(pci_alias), PCI_SLOT(pci_alias),
 		PCI_FUNC(pci_alias));
@@ -287,7 +289,7 @@ static u16 get_alias(struct device *dev)
 	if (pci_alias == devid &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
 		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
-		pr_info("AMD-Vi: Added PCI DMA alias %02x.%d for %s\n",
+		pr_info("Added PCI DMA alias %02x.%d for %s\n",
 			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias),
 			dev_name(dev));
 	}
@@ -507,8 +509,8 @@ static void dump_dte_entry(u16 devid)
 	int i;
 
 	for (i = 0; i < 4; ++i)
-		pr_err("AMD-Vi: DTE[%d]: %016llx\n", i,
-			amd_iommu_dev_table[devid].data[i]);
+		pr_err("DTE[%d]: %016llx\n",
+		       i, amd_iommu_dev_table[devid].data[i]);
 }
 
 static void dump_command(unsigned long phys_addr)
@@ -517,7 +519,7 @@ static void dump_command(unsigned long phys_addr)
 	int i;
 
 	for (i = 0; i < 4; ++i)
-		pr_err("AMD-Vi: CMD[%d]: %08x\n", i, cmd->data[i]);
+		pr_err("CMD[%d]: %08x\n", i, cmd->data[i]);
 }
 
 static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
@@ -532,10 +534,10 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 		dev_data = get_dev_data(&pdev->dev);
 
 	if (dev_data && __ratelimit(&dev_data->rs)) {
-		dev_err(&pdev->dev, "AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+		dev_err(&pdev->dev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 			domain_id, address, flags);
 	} else if (printk_ratelimit()) {
-		pr_err("AMD-Vi: Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+		pr_err("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			domain_id, address, flags);
 	}
@@ -562,7 +564,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	if (type == 0) {
 		/* Did we hit the erratum? */
 		if (++count == LOOP_TIMEOUT) {
-			pr_err("AMD-Vi: No event written to event log\n");
+			pr_err("No event written to event log\n");
 			return;
 		}
 		udelay(1);
@@ -572,43 +574,40 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	if (type == EVENT_TYPE_IO_FAULT) {
 		amd_iommu_report_page_fault(devid, pasid, address, flags);
 		return;
-	} else {
-		dev_err(dev, "AMD-Vi: Event logged [");
 	}
 
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		dump_dte_entry(devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
-		dev_err(dev, "DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
-			"address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		dev_err(dev, "PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
-		dev_err(dev, "ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
+		dev_err(dev, "Event logged [ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
 		dump_command(address);
 		break;
 	case EVENT_TYPE_CMD_HARD_ERR:
-		dev_err(dev, "COMMAND_HARDWARE_ERROR address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [COMMAND_HARDWARE_ERROR address=0x%016llx flags=0x%04x]\n",
 			address, flags);
 		break;
 	case EVENT_TYPE_IOTLB_INV_TO:
-		dev_err(dev, "IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%016llx]\n",
+		dev_err(dev, "Event logged [IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%016llx]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			address);
 		break;
 	case EVENT_TYPE_INV_DEV_REQ:
-		dev_err(dev, "INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
@@ -616,12 +615,12 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		pasid = ((event[0] >> 16) & 0xFFFF)
 			| ((event[1] << 6) & 0xF0000);
 		tag = event[1] & 0x03FF;
-		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
 	default:
-		dev_err(dev, "UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
+		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
 			event[0], event[1], event[2], event[3]);
 	}
 
@@ -648,7 +647,7 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 	struct amd_iommu_fault fault;
 
 	if (PPR_REQ_TYPE(raw[0]) != PPR_REQ_FAULT) {
-		pr_err_ratelimited("AMD-Vi: Unknown PPR request received\n");
+		pr_err_ratelimited("Unknown PPR request received\n");
 		return;
 	}
 
@@ -753,12 +752,12 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
 			if (!iommu_ga_log_notifier)
 				break;
 
-			pr_debug("AMD-Vi: %s: devid=%#x, ga_tag=%#x\n",
+			pr_debug("%s: devid=%#x, ga_tag=%#x\n",
 				 __func__, GA_DEVID(log_entry),
 				 GA_TAG(log_entry));
 
 			if (iommu_ga_log_notifier(GA_TAG(log_entry)) != 0)
-				pr_err("AMD-Vi: GA log notifier failed.\n");
+				pr_err("GA log notifier failed\n");
 			break;
 		default:
 			break;
@@ -783,18 +782,18 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 			iommu->mmio_base + MMIO_STATUS_OFFSET);
 
 		if (status & MMIO_STATUS_EVT_INT_MASK) {
-			pr_devel("AMD-Vi: Processing IOMMU Event Log\n");
+			pr_devel("Processing IOMMU Event Log\n");
 			iommu_poll_events(iommu);
 		}
 
 		if (status & MMIO_STATUS_PPR_INT_MASK) {
-			pr_devel("AMD-Vi: Processing IOMMU PPR Log\n");
+			pr_devel("Processing IOMMU PPR Log\n");
 			iommu_poll_ppr_log(iommu);
 		}
 
 #ifdef CONFIG_IRQ_REMAP
 		if (status & MMIO_STATUS_GALOG_INT_MASK) {
-			pr_devel("AMD-Vi: Processing IOMMU GA Log\n");
+			pr_devel("Processing IOMMU GA Log\n");
 			iommu_poll_ga_log(iommu);
 		}
 #endif
@@ -838,7 +837,7 @@ static int wait_on_sem(volatile u64 *sem)
 	}
 
 	if (i == LOOP_TIMEOUT) {
-		pr_alert("AMD-Vi: Completion-Wait loop timed out\n");
+		pr_alert("Completion-Wait loop timed out\n");
 		return -EIO;
 	}
 
@@ -1030,7 +1029,7 @@ static int __iommu_queue_command_sync(struct amd_iommu *iommu,
 		/* Skip udelay() the first time around */
 		if (count++) {
 			if (count == LOOP_TIMEOUT) {
-				pr_err("AMD-Vi: Command buffer timeout\n");
+				pr_err("Command buffer timeout\n");
 				return -EIO;
 			}
 
@@ -2794,9 +2793,9 @@ int __init amd_iommu_init_dma_ops(void)
 		dma_ops = &dma_direct_ops;
 
 	if (amd_iommu_unmap_flush)
-		pr_info("AMD-Vi: IO/TLB flush on unmap enabled\n");
+		pr_info("IO/TLB flush on unmap enabled\n");
 	else
-		pr_info("AMD-Vi: Lazy IO/TLB flushing enabled\n");
+		pr_info("Lazy IO/TLB flushing enabled\n");
 
 	return 0;
 
@@ -2901,7 +2900,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 	case IOMMU_DOMAIN_DMA:
 		dma_domain = dma_ops_domain_alloc();
 		if (!dma_domain) {
-			pr_err("AMD-Vi: Failed to allocate\n");
+			pr_err("Failed to allocate\n");
 			return NULL;
 		}
 		pdomain = &dma_domain->domain;
@@ -3121,7 +3120,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 						 IOMMU_RESV_DIRECT);
 		if (!region) {
 			pr_err("Out of memory allocating dm-regions for %s\n",
-				dev_name(dev));
+			       dev_name(dev));
 			return;
 		}
 		list_add_tail(&region->list, head);
@@ -4317,7 +4316,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	 * legacy mode. So, we force legacy mode instead.
 	 */
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)) {
-		pr_debug("AMD-Vi: %s: Fall back to using intr legacy remap\n",
+		pr_debug("%s: Fall back to using intr legacy remap\n",
 			 __func__);
 		pi_data->is_guest_mode = false;
 	}

