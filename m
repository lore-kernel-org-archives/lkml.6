Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E74C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E203C2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E203C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeLJRQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:16:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbeLJRNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FF5D792B8;
        Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBCFD60158;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D009622427E; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 50/52] fuse: add shared version support (virtio-fs only)
Date:   Mon, 10 Dec 2018 12:13:16 -0500
Message-Id: <20181210171318.16998-51-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

Metadata and dcache versioning support.

READDIRPLUS doesn't supply version information yet, so don't use.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c             |   3 +-
 fs/fuse/dir.c             | 244 +++++++++++++++++++++++++++++++++++++++-------
 fs/fuse/file.c            |  53 ++++++----
 fs/fuse/fuse_i.h          |  25 +++--
 fs/fuse/inode.c           |  23 +++--
 fs/fuse/readdir.c         |  12 ++-
 include/uapi/linux/fuse.h |   5 +
 7 files changed, 284 insertions(+), 81 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index f35c4ab2dcbb..9ed326d716ee 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -640,8 +640,7 @@ ssize_t fuse_simple_request(struct fuse_conn *fc, struct fuse_args *args)
 	       args->out.numargs * sizeof(struct fuse_arg));
 	fuse_request_send(fc, req);
 	ret = req->out.h.error;
-	if (!ret && args->out.argvar) {
-		BUG_ON(args->out.numargs != 1);
+	if (!ret && args->out.argvar && args->out.numargs == 1) {
 		ret = req->out.args[0].size;
 	}
 	fuse_put_request(fc, req);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 8aa4ff82ea7a..3aa214f9a28e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -25,7 +25,11 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
 }
 
 union fuse_dentry {
-	u64 time;
+	struct {
+		u64 time;
+		s64 version;
+		s64 parent_version;
+	};
 	struct rcu_head rcu;
 };
 
@@ -48,6 +52,18 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 	((union fuse_dentry *) dentry->d_fsdata)->time = time;
 }
 
+static inline void fuse_dentry_setver(struct dentry *entry,
+				      struct fuse_entryver_out *outver,
+				      s64 pver)
+{
+	union fuse_dentry *fude = entry->d_fsdata;
+
+	smp_wmb();
+	/* FIXME: verify versions aren't going backwards */
+	WRITE_ONCE(fude->version, outver->initial_version);
+	WRITE_ONCE(fude->parent_version, pver);
+}
+
 static inline u64 fuse_dentry_time(const struct dentry *entry)
 {
 	return ((union fuse_dentry *) entry->d_fsdata)->time;
@@ -150,34 +166,118 @@ static void fuse_invalidate_entry(struct dentry *entry)
 
 static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 			     u64 nodeid, const struct qstr *name,
-			     struct fuse_entry_out *outarg)
+			     struct fuse_entry_out *outarg,
+			     struct fuse_entryver_out *outver)
 {
 	memset(outarg, 0, sizeof(struct fuse_entry_out));
+	memset(outver, 0, sizeof(struct fuse_entryver_out));
 	args->in.h.opcode = FUSE_LOOKUP;
 	args->in.h.nodeid = nodeid;
 	args->in.numargs = 1;
 	args->in.args[0].size = name->len + 1;
 	args->in.args[0].value = name->name;
-	args->out.numargs = 1;
+	args->out.argvar = 1;
+	args->out.numargs = 2;
 	args->out.args[0].size = sizeof(struct fuse_entry_out);
 	args->out.args[0].value = outarg;
+	args->out.args[1].size = sizeof(struct fuse_entryver_out);
+	args->out.args[1].value = outver;
 }
 
