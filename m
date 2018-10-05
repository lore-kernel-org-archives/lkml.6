Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD6AC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DE521477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhGtv+jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DE521477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbeJEXQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbeJEXQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:16:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A8AE208E7;
        Fri,  5 Oct 2018 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756211;
        bh=hzssbgxzm8YTB8E4kxr/CBD5Zahs2kw3cvpMuxSWVpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qhGtv+jjBbU0DiU0dHbXnTVaKBB1JbiSiQMw6Zj3q2gNQ+9eOyvNh+8VE5VoDpzPJ
         09aSOF08M4zIdUwVW+q3YdQ9seXYdmtFxAr7Z2A/c+FuFbtJcM5DwYfyN7HwP72ku8
         cP4EpUI9DV+5sdQ+6O8y6o1RVQ9On9/h/Srt+ePg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 18/23] PCI: hv: support reporting serial number as slot information
Date:   Fri,  5 Oct 2018 12:16:29 -0400
Message-Id: <20181005161634.20631-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161634.20631-1-sashal@kernel.org>
References: <20181005161634.20631-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit a15f2c08c70811f120d99288d81f70d7f3d104f1 ]

The Hyper-V host API for PCI provides a unique "serial number" which
can be used as basis for sysfs PCI slot table. This can be useful
for cases where userspace wants to find the PCI device based on
serial number.

When an SR-IOV NIC is added, the host sends an attach message
with serial number. The kernel doesn't use the serial number, but
it is useful when doing the same thing in a userspace driver such
as the DPDK. By having /sys/bus/pci/slots/N it provides a direct
way to find the matching PCI device.

There maybe some cases where serial number is not unique such
as when using GPU's. But the PCI slot infrastructure will handle
that.

This has a side effect which may also be useful. The common udev
network device naming policy uses the slot information (rather
than PCI address).

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index ffc87a956d97..53d1c08cef4d 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -100,6 +100,9 @@ static enum pci_protocol_version_t pci_protocol_version;
 
 #define STATUS_REVISION_MISMATCH 0xC0000059
 
+/* space for 32bit serial number as string */
+#define SLOT_NAME_SIZE 11
+
 /*
  * Message Types
  */
@@ -516,6 +519,7 @@ struct hv_pci_dev {
 	struct list_head list_entry;
 	refcount_t refs;
 	enum hv_pcichild_state state;
+	struct pci_slot *pci_slot;
 	struct pci_function_description desc;
 	bool reported_missing;
 	struct hv_pcibus_device *hbus;
@@ -1481,6 +1485,34 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 }
 
+/*
+ * Assign entries in sysfs pci slot directory.
+ *
+ * Note that this function does not need to lock the children list
+ * because it is called from pci_devices_present_work which
+ * is serialized with hv_eject_device_work because they are on the
+ * same ordered workqueue. Therefore hbus->children list will not change
+ * even when pci_create_slot sleeps.
+ */
+static void hv_pci_assign_slots(struct hv_pcibus_device *hbus)
+{
+	struct hv_pci_dev *hpdev;
+	char name[SLOT_NAME_SIZE];
+	int slot_nr;
+
+	list_for_each_entry(hpdev, &hbus->children, list_entry) {
+		if (hpdev->pci_slot)
+			continue;
+
+		slot_nr = PCI_SLOT(wslot_to_devfn(hpdev->desc.win_slot.slot));
+		snprintf(name, SLOT_NAME_SIZE, "%u", hpdev->desc.ser);
+		hpdev->pci_slot = pci_create_slot(hbus->pci_bus, slot_nr,
+					  name, NULL);
+		if (!hpdev->pci_slot)
+			pr_warn("pci_create slot %s failed\n", name);
+	}
+}
+
 /**
  * create_root_hv_pci_bus() - Expose a new root PCI bus
  * @hbus:	Root PCI bus, as understood by this driver
@@ -1504,6 +1536,7 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 	pci_lock_rescan_remove();
 	pci_scan_child_bus(hbus->pci_bus);
 	pci_bus_assign_resources(hbus->pci_bus);
+	hv_pci_assign_slots(hbus);
 	pci_bus_add_devices(hbus->pci_bus);
 	pci_unlock_rescan_remove();
 	hbus->state = hv_pcibus_installed;
@@ -1787,6 +1820,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 */
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->pci_bus);
+		hv_pci_assign_slots(hbus);
 		pci_unlock_rescan_remove();
 		break;
 
@@ -1895,6 +1929,9 @@ static void hv_eject_device_work(struct work_struct *work)
 	list_del(&hpdev->list_entry);
 	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
 
+	if (hpdev->pci_slot)
+		pci_destroy_slot(hpdev->pci_slot);
+
 	memset(&ctxt, 0, sizeof(ctxt));
 	ejct_pkt = (struct pci_eject_response *)&ctxt.pkt.message;
 	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
-- 
2.17.1

