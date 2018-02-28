Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933582AbeB1TS4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:18:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932780AbeB1TSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:18:53 -0500
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH 2/3] tpm: reduce poll sleep time between send() and recv() in tpm_transmit()
Date: Wed, 28 Feb 2018 14:18:27 -0500
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022819-0040-0000-0000-000004191E60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022819-0041-0000-0000-0000261C1F6A
Message-Id: <20180228191828.20056-2-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280234
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tpm_transmit, after send(), the code checks for status in a loop
with polling every 5msec. It is expected that the tpm might return
earlier than 5msec, so it might be adding to unnecessary delay.

This patch reduces the polling sleep time from 5msec to 1msec.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~14sec to ~10.7sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 76df4fbcf089..2d22f981f0c9 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -470,7 +470,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 			goto out;
 		}
 
-		tpm_msleep(TPM_TIMEOUT);
+		tpm_msleep(TPM_TIMEOUT_POLL);
 		rmb();
 	} while (time_before(jiffies, stop));
 
-- 
2.13.3
