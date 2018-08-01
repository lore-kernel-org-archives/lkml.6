Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4255C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D1920844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D1920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406352AbeHATJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:09:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50840 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405274AbeHATJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:09:47 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9DFF5CC9;
        Wed,  1 Aug 2018 17:23:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 223/246] PCI: pciehp: Assume NoCompl+ for Thunderbolt ports
Date:   Wed,  1 Aug 2018 18:52:13 +0200
Message-Id: <20180801165022.375944531@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 493fb50e958c1c6deef7feff0b8c3855def78d75 upstream.

Certain Thunderbolt 1 controllers claim to support Command Completed events
(value of 0b in the No Command Completed Support field of the Slot
Capabilities register) but in reality they neither set the Command
Completed bit in the Slot Status register nor signal a Command Completed
interrupt:

  8086:1513  CV82524  [Light Ridge 4C  2010]
  8086:151a  DSL2310  [Eagle Ridge 2C  2011]
  8086:151b  CVL2510  [Light Peak 2C   2010]
  8086:1547  DSL3510  [Cactus Ridge 4C 2012]
  8086:1548  DSL3310  [Cactus Ridge 2C 2012]
  8086:1549  DSL2210  [Port Ridge 1C   2011]

All known newer chips (Redwood Ridge and onwards) set No Command Completed
Support, indicating that they do not support Command Completed events.

The user-visible impact is that after unplugging such a device, 2 seconds
elapse until pciehp is unbound.  That's because on ->remove,
pcie_write_cmd() is called via pcie_disable_notification() and every call
to pcie_write_cmd() takes 2 seconds (1 second for each invocation of
pcie_wait_cmd()):

  [  337.942727] pciehp 0000:0a:00.0:pcie204: Timeout on hotplug command 0x1038 (issued 21176 msec ago)
  [  340.014735] pciehp 0000:0a:00.0:pcie204: Timeout on hotplug command 0x0000 (issued 2072 msec ago)

That by itself has always been unpleasant, but the situation has become
worse with commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
shutdown"):  Now pciehp is unbound on ->shutdown.  Because Thunderbolt
controllers typically have 4 hotplug ports, every reboot and shutdown is
now delayed by 8 seconds, plus another 2 seconds for every attached
Thunderbolt 1 device.

Thunderbolt hotplug slots are not physical slots that one inserts cards
into, but rather logical hotplug slots implemented in silicon.  Devices
appear beyond those logical slots once a PCI tunnel is established on top
of the Thunderbolt Converged I/O switch.  One would expect commands written
to the Slot Control register to be executed immediately by the silicon, so
for simplicity we always assume NoCompl+ for Thunderbolt ports.

Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org	# v4.12+
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Yehezkel Bernat <yehezkel.bernat@intel.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/hotplug/pciehp_hpc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -863,6 +863,13 @@ struct controller *pcie_init(struct pcie
 	if (pdev->hotplug_user_indicators)
 		slot_cap &= ~(PCI_EXP_SLTCAP_AIP | PCI_EXP_SLTCAP_PIP);
 
+	/*
+	 * We assume no Thunderbolt controllers support Command Complete events,
+	 * but some controllers falsely claim they do.
+	 */
+	if (pdev->is_thunderbolt)
+		slot_cap |= PCI_EXP_SLTCAP_NCCS;
+
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
 	init_waitqueue_head(&ctrl->queue);


