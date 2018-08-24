Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E56C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B0B2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B0B2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeHYCSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:18:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:55282 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbeHYCSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:18:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Aug 2018 15:41:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,284,1531810800"; 
   d="scan'208";a="84307219"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.254.2.129])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2018 15:41:19 -0700
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH v4 4/5] Smack: Support determination of side-channel
Date:   Fri, 24 Aug 2018 15:41:16 -0700
Message-Id: <20180824224117.3356-5-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180824224117.3356-1-casey.schaufler@intel.com>
References: <20180824224117.3356-1-casey.schaufler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smack considers its private task data safe if the current task
has read access to the passed task.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 security/smack/smack_lsm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 91750205a5de..85dc053e610c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2299,6 +2299,23 @@ static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 	isp->smk_inode = skp;
 }
 
+/**
+ * smack_task_safe_sidechannel - Are the task and current sidechannel safe?
+ * @p: task to check on
+ *
+ * A crude value for sidechannel safety is that the current task is
+ * already allowed to read from the other.
+ *
+ * Returns 0 if the tasks are sidechannel safe, -EACCES otherwise.
+ */
+static int smack_task_safe_sidechannel(struct task_struct *p)
+{
+	struct smack_known *skp = smk_of_task_struct(p);
+	struct smack_known *ckp = smk_of_task_struct(current);
+
+	return smk_access(ckp, skp, MAY_READ, NULL);
+}
+
 /*
  * Socket hooks.
  */
@@ -4718,6 +4735,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_movememory, smack_task_movememory),
 	LSM_HOOK_INIT(task_kill, smack_task_kill),
 	LSM_HOOK_INIT(task_to_inode, smack_task_to_inode),
+	LSM_HOOK_INIT(task_safe_sidechannel, smack_task_safe_sidechannel),
 
 	LSM_HOOK_INIT(ipc_permission, smack_ipc_permission),
 	LSM_HOOK_INIT(ipc_getsecid, smack_ipc_getsecid),
-- 
2.17.1

