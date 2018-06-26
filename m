Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A77BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535EA26E3F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535EA26E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932228AbeFZTbE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:31:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754968AbeFZTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:30:49 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QJTRMb020920
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:30:49 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2juu0xhkrp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:30:49 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 15:30:47 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 15:30:44 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QJUhn16357248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 19:30:43 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81735AC059;
        Tue, 26 Jun 2018 15:31:53 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67B51AC05B;
        Tue, 26 Jun 2018 15:31:53 -0400 (EDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 15:31:53 -0400 (EDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, jejb@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until module shutdown
Date:   Tue, 26 Jun 2018 15:30:40 -0400
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062619-0060-0000-0000-00000282DB29
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052716; UDB=6.00539697; IPR=6.00830640;
 MB=3.00021867; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 19:30:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062619-0061-0000-0000-00004595A2BF
Message-Id: <20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tpm_default_chip() to find the system's default TPM chip and
use it as the tpm_chip parameter for all TPM operations. Release
the tpm_chip when the module is shut down.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/keys/trusted.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 423776682025..06d863caea43 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -42,6 +42,7 @@ struct sdesc {
 
 static struct crypto_shash *hashalg;
 static struct crypto_shash *hmacalg;
+static struct tpm_chip *tpm_chip;
 
 static struct sdesc *init_sdesc(struct crypto_shash *alg)
 {
@@ -360,7 +361,7 @@ static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 	int rc;
 
 	dump_tpm_buf(cmd);
-	rc = tpm_send(NULL, cmd, buflen);
+	rc = tpm_send(tpm_chip, cmd, buflen);
 	dump_tpm_buf(cmd);
 	if (rc > 0)
 		/* Can't return positive return codes values to keyctl */
@@ -381,10 +382,10 @@ static int pcrlock(const int pcrnum)
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	ret = tpm_get_random(NULL, hash, SHA1_DIGEST_SIZE);
+	ret = tpm_get_random(tpm_chip, hash, SHA1_DIGEST_SIZE);
 	if (ret != SHA1_DIGEST_SIZE)
 		return ret;
-	return tpm_pcr_extend(NULL, pcrnum, hash) ? -EINVAL : 0;
+	return tpm_pcr_extend(tpm_chip, pcrnum, hash) ? -EINVAL : 0;
 }
 
 /*
@@ -397,7 +398,7 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
 	unsigned char ononce[TPM_NONCE_SIZE];
 	int ret;
 
-	ret = tpm_get_random(NULL, ononce, TPM_NONCE_SIZE);
+	ret = tpm_get_random(tpm_chip, ononce, TPM_NONCE_SIZE);
 	if (ret != TPM_NONCE_SIZE)
 		return ret;
 
@@ -492,7 +493,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 	if (ret < 0)
 		goto out;
 
-	ret = tpm_get_random(NULL, td->nonceodd, TPM_NONCE_SIZE);
+	ret = tpm_get_random(tpm_chip, td->nonceodd, TPM_NONCE_SIZE);
 	if (ret != TPM_NONCE_SIZE)
 		goto out;
 	ordinal = htonl(TPM_ORD_SEAL);
@@ -602,7 +603,7 @@ static int tpm_unseal(struct tpm_buf *tb,
 
 	ordinal = htonl(TPM_ORD_UNSEAL);
 	keyhndl = htonl(SRKHANDLE);
-	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
+	ret = tpm_get_random(tpm_chip, nonceodd, TPM_NONCE_SIZE);
 	if (ret != TPM_NONCE_SIZE) {
 		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
 		return ret;
@@ -747,7 +748,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 	int i;
 	int tpm2;
 
-	tpm2 = tpm_is_tpm2(NULL);
+	tpm2 = tpm_is_tpm2(tpm_chip);
 	if (tpm2 < 0)
 		return tpm2;
 
@@ -916,7 +917,7 @@ static struct trusted_key_options *trusted_options_alloc(void)
 	struct trusted_key_options *options;
 	int tpm2;
 
-	tpm2 = tpm_is_tpm2(NULL);
+	tpm2 = tpm_is_tpm2(tpm_chip);
 	if (tpm2 < 0)
 		return NULL;
 
@@ -966,7 +967,7 @@ static int trusted_instantiate(struct key *key,
 	size_t key_len;
 	int tpm2;
 
-	tpm2 = tpm_is_tpm2(NULL);
+	tpm2 = tpm_is_tpm2(tpm_chip);
 	if (tpm2 < 0)
 		return tpm2;
 
@@ -1007,7 +1008,7 @@ static int trusted_instantiate(struct key *key,
 	switch (key_cmd) {
 	case Opt_load:
 		if (tpm2)
-			ret = tpm_unseal_trusted(NULL, payload, options);
+			ret = tpm_unseal_trusted(tpm_chip, payload, options);
 		else
 			ret = key_unseal(payload, options);
 		dump_payload(payload);
@@ -1017,13 +1018,13 @@ static int trusted_instantiate(struct key *key,
 		break;
 	case Opt_new:
 		key_len = payload->key_len;
-		ret = tpm_get_random(NULL, payload->key, key_len);
+		ret = tpm_get_random(tpm_chip, payload->key, key_len);
 		if (ret != key_len) {
 			pr_info("trusted_key: key_create failed (%d)\n", ret);
 			goto out;
 		}
 		if (tpm2)
-			ret = tpm_seal_trusted(NULL, payload, options);
+			ret = tpm_seal_trusted(tpm_chip, payload, options);
 		else
 			ret = key_seal(payload, options);
 		if (ret < 0)
@@ -1226,12 +1227,26 @@ static int __init init_trusted(void)
 		return ret;
 	ret = register_key_type(&key_type_trusted);
 	if (ret < 0)
-		trusted_shash_release();
+		goto exit_shash_release;
+	tpm_chip = tpm_default_chip();
+	if (!tpm_chip) {
+		ret = -ENODEV;
+		goto exit_unregister;
+	}
+	return 0;
+
+exit_unregister:
+	unregister_key_type(&key_type_trusted);
+
+exit_shash_release:
+	trusted_shash_release();
 	return ret;
 }
 
 static void __exit cleanup_trusted(void)
 {
+	if (tpm_chip)
+		tpm_put_chip(tpm_chip);
 	trusted_shash_release();
 	unregister_key_type(&key_type_trusted);
 }
-- 
2.17.1

