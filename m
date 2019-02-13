Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D93C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B740222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfBMMSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:18:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730329AbfBMMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:18:45 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DCARjo118263
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:18:44 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qmh4xdsar-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:18:43 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 13 Feb 2019 12:18:41 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Feb 2019 12:18:37 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1DCIaGK51249296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 12:18:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C75014C052;
        Wed, 13 Feb 2019 12:18:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AACAF4C044;
        Wed, 13 Feb 2019 12:18:35 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.92.165])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Feb 2019 12:18:35 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2] x86/ima: require signed kernel modules
Date:   Wed, 13 Feb 2019 07:17:59 -0500
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19021312-0008-0000-0000-000002BFF769
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021312-0009-0000-0000-0000222C1572
Message-Id: <1550060279-8624-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Require signed kernel modules on systems with secure boot mode enabled.

Requiring appended kernel module signatures may be configured, enabled
on the boot command line, or with this patch enabled in secure boot
mode.  This patch defines set_module_sig_enforced().

To coordinate between appended kernel module signatures and IMA
signatures, only define an IMA MODULE_CHECK policy rule if
CONFIG_MODULE_SIG is not enabled.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---

Changelog:
- Removed new "sig_required" flag and associated functions, directly set
  sig_enforce.

 arch/x86/kernel/ima_arch.c | 9 ++++++++-
 include/linux/module.h     | 1 +
 kernel/module.c            | 5 +++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index e47cd9390ab4..3fb9847f1cad 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -64,12 +64,19 @@ static const char * const sb_arch_rules[] = {
 	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
 #endif /* CONFIG_KEXEC_VERIFY_SIG */
 	"measure func=KEXEC_KERNEL_CHECK",
+#if !IS_ENABLED(CONFIG_MODULE_SIG)
+	"appraise func=MODULE_CHECK appraise_type=imasig",
+#endif
+	"measure func=MODULE_CHECK",
 	NULL
 };
 
 const char * const *arch_get_ima_policy(void)
 {
-	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot())
+	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
+		if (IS_ENABLED(CONFIG_MODULE_SIG))
+			set_module_sig_enforced();
 		return sb_arch_rules;
+	}
 	return NULL;
 }
diff --git a/include/linux/module.h b/include/linux/module.h
index 8fa38d3e7538..75e2a5c24a2b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -660,6 +660,7 @@ static inline bool is_livepatch_module(struct module *mod)
 #endif /* CONFIG_LIVEPATCH */
 
 bool is_module_sig_enforced(void);
+void set_module_sig_enforced(void);
 
 #else /* !CONFIG_MODULES... */
 
diff --git a/kernel/module.c b/kernel/module.c
index 2ad1b5239910..4cb5b733fb18 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -286,6 +286,11 @@ bool is_module_sig_enforced(void)
 }
 EXPORT_SYMBOL(is_module_sig_enforced);
 
+void set_module_sig_enforced(void)
+{
+       sig_enforce = true;
+}
+
 /* Block module loading/unloading? */
 int modules_disabled = 0;
 core_param(nomodule, modules_disabled, bint, 0);
-- 
2.7.5

