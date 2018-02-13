Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965235AbeBMRP2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:15:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:40390 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965261AbeBMRAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:00:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="26976067"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 05/18] thunderbolt: Wait a bit longer for root switch config space
Date: Tue, 13 Feb 2018 20:00:05 +0300
Message-Id: <20180213170018.9780-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some case reading root switch config space takes longer than what we
are currently waiting in the driver resulting timeout and failure.
Increase number of retries to allow some more time for the root switch
config space to become accesssible.

Also log an error if the timeout is exceeded so we know why the driver
probe failed.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 182226023acb..1183321586c5 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -828,7 +828,7 @@ __icm_driver_ready(struct tb *tb, enum tb_security_level *security_level)
 	struct icm_pkg_driver_ready request = {
 		.hdr.code = ICM_DRIVER_READY,
 	};
-	unsigned int retries = 10;
+	unsigned int retries = 50;
 	int ret;
 
 	memset(&reply, 0, sizeof(reply));
@@ -856,6 +856,7 @@ __icm_driver_ready(struct tb *tb, enum tb_security_level *security_level)
 		msleep(50);
 	} while (--retries);
 
+	tb_err(tb, "failed to read root switch config space, giving up\n");
 	return -ETIMEDOUT;
 }
 
-- 
2.15.1
