Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeEGQIE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:08:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752751AbeEGQH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:07:59 -0400
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v3 2/2] tpm: reduce polling time to usecs for even finer granularity
Date: Mon,  7 May 2018 12:07:33 -0400
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050716-0012-0000-0000-000005D3A46F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050716-0013-0000-0000-00001950AEDB
Message-Id: <20180507160733.8817-3-nayna@linux.vnet.ibm.com>
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

The TPM burstcount and status commands are supposed to return very
quickly [2][3]. This patch further reduces the TPM poll sleep time to usecs
in get_burstcount() and wait_for_tpm_stat() by calling usleep_range()
directly.

After this change, performance on a system[1] with a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~10.7 sec to ~7 sec.

[1] All tests are performed on an x86 based, locked down, single purpose
closed system. It has Infineon TPM 1.2 using LPC Bus.

[2] From the TCG Specification "TCG PC Client Specific TPM Interface
Specification (TIS), Family 1.2":

"NOTE : It takes roughly 330 ns per byte transfer on LPC. 256 bytes would
take 84 us, which is a long time to stall the CPU. Chipsets may not be
designed to post this much data to LPC; therefore, the CPU itself is
stalled for much of this time. Sending 1 kB would take 350 μs. Therefore,
even if the TPM_STS_x.burstCount field is a high value, software SHOULD
be interruptible during this period."

[3] From the TCG Specification 2.0, "TCG PC Client Platform TPM Profile
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
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm.h          | 4 +++-
 drivers/char/tpm/tpm_tis_core.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index ca05828b6981..9824cccb2c76 100644
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
index 493401f5fd39..b77a8dcfb822 100644
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
@@ -228,7 +229,7 @@ static int get_burstcount(struct tpm_chip *chip)
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