-u64 fuse_get_attr_version(struct fuse_conn *fc)
+s64 fuse_get_attr_version(struct inode *inode)
 {
-	u64 curr_version;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	s64 curr_version;
 
-	/*
-	 * The spin lock isn't actually needed on 64bit archs, but we
-	 * don't yet care too much about such optimizations.
-	 */
-	spin_lock(&fc->lock);
-	curr_version = fc->attr_version;
-	spin_unlock(&fc->lock);
+	if (fi->version_ptr) {
+		curr_version = READ_ONCE(*fi->version_ptr);
+	} else {
+		struct fuse_conn *fc = get_fuse_conn(inode);
+
+		/*
+		 * The spin lock isn't actually needed on 64bit archs, but we
+		 * don't yet care too much about such optimizations.
+		 */
+		spin_lock(&fc->lock);
+		curr_version = fc->attr_ctr;
+		spin_unlock(&fc->lock);
+	}
+
+	return curr_version;
+}
+
+static s64 fuse_get_attr_version_shared(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	s64 curr_version = 0;
+
+	if (fi->version_ptr)
+		curr_version = READ_ONCE(*fi->version_ptr);
 
 	return curr_version;
 }
 
+static bool fuse_version_mismatch(struct inode *inode, s64 version)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	bool mismatch = false;
+
+	if (fi->version_ptr) {
+		s64 curr_version = READ_ONCE(*fi->version_ptr);
+
+		mismatch = curr_version != version;
+		smp_rmb();
+
+		if (mismatch) {
+			pr_info("mismatch: nodeid=%llu curr=%lli cache=%lli\n",
+				get_node_id(inode), curr_version, version);
+		}
+	}
+
+	return mismatch;
+}
+
+static bool fuse_dentry_version_mismatch(struct dentry *dentry)
+{
+	union fuse_dentry *fude = dentry->d_fsdata;
+	struct inode *dir = d_inode_rcu(dentry->d_parent);
+	struct inode *inode = d_inode_rcu(dentry);
+
+	if (!fuse_version_mismatch(dir, READ_ONCE(fude->parent_version)))
+		return false;
+
+	/* Can only validate negatives based on parent version */
+	if (!inode)
+		return true;
+
+	return fuse_version_mismatch(inode, READ_ONCE(fude->version));
+}
+
+static void fuse_set_version_ptr(struct inode *inode,
+			      struct fuse_entryver_out *outver)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	if (!fc->version_table || !outver->version_index) {
+		fi->version_ptr = NULL;
+		return;
+	}
+	if (outver->version_index >= fc->version_table_size) {
+		pr_warn_ratelimited("version index too large (%llu >= %llu)\n",
+				    outver->version_index,
+				    fc->version_table_size);
+		fi->version_ptr = NULL;
+		return;
+	}
+
+	fi->version_ptr = fc->version_table + outver->version_index;
+
+	pr_info("fuse: version_ptr = %p\n", fi->version_ptr);
+	pr_info("fuse: version = %lli\n", fi->attr_version);
+	pr_info("fuse: current_version: %lli\n", *fi->version_ptr);
+}
+
 /*
  * Check whether the dentry is still valid
  *
@@ -198,12 +298,15 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	inode = d_inode_rcu(entry);
 	if (inode && is_bad_inode(inode))
 		goto invalid;
-	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
+	else if (fuse_dentry_version_mismatch(entry) ||
+		 time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & LOOKUP_REVAL)) {
 		struct fuse_entry_out outarg;
+		struct fuse_entryver_out outver;
 		FUSE_ARGS(args);
 		struct fuse_forget_link *forget;
-		u64 attr_version;
+		s64 attr_version;
+		s64 parent_version;
 
 		/* For negative dentries, always do a fresh lookup */
 		if (!inode)
@@ -220,11 +323,12 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		if (!forget)
 			goto out;
 
-		attr_version = fuse_get_attr_version(fc);
+		attr_version = fuse_get_attr_version(inode);
 
 		parent = dget_parent(entry);
+		parent_version = fuse_get_attr_version_shared(d_inode(parent));
 		fuse_lookup_init(fc, &args, get_node_id(d_inode(parent)),
-				 &entry->d_name, &outarg);
+				 &entry->d_name, &outarg, &outver);
 		ret = fuse_simple_request(fc, &args);
 		dput(parent);
 		/* Zero nodeid is same as -ENOENT */
