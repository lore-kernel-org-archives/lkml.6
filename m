Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78310C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EB220883
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EB220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbeKFE0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:26:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:23416 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387976AbeKFE0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:26:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 11:05:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="271567370"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.254.103.117])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2018 11:05:06 -0800
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH v6 4/5] Capability: Complete PTRACE_MODE_SCHED
Date:   Mon,  5 Nov 2018 11:05:03 -0800
Message-Id: <20181105190504.500-5-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181105190504.500-1-casey.schaufler@intel.com>
References: <20181105190504.500-1-casey.schaufler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>

Allow a complete ptrace access check with mode PTRACE_MODE_SCHED.
Disable the inappropriate privilege check in the capability code
that does incompatible locking.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 kernel/ptrace.c      | 2 --
 security/commoncap.c | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 99cfddde6a55..0b6a9df51c3b 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -331,8 +331,6 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	     !ptrace_has_cap(mm->user_ns, mode)))
 	    return -EPERM;
 
-	if (mode & PTRACE_MODE_SCHED)
-		return 0;
 	return security_ptrace_access_check(task, mode);
 }
 
diff --git a/security/commoncap.c b/security/commoncap.c
index 2e489d6a3ac8..70a7e3d19c16 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -152,7 +152,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, *caller_caps))
 		goto out;
-	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
+	if (!(mode & PTRACE_MODE_SCHED) &&
+	    ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
 	ret = -EPERM;
 out:
-- 
2.17.1

