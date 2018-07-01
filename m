Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CE7C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C1825242
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C1825242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeGAFSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 01:18:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:16836 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbeGAFRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 01:17:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2018 22:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,293,1526367600"; 
   d="scan'208";a="54226736"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga006.jf.intel.com with ESMTP; 30 Jun 2018 22:17:50 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 1/2] x86/intel_rdt: Support restoration of subset of permissions
Date:   Sat, 30 Jun 2018 22:17:32 -0700
Message-Id: <8773aadfade7bcb2c48a45fa294a04d2c03bb0a1.1530421961.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1530421961.git.reinette.chatre@intel.com>
References: <cover.1530421961.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1530421961.git.reinette.chatre@intel.com>
References: <cover.1530421961.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the mode of a resource group changes, the operations it can support
may also change. One way in which the supported operations are managed
is to modify the permissions of the files within the resource group's
resctrl directory.

At the moment only two possible permissions are supported: the default
permissions or no permissions in support for when the operation is
"locked down". It is possible where an operation on a resource group may
have more possibilities. For example, if by default changes can be made to
the resource group by writing to a resctrl file while the current
settings can be obtained by reading from the file, then it may be
possible that in another mode it is only possible to read the current
settings, and not change them.

Make it possible to modify some of the permissions of a resctrl file in
support of a more flexible way to manage the operations on a resource
group. In this preparation work the original behavior is maintained
where all permissions are restored.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |  3 ++-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 14 +++++++-------
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |  6 ++++--
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 2d9cbb9d7a58..4e588f36228f 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -512,7 +512,8 @@ void rdt_ctrl_update(void *arg);
 struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn);
 void rdtgroup_kn_unlock(struct kernfs_node *kn);
 int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
-int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name);
+int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
+			     umode_t mask);
 struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 				   struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 8fd79c281ee6..5dfe4008c58f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -590,11 +590,11 @@ static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
 	goto out;
 
 err_cpus_list:
-	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list");
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0777);
 err_cpus:
-	rdtgroup_kn_mode_restore(rdtgrp, "cpus");
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0777);
 err_tasks:
-	rdtgroup_kn_mode_restore(rdtgrp, "tasks");
+	rdtgroup_kn_mode_restore(rdtgrp, "tasks", 0777);
 out:
 	return ret;
 }
@@ -615,20 +615,20 @@ static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
 {
 	int ret;
 
-	ret = rdtgroup_kn_mode_restore(rdtgrp, "tasks");
+	ret = rdtgroup_kn_mode_restore(rdtgrp, "tasks", 0777);
 	if (ret)
 		return ret;
 
-	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus");
+	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0777);
 	if (ret)
 		goto err_tasks;
 
-	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus_list");
+	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0777);
 	if (ret)
 		goto err_cpus;
 
 	if (rdt_mon_capable) {
-		ret = rdtgroup_kn_mode_restore(rdtgrp, "mon_groups");
+		ret = rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
 		if (ret)
 			goto err_cpus_list;
 	}
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 7b4a09d81a30..c20b51afd62d 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1405,13 +1405,15 @@ int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name)
  * rdtgroup_kn_mode_restore - Restore user access to named resctrl file
  * @r: The resource group with which the file is associated.
  * @name: Name of the file
+ * @mask: Mask of permissions that should be restored
  *
  * Restore the permissions of the named file. If @name is a directory the
  * permissions of its parent will be used.
  *
  * Return: 0 on success, <0 on failure.
  */
-int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name)
+int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
+			     umode_t mask)
 {
 	struct iattr iattr = {.ia_valid = ATTR_MODE,};
 	struct kernfs_node *kn, *parent;
@@ -1423,7 +1425,7 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name)
 
 	for (rft = rfts; rft < rfts + len; rft++) {
 		if (!strcmp(rft->name, name))
-			iattr.ia_mode = rft->mode;
+			iattr.ia_mode = rft->mode & mask;
 	}
 
 	kn = kernfs_find_and_get_ns(r->kn, name, NULL);
-- 
2.17.0

