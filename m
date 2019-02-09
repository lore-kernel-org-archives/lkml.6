Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A7C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2AE20823
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBIJSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:18:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726047AbfBIJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 04:17:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x199DmpR120832
        for <linux-kernel@vger.kernel.org>; Sat, 9 Feb 2019 04:17:58 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qhsfcdmmq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 04:17:57 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Sat, 9 Feb 2019 09:17:56 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 9 Feb 2019 09:17:52 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x199HpMp42860602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 9 Feb 2019 09:17:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9934852050;
        Sat,  9 Feb 2019 09:17:51 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.85.75.223])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B44695204E;
        Sat,  9 Feb 2019 09:17:49 +0000 (GMT)
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To:     live-patching@vger.kernel.org
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] livepatch: Enforce reliable stack trace as config dependency
Date:   Sat,  9 Feb 2019 14:47:28 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020909-0028-0000-0000-000003468183
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020909-0029-0000-0000-00002404982A
Message-Id: <20190209091728.23046-1-kamalesh@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-09_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902090068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the consistency model was introduced, architectures without the
reliable stack trace implementation could use the immediate flag for
livepatching but with its own limitations.

After removal of the immediate flag by commit d0807da78e11
("livepatch: Remove immediate feature"), reliable stack trace became
enforcing dependency for livepatch support on any architecture. In
the current code, we ensure that the dependency is met when
enabling the patch during the module load.

This dependency check can be improved by moving it to the Kconfig,
which disables the support for livepatching in the kernel for unmet
dependencies. This patch moves both HAVE_RELIABLE_STACKTRACE and
STACKTRACE under config LIVEPATCH, it also removes the
klp_have_reliable_stack() function.

Loading a livepatching module on an architecture where reliable
stack trace is yet to be implemented, the user should see:

insmod: ERROR: could not insert module ./livepatch-sample.ko: Invalid module format

...
[  286.453463] livepatch_sample: module is marked as livepatch module, but livepatch support is disabled

[pmladek@suse.com: Suggested to explicitly add CONFIG_STACKTRACE under
 config LIVEPATCH]
Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>
---
Patch is based on a087cdd4073b (origin/for-5.1/atomic-replace) branch

 include/linux/livepatch.h | 6 ------
 kernel/livepatch/Kconfig  | 2 ++
 kernel/livepatch/core.c   | 6 ------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 53551f470722..7848c7bbffbb 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -214,12 +214,6 @@ static inline bool klp_patch_pending(struct task_struct *task)
 	return test_tsk_thread_flag(task, TIF_PATCH_PENDING);
 }
 
-static inline bool klp_have_reliable_stack(void)
-{
-	return IS_ENABLED(CONFIG_STACKTRACE) &&
-	       IS_ENABLED(CONFIG_HAVE_RELIABLE_STACKTRACE);
-}
-
 typedef int (*klp_shadow_ctor_t)(void *obj,
 				 void *shadow_data,
 				 void *ctor_data);
diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
index ec4565122e65..4e4e4fe040f5 100644
--- a/kernel/livepatch/Kconfig
+++ b/kernel/livepatch/Kconfig
@@ -10,6 +10,8 @@ config LIVEPATCH
 	depends on SYSFS
 	depends on KALLSYMS_ALL
 	depends on HAVE_LIVEPATCH
+	depends on STACKTRACE
+	depends on HAVE_RELIABLE_STACKTRACE
 	depends on !TRIM_UNUSED_KSYMS
 	help
 	  Say Y here if you want to support kernel live patching.
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index d1af69e9f0e3..a7a00478f6c3 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1034,12 +1034,6 @@ int klp_enable_patch(struct klp_patch *patch)
 	if (!klp_initialized())
 		return -ENODEV;
 
-	if (!klp_have_reliable_stack()) {
-		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
-		return -EOPNOTSUPP;
-	}
-
-
 	mutex_lock(&klp_mutex);
 
 	ret = klp_init_patch_early(patch);
-- 
2.20.1

