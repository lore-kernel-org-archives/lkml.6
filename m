Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69D9C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAD620C48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAD620C48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeGBPZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:25:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752488AbeGBPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:25:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62FOReW142185
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 11:25:02 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jyp95h502-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:25:02 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 09:25:01 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 09:24:58 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62FOv6S9568582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 08:24:57 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 822EAC6057;
        Mon,  2 Jul 2018 09:24:57 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6BBCC605A;
        Mon,  2 Jul 2018 09:24:56 -0600 (MDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 09:24:56 -0600 (MDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH] ima: Use tpm_default_chip() and call TPM functions with a tpm_chip
Date:   Mon,  2 Jul 2018 11:24:49 -0400
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18070215-0004-0000-0000-0000145D78B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009295; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055513; UDB=6.00541375; IPR=6.00833436;
 MB=3.00021964; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-02 15:25:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070215-0005-0000-0000-000087F18D0C
Message-Id: <20180702152449.3219288-1-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than accessing the TPM functions by passing a NULL pointer for
the tpm_chip, which causes a lookup for a suitable chip every time, get a
hold of a tpm_chip and access the TPM functions using it. Also get rid of
the ima_used_chip variable and use the new ima_tpm_chip variable instead
for determining whether to call TPM functions.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_crypto.c |  4 ++--
 security/integrity/ima/ima_init.c   | 16 +++++-----------
 security/integrity/ima/ima_queue.c  |  4 ++--
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 354bb5716ce3..2ab1affffa36 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -53,9 +53,9 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 extern int ima_policy_flag;
 
 /* set during initialization */
-extern int ima_used_chip;
 extern int ima_hash_algo;
 extern int ima_appraise;
+extern struct tpm_chip *ima_tpm_chip;
 
 /* IMA event related data */
 struct ima_event_data {
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 4e085a17124f..7e7e7e7c250a 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -631,10 +631,10 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 
 static void __init ima_pcrread(int idx, u8 *pcr)
 {
-	if (!ima_used_chip)
+	if (!ima_tpm_chip)
 		return;
 
-	if (tpm_pcr_read(NULL, idx, pcr) != 0)
+	if (tpm_pcr_read(ima_tpm_chip, idx, pcr) != 0)
 		pr_err("Error Communicating to TPM chip\n");
 }
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 29b72cd2502e..faac9ecaa0ae 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -26,7 +26,7 @@
 
 /* name for boot aggregate entry */
 static const char *boot_aggregate_name = "boot_aggregate";
-int ima_used_chip;
+struct tpm_chip *ima_tpm_chip;
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
@@ -64,7 +64,7 @@ static int __init ima_add_boot_aggregate(void)
 	iint->ima_hash->algo = HASH_ALGO_SHA1;
 	iint->ima_hash->length = SHA1_DIGEST_SIZE;
 
-	if (ima_used_chip) {
+	if (ima_tpm_chip) {
 		result = ima_calc_boot_aggregate(&hash.hdr);
 		if (result < 0) {
 			audit_cause = "hashing_error";
@@ -106,17 +106,11 @@ void __init ima_load_x509(void)
 
 int __init ima_init(void)
 {
-	u8 pcr_i[TPM_DIGEST_SIZE];
 	int rc;
 
-	ima_used_chip = 0;
-	rc = tpm_pcr_read(NULL, 0, pcr_i);
-	if (rc == 0)
-		ima_used_chip = 1;
-
-	if (!ima_used_chip)
-		pr_info("No TPM chip found, activating TPM-bypass! (rc=%d)\n",
-			rc);
+	ima_tpm_chip = tpm_default_chip();
+	if (!ima_tpm_chip)
+		pr_info("No TPM chip found, activating TPM-bypass!\n");
 
 	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
 	if (rc)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 418f35e38015..b186819bd5aa 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -142,10 +142,10 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
 {
 	int result = 0;
 
-	if (!ima_used_chip)
+	if (!ima_tpm_chip)
 		return result;
 
-	result = tpm_pcr_extend(NULL, pcr, hash);
+	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
 	if (result != 0)
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
 	return result;
-- 
2.17.1

