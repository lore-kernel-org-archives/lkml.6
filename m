Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC18C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED3E24603
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED3E24603
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934538AbeFVQq3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:46:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934494AbeFVQqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:46:25 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MGi6Ef139417
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:46:24 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2js3py345c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:46:24 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 12:46:23 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 12:46:20 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MGkJuD8978810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 16:46:19 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27BD711206B;
        Fri, 22 Jun 2018 12:46:16 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10817112065;
        Fri, 22 Jun 2018 12:46:16 -0400 (EDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 12:46:16 -0400 (EDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v3 4/4] ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead
Date:   Fri, 22 Jun 2018 12:46:13 -0400
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
References: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062216-0060-0000-0000-000002813EFE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009240; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050751; UDB=6.00538515; IPR=6.00829721;
 MB=3.00021808; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 16:46:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062216-0061-0000-0000-0000458A6181
Message-Id: <20180622164613.1609313-5-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of ima_used_chip and use ima_tpm_chip variable instead for
determining whether to use the TPM chip.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
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
index ae3a853e0049..4c63e1e030f5 100644
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
 
 	ima_tpm_chip = tpm_chip_find();
-
-	ima_used_chip = (ima_tpm_chip != NULL);
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
2.13.6

