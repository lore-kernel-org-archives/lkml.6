Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF4BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8444825CDF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8444825CDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbeFZRYe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:24:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753166AbeFZRXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:23:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QHIkvd125895
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:23:44 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jurm43m6c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:23:43 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 11:23:43 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 11:23:39 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QHNcWg20644318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 10:23:38 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACA537805F;
        Tue, 26 Jun 2018 11:23:38 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 367B178068;
        Tue, 26 Jun 2018 11:23:38 -0600 (MDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 11:23:38 -0600 (MDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v6 2/5] tpm: Implement tpm_default_chip() to find a TPM chip
Date:   Tue, 26 Jun 2018 13:23:28 -0400
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626172331.2505541-1-stefanb@linux.vnet.ibm.com>
References: <20180626172331.2505541-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0036-0000-0000-00000A03E0AB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052673; UDB=6.00539671; IPR=6.00830598;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:23:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0037-0000-0000-000047E00320
Message-Id: <20180626172331.2505541-3-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=816 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement tpm_default_chip() to find the first TPM chip and return it to
the caller while increasing the reference count on its device. This
function can be used by other subsystems, such as IMA, to find the system's
default TPM chip and use it for all subsequent TPM operations.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-chip.c | 27 +++++++++++++++++++++++++++
 include/linux/tpm.h         |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 242b716aed5e..f551061262c9 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -80,6 +80,33 @@ void tpm_put_ops(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm_put_ops);
 
+/**
+ * tpm_default_chip() - find a TPM chip and get a reference to it
+ */
+struct tpm_chip *tpm_default_chip(void)
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
+			get_device(&chip->dev);
+			res = chip;
+			break;
+		}
+	} while (chip_prev != chip_num);
+
+	mutex_unlock(&idr_lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(tpm_default_chip);
+
 /**
  * tpm_find_get_ops() - find and reserve a TPM chip
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 06639fb6ab85..e0e51c49a0e6 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -61,6 +61,7 @@ extern int tpm_seal_trusted(struct tpm_chip *chip,
 extern int tpm_unseal_trusted(struct tpm_chip *chip,
 			      struct trusted_key_payload *payload,
 			      struct trusted_key_options *options);
+extern struct tpm_chip *tpm_default_chip(void);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
@@ -96,5 +97,9 @@ static inline int tpm_unseal_trusted(struct tpm_chip *chip,
 {
 	return -ENODEV;
 }
+static inline struct tpm_chip *tpm_default_chip(void)
+{
+	return NULL;
+}
 #endif
 #endif
-- 
2.17.1

