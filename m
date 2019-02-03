Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DC0C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5D020821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfBCODl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:03:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52940 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727962AbfBCNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:45 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9X-0003tr-4d; Sun, 03 Feb 2019 13:49:43 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9U-0006px-MS; Sun, 03 Feb 2019 14:49:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Lukas Wunner" <lukas@wunner.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Shaohua Li" <shaohua.li@intel.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.658737906@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 036/305] PCI/ASPM: Fix link_state teardown on device
 removal
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit aeae4f3e5c38d47bdaef50446dc0ec857307df68 upstream.

Upon removal of the last device on a bus, the link_state of the bridge
leading to that bus is sought to be torn down by having pci_stop_dev()
call pcie_aspm_exit_link_state().

When ASPM was originally introduced by commit 7d715a6c1ae5 ("PCI: add
PCI Express ASPM support"), it determined whether the device being
removed is the last one by calling list_empty() on the bridge's
subordinate devices list.  That didn't work because the device is only
removed from the list slightly later in pci_destroy_dev().

Commit 3419c75e15f8 ("PCI: properly clean up ASPM link state on device
remove") attempted to fix it by calling list_is_last(), but that's not
correct either because it checks whether the device is at the *end* of
the list, not whether it's the last one *left* in the list.  If the user
removes the device which happens to be at the end of the list via sysfs
but other devices are preceding the device in the list, the link_state
is torn down prematurely.

The real fix is to move the invocation of pcie_aspm_exit_link_state() to
pci_destroy_dev() and reinstate the call to list_empty().  Remove a
duplicate check for dev->bus->self because pcie_aspm_exit_link_state()
already contains an identical check.

Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shaohua Li <shaohua.li@intel.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pci/pcie/aspm.c | 2 +-
 drivers/pci/remove.c    | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -646,7 +646,7 @@ void pcie_aspm_exit_link_state(struct pc
 	 * All PCIe functions are in one slot, remove one function will remove
 	 * the whole slot, so just wait until we are the last function left.
 	 */
-	if (!list_is_last(&pdev->bus_list, &parent->subordinate->devices))
+	if (!list_empty(&parent->subordinate->devices))
 		goto out;
 
 	link = parent->link_state;
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -25,9 +25,6 @@ static void pci_stop_dev(struct pci_dev
 		device_release_driver(&dev->dev);
 		dev->is_added = 0;
 	}
-
-	if (dev->bus->self)
-		pcie_aspm_exit_link_state(dev);
 }
 
 static void pci_destroy_dev(struct pci_dev *dev)
@@ -41,6 +38,7 @@ static void pci_destroy_dev(struct pci_d
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
+	pcie_aspm_exit_link_state(dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }

