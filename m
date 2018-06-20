Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0514AC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879092083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879092083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeFTQUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:20:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754427AbeFTQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:20:03 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGEKDr098529
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:20:03 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqs39ks4w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:20:03 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 10:20:02 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 10:19:59 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KGJwYr18678258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 09:19:59 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD1EDC6059;
        Wed, 20 Jun 2018 10:19:58 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4957DC605A;
        Wed, 20 Jun 2018 10:19:58 -0600 (MDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 10:19:58 -0600 (MDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 3/6] tpm: Implement tpm_chip_find() for other subsystems to call
Date:   Wed, 20 Jun 2018 12:19:45 -0400
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
References: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062016-0036-0000-0000-00000A017595
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009227; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049782; UDB=6.00537934; IPR=6.00828754;
 MB=3.00021761; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-20 16:20:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062016-0037-0000-0000-000047CF0B6C
Message-Id: <20180620161948.1464255-4-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement tpm_chip_find() for other subsystems to find a TPM chip and
get a reference to that chip. Once done with using the chip, the reference
is released using tpm_chip_put().

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-chip.c | 27 +++++++++++++++++++++++++++
 include/linux/tpm.h         |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 23b667c730f6..b04064291dab 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -84,6 +84,33 @@ void tpm_put_ops(struct tpm_chip *chip)
 EXPORT_SYMBOL_GPL(tpm_put_ops);
 
 /**
+ * tpm_chip_find() - find a TPM chip and get a reference to it
+ */
+struct tpm_chip *tpm_chip_find(void)
+{
+	struct tpm_chip *chip, *res = NULL;
+	int chip_num = 0;
+	int chip_prev;
+
+	mutex_lock(&idr_lock);
+
+	do {
+		chip_prev = chip_num;
+		chip = idr_get_next(&dev_nums_idr, &chip_num);
+		if (chip) {
+			kref_get(&chip->kref);
+			res = chip;
+			break;
+		}
+	} while (chip_prev != chip_num);
+
+	mutex_unlock(&idr_lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_find);
+
+/**
  * tpm_chip_find_get() - find and reserve a TPM chip
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
  *
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index cdb3ecdfc933..f0d1abcaf4af 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -61,6 +61,7 @@ extern int tpm_seal_trusted(struct tpm_chip *chip,
 extern int tpm_unseal_trusted(struct tpm_chip *chip,
 			      struct trusted_key_payload *payload,
 			      struct trusted_key_options *options);
+extern struct tpm_chip *tpm_chip_find(void);
 extern void tpm_chip_put(struct tpm_chip *chip);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
@@ -97,6 +98,10 @@ static inline int tpm_unseal_trusted(struct tpm_chip *chip,
 {
 	return -ENODEV;
 }
+static inline struct tpm_chip *tpm_chip_find(void)
+{
+	return NULL;
+}
 static inline void tpm_chip_put(struct tpm_chip *chip)
 {
 }
-- 
2.13.6

