Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1110AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6CD21780
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMuJqQVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6CD21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404152AbeKLIXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389887AbeKLIXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:01 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1AA32250E;
        Sun, 11 Nov 2018 22:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975583;
        bh=/rd+IKbkarMCXF+v81Us0V9+IeEe3k1zRTnvT+49ekw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMuJqQVxSCL1XYxPSaJ3ZzAH1EWU736d9L8qodbu/HgXwkHHLNTn/T1InplnGrgQr
         oTLW6IKAcBJow1xbWWYcl7xWIj1oNqOSQtxr6K3v14kSq4uYD0TBbhXJ5yl8s5++Q4
         SYqC2EEyh5SRx5jxDcPt9lMYiYXUC7U/XcFO942o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 4.14 146/222] PCI/ASPM: Fix link_state teardown on device removal
Date:   Sun, 11 Nov 2018 14:24:03 -0800
Message-Id: <20181111221700.497369160@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org # v2.6.26
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pcie/aspm.c |    2 +-
 drivers/pci/remove.c    |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -937,7 +937,7 @@ void pcie_aspm_exit_link_state(struct pc
 	 * All PCIe functions are in one slot, remove one function will remove
 	 * the whole slot, so just wait until we are the last function left.
 	 */
-	if (!list_is_last(&pdev->bus_list, &parent->subordinate->devices))
+	if (!list_empty(&parent->subordinate->devices))
 		goto out;
 
 	link = parent->link_state;
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -24,9 +24,6 @@ static void pci_stop_dev(struct pci_dev
 		pci_remove_sysfs_dev_files(dev);
 		dev->is_added = 0;
 	}
-
-	if (dev->bus->self)
-		pcie_aspm_exit_link_state(dev);
 }
 
 static void pci_destroy_dev(struct pci_dev *dev)
@@ -40,6 +37,7 @@ static void pci_destroy_dev(struct pci_d
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
+	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);


