Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556A2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCCF21537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCCF21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeI0Ctu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:49:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:12173 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbeI0Ctd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:49:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 13:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="93990981"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.251.154.97])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2018 13:34:47 -0700
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH v5 1/5] AppArmor: Prepare for PTRACE_MODE_SCHED
Date:   Wed, 26 Sep 2018 13:34:42 -0700
Message-Id: <20180926203446.2004-2-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180926203446.2004-1-casey.schaufler@intel.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>

A ptrace access check with mode PTRACE_MODE_SCHED gets called
from process switching code. This precludes the use of audit,
as the locking is incompatible. Don't do audit in the PTRACE_MODE_SCHED
case.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 security/apparmor/domain.c      | 2 +-
 security/apparmor/include/ipc.h | 2 +-
 security/apparmor/ipc.c         | 8 +++++---
 security/apparmor/lsm.c         | 5 +++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 08c88de0ffda..28300f4c3ef9 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -77,7 +77,7 @@ static int may_change_ptraced_domain(struct aa_label *to_label,
 	if (!tracer || unconfined(tracerl))
 		goto out;
 
-	error = aa_may_ptrace(tracerl, to_label, PTRACE_MODE_ATTACH);
+	error = aa_may_ptrace(tracerl, to_label, PTRACE_MODE_ATTACH, true);
 
 out:
 	rcu_read_unlock();
diff --git a/security/apparmor/include/ipc.h b/security/apparmor/include/ipc.h
index 5ffc218d1e74..299d1c45fef0 100644
--- a/security/apparmor/include/ipc.h
+++ b/security/apparmor/include/ipc.h
@@ -34,7 +34,7 @@ struct aa_profile;
 	"xcpu xfsz vtalrm prof winch io pwr sys emt lost"
 
 int aa_may_ptrace(struct aa_label *tracer, struct aa_label *tracee,
-		  u32 request);
+		  u32 request, bool audit);
 int aa_may_signal(struct aa_label *sender, struct aa_label *target, int sig);
 
 #endif /* __AA_IPC_H */
diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
index 527ea1557120..9ed110afc822 100644
--- a/security/apparmor/ipc.c
+++ b/security/apparmor/ipc.c
@@ -121,15 +121,17 @@ static int profile_tracer_perm(struct aa_profile *tracer,
  * Returns: %0 else error code if permission denied or error
  */
 int aa_may_ptrace(struct aa_label *tracer, struct aa_label *tracee,
-		  u32 request)
+		  u32 request, bool audit)
 {
 	struct aa_profile *profile;
 	u32 xrequest = request << PTRACE_PERM_SHIFT;
 	DEFINE_AUDIT_DATA(sa, LSM_AUDIT_DATA_NONE, OP_PTRACE);
 
 	return xcheck_labels(tracer, tracee, profile,
-			profile_tracer_perm(profile, tracee, request, &sa),
-			profile_tracee_perm(profile, tracer, xrequest, &sa));
+			profile_tracer_perm(profile, tracee, request,
+					    audit ? &sa : NULL),
+			profile_tracee_perm(profile, tracer, xrequest,
+					    audit ? &sa : NULL));
 }
 
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8b8b70620bbe..da9d0b228857 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -118,7 +118,8 @@ static int apparmor_ptrace_access_check(struct task_struct *child,
 	tracee = aa_get_task_label(child);
 	error = aa_may_ptrace(tracer, tracee,
 			(mode & PTRACE_MODE_READ) ? AA_PTRACE_READ
-						  : AA_PTRACE_TRACE);
+						  : AA_PTRACE_TRACE,
+			!(mode & PTRACE_MODE_SCHED));
 	aa_put_label(tracee);
 	end_current_label_crit_section(tracer);
 
@@ -132,7 +133,7 @@ static int apparmor_ptrace_traceme(struct task_struct *parent)
 
 	tracee = begin_current_label_crit_section();
 	tracer = aa_get_task_label(parent);
-	error = aa_may_ptrace(tracer, tracee, AA_PTRACE_TRACE);
+	error = aa_may_ptrace(tracer, tracee, AA_PTRACE_TRACE, true);
 	aa_put_label(tracer);
 	end_current_label_crit_section(tracee);
 
-- 
2.17.1

