Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAECC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF42218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF42218A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeHRBVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 21:21:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:58247 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbeHRBVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 21:21:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Aug 2018 15:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,253,1531810800"; 
   d="scan'208";a="67079640"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.254.9.75])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2018 15:16:26 -0700
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH RFC v2 5/5] SELinux: Support SELinux determination of side-channel vulnerability
Date:   Fri, 17 Aug 2018 15:16:24 -0700
Message-Id: <20180817221624.10232-6-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180817221624.10232-1-casey.schaufler@intel.com>
References: <20180817221624.10232-1-casey.schaufler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SELinux considers tasks to be side-channel safe if they
have PROCESS_SHARE access.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 security/selinux/hooks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a8bf324130f5..7fbd7d7ac1cb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4219,6 +4219,14 @@ static void selinux_task_to_inode(struct task_struct *p,
 	spin_unlock(&isec->lock);
 }
 
+static int selinux_task_safe_sidechannel(struct task_struct *p)
+{
+	struct av_decision avd;
+
+	return avc_has_perm_noaudit(&selinux_state, current_sid(), task_sid(p),
+				    SECCLASS_FILE, FILE__READ, 0, &avd);
+}
+
 /* Returns error only if unable to parse addresses */
 static int selinux_parse_skb_ipv4(struct sk_buff *skb,
 			struct common_audit_data *ad, u8 *proto)
@@ -7002,6 +7010,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
 	LSM_HOOK_INIT(task_kill, selinux_task_kill),
 	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
+	LSM_HOOK_INIT(task_safe_sidechannel, selinux_task_safe_sidechannel),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
 	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
-- 
2.17.1

