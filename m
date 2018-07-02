Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75450C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F6925187
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BXF7UdwF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jM4V64IV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F6925187
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932476AbeGBW7h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:59:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40234 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbeGBW7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:59:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7D3AA60B27; Mon,  2 Jul 2018 22:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530572374;
        bh=D9xE8YBEUSamlFhgsjsjP9kjL/OWpZ86xJlKb3xBRBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXF7UdwFEbbMaZWqWZ0qXpdFnAW15g/Mv5OXJqhoYnh8+uapYkWqSVugNcnSJkYfn
         PXU3n4ba3gmr63UcfGf/loWjRDLWFACCoisfediqq7qw7lD40PjISs+je5Q+CmeLuL
         dPgLHsUUQHQk9odaofF6248H2/1ZmucuxsaFsWf0=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E07B160B72;
        Mon,  2 Jul 2018 22:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530572371;
        bh=D9xE8YBEUSamlFhgsjsjP9kjL/OWpZ86xJlKb3xBRBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jM4V64IVG3UcS1ex5HjEwv5AZXGaCQ2t+k2iDApnnRjGXKWHwtIwxeQA/N1xSWkzY
         WI5PlQpQ+c/YFb0fm+3dm0nt9CWz4INQiPW5U3GJiI3art5THoH1PnqUBEhkBZi09M
         InSnrLIYC3FXfVOZf9yU+BDsoOSWQBeO655oypl0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E07B160B72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V5 3/6] PCI: Hide pci_reset_bridge_secondary_bus() from drivers
Date:   Mon,  2 Jul 2018 18:58:52 -0400
Message-Id: <1530572336-20296-4-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
References: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename pci_reset_bridge_secondary_bus() to pci_bridge_secondary_bus_reset()
and move the declartation from linux/pci.h to drivers/pci.h to be used
internally in PCI directory only.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp_hpc.c |  2 +-
 drivers/pci/pci.c                | 11 +++++------
 drivers/pci/pci.h                |  1 +
 drivers/pci/pcie/aer.c           |  2 +-
 drivers/pci/pcie/err.c           |  2 +-
 include/linux/pci.h              |  1 -
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bbaa211..8dae232 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -746,7 +746,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	if (pciehp_poll_mode)
 		del_timer_sync(&ctrl->poll_timer);
 
-	rc = pci_reset_bridge_secondary_bus(ctrl->pcie->port);
+	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
 
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
 	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 98d1490..236220c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4224,19 +4224,18 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
 }
 
 /**
- * pci_reset_bridge_secondary_bus - Reset the secondary bus on a PCI bridge.
+ * pci_bridge_secondary_bus_reset - Reset the secondary bus on a PCI bridge.
  * @dev: Bridge device
  *
  * Use the bridge control register to assert reset on the secondary bus.
  * Devices on the secondary bus are left in power-on state.
  */
-int pci_reset_bridge_secondary_bus(struct pci_dev *dev)
+int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
 	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
 }
-EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
 
 static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 {
@@ -4253,7 +4252,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 	if (probe)
 		return 0;
 
-	return pci_reset_bridge_secondary_bus(dev->bus->self);
+	return pci_bridge_secondary_bus_reset(dev->bus->self);
 }
 
 static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
@@ -4860,7 +4859,7 @@ static int pci_bus_reset(struct pci_bus *bus, int probe)
 
 	might_sleep();
 
-	ret = pci_reset_bridge_secondary_bus(bus->self);
+	ret = pci_bridge_secondary_bus_reset(bus->self);
 
 	pci_bus_unlock(bus);
 
@@ -4924,7 +4923,7 @@ int pci_try_reset_bus(struct pci_bus *bus)
 
 	if (pci_bus_trylock(bus)) {
 		might_sleep();
-		rc = pci_reset_bridge_secondary_bus(bus->self);
+		rc = pci_bridge_secondary_bus_reset(bus->self);
 		pci_bus_unlock(bus);
 	} else
 		rc = -EAGAIN;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a0..f784263 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -33,6 +33,7 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
 int pci_probe_reset_function(struct pci_dev *dev);
+int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index bde723d..8c12efc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1314,7 +1314,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
-	rc = pci_reset_bridge_secondary_bus(dev);
+	rc = pci_bridge_secondary_bus_reset(dev);
 	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 03075cf..ae72f88 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -177,7 +177,7 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 {
 	int rc;
 
-	rc = pci_reset_bridge_secondary_bus(dev);
+	rc = pci_bridge_secondary_bus_reset(dev);
 	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b..6b12ce2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1102,7 +1102,6 @@ int pci_reset_bus(struct pci_bus *bus);
 int pci_try_reset_bus(struct pci_bus *bus);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
-int pci_reset_bridge_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
-- 
2.7.4

