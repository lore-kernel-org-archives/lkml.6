Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18B0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A156526E2B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A156526E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754887AbeFZTJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:09:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752034AbeFZTJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:09:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QJ8Y1t051945
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:09:50 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jutw9h9kb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:09:50 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:09:49 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:09:45 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QJ9iQ37995664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 12:09:44 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A09986A05F;
        Tue, 26 Jun 2018 13:09:44 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EDBB6A054;
        Tue, 26 Jun 2018 13:09:44 -0600 (MDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:09:43 -0600 (MDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v7 5/5] ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead
Date:   Tue, 26 Jun 2018 15:09:33 -0400
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
References: <20180626190933.2508821-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062619-0036-0000-0000-00000A03E90E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052709; UDB=6.00539692; IPR=6.00830633;
 MB=3.00021866; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 19:09:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062619-0037-0000-0000-000047E03972
Message-Id: <20180626190933.2508821-6-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of ima_used_chip and use ima_tpm_chip variable instead for
determining whether to use the TPM chip.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 security/integrity/ima/ima.h        | 1 -
 security/integrity/ima/ima_crypto.c | 2 +-
 security/integrity/ima/ima_init.c   | 7 ++-----
 security/integrity/ima/ima_queue.c  | 2 +-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 35409461a3f2..2ab1affffa36 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -53,7 +53,6 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 extern int ima_policy_flag;
 
 /* set during initialization */
-extern int ima_used_chip;
 extern int ima_hash_algo;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 88082f35adb2..7e7e7e7c250a 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -631,7 +631,7 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 
 static void __init ima_pcrread(int idx, u8 *pcr)
 {
-	if (!ima_used_chip)
+	if (!ima_tpm_chip)
 		return;
 
 	if (tpm_pcr_read(ima_tpm_chip, idx, pcr) != 0)
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 1437ed3dbccc..faac9ecaa0ae 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -26,7 +26,6 @@
 
 /* name for boot aggregate entry */
 static const char *boot_aggregate_name = "boot_aggregate";
-int ima_used_chip;
 struct tpm_chip *ima_tpm_chip;
 
 /* Add the boot aggregate to the IMA measurement list and extend
@@ -65,7 +64,7 @@ static int __init ima_add_boot_aggregate(void)
 	iint->ima_hash->algo = HASH_ALGO_SHA1;
 	iint->ima_hash->length = SHA1_DIGEST_SIZE;
 
-	if (ima_used_chip) {
+	if (ima_tpm_chip) {
 		result = ima_calc_boot_aggregate(&hash.hdr);
 		if (result < 0) {
 			audit_cause = "hashing_error";
@@ -110,9 +109,7 @@ int __init ima_init(void)
 	int rc;
 
 	ima_tpm_chip = tpm_default_chip();
-
-	ima_used_chip = ima_tpm_chip != NULL;
-	if (!ima_used_chip)
+	if (!ima_tpm_chip)
 		pr_info("No TPM chip found, activating TPM-bypass!\n");
 
 	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index c6303fa19a49..b186819bd5aa 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -142,7 +142,7 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
 {
 	int result = 0;
 
-	if (!ima_used_chip)
+	if (!ima_tpm_chip)
 		return result;
 
 	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
-- 
2.17.1

