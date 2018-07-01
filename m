Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB00C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8206A25529
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8206A25529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753700AbeGARBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:01:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37842 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032358AbeGAQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:43:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB772AA6;
        Sun,  1 Jul 2018 16:43:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.17 116/220] PCI: Account for all bridges on bus when distributing bus numbers
Date:   Sun,  1 Jul 2018 18:22:20 +0200
Message-Id: <20180701160913.209172943@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 3374c545c27c5350b954d1ab03c880d5502e5eba upstream.

When distributing extra bus number space to hotplug bridges for future
extension, we don't account for the fact that there might be non-hotplug
bridges on the bus after the hotplug bridges.  For example:

  01:00.0 --+- 02:00.0 (HotPlug-) -- Thunderbolt host controller
            +- 02:01.0 (HotPlug+)
            \- 02:02.0 (HotPlug-) -- xHCI host controller

pci_scan_child_bus_extend() is supposed to distribute the remaining bus
numbers to the hotplug bridge at 02:01.0, but only after accounting for all
bridges on bus 02.  Since we don't check whether there's another
non-hotplug bridge after the hotplug bridge 02:01.0, it may not leave space
for the non-hotplug bridge:

  pci 0000:00:1b.0: PCI bridge to [bus 01-39]  (Root Port)
  pci 0000:01:00.0: PCI bridge to [bus 02-39]
  ...
  pci 0000:02:00.0: PCI bridge to [bus 03]
  pci 0000:02:01.0: PCI bridge to [bus 04]
  pci_bus 0000:04: [bus 04-39] extended by 0x35
  pci_bus 0000:04: bus scan returning with max=39
  pci_bus 0000:04: busn_res: [bus 04-39] end is updated to 39
  pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1
  pci_bus 0000:3a: scanning bus
  pci_bus 0000:3a: bus scan returning with max=3a
  pci_bus 0000:3a: busn_res: [bus 3a] end is updated to 3a
  pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:02 [bus 02-39]
  pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:01 [bus 01-39]
  pci_bus 0000:02: bus scan returning with max=3a
  pci_bus 0000:02: busn_res: [bus 02-39] end can not be updated to 3a

The resulting 'lspci -t' output looks like this:

  +-1b.0-[01-39]----00.0-[02-3a]--+-00.0-[03]----00.0
                             ^^   +-01.0-[04-39]--
                                  \-02.0-[3a]----00.0
                                          ^^
The xHCI host controller behind 02:02.0 is not usable because it would have
to be assigned bus 3a, which is not accessible through 00:1b.0.

To fix this, reserve at least one bus for each bridge while scanning
already configured bridges.  Then use this information in the second
scan to correct the available extra bus space for hotplug bridges.

After this change the 'lspci -t' output is what is expected:

  +-1b.0-[01-39]----00.0-[02-39]--+-00.0-[03]----00.0
                                  +-01.0-[04-38]--
                                  \-02.0-[39]----00.0

The xHCI controller is now on bus 39, where it is usable.

Fixes: 1c02ea810065 ("PCI: Distribute available buses to hotplug-capable bridges")
Reported-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/probe.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2638,7 +2638,14 @@ static unsigned int pci_scan_child_bus_e
 	for_each_pci_bridge(dev, bus) {
 		cmax = max;
 		max = pci_scan_bridge_extend(bus, dev, max, 0, 0);
-		used_buses += cmax - max;
+
+		/*
+		 * Reserve one bus for each bridge now to avoid extending
+		 * hotplug bridges too much during the second scan below.
+		 */
+		used_buses++;
+		if (cmax - max > 1)
+			used_buses += cmax - max - 1;
 	}
 
 	/* Scan bridges that need to be reconfigured */
@@ -2661,12 +2668,14 @@ static unsigned int pci_scan_child_bus_e
 			 * bridges if any.
 			 */
 			buses = available_buses / hotplug_bridges;
-			buses = min(buses, available_buses - used_buses);
+			buses = min(buses, available_buses - used_buses + 1);
 		}
 
 		cmax = max;
 		max = pci_scan_bridge_extend(bus, dev, cmax, buses, 1);
-		used_buses += max - cmax;
+		/* One bus is already accounted so don't add it again */
+		if (max - cmax > 1)
+			used_buses += max - cmax - 1;
 	}
 
 	/*


