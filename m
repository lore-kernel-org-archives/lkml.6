Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeD3LMu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:12:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:5810 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbeD3LMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:12:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="195508487"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] thunderbolt: Handle NULL boot ACL entries properly
Date: Mon, 30 Apr 2018 14:12:45 +0300
Message-Id: <20180430111245.31072-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the boot ACL entry is already NULL we should not fill in the upper
two DWs with 0xfffffffff. Otherwise they are not shown as empty entries
when the sysfs attribute is read.

Fixes: 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes from v1 (https://lkml.org/lkml/2018/4/27/845):

 * Use || instead of && to make sure UUIDs with only one zero DW
   are still treated as valid.

 drivers/thunderbolt/icm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 2d2ceda9aa26..500911f16498 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1255,7 +1255,7 @@ static int icm_ar_get_boot_acl(struct tb *tb, uuid_t *uuids, size_t nuuids)
 			/* Map empty entries to null UUID */
 			uuid[0] = 0;
 			uuid[1] = 0;
-		} else {
+		} else if (uuid[0] != 0 || uuid[1] != 0) {
 			/* Upper two DWs are always one's */
 			uuid[2] = 0xffffffff;
 			uuid[3] = 0xffffffff;
-- 
2.17.0
