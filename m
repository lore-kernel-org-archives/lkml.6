Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5506DC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1900C20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1900C20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbeHWLqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:46:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHWLqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:46:20 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4EC86C83;
        Thu, 23 Aug 2018 08:17:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.9 128/130] PCI: pciehp: Fix unprotected list iteration in IRQ handler
Date:   Thu, 23 Aug 2018 09:54:04 +0200
Message-Id: <20180823074935.211345645@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/pciehp_hpc.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -562,8 +562,6 @@ static irqreturn_t pciehp_isr(int irq, v
 {
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	struct pci_bus *subordinate = pdev->subordinate;
-	struct pci_dev *dev;
 	struct slot *slot = ctrl->slot;
 	u16 status, events;
 	u8 present;
@@ -611,14 +609,9 @@ static irqreturn_t pciehp_isr(int irq, v
 		wake_up(&ctrl->queue);
 	}
 
-	if (subordinate) {
-		list_for_each_entry(dev, &subordinate->devices, bus_list) {
-			if (dev->ignore_hotplug) {
-				ctrl_dbg(ctrl, "ignoring hotplug event %#06x (%s requested no hotplug)\n",
-					 events, pci_name(dev));
-				return IRQ_HANDLED;
-			}
-		}
+	if (pdev->ignore_hotplug) {
+		ctrl_dbg(ctrl, "ignoring hotplug event %#06x\n", events);
+		return IRQ_HANDLED;
 	}
 
 	/* Check Attention Button Pressed */


