Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51405C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FF021533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FF021533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeI0Ctg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:49:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:12173 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbeI0Ctf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:49:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 13:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="93990998"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.251.154.97])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2018 13:34:49 -0700
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH v5 5/5] sidechannel: Linux Security Module for sidechannel
Date:   Wed, 26 Sep 2018 13:34:46 -0700
Message-Id: <20180926203446.2004-6-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180926203446.2004-1-casey.schaufler@intel.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>

This is a new Linux Security Module (LSM) that checks for
potential sidechannel issues that are not covered in the
ptrace PTRACE_MODE_SCHED option. Namespace differences are
checked in this intitial version. Additional checks should
be added when they are determined to be useful.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 include/linux/lsm_hooks.h          |  5 ++
 security/Kconfig                   |  1 +
 security/Makefile                  |  2 +
 security/security.c                |  1 +
 security/sidechannel/Kconfig       | 13 +++++
 security/sidechannel/Makefile      |  1 +
 security/sidechannel/sidechannel.c | 88 ++++++++++++++++++++++++++++++
 7 files changed, 111 insertions(+)
 create mode 100644 security/sidechannel/Kconfig
 create mode 100644 security/sidechannel/Makefile
 create mode 100644 security/sidechannel/sidechannel.c

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 97a020c616ad..3cb6516dba3c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2081,5 +2081,10 @@ void __init loadpin_add_hooks(void);
 #else
 static inline void loadpin_add_hooks(void) { };
 #endif
+#ifdef CONFIG_SECURITY_SIDECHANNEL
+void __init sidechannel_add_hooks(void);
+#else
+static inline void sidechannel_add_hooks(void) { };
+#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index d9aa521b5206..6b814a3f93ea 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -236,6 +236,7 @@ source security/tomoyo/Kconfig
 source security/apparmor/Kconfig
 source security/loadpin/Kconfig
 source security/yama/Kconfig
+source security/sidechannel/Kconfig
 
 source security/integrity/Kconfig
 
diff --git a/security/Makefile b/security/Makefile
index 4d2d3782ddef..d0c9e1b227f9 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -10,6 +10,7 @@ subdir-$(CONFIG_SECURITY_TOMOYO)        += tomoyo
 subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
 subdir-$(CONFIG_SECURITY_YAMA)		+= yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
+subdir-$(CONFIG_SECURITY_SIDECHANNEL)	+= sidechannel
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -25,6 +26,7 @@ obj-$(CONFIG_SECURITY_TOMOYO)		+= tomoyo/
 obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
+obj-$(CONFIG_SECURITY_SIDECHANNEL)	+= sidechannel/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 
 # Object integrity file lists
diff --git a/security/security.c b/security/security.c
index 736e78da1ab9..2129b0e31d7b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -83,6 +83,7 @@ int __init security_init(void)
 	capability_add_hooks();
 	yama_add_hooks();
 	loadpin_add_hooks();
+	sidechannel_add_hooks();
 
 	/*
 	 * Load all the remaining security modules.
diff --git a/security/sidechannel/Kconfig b/security/sidechannel/Kconfig
new file mode 100644
index 000000000000..653033027415
--- /dev/null
+++ b/security/sidechannel/Kconfig
@@ -0,0 +1,13 @@
+config SECURITY_SIDECHANNEL
+	bool "Sidechannel attack safety extra checks"
+	depends on SECURITY
+	default n
+	help
+	  Look for a variety of cases where a side-channel attack
+	  could potentially be exploited. Instruct the switching
+	  code to use the indirect_branch_prediction_barrier in
+	  cases where the passed task and the current task may be
+	  at risk.
+
+          If you are unsure how to answer this question, answer N.
+
diff --git a/security/sidechannel/Makefile b/security/sidechannel/Makefile
new file mode 100644
index 000000000000..f61d83f28035
--- /dev/null
+++ b/security/sidechannel/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SECURITY_SIDECHANNEL) += sidechannel.o
diff --git a/security/sidechannel/sidechannel.c b/security/sidechannel/sidechannel.c
new file mode 100644
index 000000000000..18a67d19c020
--- /dev/null
+++ b/security/sidechannel/sidechannel.c
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Side Channel Safety Security Module
+ *
+ * Copyright (C) 2018 Intel Corporation.
+ *
+ */
+
+#define pr_fmt(fmt) "SideChannel: " fmt
+
+#include <linux/types.h>
+#include <linux/lsm_hooks.h>
+#include <linux/capability.h>
+#include <linux/cred.h>
+#include <linux/sched.h>
+#include <linux/string_helpers.h>
+#include <linux/nsproxy.h>
+#include <linux/pid_namespace.h>
+#include <linux/ptrace.h>
+
+#ifdef CONFIG_NAMESPACES
+/**
+ * safe_by_namespace - Are task and current sidechannel safe?
+ * @p: task to check on
+ *
+ * Returns 0 if the tasks are sidechannel safe, -EACCES otherwise.
+ */
+static int safe_by_namespace(struct task_struct *p)
+{
+	struct cgroup_namespace *ccgn = NULL;
+	struct cgroup_namespace *pcgn = NULL;
+
+	/*
+	 * Namespace checks. Considered safe if:
+	 *	cgroup namespace is the same
+	 *	User namespace is the same
+	 *	PID namespace is the same
+	 */
+	if (current->nsproxy)
+		ccgn = current->nsproxy->cgroup_ns;
+	if (p->nsproxy)
+		pcgn = p->nsproxy->cgroup_ns;
+	if (ccgn != pcgn)
+		return -EACCES;
+	if (current->cred->user_ns != p->cred->user_ns)
+		return -EACCES;
+	if (task_active_pid_ns(current) != task_active_pid_ns(p))
+		return -EACCES;
+	return 0;
+}
+#else
+static int safe_by_namespace(struct task_struct *p)
+{
+	return 0;
+}
+#endif
+
+/**
+ * sidechannel_ptrace_access_check - Are task and current sidechannel safe?
+ * @p: task to check on
+ * @mode: ptrace access mode
+ *
+ * Returns 0 if the tasks are sidechannel safe, -EACCES otherwise.
+ */
+static int sidechannel_ptrace_access_check(struct task_struct *p,
+					   unsigned int mode)
+{
+	int rc;
+
+	if ((mode & PTRACE_MODE_SCHED) == 0)
+		return 0;
+
+	rc = safe_by_namespace(p);
+	if (rc)
+		return rc;
+	return 0;
+}
+
+static struct security_hook_list sidechannel_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(ptrace_access_check, sidechannel_ptrace_access_check),
+};
+
+void __init sidechannel_add_hooks(void)
+{
+	pr_info("Extra sidechannel checks enabled\n");
+	security_add_hooks(sidechannel_hooks, ARRAY_SIZE(sidechannel_hooks),
+			   "sidechannel");
+}
-- 
2.17.1

