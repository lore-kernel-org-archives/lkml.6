Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87F8C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CBD20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CBD20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbeGZAqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:46:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731816AbeGZAqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:46:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PNTagv020826
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:16 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kexu6gnp3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:15 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <erichte@linux.vnet.ibm.com>;
        Thu, 26 Jul 2018 00:32:13 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Jul 2018 00:32:10 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PNW9YU22806674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 23:32:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF1FEAE051;
        Thu, 26 Jul 2018 02:32:16 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83034AE045;
        Thu, 26 Jul 2018 02:32:15 +0100 (BST)
Received: from yorha.ibmmodules.com (unknown [9.80.225.100])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jul 2018 02:32:15 +0100 (BST)
From:   Eric Richter <erichte@linux.vnet.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH 2/4] ima: add support for external setting of ima_appraise
Date:   Wed, 25 Jul 2018 18:31:58 -0500
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
References: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072523-0012-0000-0000-0000028ED4F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072523-0013-0000-0000-000020C0BE96
Message-Id: <20180725233200.761-3-erichte@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nayna Jain <nayna@linux.vnet.ibm.com>

The "ima_appraise" mode defaults to enforcing, unless configured to
allow the boot command line "ima_appraise" option. This patch allows
the "ima_appraise" mode to be defined based on the arch setting.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h          |  5 +++++
 security/integrity/ima/ima_appraise.c | 11 +++++++++--
 security/integrity/ima/ima_policy.c   |  5 ++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 588e4813370..6e5fa7c4280 100644
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
index 8bd7a0733e5..e061613bcb8 100644
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
index b47db4d7fea..402e5bd1093 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -573,8 +573,11 @@ void __init ima_init_policy(void)
 	 * (Highest priority)
 	 */
 	arch_policy_entries = ima_init_arch_policy();
-	if (arch_policy_entries > 0)
+	if (arch_policy_entries > 0) {
 		pr_info("Adding %d architecture policy rules.\n", arch_policy_entries);
+		set_ima_appraise("enforce");
+	}
+
 	for (i = 0; i < arch_policy_entries; i++) {
 		struct ima_rule_entry *entry;
 
-- 
2.14.4

