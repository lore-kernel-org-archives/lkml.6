Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbeCFJ3r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:29:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:27812 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753286AbeCFJ2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:28:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="209184773"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 3/5 V2] tpm2: add longer timeouts for creation commands.
Date: Tue,  6 Mar 2018 11:25:01 +0200
Message-Id: <20180306092503.11568-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180306092503.11568-1-tomas.winkler@intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve generation
of crypto keys which can be a computationally intensive task.
The timeout is set to 3min.
Rather than increasing default timeout a new constant is
added, to not stall for too long on regular commands failures.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: add more explanation to the commit message.

 drivers/char/tpm/tpm-interface.c |  3 +++
 drivers/char/tpm/tpm.h           | 28 ++++++++++++++++++----------
 drivers/char/tpm/tpm2-cmd.c      |  8 +++++---
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 402e54252b22..40d1770f6b38 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -421,6 +421,8 @@ int tpm_get_timeouts(struct tpm_chip *chip)
 		    msecs_to_jiffies(TPM2_DURATION_MEDIUM);
 		chip->duration[TPM_LONG] =
 		    msecs_to_jiffies(TPM2_DURATION_LONG);
+		chip->duration[TPM_LONG_LONG] =
+		    msecs_to_jiffies(TPM2_DURATION_LONG_LONG);
 
 		chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
 		return 0;
@@ -509,6 +511,7 @@ int tpm_get_timeouts(struct tpm_chip *chip)
 		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_medium));
 	chip->duration[TPM_LONG] =
 		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_long));
+	chip->duration[TPM_LONG_LONG] = 0; /* not used under 1.2 */
 
 	/* The Broadcom BCM0102 chipset in a Dell Latitude D820 gets the above
 	 * value wrong and apparently reports msecs rather than usecs. So we
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 38197a30ad7b..30610d97d30c 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -67,7 +67,9 @@ enum tpm_duration {
 	TPM_SHORT = 0,
 	TPM_MEDIUM = 1,
 	TPM_LONG = 2,
+	TPM_LONG_LONG = 3,
 	TPM_UNDEFINED,
+	TPM_DURATION_MAX = TPM_UNDEFINED,
 };
 
 #define TPM_WARN_RETRY          0x800
@@ -79,15 +81,20 @@ enum tpm_duration {
 #define TPM_HEADER_SIZE		10
 
 enum tpm2_const {
-	TPM2_PLATFORM_PCR	= 24,
-	TPM2_PCR_SELECT_MIN	= ((TPM2_PLATFORM_PCR + 7) / 8),
-	TPM2_TIMEOUT_A		= 750,
-	TPM2_TIMEOUT_B		= 2000,
-	TPM2_TIMEOUT_C		= 200,
-	TPM2_TIMEOUT_D		= 30,
-	TPM2_DURATION_SHORT	= 20,
-	TPM2_DURATION_MEDIUM	= 750,
-	TPM2_DURATION_LONG	= 2000,
+	TPM2_PLATFORM_PCR       =     24,
+	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
+};
+
+enum tpm2_timeouts {
+	TPM2_TIMEOUT_A          =    750,
+	TPM2_TIMEOUT_B          =   2000,
+	TPM2_TIMEOUT_C          =    200,
+	TPM2_TIMEOUT_D          =     30,
+	TPM2_DURATION_SHORT     =     20,
+	TPM2_DURATION_MEDIUM    =    750,
+	TPM2_DURATION_LONG      =   2000,
+	TPM2_DURATION_LONG_LONG = 300000,
+	TPM2_DURATION_DEFAULT   = 120000,
 };
 
 enum tpm2_structures {
@@ -123,6 +130,7 @@ enum tpm2_algorithms {
 
 enum tpm2_command_codes {
 	TPM2_CC_FIRST		= 0x011F,
+	TPM2_CC_CREATE_PRIMARY  = 0x0131,
 	TPM2_CC_SELF_TEST	= 0x0143,
 	TPM2_CC_STARTUP		= 0x0144,
 	TPM2_CC_SHUTDOWN	= 0x0145,
@@ -227,7 +235,7 @@ struct tpm_chip {
 	unsigned long timeout_c; /* jiffies */
 	unsigned long timeout_d; /* jiffies */
 	bool timeout_adjusted;
-	unsigned long duration[3]; /* jiffies */
+	unsigned long duration[TPM_DURATION_MAX]; /* jiffies */
 	bool duration_adjusted;
 
 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a700f8f9ead7..c1ddbbba406e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -90,6 +90,8 @@ static struct tpm2_hash tpm2_hash_map[] = {
  * of time the chip could take to return the result. The values
  * of the SHORT, MEDIUM, and LONG durations are taken from the
  * PC Client Profile (PTP) specification.
+ * LONG_LONG is for commands that generates keys which empirically
+ * takes longer time on some systems.
  */
 static const u8 tpm2_ordinal_duration[TPM2_CC_LAST - TPM2_CC_FIRST + 1] = {
 	TPM_UNDEFINED,		/* 11F */
@@ -110,7 +112,7 @@ static const u8 tpm2_ordinal_duration[TPM2_CC_LAST - TPM2_CC_FIRST + 1] = {
 	TPM_UNDEFINED,		/* 12e */
 	TPM_UNDEFINED,		/* 12f */
 	TPM_UNDEFINED,		/* 130 */
-	TPM_UNDEFINED,		/* 131 */
+	TPM_LONG_LONG,		/* 131 */
 	TPM_UNDEFINED,		/* 132 */
 	TPM_UNDEFINED,		/* 133 */
 	TPM_UNDEFINED,		/* 134 */
@@ -144,7 +146,7 @@ static const u8 tpm2_ordinal_duration[TPM2_CC_LAST - TPM2_CC_FIRST + 1] = {
 	TPM_UNDEFINED,		/* 150 */
 	TPM_UNDEFINED,		/* 151 */
 	TPM_UNDEFINED,		/* 152 */
-	TPM_UNDEFINED,		/* 153 */
+	TPM_LONG_LONG,		/* 153 */
 	TPM_UNDEFINED,		/* 154 */
 	TPM_UNDEFINED,		/* 155 */
 	TPM_UNDEFINED,		/* 156 */
@@ -821,7 +823,7 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 		duration = chip->duration[index];
 
 	if (duration <= 0)
-		duration = 2 * 60 * HZ;
+		duration = msecs_to_jiffies(TPM2_DURATION_DEFAULT);
 
 	return duration;
 }
-- 
2.14.3