@@ -236,6 +340,9 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 				fuse_queue_forget(fc, forget, outarg.nodeid, 1);
 				goto invalid;
 			}
+			if (fi->version_ptr != fc->version_table + outver.version_index)
+				pr_warn("fuse_dentry_revalidate: version_ptr changed (%p -> %p)\n", fi->version_ptr, fc->version_table + outver.version_index);
+
 			spin_lock(&fc->lock);
 			fi->nlookup++;
 			spin_unlock(&fc->lock);
@@ -246,14 +353,26 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		if (ret || (outarg.attr.mode ^ inode->i_mode) & S_IFMT)
 			goto invalid;
 
+		if (fi->version_ptr) {
+			if (outver.initial_version > attr_version)
+				attr_version = outver.initial_version;
+			else if (outver.initial_version < attr_version)
+				pr_warn("fuse_dentry_revalidate: backward going version (%lli -> %lli)\n", attr_version, outver.initial_version);
+		}
+
 		forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &outarg.attr,
 				       entry_attr_timeout(&outarg),
 				       attr_version);
 		fuse_change_entry_timeout(entry, &outarg);
+		fuse_dentry_setver(entry, &outver, parent_version);
 	} else if (inode) {
 		fi = get_fuse_inode(inode);
 		if (flags & LOOKUP_RCU) {
+			/*
+			 * FIXME: Don't leave rcu if FUSE_I_ADVISE_RDPLUS is
+			 * already set?
+			 */
 			if (test_bit(FUSE_I_INIT_RDPLUS, &fi->state))
 				return -ECHILD;
 		} else if (test_and_clear_bit(FUSE_I_INIT_RDPLUS, &fi->state)) {
@@ -307,13 +426,16 @@ int fuse_valid_type(int m)
 		S_ISBLK(m) || S_ISFIFO(m) || S_ISSOCK(m);
 }
 
-int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     struct fuse_entry_out *outarg, struct inode **inode)
+static int fuse_lookup_name_with_ver(struct super_block *sb, u64 nodeid,
+				     const struct qstr *name,
+				     struct fuse_entry_out *outarg,
+				     struct fuse_entryver_out *outver,
+				     struct inode **inode)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 	FUSE_ARGS(args);
 	struct fuse_forget_link *forget;
-	u64 attr_version;
+	s64 attr_version;
 	int err;
 
 	*inode = NULL;
@@ -327,9 +449,11 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	if (!forget)
 		goto out;
 
-	attr_version = fuse_get_attr_version(fc);
+	spin_lock(&fc->lock);
+	attr_version = fc->attr_ctr;
+	spin_unlock(&fc->lock);
 
-	fuse_lookup_init(fc, &args, nodeid, name, outarg);
+	fuse_lookup_init(fc, &args, nodeid, name, outarg, outver);
 	err = fuse_simple_request(fc, &args);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
 	if (err || !outarg->nodeid)
@@ -357,19 +481,32 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	return err;
 }
 
