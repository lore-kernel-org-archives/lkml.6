Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F6DC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FE124BCB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FE124BCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeFWMRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:17:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbeFWMRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:17:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCHGaw464519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:17:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCHGAk464516;
        Sat, 23 Jun 2018 05:17:16 -0700
Date:   Sat, 23 Jun 2018 05:17:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-125db711e3629977b5e1f06fa066abe6366db294@git.kernel.org>
Cc:     reinette.chatre@intel.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, reinette.chatre@intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <7afdbf5551b2f93cd45d61fbf5e01d87331f529a.1529706536.git.reinette.chatre@intel.com>
References: <7afdbf5551b2f93cd45d61fbf5e01d87331f529a.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Add utility to restrict/restore
 access to resctrl files
Git-Commit-ID: 125db711e3629977b5e1f06fa066abe6366db294
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  125db711e3629977b5e1f06fa066abe6366db294
Gitweb:     https://git.kernel.org/tip/125db711e3629977b5e1f06fa066abe6366db294
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:11 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:46 +0200

x86/intel_rdt: Add utility to restrict/restore access to resctrl files

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
Link: https://lkml.kernel.org/r/7afdbf5551b2f93cd45d61fbf5e01d87331f529a.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h          |  2 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 95 ++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 11c76c4b9a5e..8d56776a3bd2 100644
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
index 59e1de9fe2d5..08a412e0b47a 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1290,6 +1290,101 @@ error:
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
