Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E20C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C901C2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C901C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbeKLGGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:06:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53230 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730491AbeKLGGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:06:20 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt4-0000oJ-EF; Sun, 11 Nov 2018 19:59:14 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001Vw-6C; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Bjorn Helgaas" <bhelgaas@google.com>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.10961504@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 113/366] PCI: shpchp: Fix AMD POGO identification
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>

commit bed4e9cfab93a0f3d0144cb919820e6d5c40b8b1 upstream.

The fix for an AMD POGO erratum related to SHPC incorrectly identified the
device.  The workaround should be applied only for AMD POGO devices, but it
was instead applied to:

  - all AMD bridges, and
  - all devices from any vendor with device ID 0x7458

Fixes: 53044f357448 ("[PATCH] PCI Hotplug: shpchp: AMD POGO errata fix")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pci/hotplug/shpchp_ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -595,13 +595,13 @@ static int shpchp_enable_slot (struct sl
 	ctrl_dbg(ctrl, "%s: p_slot->pwr_save %x\n", __func__, p_slot->pwr_save);
 	p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 
-	if(((p_slot->ctrl->pci_dev->vendor == PCI_VENDOR_ID_AMD) ||
-	    (p_slot->ctrl->pci_dev->device == PCI_DEVICE_ID_AMD_POGO_7458))
+	if ((p_slot->ctrl->pci_dev->vendor == PCI_VENDOR_ID_AMD &&
+	     p_slot->ctrl->pci_dev->device == PCI_DEVICE_ID_AMD_POGO_7458)
 	     && p_slot->ctrl->num_slots == 1) {
-		/* handle amd pogo errata; this must be done before enable  */
+		/* handle AMD POGO errata; this must be done before enable  */
 		amd_pogo_errata_save_misc_reg(p_slot);
 		retval = board_added(p_slot);
-		/* handle amd pogo errata; this must be done after enable  */
+		/* handle AMD POGO errata; this must be done after enable  */
 		amd_pogo_errata_restore_misc_reg(p_slot);
 	} else
 		retval = board_added(p_slot);

