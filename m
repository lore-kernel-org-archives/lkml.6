Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeBWI15 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:27:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35761 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeBWI1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:27:30 -0500
Date: Fri, 23 Feb 2018 00:26:05 -0800
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-ac95090a0440be1b17aa1b5d9462d9c67146ce0b@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, jdelvare@suse.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org,
        peterz@infradead.org, hpa@zytor.com, rjw@rjwysocki.net
Reply-To: hpa@zytor.com, peterz@infradead.org, rjw@rjwysocki.net,
        mingo@kernel.org, torvalds@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bhelgaas@google.com, jdelvare@suse.com
In-Reply-To: <20180222125923.57385-4-andriy.shevchenko@linux.intel.com>
References: <20180222125923.57385-4-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] pci: Simplify code by using the new
 dmi_get_bios_year() helper
Git-Commit-ID: ac95090a0440be1b17aa1b5d9462d9c67146ce0b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ac95090a0440be1b17aa1b5d9462d9c67146ce0b
Gitweb:     https://git.kernel.org/tip/ac95090a0440be1b17aa1b5d9462d9c67146ce0b
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Thu, 22 Feb 2018 14:59:23 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:20:31 +0100

pci: Simplify code by using the new dmi_get_bios_year() helper

...instead of open coding its functionality.

No changes in functionality.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Link: http://lkml.kernel.org/r/20180222125923.57385-4-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/pci/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd10d9b0..ae654e21439d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2258,8 +2258,6 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
-	unsigned int year;
-
 	if (!pci_is_pcie(bridge))
 		return false;
 
@@ -2287,10 +2285,8 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		 * It should be safe to put PCIe ports from 2015 or newer
 		 * to D3.
 		 */
-		if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
-		    year >= 2015) {
+		if (dmi_get_bios_year() >= 2015)
 			return true;
-		}
 		break;
 	}
 
