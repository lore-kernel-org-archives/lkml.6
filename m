Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A9C21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A9C21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeI0Cte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:49:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:12173 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbeI0Ctd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:49:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 13:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="93990991"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.251.154.97])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2018 13:34:48 -0700
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH v5 3/5] SELinux: Prepare for PTRACE_MODE_SCHED
Date:   Wed, 26 Sep 2018 13:34:44 -0700
Message-Id: <20180926203446.2004-4-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180926203446.2004-1-casey.schaufler@intel.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>

A ptrace access check with mode PTRACE_MODE_SCHED gets called
from process switching code. This precludes the use of audit or avc,
as the locking is incompatible. The only available check that
can be made without using avc is a comparison of the secids.
This is not very satisfactory as it will indicate possible
vulnerabilies much too aggressively.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 security/selinux/hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad9a9b8e9979..160239791007 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2267,6 +2267,8 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 	u32 sid = current_sid();
 	u32 csid = task_sid(child);
 
+	if (mode & PTRACE_MODE_SCHED)
+		return sid == csid ? 0 : -EACCES;
 	if (mode & PTRACE_MODE_READ)
 		return avc_has_perm(&selinux_state,
 				    sid, csid, SECCLASS_FILE, FILE__READ, NULL);
-- 
2.17.1

