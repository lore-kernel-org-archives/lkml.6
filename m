Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427638AbeCBMjA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:39:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:43762 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422861AbeCBMi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:38:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="21556731"
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
Subject: [PATCH v3 01/18] thunderbolt: Resume control channel after hibernation image is created
Date: Fri,  2 Mar 2018 15:38:35 +0300
Message-Id: <20180302123852.50463-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
References: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver misses implementation of PM hook that undoes what
->freeze_noirq() does after the hibernation image is created. This means
the control channel is not resumed properly and the Thunderbolt bus
becomes useless in later stages of hibernation (when the image is stored
or if the operation fails).

Fix this by pointing ->thaw_noirq to driver nhi_resume_noirq(). This
makes sure the control channel is resumed properly.

Fixes: 23dd5bb49d98 ("thunderbolt: Add suspend/hibernate support")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/nhi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index f45bcbc63738..80c33c7404f5 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1064,6 +1064,7 @@ static const struct dev_pm_ops nhi_pm_ops = {
 					    * we just disable hotplug, the
 					    * pci-tunnels stay alive.
 					    */
+	.thaw_noirq = nhi_resume_noirq,
 	.restore_noirq = nhi_resume_noirq,
 	.suspend = nhi_suspend,
 	.freeze = nhi_suspend,
-- 
2.16.1
