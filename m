Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D2EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19FD2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19FD2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeK1Tou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:44:50 -0500
Received: from 8bytes.org ([81.169.241.247]:50634 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbeK1Tog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:44:36 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F1BF722F; Wed, 28 Nov 2018 09:43:43 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@kv.home.8bytes.org>
Subject: [PATCH 1/3] iommu/amd: Use pr_fmt()
Date:   Wed, 28 Nov 2018 09:43:40 +0100
Message-Id: <20181128084342.16363-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128084342.16363-1-joro@8bytes.org>
References: <20181128084342.16363-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <joro@kv.home.8bytes.org>

Make use of pr_fmt instead of having the 'AMD-Vi' prefix
added manually at every printk() call.

Signed-off-by: Joerg Roedel <joro@kv.home.8bytes.org>
---
 drivers/iommu/amd_iommu.c      | 38 ++++++++++----------
 drivers/iommu/amd_iommu_init.c | 64 ++++++++++++++++++----------------
 drivers/iommu/amd_iommu_v2.c   |  2 ++
 3 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0416cf..9b96b424add4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -17,6 +17,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+
 #include <linux/ratelimit.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
@@ -279,7 +281,7 @@ static u16 get_alias(struct device *dev)
 		return pci_alias;
 	}
 
-	pr_info("AMD-Vi: Using IVRS reported alias %02x:%02x.%d "
+	pr_info("Using IVRS reported alias %02x:%02x.%d "
 		"for device %s[%04x:%04x], kernel reported alias "
 		"%02x:%02x.%d\n", PCI_BUS_NUM(ivrs_alias), PCI_SLOT(ivrs_alias),
 		PCI_FUNC(ivrs_alias), dev_name(dev), pdev->vendor, pdev->device,
@@ -293,7 +295,7 @@ static u16 get_alias(struct device *dev)
 	if (pci_alias == devid &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
 		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
-		pr_info("AMD-Vi: Added PCI DMA alias %02x.%d for %s\n",
+		pr_info("Added PCI DMA alias %02x.%d for %s\n",
 			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias),
 			dev_name(dev));
 	}
@@ -513,7 +515,7 @@ static void dump_dte_entry(u16 devid)
 	int i;
 
 	for (i = 0; i < 4; ++i)
-		pr_err("AMD-Vi: DTE[%d]: %016llx\n", i,
+		pr_err("DTE[%d]: %016llx\n", i,
 			amd_iommu_dev_table[devid].data[i]);
 }
 
@@ -523,7 +525,7 @@ static void dump_command(unsigned long phys_addr)
 	int i;
 
 	for (i = 0; i < 4; ++i)
-		pr_err("AMD-Vi: CMD[%d]: %08x\n", i, cmd->data[i]);
+		pr_err("CMD[%d]: %08x\n", i, cmd->data[i]);
 }
 
 static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
@@ -541,7 +543,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 		dev_err(&pdev->dev, "AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 			domain_id, address, flags);
 	} else if (printk_ratelimit()) {
-		pr_err("AMD-Vi: Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+		pr_err("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			domain_id, address, flags);
 	}
@@ -568,7 +570,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	if (type == 0) {
 		/* Did we hit the erratum? */
 		if (++count == LOOP_TIMEOUT) {
-			pr_err("AMD-Vi: No event written to event log\n");
+			pr_err("No event written to event log\n");
 			return;
 		}
 		udelay(1);
@@ -654,7 +656,7 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 	struct amd_iommu_fault fault;
 
 	if (PPR_REQ_TYPE(raw[0]) != PPR_REQ_FAULT) {
-		pr_err_ratelimited("AMD-Vi: Unknown PPR request received\n");
+		pr_err_ratelimited("Unknown PPR request received\n");
 		return;
 	}
 
@@ -759,12 +761,12 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
 			if (!iommu_ga_log_notifier)
 				break;
 
-			pr_debug("AMD-Vi: %s: devid=%#x, ga_tag=%#x\n",
+			pr_debug("%s: devid=%#x, ga_tag=%#x\n",
 				 __func__, GA_DEVID(log_entry),
 				 GA_TAG(log_entry));
 
 			if (iommu_ga_log_notifier(GA_TAG(log_entry)) != 0)
-				pr_err("AMD-Vi: GA log notifier failed.\n");
+				pr_err("GA log notifier failed.\n");
 			break;
 		default:
 			break;
@@ -789,18 +791,18 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
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
@@ -844,7 +846,7 @@ static int wait_on_sem(volatile u64 *sem)
 	}
 
 	if (i == LOOP_TIMEOUT) {
-		pr_alert("AMD-Vi: Completion-Wait loop timed out\n");
+		pr_alert("Completion-Wait loop timed out\n");
 		return -EIO;
 	}
 
@@ -1036,7 +1038,7 @@ static int __iommu_queue_command_sync(struct amd_iommu *iommu,
 		/* Skip udelay() the first time around */
 		if (count++) {
 			if (count == LOOP_TIMEOUT) {
-				pr_err("AMD-Vi: Command buffer timeout\n");
+				pr_err("Command buffer timeout\n");
 				return -EIO;
 			}
 
@@ -2790,9 +2792,9 @@ int __init amd_iommu_init_dma_ops(void)
 		dma_ops = &dma_direct_ops;
 
 	if (amd_iommu_unmap_flush)
-		pr_info("AMD-Vi: IO/TLB flush on unmap enabled\n");
+		pr_info("IO/TLB flush on unmap enabled\n");
 	else
-		pr_info("AMD-Vi: Lazy IO/TLB flushing enabled\n");
+		pr_info("Lazy IO/TLB flushing enabled\n");
 
 	return 0;
 
@@ -2897,7 +2899,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 	case IOMMU_DOMAIN_DMA:
 		dma_domain = dma_ops_domain_alloc();
 		if (!dma_domain) {
-			pr_err("AMD-Vi: Failed to allocate\n");
+			pr_err("Failed to allocate\n");
 			return NULL;
 		}
 		pdomain = &dma_domain->domain;
@@ -4318,7 +4320,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	 * legacy mode. So, we force legacy mode instead.
 	 */
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)) {
-		pr_debug("AMD-Vi: %s: Fall back to using intr legacy remap\n",
+		pr_debug("%s: Fall back to using intr legacy remap\n",
 			 __func__);
 		pi_data->is_guest_mode = false;
 	}
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index d8f7000a466a..66123b911ec8 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -17,6 +17,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/list.h>
@@ -443,9 +445,9 @@ static void iommu_disable(struct amd_iommu *iommu)
 static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
 {
 	if (!request_mem_region(address, end, "amd_iommu")) {
-		pr_err("AMD-Vi: Can not reserve memory region %llx-%llx for mmio\n",
+		pr_err("Can not reserve memory region %llx-%llx for mmio\n",
 			address, end);
-		pr_err("AMD-Vi: This is a BIOS bug. Please contact your hardware vendor\n");
+		pr_err("This is a BIOS bug. Please contact your hardware vendor\n");
 		return NULL;
 	}
 
@@ -512,7 +514,7 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 	u32 ivhd_size = get_ivhd_header_size(h);
 
 	if (!ivhd_size) {
-		pr_err("AMD-Vi: Unsupported IVHD type %#x\n", h->type);
+		pr_err("Unsupported IVHD type %#x\n", h->type);
 		return -EINVAL;
 	}
 
@@ -553,7 +555,7 @@ static int __init check_ivrs_checksum(struct acpi_table_header *table)
 		checksum += p[i];
 	if (checksum != 0) {
 		/* ACPI table corrupt */
-		pr_err(FW_BUG "AMD-Vi: IVRS invalid checksum\n");
+		pr_err(FW_BUG "IVRS invalid checksum\n");
 		return -ENODEV;
 	}
 
@@ -1028,7 +1030,7 @@ static int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
 		if (!(entry->id == id && entry->cmd_line))
 			continue;
 
-		pr_info("AMD-Vi: Command-line override present for %s id %d - ignoring\n",
+		pr_info("Command-line override present for %s id %d - ignoring\n",
 			type == IVHD_SPECIAL_IOAPIC ? "IOAPIC" : "HPET", id);
 
 		*devid = entry->devid;
@@ -1061,7 +1063,7 @@ static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u16 *devid,
 		    !entry->cmd_line)
 			continue;
 
-		pr_info("AMD-Vi: Command-line override for hid:%s uid:%s\n",
+		pr_info("Command-line override for hid:%s uid:%s\n",
 			hid, uid);
 		*devid = entry->devid;
 		return 0;
@@ -1077,7 +1079,7 @@ static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u16 *devid,
 	entry->cmd_line	= cmd_line;
 	entry->root_devid = (entry->devid & (~0x7));
 
-	pr_info("AMD-Vi:%s, add hid:%s, uid:%s, rdevid:%d\n",
+	pr_info("%s, add hid:%s, uid:%s, rdevid:%d\n",
 		entry->cmd_line ? "cmd" : "ivrs",
 		entry->hid, entry->uid, entry->root_devid);
 
@@ -1173,7 +1175,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	 */
 	ivhd_size = get_ivhd_header_size(h);
 	if (!ivhd_size) {
-		pr_err("AMD-Vi: Unsupported IVHD type %#x\n", h->type);
+		pr_err("Unsupported IVHD type %#x\n", h->type);
 		return -EINVAL;
 	}
 
@@ -1455,7 +1457,7 @@ static void amd_iommu_erratum_746_workaround(struct amd_iommu *iommu)
 	pci_write_config_dword(iommu->dev, 0xf0, 0x90 | (1 << 8));
 
 	pci_write_config_dword(iommu->dev, 0xf4, value | 0x4);
-	pr_info("AMD-Vi: Applying erratum 746 workaround for IOMMU at %s\n",
+	pr_info("Applying erratum 746 workaround for IOMMU at %s\n",
 		dev_name(&iommu->dev->dev));
 
 	/* Clear the enable writing bit */
@@ -1486,7 +1488,7 @@ static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
 	/* Set L2_DEBUG_3[AtsIgnoreIWDis] = 1 */
 	iommu_write_l2(iommu, 0x47, value | BIT(0));
 
-	pr_info("AMD-Vi: Applying ATS write check workaround for IOMMU at %s\n",
+	pr_info("Applying ATS write check workaround for IOMMU at %s\n",
 		dev_name(&iommu->dev->dev));
 }
 
@@ -1506,7 +1508,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	iommu->index = amd_iommus_present++;
 
 	if (unlikely(iommu->index >= MAX_IOMMUS)) {
-		WARN(1, "AMD-Vi: System has more IOMMUs than supported by this driver\n");
+		WARN(1, "System has more IOMMUs than supported by this driver\n");
 		return -ENOSYS;
 	}
 
@@ -1674,12 +1676,12 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
 	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
 	    (val != val2)) {
-		pr_err("AMD-Vi: Unable to write to IOMMU perf counter.\n");
+		pr_err("Unable to write to IOMMU perf counter.\n");
 		amd_iommu_pc_present = false;
 		return;
 	}
 
-	pr_info("AMD-Vi: IOMMU performance counters supported\n");
+	pr_info("IOMMU performance counters supported\n");
 
 	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
 	iommu->max_banks = (u8) ((val >> 12) & 0x3f);
@@ -1840,11 +1842,11 @@ static void print_iommu_info(void)
 	for_each_iommu(iommu) {
 		int i;
 
-		pr_info("AMD-Vi: Found IOMMU at %s cap 0x%hx\n",
+		pr_info("Found IOMMU at %s cap 0x%hx\n",
 			dev_name(&iommu->dev->dev), iommu->cap_ptr);
 
 		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
-			pr_info("AMD-Vi: Extended features (%#llx):\n",
+			pr_info("Extended features (%#llx):\n",
 				iommu->features);
 			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
 				if (iommu_feature(iommu, (1ULL << i)))
@@ -1858,11 +1860,11 @@ static void print_iommu_info(void)
 		}
 	}
 	if (irq_remapping_enabled) {
-		pr_info("AMD-Vi: Interrupt remapping enabled\n");
+		pr_info("Interrupt remapping enabled\n");
 		if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
-			pr_info("AMD-Vi: virtual APIC enabled\n");
+			pr_info("Virtual APIC enabled\n");
 		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
-			pr_info("AMD-Vi: X2APIC enabled\n");
+			pr_info("X2APIC enabled\n");
 	}
 }
 
@@ -2376,7 +2378,7 @@ static bool __init check_ioapic_information(void)
 
 		devid = get_ioapic_devid(id);
 		if (devid < 0) {
-			pr_err("%sAMD-Vi: IOAPIC[%d] not in IVRS table\n",
+			pr_err("%s: IOAPIC[%d] not in IVRS table\n",
 				fw_bug, id);
 			ret = false;
 		} else if (devid == IOAPIC_SB_DEVID) {
@@ -2394,11 +2396,11 @@ static bool __init check_ioapic_information(void)
 		 * when the BIOS is buggy and provides us the wrong
 		 * device id for the IOAPIC in the system.
 		 */
-		pr_err("%sAMD-Vi: No southbridge IOAPIC found\n", fw_bug);
+		pr_err("%s: No southbridge IOAPIC found\n", fw_bug);
 	}
 
 	if (!ret)
-		pr_err("AMD-Vi: Disabling interrupt remapping\n");
+		pr_err("Disabling interrupt remapping\n");
 
 	return ret;
 }
@@ -2453,7 +2455,7 @@ static int __init early_amd_iommu_init(void)
 		return -ENODEV;
 	else if (ACPI_FAILURE(status)) {
 		const char *err = acpi_format_exception(status);
-		pr_err("AMD-Vi: IVRS table error: %s\n", err);
+		pr_err("IVRS table error: %s\n", err);
 		return -EINVAL;
 	}
 
@@ -2606,7 +2608,7 @@ static bool detect_ivrs(void)
 		return false;
 	else if (ACPI_FAILURE(status)) {
 		const char *err = acpi_format_exception(status);
-		pr_err("AMD-Vi: IVRS table error: %s\n", err);
+		pr_err("IVRS table error: %s\n", err);
 		return false;
 	}
 
@@ -2641,7 +2643,7 @@ static int __init state_next(void)
 		ret = early_amd_iommu_init();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
 		if (init_state == IOMMU_ACPI_FINISHED && amd_iommu_disabled) {
-			pr_info("AMD-Vi: AMD IOMMU disabled on kernel command-line\n");
+			pr_info("AMD IOMMU disabled on kernel command-line\n");
 			free_dma_resources();
 			free_iommu_resources();
 			init_state = IOMMU_CMDLINE_DISABLED;
@@ -2788,7 +2790,7 @@ static bool amd_iommu_sme_check(void)
 	    (boot_cpu_data.microcode <= 0x080011ff))
 		return true;
 
-	pr_notice("AMD-Vi: IOMMU not currently supported when SME is active\n");
+	pr_notice("IOMMU not currently supported when SME is active\n");
 
 	return false;
 }
@@ -2873,12 +2875,12 @@ static int __init parse_ivrs_ioapic(char *str)
 	ret = sscanf(str, "[%d]=%x:%x.%x", &id, &bus, &dev, &fn);
 
 	if (ret != 4) {
-		pr_err("AMD-Vi: Invalid command line: ivrs_ioapic%s\n", str);
+		pr_err("Invalid command line: ivrs_ioapic%s\n", str);
 		return 1;
 	}
 
 	if (early_ioapic_map_size == EARLY_MAP_SIZE) {
-		pr_err("AMD-Vi: Early IOAPIC map overflow - ignoring ivrs_ioapic%s\n",
+		pr_err("Early IOAPIC map overflow - ignoring ivrs_ioapic%s\n",
 			str);
 		return 1;
 	}
@@ -2903,12 +2905,12 @@ static int __init parse_ivrs_hpet(char *str)
 	ret = sscanf(str, "[%d]=%x:%x.%x", &id, &bus, &dev, &fn);
 
 	if (ret != 4) {
-		pr_err("AMD-Vi: Invalid command line: ivrs_hpet%s\n", str);
+		pr_err("Invalid command line: ivrs_hpet%s\n", str);
 		return 1;
 	}
 
 	if (early_hpet_map_size == EARLY_MAP_SIZE) {
-		pr_err("AMD-Vi: Early HPET map overflow - ignoring ivrs_hpet%s\n",
+		pr_err("Early HPET map overflow - ignoring ivrs_hpet%s\n",
 			str);
 		return 1;
 	}
@@ -2933,7 +2935,7 @@ static int __init parse_ivrs_acpihid(char *str)
 
 	ret = sscanf(str, "[%x:%x.%x]=%s", &bus, &dev, &fn, acpiid);
 	if (ret != 4) {
-		pr_err("AMD-Vi: Invalid command line: ivrs_acpihid(%s)\n", str);
+		pr_err("Invalid command line: ivrs_acpihid(%s)\n", str);
 		return 1;
 	}
 
@@ -2942,7 +2944,7 @@ static int __init parse_ivrs_acpihid(char *str)
 	uid = p;
 
 	if (!hid || !(*hid) || !uid) {
-		pr_err("AMD-Vi: Invalid command line: hid or uid\n");
+		pr_err("Invalid command line: hid or uid\n");
 		return 1;
 	}
 
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index fd552235bd13..23dae9348ace 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -16,6 +16,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+
 #include <linux/mmu_notifier.h>
 #include <linux/amd-iommu.h>
 #include <linux/mm_types.h>
-- 
2.17.1

