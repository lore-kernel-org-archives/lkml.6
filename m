Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946504AbeCBMjM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:39:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:43766 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427642AbeCBMjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:39:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="35407838"
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
Subject: [PATCH v3 06/18] thunderbolt: Wait a bit longer for ICM to authenticate the active NVM
Date: Fri,  2 Mar 2018 15:38:40 +0300
Message-Id: <20180302123852.50463-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
References: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes during cold boot ICM has not yet authenticated the active NVM
image leading to timeout and failing the driver probe. Allow ICM to take
some more time and increase the timeout to 3 seconds before we give up.

While there fix icm_firmware_init() to return the real error code
without overwriting it with -ENODEV.

Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/icm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 1183321586c5..611d28e8e5f2 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -736,14 +736,14 @@ static bool icm_ar_is_supported(struct tb *tb)
 static int icm_ar_get_mode(struct tb *tb)
 {
 	struct tb_nhi *nhi = tb->nhi;
-	int retries = 5;
+	int retries = 60;
 	u32 val;
 
 	do {
 		val = ioread32(nhi->iobase + REG_FW_STS);
 		if (val & REG_FW_STS_NVM_AUTH_DONE)
 			break;
-		msleep(30);
+		msleep(50);
 	} while (--retries);
 
 	if (!retries) {
@@ -1063,6 +1063,9 @@ static int icm_firmware_init(struct tb *tb)
 			break;
 
 		default:
+			if (ret < 0)
+				return ret;
+
 			tb_err(tb, "ICM firmware is in wrong mode: %u\n", ret);
 			return -ENODEV;
 		}
-- 
2.16.1