+int fuse_lookup_name(struct super_block *sb, u64 nodeid,
+		     const struct qstr *name,
+		     struct fuse_entry_out *outarg, struct inode **inode)
+{
+	struct fuse_entryver_out outver;
+
+	return fuse_lookup_name_with_ver(sb, nodeid, name, outarg, &outver,
+					 inode);
+}
+
 static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 				  unsigned int flags)
 {
 	int err;
 	struct fuse_entry_out outarg;
+	struct fuse_entryver_out outver;
 	struct inode *inode;
 	struct dentry *newent;
 	bool outarg_valid = true;
+	s64 parent_version = fuse_get_attr_version_shared(dir);
 	bool locked;
 
 	locked = fuse_lock_inode(dir);
-	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
-			       &outarg, &inode);
+	err = fuse_lookup_name_with_ver(dir->i_sb, get_node_id(dir),
+					&entry->d_name, &outarg, &outver,
+					&inode);
 	fuse_unlock_inode(dir, locked);
 	if (err == -ENOENT) {
 		outarg_valid = false;
@@ -382,16 +519,21 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 	if (inode && get_node_id(inode) == FUSE_ROOT_ID)
 		goto out_iput;
 
+	if (inode)
+		fuse_set_version_ptr(inode, &outver);
+
 	newent = d_splice_alias(inode, entry);
 	err = PTR_ERR(newent);
 	if (IS_ERR(newent))
 		goto out_err;
 
 	entry = newent ? newent : entry;
-	if (outarg_valid)
+	if (outarg_valid) {
 		fuse_change_entry_timeout(entry, &outarg);
-	else
+		fuse_dentry_setver(entry, &outver, parent_version);
+	} else {
 		fuse_invalidate_entry_cache(entry);
+	}
 
 	fuse_advise_use_readdirplus(dir);
 	return newent;
@@ -420,7 +562,9 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	struct fuse_create_in inarg;
 	struct fuse_open_out outopen;
 	struct fuse_entry_out outentry;
+	struct fuse_entryver_out outver;
 	struct fuse_file *ff;
+	s64 parent_version = fuse_get_attr_version_shared(dir);
 
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
@@ -451,11 +595,14 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.in.args[0].value = &inarg;
 	args.in.args[1].size = entry->d_name.len + 1;
 	args.in.args[1].value = entry->d_name.name;
-	args.out.numargs = 2;
+	args.out.argvar = 1;
+	args.out.numargs = 3;
 	args.out.args[0].size = sizeof(outentry);
 	args.out.args[0].value = &outentry;
 	args.out.args[1].size = sizeof(outopen);
 	args.out.args[1].value = &outopen;
+	args.out.args[2].size = sizeof(outver);
+	args.out.args[2].value = &outver;
 	err = fuse_simple_request(fc, &args);
 	if (err)
 		goto out_free_ff;
@@ -478,7 +625,9 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	}
 	kfree(forget);
 	d_instantiate(entry, inode);
+	fuse_set_version_ptr(inode, &outver);
 	fuse_change_entry_timeout(entry, &outentry);
+	fuse_dentry_setver(entry, &outver, parent_version);
 	fuse_dir_changed(dir);
 	err = finish_open(file, entry, generic_file_open);
 	if (err) {
@@ -549,10 +698,12 @@ static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
 			    umode_t mode)
 {
 	struct fuse_entry_out outarg;
+	struct fuse_entryver_out outver;
 	struct inode *inode;
 	struct dentry *d;
 	int err;
 	struct fuse_forget_link *forget;
+	s64 parent_version = fuse_get_attr_version_shared(dir);
 
 	forget = fuse_alloc_forget();
 	if (!forget)
@@ -560,9 +711,12 @@ static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
 
 	memset(&outarg, 0, sizeof(outarg));
 	args->in.h.nodeid = get_node_id(dir);
-	args->out.numargs = 1;
+	args->out.argvar = 1;
+	args->out.numargs = 2;
 	args->out.args[0].size = sizeof(outarg);
 	args->out.args[0].value = &outarg;
+	args->out.args[1].size = sizeof(outver);
+	args->out.args[1].value = &outver;
 	err = fuse_simple_request(fc, args);
 	if (err)
 		goto out_put_forget_req;
@@ -582,6 +736,8 @@ static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
 	}
 	kfree(forget);
 
+	fuse_set_version_ptr(inode, &outver);
+
 	d_drop(entry);
 	d = d_splice_alias(inode, entry);
 	if (IS_ERR(d))
@@ -589,9 +745,11 @@ static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
 
 	if (d) {
 		fuse_change_entry_timeout(d, &outarg);
+		fuse_dentry_setver(d, &outver, parent_version);
 		dput(d);
 	} else {
 		fuse_change_entry_timeout(entry, &outarg);
+		fuse_dentry_setver(entry, &outver, parent_version);
 	}
 	fuse_dir_changed(dir);
 	return 0;
