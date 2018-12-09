Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B47C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635BB20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635BB20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeLIWQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:16:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37952 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728428AbeLIWNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:13:44 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73O-0002ij-Kd; Sun, 09 Dec 2018 21:55:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003GH-Tq; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Lukas Wunner" <lukas@wunner.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.871357983@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 052/328] PCI: pciehp: Fix unprotected list iteration
 in IRQ handler
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 1204e35bedf4e5015cda559ed8c84789a6dae24e upstream.

Commit b440bde74f04 ("PCI: Add pci_ignore_hotplug() to ignore hotplug
events for a device") iterates over the devices on a hotplug port's
subordinate bus in pciehp's IRQ handler without acquiring pci_bus_sem.
It is thus possible for a user to cause a crash by concurrently
manipulating the device list, e.g. by disabling slot power via sysfs
on a different CPU or by initiating a remove/rescan via sysfs.

This can't be fixed by acquiring pci_bus_sem because it may sleep.
The simplest fix is to avoid the list iteration altogether and just
check the ignore_hotplug flag on the port itself.  This works because
pci_ignore_hotplug() sets the flag both on the device as well as on its
parent bridge.

We do lose the ability to print the name of the device blocking hotplug
in the debug message, but that's probably bearable.

Fixes: b440bde74f04 ("PCI: Add pci_ignore_hotplug() to ignore hotplug events for a device")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
[bwh: Backported to 3.16: s/events/intr_loc/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pci/hotplug/pciehp_hpc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -508,8 +508,6 @@ static irqreturn_t pcie_isr(int irq, voi
 {
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	struct pci_bus *subordinate = pdev->subordinate;
-	struct pci_dev *dev;
 	struct slot *slot = ctrl->slot;
 	u16 detected, intr_loc;
 
@@ -543,14 +541,9 @@ static irqreturn_t pcie_isr(int irq, voi
 		wake_up(&ctrl->queue);
 	}
 
-	if (subordinate) {
-		list_for_each_entry(dev, &subordinate->devices, bus_list) {
-			if (dev->ignore_hotplug) {
-				ctrl_dbg(ctrl, "ignoring hotplug event %#06x (%s requested no hotplug)\n",
-					 intr_loc, pci_name(dev));
-				return IRQ_HANDLED;
-			}
-		}
+	if (pdev->ignore_hotplug) {
+		ctrl_dbg(ctrl, "ignoring hotplug event %#06x\n", intr_loc);
+		return IRQ_HANDLED;
 	}
 
 	if (!(intr_loc & ~PCI_EXP_SLTSTA_CC))

