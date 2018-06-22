Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA16C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3EE24984
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3EE24984
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933968AbeFVWrB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:47:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:22310 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754672AbeFVWmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843409"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 20/41] x86/intel_rdt: Add utility to restrict/restore access to resctrl files
Date:   Fri, 22 Jun 2018 15:42:11 -0700
Message-Id: <7afdbf5551b2f93cd45d61fbf5e01d87331f529a.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a resource group is used for Cache Pseudo-Locking then the region of
cache ends up being orphaned with no class of service referring to it. The
resctrl files intended to manage how the classes of services are utilized
thus become irrelevant.

The fact that a resctrl file is not relevant can be communicated to the
user by setting all of its permissions to zero. That is, its read, write,
and execute permissions are unset for all users.

Introduce two utilities, rdtgroup_kn_mode_restrict() and
rdtgroup_kn_mode_restore(), that can be used to restrict and restore the
permissions of a file or directory belonging to a resource group.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/d4782f79e0bf2cd7a438a45c46bf4427c9d813aa.1527593970.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt.h          |  2 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 95 ++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 10a1539cbec6..c9b8d3d1d413 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -469,6 +469,8 @@ void rdt_last_cmd_printf(const char *fmt, ...);
 void rdt_ctrl_update(void *arg);
 struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn);
 void rdtgroup_kn_unlock(struct kernfs_node *kn);
+int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
+int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name);
 struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 				   struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 5a2a34d68722..c17d5399b9f1 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1290,6 +1290,101 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 	return ret;
 }
 
+/**
+ * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
+ * @r: The resource group with which the file is associated.
+ * @name: Name of the file
+ *
+ * The permissions of named resctrl file, directory, or link are modified
+ * to not allow read, write, or execute by any user.
+ *
+ * WARNING: This function is intended to communicate to the user that the
+ * resctrl file has been locked down - that it is not relevant to the
+ * particular state the system finds itself in. It should not be relied
+ * on to protect from user access because after the file's permissions
+ * are restricted the user can still change the permissions using chmod
+ * from the command line.
+ *
+ * Return: 0 on success, <0 on failure.
+ */
+int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name)
+{
+	struct iattr iattr = {.ia_valid = ATTR_MODE,};
+	struct kernfs_node *kn;
+	int ret = 0;
+
+	kn = kernfs_find_and_get_ns(r->kn, name, NULL);
+	if (!kn)
+		return -ENOENT;
+
+	switch (kernfs_type(kn)) {
+	case KERNFS_DIR:
+		iattr.ia_mode = S_IFDIR;
+		break;
+	case KERNFS_FILE:
+		iattr.ia_mode = S_IFREG;
+		break;
+	case KERNFS_LINK:
+		iattr.ia_mode = S_IFLNK;
+		break;
+	}
+
+	ret = kernfs_setattr(kn, &iattr);
+	kernfs_put(kn);
+	return ret;
+}
+
+/**
+ * rdtgroup_kn_mode_restore - Restore user access to named resctrl file
+ * @r: The resource group with which the file is associated.
+ * @name: Name of the file
+ *
+ * Restore the permissions of the named file. If @name is a directory the
+ * permissions of its parent will be used.
+ *
+ * Return: 0 on success, <0 on failure.
+ */
+int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name)
+{
+	struct iattr iattr = {.ia_valid = ATTR_MODE,};
+	struct kernfs_node *kn, *parent;
+	struct rftype *rfts, *rft;
+	int ret, len;
+
+	rfts = res_common_files;
+	len = ARRAY_SIZE(res_common_files);
+
+	for (rft = rfts; rft < rfts + len; rft++) {
+		if (!strcmp(rft->name, name))
+			iattr.ia_mode = rft->mode;
+	}
+
+	kn = kernfs_find_and_get_ns(r->kn, name, NULL);
+	if (!kn)
+		return -ENOENT;
+
+	switch (kernfs_type(kn)) {
+	case KERNFS_DIR:
+		parent = kernfs_get_parent(kn);
+		if (parent) {
+			iattr.ia_mode |= parent->mode;
+			kernfs_put(parent);
+		}
+		iattr.ia_mode |= S_IFDIR;
+		break;
+	case KERNFS_FILE:
+		iattr.ia_mode |= S_IFREG;
+		break;
+	case KERNFS_LINK:
+		iattr.ia_mode |= S_IFLNK;
+		break;
+	}
+
+	ret = kernfs_setattr(kn, &iattr);
+	kernfs_put(kn);
+	return ret;
+}
+
 static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char *name,
 				      unsigned long fflags)
 {
-- 
2.17.0