@@ -689,10 +847,9 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 	err = fuse_simple_request(fc, &args);
 	if (!err) {
 		struct inode *inode = d_inode(entry);
-		struct fuse_inode *fi = get_fuse_inode(inode);
 
 		spin_lock(&fc->lock);
-		fi->attr_version = ++fc->attr_version;
+		fuse_update_attr_version_locked(inode);
 		/*
 		 * If i_nlink == 0 then unlink doesn't make sense, yet this can
 		 * happen if userspace filesystem is careless.  It would be
@@ -843,10 +1000,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	   etc.)
 	*/
 	if (!err) {
-		struct fuse_inode *fi = get_fuse_inode(inode);
-
 		spin_lock(&fc->lock);
-		fi->attr_version = ++fc->attr_version;
+		fuse_update_attr_version_locked(inode);
 		inc_nlink(inode);
 		spin_unlock(&fc->lock);
 		fuse_invalidate_attr(inode);
@@ -904,9 +1059,9 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 	struct fuse_attr_out outarg;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	FUSE_ARGS(args);
-	u64 attr_version;
+	s64 attr_version;
 
-	attr_version = fuse_get_attr_version(fc);
+	attr_version = fuse_get_attr_version(inode);
 
 	memset(&inarg, 0, sizeof(inarg));
 	memset(&outarg, 0, sizeof(outarg));
@@ -941,6 +1096,13 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 	return err;
 }
 
+static bool fuse_shared_version_mismatch(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return fuse_version_mismatch(inode, READ_ONCE(fi->attr_version));
+}
+
 static int fuse_update_get_attr(struct inode *inode, struct file *file,
 				struct kstat *stat, u32 request_mask,
 				unsigned int flags)
@@ -956,7 +1118,8 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 	else if (request_mask & READ_ONCE(fi->inval_mask))
 		sync = true;
 	else
-		sync = time_before64(fi->i_time, get_jiffies_64());
+		sync = (fuse_shared_version_mismatch(inode) ||
+			time_before64(fi->i_time, get_jiffies_64()));
 
 	if (sync) {
 		forget_all_cached_acls(inode);
@@ -1150,7 +1313,9 @@ static int fuse_permission(struct inode *inode, int mask)
 	}
 
 	if (fc->default_permissions) {
-		err = generic_permission(inode, mask);
+		err = -EACCES;
+		if (!refreshed && !fuse_shared_version_mismatch(inode))
+			err = generic_permission(inode, mask);
 
 		/* If permission is denied, try to refresh file
 		   attributes.  This is also needed, because the root
@@ -1459,6 +1624,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	loff_t oldsize;
 	int err;
 	bool trust_local_cmtime = is_wb && S_ISREG(inode->i_mode);
+	s64 attr_version = fuse_get_attr_version(inode);
 
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
@@ -1534,8 +1700,12 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		/* FIXME: clear I_DIRTY_SYNC? */
 	}
 
+	if (fi->version_ptr)
+		attr_version++;
+	else
+		attr_version = fuse_update_attr_version_locked(inode);
 	fuse_change_attributes_common(inode, &outarg.attr,
-				      attr_timeout(&outarg));
+				      attr_timeout(&outarg), attr_version);
 	oldsize = inode->i_size;
 	/* see the comment in fuse_change_attributes() */
 	if (!is_wb || is_truncate || !S_ISREG(inode->i_mode))
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0be5a7380b3c..4cb8c8a8011c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -376,6 +376,28 @@ void fuse_removemapping(struct inode *inode)
 	pr_debug("%s request succeeded\n", __func__);
 }
 
