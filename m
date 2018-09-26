Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9FEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44412214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44412214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeIZSiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:38:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728185AbeIZSiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:38:17 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QCOihl093708
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:25:32 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mr90qu6bx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:25:32 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 26 Sep 2018 13:25:30 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 13:25:27 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8QCPQvB61800528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 12:25:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE4895204F;
        Wed, 26 Sep 2018 15:25:07 +0100 (BST)
Received: from swastik.in.ibm.com (unknown [9.124.31.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5CFA95204E;
        Wed, 26 Sep 2018 15:25:06 +0100 (BST)
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v4 5/6] ima: add support for external setting of ima_appraise
Date:   Wed, 26 Sep 2018 17:52:09 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
References: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18092612-0016-0000-0000-0000020AD294
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092612-0017-0000-0000-00003261F1D0
Message-Id: <20180926122210.14642-6-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ima_appraise" mode defaults to enforcing, unless configured to allow
the boot command line "ima_appraise" option. This patch explicitly sets the
"ima_appraise" mode for the arch specific policy setting.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h          |  5 +++++
 security/integrity/ima/ima_appraise.c | 11 +++++++++--
 security/integrity/ima/ima_policy.c   |  5 ++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 588e4813370c..6e5fa7c42809 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -248,6 +248,7 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
 				 int xattr_len);
 int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value);
+void set_ima_appraise(char *str);
 
 #else
 static inline int ima_appraise_measurement(enum ima_hooks func,
@@ -290,6 +291,10 @@ static inline int ima_read_xattr(struct dentry *dentry,
 	return 0;
 }
 
+static inline void set_ima_appraise(char *str)
+{
+}
+
 #endif /* CONFIG_IMA_APPRAISE */
 
 /* LSM based policy rules require audit */
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 8bd7a0733e51..e061613bcb87 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -18,15 +18,22 @@
 
 #include "ima.h"
 
-static int __init default_appraise_setup(char *str)
+void set_ima_appraise(char *str)
 {
-#ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 	if (strncmp(str, "off", 3) == 0)
 		ima_appraise = 0;
 	else if (strncmp(str, "log", 3) == 0)
 		ima_appraise = IMA_APPRAISE_LOG;
 	else if (strncmp(str, "fix", 3) == 0)
 		ima_appraise = IMA_APPRAISE_FIX;
+	else if (strncmp(str, "enforce", 7) == 0)
+		ima_appraise = IMA_APPRAISE_ENFORCE;
+}
+
+static int __init default_appraise_setup(char *str)
+{
+#ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
+	set_ima_appraise(str);
 #endif
 	return 1;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5fb4b0c123a3..410fee31b162 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -585,9 +585,12 @@ void __init ima_init_policy(void)
 	arch_entries = ima_init_arch_policy();
 	if (!arch_entries)
 		pr_info("No architecture policies found\n");
-	else
+	else {
 		add_rules(arch_policy_entry, arch_entries,
 			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
+		if (temp_ima_appraise)
+			set_ima_appraise("enforce");
+	}
 
 	/*
 	 * Insert the builtin "secure_boot" policy rules requiring file
-- 
2.13.6

