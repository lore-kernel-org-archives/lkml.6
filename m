Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A7EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2DD216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2DD216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeI1BhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:37:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:38331 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727760AbeI1BhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:37:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 12:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,311,1534834800"; 
   d="scan'208";a="90082086"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.251.154.97])
  by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2018 12:17:21 -0700
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH 6/5] capability: Repair sidechannel test in ptrace
Date:   Thu, 27 Sep 2018 12:17:20 -0700
Message-Id: <20180927191720.9480-1-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180824224117.3356-1-casey.schaufler@intel.com>
References: <20180824224117.3356-1-casey.schaufler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>

The PTRACE_MODE_SCHED check erroniously returns 0 in
all cases. It should be returning -EPERM. This fixes
the logic to correct that error.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 security/commoncap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index e77457110d05..70a7e3d19c16 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -152,9 +152,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, *caller_caps))
 		goto out;
-	if (mode & PTRACE_MODE_SCHED)
-		goto out;
-	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
+	if (!(mode & PTRACE_MODE_SCHED) &&
+	    ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
 	ret = -EPERM;
 out:
-- 
2.17.1

