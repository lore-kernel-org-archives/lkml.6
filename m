Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427814AbeCBMoR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:44:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:43762 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427595AbeCBMi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:38:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="21556733"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jeremy McNicoll <jmcnicol@redhat.com>,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 02/18] thunderbolt: Serialize PCIe tunnel creation with PCI rescan
Date: Fri,  2 Mar 2018 15:38:36 +0300
Message-Id: <20180302123852.50463-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
References: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to make sure a new PCIe tunnel is not created in a middle of
previous PCI rescan because otherwise the rescan code might find too
much and fail to reconfigure devices properly. This is important when
native PCIe hotplug is used. In BIOS assisted hotplug there should be no
such issue.

Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/switch.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index da54ace4dd2f..1cc79785ce42 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -716,6 +716,13 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 	if (sw->authorized)
 		goto unlock;
 
+	/*
+	 * Make sure there is no PCIe rescan ongoing when a new PCIe
+	 * tunnel is created. Otherwise the PCIe rescan code might find
+	 * the new tunnel too early.
+	 */
+	pci_lock_rescan_remove();
+
 	switch (val) {
 	/* Approve switch */
 	case 1:
@@ -735,6 +742,8 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 		break;
 	}
 
+	pci_unlock_rescan_remove();
+
 	if (!ret) {
 		sw->authorized = val;
 		/* Notify status change to the userspace */
-- 
2.16.1
