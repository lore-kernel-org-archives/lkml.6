Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B440AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790A921566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790A921566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391072AbeIUWWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:22:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390638AbeIUWWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:22:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF23CE89B;
        Fri, 21 Sep 2018 16:32:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ED6E16938;
        Fri, 21 Sep 2018 16:32:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/34] cpuset: Use fs_context [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
        dhowells@redhat.com, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:32:50 +0100
Message-ID: <153754757020.17872.17671307412673923587.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 21 Sep 2018 16:32:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

 kernel/cgroup/cpuset.c |   67 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6d9f1a709af9..df78e166028c 100644
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
@@ -315,26 +315,65 @@ static inline bool is_in_v2_mode(void)
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
+	cg_fc = vfs_new_fs_context(cgroup_fs, NULL, fc->sb_flags, fc->sb_flags,
+				   fc->purpose);
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

