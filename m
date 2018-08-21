Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F225BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 00:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54F221763
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 00:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54F221763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeHUDWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 23:22:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:10085 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbeHUDWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 23:22:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 17:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,267,1531810800"; 
   d="scan'208";a="250527755"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.252.136.122])
  by orsmga005.jf.intel.com with ESMTP; 20 Aug 2018 17:04:45 -0700
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH v3 1/5] LSM: Introduce a hook for side-channel danger
Date:   Mon, 20 Aug 2018 17:04:40 -0700
Message-Id: <20180821000444.7004-2-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180821000444.7004-1-casey.schaufler@intel.com>
References: <20180821000444.7004-1-casey.schaufler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be cases where the data maintained for
security controls is more sensitive than general
process information and that may be subjected to
side-channel attacks. An LSM hook is provided so
that this can be check for where the system would
take action should the current task have potential
access to the passed task.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 include/linux/lsm_hooks.h | 7 +++++++
 include/linux/security.h  | 1 +
 security/security.c       | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a08bc2587b96..fd2a7e6beb01 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -698,6 +698,11 @@
  *	security attributes, e.g. for /proc/pid inodes.
  *	@p contains the task_struct for the task.
  *	@inode contains the inode structure for the inode.
+ * @task_safe_sidechannel:
+ *	Check if a side channel attack is harmless for the current task and @p.
+ *	The caller may have determined that no attack is possible, in which
+ *	case this hook won't get called.
+ *	@p contains the task_struct for the task.
  *
  * Security hooks for Netlink messaging.
  *
@@ -1611,6 +1616,7 @@ union security_list_options {
 	int (*task_prctl)(int option, unsigned long arg2, unsigned long arg3,
 				unsigned long arg4, unsigned long arg5);
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
+	int (*task_safe_sidechannel)(struct task_struct *p);
 
 	int (*ipc_permission)(struct kern_ipc_perm *ipcp, short flag);
 	void (*ipc_getsecid)(struct kern_ipc_perm *ipcp, u32 *secid);
@@ -1897,6 +1903,7 @@ struct security_hook_heads {
 	struct hlist_head task_kill;
 	struct hlist_head task_prctl;
 	struct hlist_head task_to_inode;
+	struct hlist_head task_safe_sidechannel;
 	struct hlist_head ipc_permission;
 	struct hlist_head ipc_getsecid;
 	struct hlist_head msg_msg_alloc_security;
diff --git a/include/linux/security.h b/include/linux/security.h
index 3410acfe139c..69a5526f789f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -366,6 +366,7 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
+int security_task_safe_sidechannel(struct task_struct *p);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
 int security_msg_msg_alloc(struct msg_msg *msg);
diff --git a/security/security.c b/security/security.c
index 4927e7cc7d96..353b711e635a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1165,6 +1165,11 @@ void security_task_to_inode(struct task_struct *p, struct inode *inode)
 	call_void_hook(task_to_inode, p, inode);
 }
 
+int security_task_safe_sidechannel(struct task_struct *p)
+{
+	return call_int_hook(task_safe_sidechannel, 0, p);
+}
+
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
-- 
2.17.1

