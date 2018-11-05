Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDE1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AD92085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AD92085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbeKFE0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:26:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:23434 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbeKFE0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:26:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 11:05:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="271567363"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.254.103.117])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2018 11:05:06 -0800
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH v6 3/5] SELinux: Prepare for PTRACE_MODE_SCHED
Date:   Mon,  5 Nov 2018 11:05:02 -0800
Message-Id: <20181105190504.500-4-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181105190504.500-1-casey.schaufler@intel.com>
References: <20181105190504.500-1-casey.schaufler@intel.com>
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