+s64 fuse_update_attr_version_locked(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	s64 curr_version = 0;
+
+	if (!fi->version_ptr) {
+		struct fuse_conn *fc = get_fuse_conn(inode);
+
+		curr_version = fi->attr_version = fc->attr_ctr++;
+	}
+	return curr_version;
+}
+
+static void fuse_update_attr_version(struct inode *inode)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	spin_lock(&fc->lock);
+	fuse_update_attr_version_locked(inode);
+	spin_unlock(&fc->lock);
+}
+
 void fuse_finish_open(struct inode *inode, struct file *file)
 {
 	struct fuse_file *ff = file->private_data;
@@ -386,12 +408,11 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 	if (ff->open_flags & FOPEN_NONSEEKABLE)
 		nonseekable_open(inode, file);
 	if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC)) {
-		struct fuse_inode *fi = get_fuse_inode(inode);
-
 		spin_lock(&fc->lock);
-		fi->attr_version = ++fc->attr_version;
+		fuse_update_attr_version_locked(inode);
 		i_size_write(inode, 0);
 		spin_unlock(&fc->lock);
+
 		fuse_invalidate_attr(inode);
 		if (fc->writeback_cache)
 			file_update_time(file);
@@ -806,15 +827,8 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 	if (!left && !io->blocking) {
 		ssize_t res = fuse_get_res_by_io(io);
 
-		if (res >= 0) {
-			struct inode *inode = file_inode(io->iocb->ki_filp);
-			struct fuse_conn *fc = get_fuse_conn(inode);
-			struct fuse_inode *fi = get_fuse_inode(inode);
-
-			spin_lock(&fc->lock);
-			fi->attr_version = ++fc->attr_version;
-			spin_unlock(&fc->lock);
-		}
+		if (res >= 0)
+			fuse_update_attr_version(file_inode(io->iocb->ki_filp));
 
 		io->iocb->ki_complete(io->iocb, res, 0);
 	}
@@ -883,7 +897,7 @@ static size_t fuse_send_read(struct fuse_req *req, struct fuse_io_priv *io,
 }
 
 static void fuse_read_update_size(struct inode *inode, loff_t size,
-				  u64 attr_ver)
+				  s64 attr_ver)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -891,14 +905,14 @@ static void fuse_read_update_size(struct inode *inode, loff_t size,
 	spin_lock(&fc->lock);
 	if (attr_ver == fi->attr_version && size < inode->i_size &&
 	    !test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
-		fi->attr_version = ++fc->attr_version;
+		fuse_update_attr_version_locked(inode);
 		i_size_write(inode, size);
 	}
 	spin_unlock(&fc->lock);
 }
 
 static void fuse_short_read(struct fuse_req *req, struct inode *inode,
-			    u64 attr_ver)
+			    s64 attr_ver)
 {
 	size_t num_read = req->out.args[0].size;
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -933,7 +947,7 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 	size_t num_read;
 	loff_t pos = page_offset(page);
 	size_t count = PAGE_SIZE;
-	u64 attr_ver;
+	s64 attr_ver;
 	int err;
 
 	/*
@@ -947,7 +961,7 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	attr_ver = fuse_get_attr_version(fc);
+	attr_ver = fuse_get_attr_version(inode);
 
 	req->out.page_zeroing = 1;
 	req->out.argpages = 1;
@@ -1036,7 +1050,7 @@ static void fuse_send_readpages(struct fuse_req *req, struct file *file)
 	req->out.page_zeroing = 1;
 	req->out.page_replace = 1;
 	fuse_read_fill(req, file, pos, count, FUSE_READ);
-	req->misc.read.attr_ver = fuse_get_attr_version(fc);
+	req->misc.read.attr_ver = fuse_get_attr_version(file_inode(file));
 	if (fc->async_read) {
 		req->ff = fuse_file_get(ff);
 		req->end = fuse_readpages_end;
@@ -1218,11 +1232,10 @@ static size_t fuse_send_write(struct fuse_req *req, struct fuse_io_priv *io,
 bool fuse_write_update_size(struct inode *inode, loff_t pos)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_inode *fi = get_fuse_inode(inode);
 	bool ret = false;
 
 	spin_lock(&fc->lock);
-	fi->attr_version = ++fc->attr_version;
+	fuse_update_attr_version_locked(inode);
 	if (pos > inode->i_size) {
 		i_size_write(inode, pos);
 		ret = true;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8a2604606d51..9ea5d0f760f4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -172,7 +172,7 @@ struct fuse_inode {
 	u64 orig_ino;
 
 	/** Version of last attribute change */
-	u64 attr_version;
+	s64 attr_version;
 
 	union {
 		/* Write related fields (regular file only) */
@@ -223,7 +223,7 @@ struct fuse_inode {
 	/** Miscellaneous bits describing inode state */
 	unsigned long state;
 
-	/** Lock for serializing lookup and readdir for back compatibility*/
+	/** Lock for serializing lookup and readdir for back compatibility */
 	struct mutex mutex;
 
 	/*
@@ -241,6 +241,9 @@ struct fuse_inode {
 	/** Sorted rb tree of struct fuse_dax_mapping elements */
 	struct rb_root_cached dmap_tree;
 	unsigned long nr_dmaps;
+
+	/** Pointer to shared version */
+	s64 *version_ptr;
 };
 
 /** FUSE inode state bits */
@@ -364,7 +367,7 @@ struct fuse_out {
 	unsigned numargs;
 
 	/** Array of arguments */
-	struct fuse_arg args[2];
+	struct fuse_arg args[3];
 };
 
 /** FUSE page descriptor */
@@ -386,7 +389,7 @@ struct fuse_args {
 	struct {
 		unsigned argvar:1;
 		unsigned numargs;
-		struct fuse_arg args[2];
+		struct fuse_arg args[3];
 	} out;
 };
 
@@ -486,7 +489,7 @@ struct fuse_req {
 		struct cuse_init_in cuse_init_in;
 		struct {
 			struct fuse_read_in in;
-			u64 attr_ver;
+			s64 attr_ver;
 		} read;
 		struct {
 			struct fuse_write_in in;
@@ -869,7 +872,7 @@ struct fuse_conn {
 	struct fuse_req *destroy_req;
 
 	/** Version counter for attribute changes */
-	u64 attr_version;
+	s64 attr_ctr;
 
 	/** Called on final put */
 	void (*release)(struct fuse_conn *);
@@ -953,7 +956,7 @@ int fuse_inode_eq(struct inode *inode, void *_nodeidp);
  */
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
-			u64 attr_valid, u64 attr_version);
+			u64 attr_valid, s64 attr_version);
 
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
 		     struct fuse_entry_out *outarg, struct inode **inode);
@@ -1027,10 +1030,10 @@ void fuse_init_symlink(struct inode *inode);
  * Change attributes of an inode
  */
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
-			    u64 attr_valid, u64 attr_version);
+			    u64 attr_valid, s64 attr_version);
 
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
-				   u64 attr_valid);
+				   u64 attr_valid, s64 attr_version);
 
 /**
  * Initialize the client device
@@ -1195,7 +1198,7 @@ void fuse_flush_writepages(struct inode *inode);
 void fuse_set_nowrite(struct inode *inode);
 void fuse_release_nowrite(struct inode *inode);
 
-u64 fuse_get_attr_version(struct fuse_conn *fc);
+s64 fuse_get_attr_version(struct inode *inode);
 
 /**
  * File-system tells the kernel to invalidate cache for the given node id.
@@ -1281,4 +1284,6 @@ u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_dax_free_mem_worker(struct work_struct *work);
 void fuse_removemapping(struct inode *inode);
 
+s64 fuse_update_attr_version_locked(struct inode *inode);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d44827bbfa3d..ea2be153a322 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -82,6 +82,8 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->nodeid = 0;
 	fi->nlookup = 0;
 	fi->attr_version = 0;
+	fi->state = 0;
+	fi->version_ptr = NULL;
 	fi->orig_ino = 0;
 	fi->state = 0;
 	fi->nr_dmaps = 0;
@@ -153,12 +155,11 @@ static ino_t fuse_squash_ino(u64 ino64)
 }
 
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
-				   u64 attr_valid)
+				   u64 attr_valid, s64 attr_version)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
-	fi->attr_version = ++fc->attr_version;
 	fi->i_time = attr_valid;
 	WRITE_ONCE(fi->inval_mask, 0);
 
@@ -193,10 +194,13 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		inode->i_mode &= ~S_ISVTX;
 
 	fi->orig_ino = attr->ino;
+	smp_wmb();
+	WRITE_ONCE(fi->attr_version, attr_version);
+
 }
 
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
-			    u64 attr_valid, u64 attr_version)
+			    u64 attr_valid, s64 attr_version)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -205,14 +209,17 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	struct timespec64 old_mtime;
 
 	spin_lock(&fc->lock);
-	if ((attr_version != 0 && fi->attr_version > attr_version) ||
-	    test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
+	if (test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
+		spin_unlock(&fc->lock);
+		return;
+	}
+	if (attr_version != 0 && fi->attr_version > attr_version) {
 		spin_unlock(&fc->lock);
 		return;
 	}
 
 	old_mtime = inode->i_mtime;
-	fuse_change_attributes_common(inode, attr, attr_valid);
+	fuse_change_attributes_common(inode, attr, attr_valid, attr_version);
 
 	oldsize = inode->i_size;
 	/*
@@ -291,7 +298,7 @@ static int fuse_inode_set(struct inode *inode, void *_nodeidp)
 
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
-			u64 attr_valid, u64 attr_version)
+			u64 attr_valid, s64 attr_version)
 {
 	struct inode *inode;
 	struct fuse_inode *fi;
@@ -709,7 +716,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->blocked = 0;
 	fc->initialized = 0;
 	fc->connected = 1;
-	fc->attr_version = 1;
+	fc->attr_ctr = 1;
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
 	fc->dax_dev = dax_dev;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index ab18b78f4755..e3ecc56013b8 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -147,7 +147,7 @@ static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
 
 static int fuse_direntplus_link(struct file *file,
 				struct fuse_direntplus *direntplus,
-				u64 attr_version)
+				s64 attr_version)
 {
 	struct fuse_entry_out *o = &direntplus->entry_out;
 	struct fuse_dirent *dirent = &direntplus->dirent;
@@ -212,6 +212,9 @@ static int fuse_direntplus_link(struct file *file,
 			return -EIO;
 		}
 
+		/* FIXME: translate version_ptr on reading from device... */
+		/* fuse_set_version_ptr(inode, o); */
+
 		fi = get_fuse_inode(inode);
 		spin_lock(&fc->lock);
 		fi->nlookup++;
