Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeEGQHz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:07:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752751AbeEGQHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:07:51 -0400
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v3 1/2] tpm: reduce poll sleep time in tpm_transmit()
Date: Mon,  7 May 2018 12:07:32 -0400
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050716-0040-0000-0000-000004560696
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050716-0041-0000-0000-000020FA4246
Message-Id: <20180507160733.8817-2-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tpm_try_transmit currently checks TPM status every 5 msecs between
send and recv. It does so in a loop for the maximum timeout as defined
in the TPM Interface Specification. However, the TPM may return before
5 msecs. Thus the polling interval for each iteration can be reduced,
which improves overall performance. This patch changes the polling sleep
time from 5 msecs to 1 msec.

Additionally, this patch renames TPM_POLL_SLEEP to TPM_TIMEOUT_POLL and
moves it to tpm.h as an enum value.

After this change, performance on a system[1] with a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~14 sec to ~10.7 sec.

[1] All tests are performed on an x86 based, locked down, single purpose
closed system. It has Infineon TPM 1.2 using LPC Bus.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-interface.c |  2 +-
 drivers/char/tpm/tpm.h           |  3 ++-
 drivers/char/tpm/tpm_tis_core.c  | 10 ++--------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 6201aab374e6..e32f6e85dc6d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -489,7 +489,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 			goto out;
 		}
 
-		tpm_msleep(TPM_TIMEOUT);
+		tpm_msleep(TPM_TIMEOUT_POLL);
 		rmb();
 	} while (time_before(jiffies, stop));
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index eedcd9cf30bc..ca05828b6981 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -53,7 +53,8 @@ enum tpm_const {
 enum tpm_timeout {
 	TPM_TIMEOUT = 5,	/* msecs */
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
-	TPM_TIMEOUT_RANGE_US = 300	/* usecs */
+	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
+	TPM_TIMEOUT_POLL = 1	/* msecs */
 };
 
 /* TPM addresses */
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 5a1f47b43947..493401f5fd39 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -31,12 +31,6 @@
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
-/* This is a polling delay to check for status and burstcount.
- * As per ddwg input, expectation is that status check and burstcount
- * check should return within few usecs.
- */
-#define TPM_POLL_SLEEP	1  /* msec */
-
 static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
 
 static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
@@ -90,7 +84,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			tpm_msleep(TPM_POLL_SLEEP);
+			tpm_msleep(TPM_TIMEOUT_POLL);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -234,7 +228,7 @@ static int get_burstcount(struct tpm_chip *chip)
 		burstcnt = (value >> 8) & 0xFFFF;
 		if (burstcnt)
 			return burstcnt;
-		tpm_msleep(TPM_POLL_SLEEP);
+		tpm_msleep(TPM_TIMEOUT_POLL);
 	} while (time_before(jiffies, stop));
 	return -EBUSY;
 }
-- 
2.13.3
