Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B1AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA5E2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyozaYpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA5E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeJQBGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQBGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28EE921476;
        Tue, 16 Oct 2018 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710093;
        bh=i0YFQsenVgW9j5qOttl0V91Fq7gCUZfezEk4XUj1YxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyozaYpvKglbVEXALCQrShN2mkT7HwHzL6qt1fpUqWdUEtDr5U+eSjdUzvdwzzNG4
         x/HrQn6CxDH9Y0CCN6DtTUG84/N5v/SgJ9k6mI7+iqbjjPWT/fz1dyqViOfzt+y7Un
         QjihE3BaGxItrGzOjtqs+ZO2h69ox+hq8iHVhiX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 100/135] PCI: hv: support reporting serial number as slot information
Date:   Tue, 16 Oct 2018 19:05:30 +0200
Message-Id: <20181016170522.236280831@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pci-hyperv.c |   37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -89,6 +89,9 @@ static enum pci_protocol_version_t pci_p
 
 #define STATUS_REVISION_MISMATCH 0xC0000059
 
+/* space for 32bit serial number as string */
+#define SLOT_NAME_SIZE 11
+
 /*
  * Message Types
  */
@@ -494,6 +497,7 @@ struct hv_pci_dev {
 	struct list_head list_entry;
 	refcount_t refs;
 	enum hv_pcichild_state state;
+	struct pci_slot *pci_slot;
 	struct pci_function_description desc;
 	bool reported_missing;
 	struct hv_pcibus_device *hbus;
@@ -1457,6 +1461,34 @@ static void prepopulate_bars(struct hv_p
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
@@ -1480,6 +1512,7 @@ static int create_root_hv_pci_bus(struct
 	pci_lock_rescan_remove();
 	pci_scan_child_bus(hbus->pci_bus);
 	pci_bus_assign_resources(hbus->pci_bus);
+	hv_pci_assign_slots(hbus);
 	pci_bus_add_devices(hbus->pci_bus);
 	pci_unlock_rescan_remove();
 	hbus->state = hv_pcibus_installed;
@@ -1742,6 +1775,7 @@ static void pci_devices_present_work(str
 		 */
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->pci_bus);
+		hv_pci_assign_slots(hbus);
 		pci_unlock_rescan_remove();
 		break;
 
@@ -1858,6 +1892,9 @@ static void hv_eject_device_work(struct
 	list_del(&hpdev->list_entry);
 	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
 
+	if (hpdev->pci_slot)
+		pci_destroy_slot(hpdev->pci_slot);
+
 	memset(&ctxt, 0, sizeof(ctxt));
 	ejct_pkt = (struct pci_eject_response *)&ctxt.pkt.message;
 	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;


