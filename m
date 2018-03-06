Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbeCFJ2n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:28:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:27809 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbeCFJ2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:28:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="209184766"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 2/5 V2] tpm: factor out tpm 1.2 duration calculation to tpm1-cmd.c
Date: Tue,  6 Mar 2018 11:25:00 +0200
Message-Id: <20180306092503.11568-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180306092503.11568-1-tomas.winkler@intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out tpm1.2 commands calculation into tpm1-cmd.c file.
and change the prefix from tpm_ to tpm1_.
No functional change is done here.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: Rebase.

 drivers/char/tpm/Makefile            |   1 +
 drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
 drivers/char/tpm/tpm-interface.c     | 284 +-------------------------------
 drivers/char/tpm/tpm.h               |   2 +-
 drivers/char/tpm/tpm1-cmd.c          | 309 +++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  10 +-
 drivers/char/tpm/tpm_tis_core.c      |   2 +-
 drivers/char/tpm/xen-tpmfront.c      |   2 +-
 8 files changed, 321 insertions(+), 291 deletions(-)
 create mode 100644 drivers/char/tpm/tpm1-cmd.c

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index b2d6ca9e62e4..87f77dfa7fc9 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -9,6 +9,7 @@ tpm-y += tpm-dev-common.o
 tpm-y += tpm-interface.o
 tpm-y += tpmrm-dev.o
 tpm-y += tpm-sysfs.o
+tpm-y += tpm1-cmd.o
 tpm-y += tpm1_eventlog.o
 tpm-y += tpm2-cmd.o
 tpm-y += tpm2_eventlog.o
diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index f95b9c75175b..ad03c99899fa 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -432,7 +432,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
 
 		ret = wait_for_stat(chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-				tpm_calc_ordinal_duration(chip, ordinal),
+				tpm1_calc_ordinal_duration(chip, ordinal),
 				&tpm_dev->read_queue, false);
 		if (ret < 0)
 			goto out_err;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index ddf7d937c77c..402e54252b22 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -33,7 +33,6 @@
 
 #include "tpm.h"
 
-#define TPM_MAX_ORDINAL 243
 #define TSC_MAX_ORDINAL 12
 #define TPM_PROTECTED_COMMAND 0x00
 #define TPM_CONNECTION_COMMAND 0x40
@@ -48,285 +47,6 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
 MODULE_PARM_DESC(suspend_pcr,
 		 "PCR to use for dummy writes to facilitate flush on suspend.");
 
