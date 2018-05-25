Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161575AbeEYAHK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:07:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935560AbeEYAHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:07:03 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/32] cpuset: Use fs_context [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:07:01 +0100
Message-ID: <152720682160.9073.16572834582691971149.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the cpuset filesystem use the filesystem context.  This is potentially
tricky as the cpuset fs is almost an alias for the cgroup filesystem, but
with some special parameters.

This can, however, be handled by setting up an appropriate cgroup
filesystem and returning the root directory of that as the root dir of this
one.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Tejun Heo <tj@kernel.org>
---

 kernel/cgroup/cpuset.c |   66 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3c8ef37879f0..f570d13bc688 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -38,7 +38,7 @@
 #include <linux/mm.h>
 #include <linux/memory.h>
 #include <linux/export.h>
-#include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/proc_fs.h>
@@ -315,26 +315,64 @@ static inline bool is_in_v2_mode(void)
  * users. If someone tries to mount the "cpuset" filesystem, we
  * silently switch it to mount "cgroup" instead
  */
-static struct dentry *cpuset_mount(struct file_system_type *fs_type,
-				   int flags, const char *unused_dev_name,
-				   void *data, size_t data_size)
+static int cpuset_get_tree(struct fs_context *fc)
 {
-	struct file_system_type *cgroup_fs = get_fs_type("cgroup");
-	struct dentry *ret = ERR_PTR(-ENODEV);
+	static const char opts[] = "cpuset,noprefix,release_agent=/sbin/cpuset_release_agent";
+	struct file_system_type *cgroup_fs;
+	struct fs_context *cg_fc;
+	char *p;
+	int ret = -ENODEV;
+
+	cgroup_fs = get_fs_type("cgroup");
 	if (cgroup_fs) {
-		char mountopts[] =
-			"cpuset,noprefix,"
-			"release_agent=/sbin/cpuset_release_agent";
-		ret = cgroup_fs->mount(cgroup_fs, flags, unused_dev_name,
-				       mountopts, data_size);
-		put_filesystem(cgroup_fs);
+		ret = PTR_ERR(cgroup_fs);
+		goto out;
+	}
+
+	cg_fc = vfs_new_fs_context(cgroup_fs, NULL, fc->sb_flags, fc->purpose);
+	put_filesystem(cgroup_fs);
+	if (IS_ERR(cg_fc)) {
+		ret = PTR_ERR(cg_fc);
+		goto out;
 	}
+
+	ret = -ENOMEM;
+	p = kstrdup(opts, GFP_KERNEL);
+	if (!p)
+		goto out_fc;
+
+	ret = generic_parse_monolithic(fc, p, sizeof(opts) - 1);
+	kfree(p);
+	if (ret < 0)
+		goto out_fc;
+
+	ret = vfs_get_tree(cg_fc);
+	if (ret < 0)
+		goto out_fc;
+
+	fc->root = dget(cg_fc->root);
+	ret = 0;
+
+out_fc:
+	put_fs_context(cg_fc);
+out:
 	return ret;
 }
 
+static const struct fs_context_operations cpuset_fs_context_ops = {
+	.get_tree	= cpuset_get_tree,
+};
+
+static int cpuset_init_fs_context(struct fs_context *fc,
+				  struct dentry *reference)
+{
+	fc->ops = &cpuset_fs_context_ops;
+	return 0;
+}
+
 static struct file_system_type cpuset_fs_type = {
-	.name = "cpuset",
-	.mount = cpuset_mount,
+	.name			= "cpuset",
+	.init_fs_context	= cpuset_init_fs_context,
 };
 
 /*
