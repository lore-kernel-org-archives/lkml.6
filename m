Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbeDBQVz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:21:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752771AbeDBQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:21:53 -0400
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH] tpm: moves the delay_msec increment after sleep in tpm_transmit() 
Date: Mon,  2 Apr 2018 21:50:06 +0530
X-Mailer: git-send-email 2.13.6
X-TM-AS-GCONF: 00
x-cbid: 18040216-0012-0000-0000-000005C61E58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040216-0013-0000-0000-000019422823
Message-Id: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
handle the TPM2_RC_RETRY error. The loop retries the command after
sleeping for the specified time, which is incremented exponentially in
every iteration. This patch fixes the initial sleep to be the default
sleep time.

Fixes: commit e2fb992d82c6 ("tpm: add retry logic")
Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index c43a9e28995e..6201aab374e6 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -587,7 +587,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		 */
 		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
 			break;
-		delay_msec *= 2;
+
 		if (delay_msec > TPM2_DURATION_LONG) {
 			if (rc == TPM2_RC_RETRY)
 				dev_err(&chip->dev, "in retry loop\n");
@@ -597,6 +597,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 			break;
 		}
 		tpm_msleep(delay_msec);
+		delay_msec *= 2;
 		memcpy(buf, save, save_size);
 	}
 	return ret;
-- 
2.13.6
