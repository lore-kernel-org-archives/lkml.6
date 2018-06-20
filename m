Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9A4C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8022E20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8022E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbeFTUoB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:44:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933391AbeFTUmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:42:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KKeogv075382
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:42:47 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqx5qr2ex-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:42:47 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 14:42:46 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 14:42:44 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KKghRF12714340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 13:42:43 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99E1E6A047;
        Wed, 20 Jun 2018 14:42:43 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19AA46A04D;
        Wed, 20 Jun 2018 14:42:43 -0600 (MDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 14:42:42 -0600 (MDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 3/4] ima: Use tpm_chip_find() and access TPM functions using it
Date:   Wed, 20 Jun 2018 16:42:35 -0400
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062020-8235-0000-0000-00000DC4F8DA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009228; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049869; UDB=6.00537986; IPR=6.00828842;
 MB=3.00021764; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-20 20:42:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062020-8236-0000-0000-00004198F46B
Message-Id: <20180620204236.1572523-4-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than accessing the TPM functions using a NULL pointer, which
causes a lookup for a suitable chip every time, get a hold of a tpm_chip
and access the TPM functions using this chip. We call the tpm_chip
ima_tpm_chip and protect it, once initialization is done, using a
rw_semaphore called ima_tpm_chip_lock.

Use ima_shutdown to release the tpm_chip.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h        |  3 +++
 security/integrity/ima/ima_crypto.c | 12 ++++++++++--
 security/integrity/ima/ima_init.c   | 19 ++++++++++++-------
 security/integrity/ima/ima_queue.c  |  7 +++++--
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 354bb5716ce3..53a88d578ca5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -24,6 +24,7 @@
 #include <linux/hash.h>
 #include <linux/tpm.h>
 #include <linux/audit.h>
+#include <linux/rwsem.h>
 #include <crypto/hash_info.h>
 
 #include "../integrity.h"
@@ -56,6 +57,8 @@ extern int ima_policy_flag;
 extern int ima_used_chip;
 extern int ima_hash_algo;
 extern int ima_appraise;
+extern struct rw_semaphore ima_tpm_chip_lock;
+extern struct tpm_chip *ima_tpm_chip;
 
 /* IMA event related data */
 struct ima_event_data {
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 4e085a17124f..da7715240476 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -631,10 +631,18 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 
 static void __init ima_pcrread(int idx, u8 *pcr)
 {
+	int result = 0;
+
+	down_read(&ima_tpm_chip_lock);
+
 	if (!ima_used_chip)
-		return;
+		goto out;
+
+	result = tpm_pcr_read(ima_tpm_chip, idx, pcr);
+out:
+	up_read(&ima_tpm_chip_lock);
 
-	if (tpm_pcr_read(NULL, idx, pcr) != 0)
+	if (result != 0)
 		pr_err("Error Communicating to TPM chip\n");
 }
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 8a5258eb32b6..24db06c4f463 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -28,6 +28,8 @@
 /* name for boot aggregate entry */
 static const char *boot_aggregate_name = "boot_aggregate";
 int ima_used_chip;
+struct rw_semaphore ima_tpm_chip_lock = __RWSEM_INITIALIZER(ima_tpm_chip_lock);
+struct tpm_chip *ima_tpm_chip;
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
@@ -108,6 +110,13 @@ void __init ima_load_x509(void)
 static int ima_shutdown(struct notifier_block *this, unsigned long action,
 			void *data)
 {
+	down_write(&ima_tpm_chip_lock);
+	if (ima_tpm_chip) {
+		tpm_chip_put(ima_tpm_chip);
+		ima_tpm_chip = NULL;
+		ima_used_chip = 0;
+	}
+	up_write(&ima_tpm_chip_lock);
 	return NOTIFY_DONE;
 }
 
@@ -118,19 +127,15 @@ static struct notifier_block ima_reboot_notifier = {
 
 int __init ima_init(void)
 {
-	u8 pcr_i[TPM_DIGEST_SIZE];
 	int rc;
 
 	register_reboot_notifier(&ima_reboot_notifier);
 
-	ima_used_chip = 0;
-	rc = tpm_pcr_read(NULL, 0, pcr_i);
-	if (rc == 0)
-		ima_used_chip = 1;
+	ima_tpm_chip = tpm_chip_find();
 
+	ima_used_chip = (ima_tpm_chip != NULL);
 	if (!ima_used_chip)
-		pr_info("No TPM chip found, activating TPM-bypass! (rc=%d)\n",
-			rc);
+		pr_info("No TPM chip found, activating TPM-bypass!\n");
 
 	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
 	if (rc)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 418f35e38015..6c9427939a28 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -142,10 +142,13 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
 {
 	int result = 0;
 
+	down_read(&ima_tpm_chip_lock);
 	if (!ima_used_chip)
-		return result;
+		goto out;
 
-	result = tpm_pcr_extend(NULL, pcr, hash);
+	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
+out:
+	up_read(&ima_tpm_chip_lock);
 	if (result != 0)
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
 	return result;
-- 
2.13.6

