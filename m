Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbeB1TTW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:19:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933606AbeB1TTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:19:14 -0500
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/3] tpm: tpm_msleep() with finer granularity improves performance
Date: Wed, 28 Feb 2018 14:18:28 -0500
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022819-0016-0000-0000-0000052B1E78
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022819-0017-0000-0000-000028681FA3
Message-Id: <20180228191828.20056-3-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280235
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'commit 9f3fc7bcddcb ("tpm: replace msleep() with  usleep_range()
in TPM 1.2/2.0 generic drivers")' was upstreamed, it replaced the
msleep() calls with usleep_range(), but did not change the
granularity of the calls. They're still defined in terms of msec.
Test results show that refining the granularity further improves
the performance. We're posting this patch as an RFC to show that there
needs to be another function which allows finer granularity.

After this change, performance on a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~10.7sec to ~6.9sec.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7e797377e1eb..8cad6bfc5f46 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -522,8 +522,7 @@ int tpm_pm_resume(struct device *dev);
 
 static inline void tpm_msleep(unsigned int delay_msec)
 {
-	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
-		     delay_msec * 1000);
+	usleep_range((delay_msec * 1000) / 10, (delay_msec * 1000) / 2);
 };
 
 struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip);
-- 
2.13.3
