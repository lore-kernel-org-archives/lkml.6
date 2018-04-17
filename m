Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbeDQNNI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:13:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753731AbeDQNND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:13:03 -0400
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] tpm: reduce poll sleep time in tpm_transmit()
Date: Tue, 17 Apr 2018 09:12:45 -0400
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20180417131246.434-1-nayna@linux.vnet.ibm.com>
References: <20180417131246.434-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041713-0044-0000-0000-00000549323B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041713-0045-0000-0000-00002889408B
Message-Id: <20180417131246.434-2-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170119
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPM polling code in tpm_transmit sleeps in each loop iteration for
5 msecs. However, the TPM might return earlier, and thus waiting for
5 msecs adds an unnecessary delay. This patch reduces the polling sleep
time in tpm_transmit() from 5 msecs to 1 msecs.

Additionally, this patch renames TPM_POLL_SLEEP and moves it to tpm.h as
an enum value.

After this change, performance on a TPM 1.2 with an 8 byte burstcount
for 1000 extends improved from ~14 sec to ~10.7 sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-interface.c |  2 +-
 drivers/char/tpm/tpm.h           |  3 ++-
 drivers/char/tpm/tpm_tis_core.c  | 10 ++--------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 9e80a953d693..a676d8ad5992 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -470,7 +470,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 			goto out;
 		}
 
-		tpm_msleep(TPM_TIMEOUT);
+		tpm_msleep(TPM_TIMEOUT_POLL);
 		rmb();
 	} while (time_before(jiffies, stop));
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f895fba4e20d..7e797377e1eb 100644
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
index da074e3db19b..021e6b68f2db 100644
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
@@ -232,7 +226,7 @@ static int get_burstcount(struct tpm_chip *chip)
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
