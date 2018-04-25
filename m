Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756294AbeDYSZG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:25:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:41714 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932169AbeDYSMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243695"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 19/39] x86/intel_rdt: Add utility to restrict/restore access to resctrl files
Date: Wed, 25 Apr 2018 03:09:55 -0700
Message-Id: <c0c1be5bf52f6c4ea7313edf164f13c264ed21d0.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a resource group is used for Cache Pseudo-Locking then the region
of cache ends up being orphaned with no class of service referring to
it. The resctrl files intended to manage how the classes of services are
utilized thus become irrelevant.

The fact that a resctrl file is not relevant can be communicated to the
user by setting all of its permissions to zero. That is, its read,
write, and execute permissions are unset for all users.

Introduce two utilities, rdtgroup_kn_mode_restrict() and
rdtgroup_kn_mode_restore(), that can be used to restrict and restore
the permissions of a file or directory belonging to a resource group.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h          |  2 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 95 ++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index e33b1215f394..24399f2407d7 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -454,6 +454,8 @@ void rdt_last_cmd_printf(const char *fmt, ...);
 void rdt_ctrl_update(void *arg);
 struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn);
 void rdtgroup_kn_unlock(struct kernfs_node *kn);
+int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
+int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name);
 struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 				   struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index f2da6a2827c8..4d63934e6f68 100644
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
2.13.6
