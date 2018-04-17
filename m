Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753783AbeDQNNQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:13:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753224AbeDQNNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:13:13 -0400
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] tpm: reduce polling time to usecs for even finer granularity
Date: Tue, 17 Apr 2018 09:12:46 -0400
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20180417131246.434-1-nayna@linux.vnet.ibm.com>
References: <20180417131246.434-1-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041713-0012-0000-0000-000005CBD4FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041713-0013-0000-0000-000019481FCD
Message-Id: <20180417131246.434-3-nayna@linux.vnet.ibm.com>
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

The TPM burstcount and status commands are supposed to return very
quickly [1][2]. This patch further reduces the TPM poll sleep time to usecs
in get_burstcount() and wait_for_tpm_stat() by calling usleep_range()
directly.

After this change, performance on a TPM 1.2 with an 8 byte burstcount for
1000 extends improved from ~10.7 sec to ~7 sec.

[1] From TCG Specification "TCG PC Client Specific TPM Interface
Specification (TIS), Family 1.2":

"NOTE : It takes roughly 330 ns per byte transfer on LPC. 256 bytes would
take 84 us, which is a long time to stall the CPU. Chipsets may not be
designed to post this much data to LPC; therefore, the CPU itself is
stalled for much of this time. Sending 1 kB would take 350 μs. Therefore,
even if the TPM_STS_x.burstCount field is a high value, software SHOULD
be interruptible during this period."

[2] From TCG Specification 2.0, "TCG PC Client Platform TPM Profile
(PTP) Specification":

"It takes roughly 330 ns per byte transfer on LPC. 256 bytes would take
84 us. Chipsets may not be designed to post this much data to LPC;
therefore, the CPU itself is stalled for much of this time. Sending 1 kB
would take 350 us. Therefore, even if the TPM_STS_x.burstCount field is a
high value, software should be interruptible during this period. For SPI,
assuming 20MHz clock and 64-byte transfers, it would take about 120 usec
to move 256B of data. Sending 1kB would take about 500 usec. If the
transactions are done using 4 bytes at a time, then it would take about
1 msec. to transfer 1kB of data."

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm.h          | 4 +++-
 drivers/char/tpm/tpm_tis_core.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7e797377e1eb..f0e4d290c347 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -54,7 +54,9 @@ enum tpm_timeout {
 	TPM_TIMEOUT = 5,	/* msecs */
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
-	TPM_TIMEOUT_POLL = 1	/* msecs */
+	TPM_TIMEOUT_POLL = 1,	/* msecs */
+	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
+	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
 };
 
 /* TPM addresses */
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 021e6b68f2db..5bba5c662423 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -84,7 +84,8 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			tpm_msleep(TPM_TIMEOUT_POLL);
+			usleep_range(TPM_TIMEOUT_USECS_MIN,
+					TPM_TIMEOUT_USECS_MAX);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -226,7 +227,7 @@ static int get_burstcount(struct tpm_chip *chip)
 		burstcnt = (value >> 8) & 0xFFFF;
 		if (burstcnt)
 			return burstcnt;
-		tpm_msleep(TPM_TIMEOUT_POLL);
+		usleep_range(TPM_TIMEOUT_USECS_MIN, TPM_TIMEOUT_USECS_MAX);
 	} while (time_before(jiffies, stop));
 	return -EBUSY;
 }
-- 
2.13.3