-/*
- * Array with one entry per ordinal defining the maximum amount
- * of time the chip could take to return the result.  The ordinal
- * designation of short, medium or long is defined in a table in
- * TCG Specification TPM Main Part 2 TPM Structures Section 17. The
- * values of the SHORT, MEDIUM, and LONG durations are retrieved
- * from the chip during initialization with a call to tpm_get_timeouts.
- */
-static const u8 tpm_ordinal_duration[TPM_MAX_ORDINAL] = {
-	TPM_UNDEFINED,		/* 0 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 5 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 10 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_LONG,
-	TPM_LONG,
-	TPM_MEDIUM,		/* 15 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_LONG,
-	TPM_SHORT,		/* 20 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_SHORT,		/* 25 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,		/* 30 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 35 */
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 40 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 45 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_LONG,
-	TPM_MEDIUM,		/* 50 */
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 55 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 60 */
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,		/* 65 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 70 */
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 75 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_LONG,		/* 80 */
-	TPM_UNDEFINED,
-	TPM_MEDIUM,
-	TPM_LONG,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 85 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 90 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 95 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 100 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 105 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 110 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 115 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_LONG,		/* 120 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_SHORT,		/* 125 */
-	TPM_SHORT,
-	TPM_LONG,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,		/* 130 */
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,		/* 135 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 140 */
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 145 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 150 */
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 155 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 160 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 165 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_LONG,		/* 170 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 175 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_MEDIUM,		/* 180 */
-	TPM_SHORT,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,		/* 185 */
-	TPM_SHORT,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 190 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 195 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 200 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_SHORT,		/* 205 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_MEDIUM,		/* 210 */
-	TPM_UNDEFINED,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,		/* 215 */
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,
-	TPM_SHORT,		/* 220 */
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_SHORT,
-	TPM_UNDEFINED,		/* 225 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 230 */
-	TPM_LONG,
-	TPM_MEDIUM,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,		/* 235 */
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_UNDEFINED,
-	TPM_SHORT,		/* 240 */
-	TPM_UNDEFINED,
-	TPM_MEDIUM,
-};
-
-/*
- * Returns max number of jiffies to wait
- */
-unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip,
-					   u32 ordinal)
-{
-	int duration_idx = TPM_UNDEFINED;
-	int duration = 0;
-
-	/*
-	 * We only have a duration table for protected commands, where the upper
-	 * 16 bits are 0. For the few other ordinals the fallback will be used.
-	 */
-	if (ordinal < TPM_MAX_ORDINAL)
-		duration_idx = tpm_ordinal_duration[ordinal];
-
-	if (duration_idx != TPM_UNDEFINED)
-		duration = chip->duration[duration_idx];
-	if (duration <= 0)
-		return 2 * 60 * HZ;
-	else
-		return duration;
-}
-EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
-
 static int tpm_validate_command(struct tpm_chip *chip,
 				 struct tpm_space *space,
 				 const u8 *cmd,
@@ -489,7 +209,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		stop = jiffies + tpm2_calc_ordinal_duration(chip, ordinal);
 	else
-		stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
+		stop = jiffies + tpm1_calc_ordinal_duration(chip, ordinal);
 	do {
 		u8 status = chip->ops->status(chip);
 		if ((status & chip->ops->req_complete_mask) ==
@@ -999,7 +719,7 @@ int tpm_do_selftest(struct tpm_chip *chip)
 	unsigned long duration;
 	u8 dummy[TPM_DIGEST_SIZE];
 
-	duration = tpm_calc_ordinal_duration(chip, TPM_ORD_CONTINUE_SELFTEST);
+	duration = tpm1_calc_ordinal_duration(chip, TPM_ORD_CONTINUE_SELFTEST);
 
 	loops = jiffies_to_msecs(duration) / delay_msec;
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index b0ee61e5d414..38197a30ad7b 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -515,7 +515,7 @@ ssize_t tpm_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 int tpm_get_timeouts(struct tpm_chip *);
 int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm_do_selftest(struct tpm_chip *chip);
-unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
+unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
new file mode 100644
index 000000000000..70adcea681cd
--- /dev/null
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -0,0 +1,309 @@
+/*
+ * Copyright (C) 2004 IBM Corporation
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Dave Safford <safford@watson.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ */
+
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/freezer.h>
+#include <linux/tpm_eventlog.h>
+
+#include "tpm.h"
+
+#define TPM_MAX_ORDINAL 243
+
+/*
+ * Array with one entry per ordinal defining the maximum amount
+ * of time the chip could take to return the result.  The ordinal
+ * designation of short, medium or long is defined in a table in
+ * TCG Specification TPM Main Part 2 TPM Structures Section 17. The
+ * values of the SHORT, MEDIUM, and LONG durations are retrieved
+ * from the chip during initialization with a call to tpm_get_timeouts.
+ */
+static const u8 tpm1_ordinal_duration[TPM_MAX_ORDINAL] = {
+	TPM_UNDEFINED,		/* 0 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 5 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 10 */
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_LONG,
+	TPM_LONG,
+	TPM_MEDIUM,		/* 15 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_LONG,
+	TPM_SHORT,		/* 20 */
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_SHORT,		/* 25 */
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_MEDIUM,		/* 30 */
+	TPM_LONG,
+	TPM_MEDIUM,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,		/* 35 */
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_MEDIUM,		/* 40 */
+	TPM_LONG,
+	TPM_MEDIUM,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,		/* 45 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_LONG,
+	TPM_MEDIUM,		/* 50 */
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 55 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_MEDIUM,		/* 60 */
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_MEDIUM,		/* 65 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 70 */
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 75 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_LONG,		/* 80 */
+	TPM_UNDEFINED,
+	TPM_MEDIUM,
+	TPM_LONG,
+	TPM_SHORT,
+	TPM_UNDEFINED,		/* 85 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 90 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,		/* 95 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_MEDIUM,		/* 100 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 105 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 110 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,		/* 115 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_LONG,		/* 120 */
+	TPM_LONG,
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_SHORT,
+	TPM_SHORT,		/* 125 */
+	TPM_SHORT,
+	TPM_LONG,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,		/* 130 */
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_UNDEFINED,		/* 135 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 140 */
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 145 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 150 */
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,		/* 155 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 160 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 165 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_LONG,		/* 170 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 175 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_MEDIUM,		/* 180 */
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_MEDIUM,		/* 185 */
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 190 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 195 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 200 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,
+	TPM_SHORT,		/* 205 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_MEDIUM,		/* 210 */
+	TPM_UNDEFINED,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_UNDEFINED,		/* 215 */
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,
+	TPM_SHORT,		/* 220 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,		/* 225 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 230 */
+	TPM_LONG,
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 235 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 240 */
+	TPM_UNDEFINED,
+	TPM_MEDIUM,
+};
+
+/*
+ * Returns max number of jiffies to wait
+ */
+unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
+{
+	int duration_idx = TPM_UNDEFINED;
+	int duration = 0;
+
+	/*
+	 * We only have a duration table for protected commands, where the upper
+	 * 16 bits are 0. For the few other ordinals the fallback will be used.
+	 */
+	if (ordinal < TPM_MAX_ORDINAL)
+		duration_idx = tpm1_ordinal_duration[ordinal];
+
+	if (duration_idx != TPM_UNDEFINED)
+		duration = chip->duration[duration_idx];
+	if (duration <= 0)
+		return 2 * 60 * HZ;
+	else
+		return duration;
+}
+EXPORT_SYMBOL_GPL(tpm1_calc_ordinal_duration);
+
diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index caa86b19c76d..5d20e98b844f 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -370,6 +370,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	struct i2c_client *client = to_i2c_client(dev);
 	u32 ordinal;
 	size_t count = 0;
+	unsigned long duration;
 	int burst_count, bytes2write, retries, rc = -EIO;
 
 	for (retries = 0; retries < TPM_RETRY; retries++) {
@@ -455,12 +456,11 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		return rc;
 	}
 	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
-	rc = i2c_nuvoton_wait_for_data_avail(chip,
-					     tpm_calc_ordinal_duration(chip,
-								       ordinal),
-					     &priv->read_queue);
+	duration = tpm1_calc_ordinal_duration(chip, ordinal);
+	rc = i2c_nuvoton_wait_for_data_avail(chip, duration, &priv->read_queue);
 	if (rc) {
-		dev_err(dev, "%s() timeout command duration\n", __func__);
+		dev_err(dev, "%s() timeout command duration %ld\n",
+			__func__, duration);
 		i2c_nuvoton_ready(chip);
 		return rc;
 	}
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 5a1f47b43947..222e45a5a762 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -436,7 +436,7 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 		if (chip->flags & TPM_CHIP_FLAG_TPM2)
 			dur = tpm2_calc_ordinal_duration(chip, ordinal);
 		else
-			dur = tpm_calc_ordinal_duration(chip, ordinal);
+			dur = tpm1_calc_ordinal_duration(chip, ordinal);
 
 		if (wait_for_tpm_stat
 		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 911475d36800..c7ded298617d 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -164,7 +164,7 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 	notify_remote_via_evtchn(priv->evtchn);
 
 	ordinal = be32_to_cpu(((struct tpm_input_header*)buf)->ordinal);
-	duration = tpm_calc_ordinal_duration(chip, ordinal);
+	duration = tpm1_calc_ordinal_duration(chip, ordinal);
 
 	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, duration,
 			&priv->read_queue, true) < 0) {
-- 
2.14.3