@@ -231,6 +234,7 @@ static int fuse_direntplus_link(struct file *file,
 				  attr_version);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
+		/* else fuse_set_version_ptr(inode, o); */
 
 		alias = d_splice_alias(inode, dentry);
 		d_lookup_done(dentry);
@@ -250,7 +254,7 @@ static int fuse_direntplus_link(struct file *file,
 }
 
 static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
-			     struct dir_context *ctx, u64 attr_version)
+			     struct dir_context *ctx, s64 attr_version)
 {
 	struct fuse_direntplus *direntplus;
 	struct fuse_dirent *dirent;
@@ -301,7 +305,7 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	struct inode *inode = file_inode(file);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_req *req;
-	u64 attr_version = 0;
+	s64 attr_version = 0;
 	bool locked;
 
 	req = fuse_get_req(fc, 1);
@@ -320,7 +324,7 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	req->pages[0] = page;
 	req->page_descs[0].length = PAGE_SIZE;
 	if (plus) {
-		attr_version = fuse_get_attr_version(fc);
+		attr_version = fuse_get_attr_version(inode);
 		fuse_read_fill(req, file, ctx->pos, PAGE_SIZE,
 			       FUSE_READDIRPLUS);
 	} else {
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1657253cb7d6..301c3c23228f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -427,6 +427,11 @@ struct fuse_entry_out {
 	struct fuse_attr attr;
 };
 
+struct fuse_entryver_out {
+	uint64_t	version_index;
+	int64_t		initial_version;
+};
+
 struct fuse_forget_in {
 	uint64_t	nlookup;
 };
-- 
2.13.6

