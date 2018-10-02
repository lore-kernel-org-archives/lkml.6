Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8A5C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F83206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F83206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbeJBUOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbeJBUOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:11 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93612C2A;
        Tue,  2 Oct 2018 13:30:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Anemone <peter.anemone@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 166/228] ACPI / hotplug / PCI: Dont scan for non-hotplug bridges if slot is not bridge
Date:   Tue,  2 Oct 2018 06:24:23 -0700
Message-Id: <20181002132509.971550298@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit f188b99f0b2d33794b4af8a225f95d1e968c0a3f upstream.

HP 6730b laptop has an ethernet NIC connected to one of the PCIe root
ports.  The root ports themselves are native PCIe hotplug capable.  Now,
during boot after PCI devices are scanned the BIOS triggers ACPI bus check
directly to the NIC:

  ACPI: \_SB_.PCI0.RP06.NIC_: Bus check in hotplug_event()

It is not clear why it is sending bus check but regardless the ACPI hotplug
notify handler calls enable_slot() directly (instead of going through
acpiphp_check_bridge() as there is no bridge), which ends up handling
special case for non-hotplug bridges with native PCIe hotplug.  This
results a crash of some kind but the reporter only sees black screen so it
is hard to figure out the exact spot and what actually happens.  Based on
a few fix proposals it was tracked to crash somewhere inside
pci_assign_unassigned_bridge_resources().

In any case we should not really be in that special branch at all because
the ACPI notify happened to a slot that is not a PCI bridge (it is just a
regular PCI device).

Fix this so that we only go to that special branch if we are calling
enable_slot() for a bridge (e.g., the ACPI notification was for the
bridge).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201127
Fixes: 84c8b58ed3ad ("ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug")
Reported-by: Peter Anemone <peter.anemone@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: stable@vger.kernel.org	# v4.18+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/acpiphp_glue.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -457,17 +457,18 @@ static void acpiphp_native_scan_bridge(s
 /**
  * enable_slot - enable, configure a slot
  * @slot: slot to be enabled
+ * @bridge: true if enable is for the whole bridge (not a single slot)
  *
  * This function should be called per *physical slot*,
  * not per each slot object in ACPI namespace.
  */
-static void enable_slot(struct acpiphp_slot *slot)
+static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus = slot->bus;
 	struct acpiphp_func *func;
 
-	if (bus->self && hotplug_is_native(bus->self)) {
+	if (bridge && bus->self && hotplug_is_native(bus->self)) {
 		/*
 		 * If native hotplug is used, it will take care of hotplug
 		 * slot management and resource allocation for hotplug
@@ -701,7 +702,7 @@ static void acpiphp_check_bridge(struct
 					trim_stale_devices(dev);
 
 			/* configure all functions */
-			enable_slot(slot);
+			enable_slot(slot, true);
 		} else {
 			disable_slot(slot);
 		}
@@ -785,7 +786,7 @@ static void hotplug_event(u32 type, stru
 		if (bridge)
 			acpiphp_check_bridge(bridge);
 		else if (!(slot->flags & SLOT_IS_GOING_AWAY))
-			enable_slot(slot);
+			enable_slot(slot, false);
 
 		break;
 
@@ -973,7 +974,7 @@ int acpiphp_enable_slot(struct acpiphp_s
 
 	/* configure all functions */
 	if (!(slot->flags & SLOT_ENABLED))
-		enable_slot(slot);
+		enable_slot(slot, false);
 
 	pci_unlock_rescan_remove();
 	return 0;


