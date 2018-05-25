Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161666AbeEYAJA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:09:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965158AbeEYAIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:08:53 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 32/32] [RFC] fsinfo: Add a system call to allow querying of
 filesystem information [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:08:51 +0100
Message-ID: <152720693123.9073.4511934790831409009.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a system call to allow filesystem information to be queried.  This is
implemented as a function switch where the desired attribute value or
values is nominated.


===============
NEW SYSTEM CALL
===============

The new system call looks like:

	int ret = fsinfo(int dfd,
			 const char *filename,
			 const struct fsinfo_params *params,
			 void *buffer,
			 size_t buf_size);

The params parameter optionally points to a block of parameters:

	struct fsinfo_params {
		enum fsinfo_attribute	request;
		__u32			Nth;
		__u32			at_flags;
		__u32			__spare[6];
	};

If params is NULL, it is assumed params->request should be
fsinfo_attr_statfs, params->Nth should be 0 and params->at_flags should be
0.

If params is given, all of params->__spare[] must be 0.

dfd, filename and params->at_flags indicate the file to query.  There is no
equivalent of lstat() as that can be emulated with fsinfo() by setting
AT_SYMLINK_NOFOLLOW in params->at_flags.  There is also no equivalent of
fstat() as that can be emulated by passing a NULL filename to fsinfo() with
the fd of interest in dfd.  AT_NO_AUTOMOUNT can also be used to an allow
automount point to be queried without triggering it.

AT_FORCE_ATTR_SYNC can be set in params->at_flags.  This will require a
network filesystem to synchronise its attributes with the server.

AT_NO_ATTR_SYNC can be set in params->at_flags.  This will suppress
synchronisation with the server in a network filesystem.  The resulting
values should be considered approximate.

params->request indicates the attribute/attributes to be queried.  This can
be one of:

	fsinfo_attr_statfs		- statfs-style info
	fsinfo_attr_fsinfo		- Information about fsinfo()
	fsinfo_attr_limits		- Filesystem limits
	fsinfo_attr_capabilities	- Filesystem capabilities
	fsinfo_attr_timestamp_info	- Inode timestamp info
	fsinfo_attr_volume_id		- Volume ID (var length)
	fsinfo_attr_volume_uuid		- Volume UUID
	fsinfo_attr_volume_name		- Volume name (string)
	fsinfo_attr_cell_name		- Cell name (string)
	fsinfo_attr_domain_name		- Domain name (string)
	fsinfo_attr_realm_name		- Realm name (string)
	fsinfo_attr_server_name		- Name of the Nth server (string)
	fsinfo_attr_server_addresses	- Addresses of the Nth server
	fsinfo_attr_error_state		- Error state
	fsinfo_attr_parameter		- Nth mount parameter (string)
	fsinfo_attr_source		- Nth mount source name (string)
	fsinfo_attr_name_encoding	- Filename encoding (string)
	fsinfo_attr_name_codepage	- Filename codepage (string)
	fsinfo_attr_io_size		- Optimal I/O sizes

Some attributes (such as the servers backing a network filesystem) can have
multiple values.  These can be enumerated by setting params->Nth to 0, 1,
... until ENODATA is returned.

buffer and buf_size point to the reply buffer.  The buffer is filled up to the
specified size, even if this means truncating the reply.  The full size of the
reply is returned.  In future versions, this will allow extra fields to be
tacked on to the end of the reply, but anyone not expecting them will only get
the subset they're expecting.  If either buffer of buf_size are 0, no copy
will take place and the data size will be returned.

At the moment, this will only work on x86_64 and i386 as it requires the system
call to be wired up.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/statfs.c                            |  431 ++++++++++++++++++++++++++++++++
 include/linux/fs.h                     |    4 
 include/linux/fsinfo.h                 |   25 ++
 include/linux/syscalls.h               |    3 
 include/uapi/linux/fsinfo.h            |  231 +++++++++++++++++
 samples/statx/Makefile                 |    5 
 samples/statx/test-fsinfo.c            |  179 +++++++++++++
 9 files changed, 879 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 samples/statx/test-fsinfo.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 76c95f35a599..d447f9fe28b4 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -401,3 +401,4 @@
 387	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 388	i386	fspick			sys_fspick			__ia32_sys_fspick
 389	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
+390	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b53080b756e8..dce56e0507ef 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -346,6 +346,7 @@
 335	common	fsmount			__x64_sys_fsmount
 336	common	fspick			__x64_sys_fspick
 337	common	move_mount		__x64_sys_move_mount
+338	common	fsinfo			__x64_sys_fsinfo
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/statfs.c b/fs/statfs.c
index 5b2a24f0f263..07437780a30c 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -9,6 +9,7 @@
 #include <linux/security.h>
 #include <linux/uaccess.h>
 #include <linux/compat.h>
+#include <linux/fsinfo.h>
 #include "internal.h"
 
 static int flags_by_mnt(int mnt_flags)
@@ -384,3 +385,433 @@ COMPAT_SYSCALL_DEFINE2(ustat, unsigned, dev, struct compat_ustat __user *, u)
 	return 0;
 }
 #endif
+
+/*
+ * Get basic filesystem stats from statfs.
+ */
+static int fsinfo_generic_statfs(struct dentry *dentry,
+				 struct fsinfo_statfs *p)
+{
+	struct super_block *sb;
+	struct kstatfs buf;
+	int ret;
+
+	ret = statfs_by_dentry(dentry, &buf);
+	if (ret < 0)
+		return ret;
+
+	sb = dentry->d_sb;
+	p->f_fstype	= sb->s_magic;
+	p->f_dev_major	= MAJOR(sb->s_dev);
+	p->f_dev_minor	= MINOR(sb->s_dev);
+	p->f_blocks	= buf.f_blocks;
+	p->f_bfree	= buf.f_bfree;
+	p->f_bavail	= buf.f_bavail;
+	p->f_files	= buf.f_files;
+	p->f_ffree	= buf.f_ffree;
+	p->f_favail	= buf.f_ffree;
+	p->f_bsize	= buf.f_bsize;
+	p->f_frsize	= buf.f_frsize;
+	p->f_flags	= ST_VALID | flags_by_sb(sb->s_flags);
+
+	memcpy(&p->f_fsid, &buf.f_fsid, sizeof(p->f_fsid));
+	strcpy(p->f_fs_name, dentry->d_sb->s_type->name);
+	return sizeof(*p);
+}
+
+static int fsinfo_generic_limits(struct dentry *dentry,
+				 struct fsinfo_limits *lim)
+{
+	struct super_block *sb = dentry->d_sb;
+
+	lim->max_file_size = sb->s_maxbytes;
+	lim->max_hard_links = sb->s_max_links;
+	lim->max_uid = UINT_MAX;
+	lim->max_gid = UINT_MAX;
+	lim->max_projid = UINT_MAX;
+	lim->max_filename_len = NAME_MAX;
+	lim->max_symlink_len = PAGE_SIZE;
+	lim->max_xattr_name_len = XATTR_NAME_MAX;
+	lim->max_xattr_body_len = XATTR_SIZE_MAX;
+	lim->max_dev_major = 0xffffff;
+	lim->max_dev_minor = 0xff;
+	return sizeof(*lim);
+}
+
+static inline void set_cap(struct fsinfo_capabilities *c,
+			   enum fsinfo_capability cap)
+{
+	c->capabilities[cap / 8] |= 1 << (cap % 8);
+}
+
+static int fsinfo_generic_capabilities(struct dentry *dentry,
+				       struct fsinfo_capabilities *c)
+{
+	struct super_block *sb = dentry->d_sb;
+
+	c->supported_stx_mask = STATX_BASIC_STATS;
+	c->supported_stx_attributes = 0;
+
+	if (sb->s_mtd)
+		set_cap(c, fsinfo_cap_is_flash_fs);
+	else if (sb->s_bdev)
+		set_cap(c, fsinfo_cap_is_block_fs);
+
+	if (sb->s_quota_types & QTYPE_MASK_USR)
+		set_cap(c, fsinfo_cap_user_quotas);
+	if (sb->s_quota_types & QTYPE_MASK_GRP)
+		set_cap(c, fsinfo_cap_group_quotas);
+	if (sb->s_quota_types & QTYPE_MASK_PRJ)
+		set_cap(c, fsinfo_cap_project_quotas);
+	if (sb->s_xattr)
+		set_cap(c, fsinfo_cap_xattrs);
+	if (sb->s_d_op && sb->s_d_op->d_automount)
+		set_cap(c, fsinfo_cap_automounts);
+	if (sb->s_id[0])
+		set_cap(c, fsinfo_cap_volume_name);
+	set_cap(c, fsinfo_cap_no_unix_mode);
+	return sizeof(*c);
+}
+
+static int fsinfo_generic_timestamp_info(struct dentry *dentry,
+					 struct fsinfo_timestamp_info *ts)
+{
+	struct super_block *sb = dentry->d_sb;
+
+	/* If unset, assume 1s granularity */
+	u16 mantissa = 1;
+	s8 exponent = 0;
+
+	ts->minimum_timestamp = S64_MIN;
+	ts->maximum_timestamp = S64_MAX;
+	if (sb->s_time_gran < 1000000000) {
+		if (sb->s_time_gran < 1000)
+			exponent = -9;
+		else if (sb->s_time_gran < 1000000)
+			exponent = -6;
+		else
+			exponent = -3;
+	}
+#define set_gran(x)				\
+	do {					\
+		ts->x##_mantissa = mantissa;	\
+		ts->x##_exponent = exponent;	\
+	} while (0)
+	set_gran(atime_gran);
+	set_gran(btime_gran);
+	set_gran(ctime_gran);
+	set_gran(mtime_gran);
+	return sizeof(*ts);
+}
+
+static int fsinfo_generic_volume_uuid(struct dentry *dentry,
+				      struct fsinfo_volume_uuid *vu)
+{
+	struct super_block *sb = dentry->d_sb;
+
+	memcpy(vu, &sb->s_uuid, sizeof(*vu));
+	return sizeof(*vu);
+}
+
+static int fsinfo_generic_volume_name(struct dentry *dentry, char *buf)
+{
+	struct super_block *sb = dentry->d_sb;
+	size_t len = strlen(sb->s_id);
+
+	if (buf)
+		memcpy(buf, sb->s_id, len + 1);
+	return len;
+}
+
+static int fsinfo_generic_name_encoding(struct dentry *dentry, char *buf)
+{
+	static const char encoding[] = "utf8";
+
+	if (buf)
+		memcpy(buf, encoding, sizeof(encoding) - 1);
+	return sizeof(encoding) - 1;
+}
+
+static int fsinfo_generic_io_size(struct dentry *dentry,
+				  struct fsinfo_io_size *c)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct kstatfs buf;
+	int ret;
+
+	if (sb->s_op->statfs == simple_statfs) {
+		c->block_size = PAGE_SIZE;
+		c->max_single_read_size = 0;
+		c->max_single_write_size = 0;
+		c->best_read_size = PAGE_SIZE;
+		c->best_write_size = PAGE_SIZE;
+	} else {
+		ret = statfs_by_dentry(dentry, &buf);
+		if (ret < 0)
+			return ret;
+		c->block_size = buf.f_bsize;
+		c->max_single_read_size = buf.f_bsize;
+		c->max_single_write_size = buf.f_bsize;
+		c->best_read_size = PAGE_SIZE;
+		c->best_write_size = PAGE_SIZE;
+	}
+	return sizeof(*c);
+}
+
+/*
+ * Implement some queries generically from stuff in the superblock.
+ */
+int generic_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
+{
+#define _gen(X) fsinfo_attr_##X: return fsinfo_generic_##X(dentry, params->buffer)
+
+	switch (params->request) {
+	case _gen(statfs);
+	case _gen(limits);
+	case _gen(capabilities);
+	case _gen(timestamp_info);
+	case _gen(volume_uuid);
+	case _gen(volume_name);
+	case _gen(name_encoding);
+	case _gen(io_size);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/*
+ * Retrieve the filesystem info.  We make some stuff up if the operation is not
+ * supported.
+ */
+int vfs_fsinfo(const struct path *path, struct fsinfo_kparams *params)
+{
+	struct dentry *dentry = path->dentry;
+	int (*get_fsinfo)(struct dentry *, struct fsinfo_kparams *);
+	int ret;
+
+	if (params->request == fsinfo_attr_fsinfo) {
+		struct fsinfo_fsinfo *info = params->buffer;
+
+		info->max_attr	= fsinfo_attr__nr;
+		info->max_cap	= fsinfo_cap__nr;
+		return sizeof(*info);
+	}
+
+	get_fsinfo = dentry->d_sb->s_op->get_fsinfo;
+	if (!get_fsinfo) {
+		if (!dentry->d_sb->s_op->statfs)
+			return -EOPNOTSUPP;
+		get_fsinfo = generic_fsinfo;
+	}
+
+	ret = security_sb_statfs(dentry);
+	if (ret)
+		return ret;
+
+	ret = get_fsinfo(dentry, params);
+	if (ret < 0)
+		return ret;
+
+	if (params->request == fsinfo_attr_statfs &&
+	    params->buffer) {
+		struct fsinfo_statfs *p = params->buffer;
+
+		p->f_flags |= flags_by_mnt(path->mnt->mnt_flags);
+	}
+	return 0;
+}
+
+static int vfs_fsinfo_path(int dfd, const char __user *filename,
+			   struct fsinfo_kparams *params)
+{
+	struct path path;
+	unsigned lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
+	int ret = -EINVAL;
+
+	if ((params->at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
+				 AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	if (params->at_flags & AT_SYMLINK_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
+	if (params->at_flags & AT_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (params->at_flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+retry:
+	ret = user_path_at(dfd, filename, lookup_flags, &path);
+	if (ret)
+		goto out;
+
+	ret = vfs_fsinfo(&path, params);
+	path_put(&path);
+	if (retry_estale(ret, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		goto retry;
+	}
+out:
+	return ret;
+}
+
+static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams *params)
+{
+	struct fd f = fdget_raw(fd);
+	int ret = -EBADF;
+
+	if (f.file) {
+		ret = vfs_fsinfo(&f.file->f_path, params);
+		fdput(f);
+	}
+	return ret;
+}
+
+/*
+ * Return buffer information by requestable attribute.
+ *
+ * STRUCT indicates a fixed-size structure with only one instance.
+ * STRUCT_N indicates a fixed-size structure that may have multiple instances.
+ * STRING indicates a string with only one instance.
+ * STRING_N indicates a string that may have multiple instances.
+ * STRUCT_ARRAY indicates an array of fixed-size structs with only one instance.
+ * STRUCT_ARRAY_N as above that may have multiple instances.
+ *
+ * If an entry is marked STRUCT or STRUCT_N then if no buffer is supplied to
+ * sys_fsinfo(), sys_fsinfo() will handle returning the buffer size without
+ * calling vfs_fsinfo() and the filesystem.
+ *
+ * No struct may have more than 252 bytes (ie. 0x3f * 4)
+ */
+#define FSINFO_STRUCT(N)	 [fsinfo_attr_##N] = sizeof(struct fsinfo_##N)/sizeof(__u32)
+#define FSINFO_STRING(N)	 [fsinfo_attr_##N] = 0x80
+#define FSINFO_STRUCT_ARRAY(N)	 [fsinfo_attr_##N] = 0x80 | sizeof(struct fsinfo_##N)
+#define FSINFO_STRUCT_N(N)	 [fsinfo_attr_##N] = 0xc0 | sizeof(struct fsinfo_##N)/sizeof(__u32)
+#define FSINFO_STRING_N(N)	 [fsinfo_attr_##N] = 0xc0
+#define FSINFO_STRUCT_ARRAY_N(N) [fsinfo_attr_##N] = 0xc0 | sizeof(struct fsinfo_##N)
+static const u8 fsinfo_buffer_sizes[fsinfo_attr__nr] = {
+	FSINFO_STRUCT(statfs),
+	FSINFO_STRUCT(fsinfo),
+	FSINFO_STRUCT(limits),
+	FSINFO_STRUCT_ARRAY(capabilities),
+	FSINFO_STRUCT(timestamp_info),
+	FSINFO_STRING(volume_id),
+	FSINFO_STRUCT(volume_uuid),
+	FSINFO_STRING(volume_name),
+	FSINFO_STRING(cell_name),
+	FSINFO_STRING(domain_name),
+	FSINFO_STRING(realm_name),
+	FSINFO_STRING_N(server_name),
+	FSINFO_STRUCT_ARRAY_N	(server_addresses),
+	FSINFO_STRUCT(error_state),
+	FSINFO_STRING_N(parameter),
+	FSINFO_STRING_N(source),
+	FSINFO_STRING(name_encoding),
+	FSINFO_STRING(name_codepage),
+	FSINFO_STRUCT(io_size),
+};
+
+/**
+ * sys_fsinfo - System call to get filesystem information
+ * @dfd: Base directory to pathwalk from or fd referring to filesystem.
+ * @filename: Filesystem to query or NULL.
+ * @_params: Parameters to define request (or NULL for enhanced statfs).
+ * @_buffer: Result buffer.
+ * @buf_size: Size of result buffer.
+ *
+ * Get information on a filesystem.  The filesystem attribute to be queried is
+ * indicated by @_params->request, and some of the attributes can have multiple
+ * values, indexed by @_params->Nth.  If @_params is NULL, then the 0th
+ * fsinfo_attr_statfs attribute is queried.  If an attribute does not exist,
+ * EOPNOTSUPP is returned; if the Nth value does not exist, ENODATA is
+ * returned.
+ *
+ * On success, the size of the attribute's value is returned.  If @buf_size is
+ * 0 or @_buffer is NULL, only the size is returned.  If the size of the value
+ * is larger than @buf_size, it will be truncated by the copy.  The full size
+ * of the value will be returned.
+ */
+SYSCALL_DEFINE5(fsinfo,
+		int, dfd, const char __user *, filename,
+		struct fsinfo_params *, _params,
+		void __user *, _buffer, size_t, buf_size)
+{
+	struct fsinfo_params user_params;
+	struct fsinfo_kparams params;
+	size_t size;
+	int ret;
+
+	if (!access_ok(VERIFY_WRITE, _buffer, buf_size))
+		return -EFAULT;
+
+	if (_params) {
+		if (copy_from_user(&user_params, _params, sizeof(user_params)))
+			return -EFAULT;
+		if (user_params.__spare[0] ||
+		    user_params.__spare[1] ||
+		    user_params.__spare[2] ||
+		    user_params.__spare[3] ||
+		    user_params.__spare[4] ||
+		    user_params.__spare[5])
+			return -EINVAL;
+		if (user_params.request > fsinfo_attr__nr)
+			return -EOPNOTSUPP;
+		params.request = user_params.request;
+		params.Nth = user_params.Nth;
+		params.at_flags = user_params.at_flags;
+	} else {
+		params.request = fsinfo_attr_statfs;
+		params.Nth = 0;
+		params.at_flags = AT_SYMLINK_FOLLOW;
+	}
+
+	if (!_buffer)
+		buf_size = 0;
+
+	/* Allocate an appropriately-sized buffer.  We will truncate the
+	 * contents when we write the contents back to userspace.
+	 */
+	size = fsinfo_buffer_sizes[params.request];
+	if (!(size & 0x40) && params.Nth != 0)
+		return -ENODATA;
+	size &= ~0x40;
+	if (size == 0)
+		return -ENOBUFS;
+	if (size & 0x80) {
+		size = 4096;
+	} else {
+		size *= sizeof(__u32);
+		if (buf_size == 0)
+			return size; /* We know how big the buffer should be */
+	}
+
+	if (buf_size > 0) {
+		params.buf_size = size;
+		params.buffer = kzalloc(size, GFP_KERNEL);
+		if (!params.buffer)
+			return -ENOMEM;
+	} else {
+		params.buf_size = 0;
+		params.buffer = NULL;
+	}
+
+	if (filename)
+		ret = vfs_fsinfo_path(dfd, filename, &params);
+	else
+		ret = vfs_fsinfo_fd(dfd, &params);
+	if (ret < 0)
+		goto error;
+
+	if (ret == 0) {
+		ret = -ENODATA;
+		goto error;
+	}
+
+	if (buf_size > ret)
+		buf_size = ret;
+
+	if (copy_to_user(_buffer, params.buffer, buf_size))
+		ret = -EFAULT;
+error:
+	kfree(params.buffer);
+	return ret;
+}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 40890e3359f0..a339c5560506 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -61,6 +61,8 @@ struct iov_iter;
 struct fscrypt_info;
 struct fscrypt_operations;
 struct fs_context;
+struct fsinfo_kparams;
+enum fsinfo_attribute;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1835,6 +1837,7 @@ struct super_operations {
 	int (*thaw_super) (struct super_block *);
 	int (*unfreeze_fs) (struct super_block *);
 	int (*statfs) (struct dentry *, struct kstatfs *);
+	int (*get_fsinfo) (struct dentry *, struct fsinfo_kparams *);
 	int (*remount_fs) (struct super_block *, int *, char *, size_t);
 	int (*reconfigure) (struct super_block *, struct fs_context *);
 	void (*umount_begin) (struct super_block *);
@@ -2200,6 +2203,7 @@ extern int iterate_mounts(int (*)(struct vfsmount *, void *), void *,
 extern int vfs_statfs(const struct path *, struct kstatfs *);
 extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
+extern int vfs_fsinfo(const struct path *, struct fsinfo_kparams *);
 extern int freeze_super(struct super_block *super);
 extern int thaw_super(struct super_block *super);
 extern bool our_mnt(struct vfsmount *mnt);
diff --git a/include/linux/fsinfo.h b/include/linux/fsinfo.h
new file mode 100644
index 000000000000..4832064653ab
--- /dev/null
+++ b/include/linux/fsinfo.h
@@ -0,0 +1,25 @@
+/* Filesystem information query
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_FSINFO_H
+#define _LINUX_FSINFO_H
+
+#include <uapi/linux/fsinfo.h>
+
+struct fsinfo_kparams {
+	enum fsinfo_attribute	request;	/* What is being asking for */
+	__u32			Nth;		/* Instance of it (some may have multiple) */
+	__u32			at_flags;	/* AT_SYMLINK_NOFOLLOW and similar */
+	void			*buffer;	/* Where to place the reply */
+	size_t			buf_size;	/* Size of the buffer */
+};
+
+#endif /* _LINUX_FSINFO_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index bf89f57046dc..14be5dc15a13 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -49,6 +49,7 @@ struct stat64;
 struct statfs;
 struct statfs64;
 struct statx;
+struct fsinfo_params;
 struct __sysctl_args;
 struct sysinfo;
 struct timespec;
@@ -904,6 +905,8 @@ asmlinkage long sys_fspick(int dfd, const char *path, unsigned int at_flags);
 asmlinkage long sys_move_mount(int from_dfd, const char *from_path,
 			       int to_dfd, const char *to_path,
 			       unsigned int ms_flags);
+asmlinkage long sys_fsinfo(int dfd, const char *path, struct fsinfo_params *params,
+			   void *buffer, size_t buf_size);
 
 
 /*
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
new file mode 100644
index 000000000000..972feebaf2ed
--- /dev/null
+++ b/include/uapi/linux/fsinfo.h
@@ -0,0 +1,231 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* fsinfo() definitions.
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#ifndef _UAPI_LINUX_FSINFO_H
+#define _UAPI_LINUX_FSINFO_H
+
+/*
+ * The filesystem attributes that can be requested.  Note that some attributes
+ * may have multiple instances which can be switched in the parameter block.
+ */
+enum fsinfo_attribute {
+	fsinfo_attr_statfs		= 0,	/* Extended filesystem information */
+	fsinfo_attr_fsinfo		= 1,	/* Information about fsinfo() */
+	fsinfo_attr_limits		= 2,	/* Filesystem limits */
+	fsinfo_attr_capabilities	= 3,	/* Filesystem capabilities (bits) */
+	fsinfo_attr_timestamp_info	= 4,	/* Inode timestamp info */
+	fsinfo_attr_volume_id		= 5,	/* Volume ID (var length) */
+	fsinfo_attr_volume_uuid		= 6,	/* Volume UUID (LE uuid) */
+	fsinfo_attr_volume_name		= 7,	/* Volume name (string) */
+	fsinfo_attr_cell_name		= 8,	/* Cell name (string) */
+	fsinfo_attr_domain_name		= 9,	/* Domain name (string) */
+	fsinfo_attr_realm_name		= 10,	/* Realm name (string) */
+	fsinfo_attr_server_name		= 11,	/* Name of the Nth server */
+	fsinfo_attr_server_addresses	= 12,	/* Addresses of the Nth server */
+	fsinfo_attr_error_state		= 13,	/* Error state */
+	fsinfo_attr_parameter		= 14,	/* Nth mount parameter (string) */
+	fsinfo_attr_source		= 15,	/* Nth mount source name (string) */
+	fsinfo_attr_name_encoding	= 16,	/* Filename encoding (string) */
+	fsinfo_attr_name_codepage	= 17,	/* Filename codepage (string) */
+	fsinfo_attr_io_size		= 18,	/* Optimal I/O sizes */
+	fsinfo_attr__nr
+};
+
+/*
+ * Optional fsinfo() parameter structure.
+ *
+ * If this is not given, it is assumed that fsinfo_attr_statfs instance 0 is
+ * desired.
+ */
+struct fsinfo_params {
+	enum fsinfo_attribute	request;	/* What is being asking for */
+	__u32			Nth;		/* Instance of it (some may have multiple) */
+	__u32			at_flags;	/* AT_SYMLINK_NOFOLLOW and similar flags */
+	__u32			__spare[6];	/* Spare params; all must be 0 */
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_statfs).
+ * - This gives extended filesystem information.
+ */
+struct fsinfo_statfs {
+	/* 0x00 - General info */
+	__u32	f_fstype;	/* Filesystem type from linux/magic.h [uncond] */
+	__u32	f_dev_major;	/* As st_dev_* from struct statx [uncond] */
+	__u32	f_dev_minor;
+	__u32	__spare0c[1];
+
+	/* 0x10 - statfs information */
+	__u64	f_blocks;	/* Total number of blocks in fs */
+	__u64	f_bfree;	/* Total number of free blocks */
+	__u64	f_bavail;	/* Number of free blocks available to ordinary user */
+	__u64	f_files;	/* Total number of file nodes in fs */
+	__u64	f_ffree;	/* Number of free file nodes */
+	__u64	f_favail;	/* Number of free file nodes available to ordinary user */
+	/* 0x40 */
+	__u32	f_bsize;	/* Optimal block size */
+	__u32	f_frsize;	/* Fragment size */
+	__u64	f_flags;	/* Filesystem mount flags (MS_*) */
+	/* 0x50 */
+	__u64	f_fsid;		/* Short 64-bit Filesystem ID (as statfs) */
+	__u64	f_sb_id;	/* Internal superblock ID for sbnotify()/mntnotify() */
+	/* 0x60 - Filesystem type name */
+	char	f_fs_name[15 + 1];
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_id).
+ * - This gives filesystem identifiers.
+ */
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_limits).
+ *
+ * List of supported filesystem limits.
+ */
+struct fsinfo_limits {
+	__u64	max_file_size;			/* Maximum file size */
+	__u64	max_uid;			/* Maximum UID supported */
+	__u64	max_gid;			/* Maximum GID supported */
+	__u64	max_projid;			/* Maximum project ID supported */
+	__u32	max_dev_major;			/* Maximum device major representable */
+	__u32	max_dev_minor;			/* Maximum device minor representable */
+	__u32	max_hard_links;			/* Maximum number of hard links on a file */
+	__u32	max_xattr_body_len;		/* Maximum xattr content length */
+	__u16	max_xattr_name_len;		/* Maximum xattr name length */
+	__u16	max_filename_len;		/* Maximum filename length */
+	__u16	max_symlink_len;		/* Maximum symlink content length */
+	__u16	__spare;
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_capabilities).
+ *
+ * Bitmask indicating filesystem capabilities where renderable as single bits.
+ */
+enum fsinfo_capability {
+	fsinfo_cap_is_kernel_fs		= 0,	/* fs is kernel-special filesystem */
+	fsinfo_cap_is_block_fs		= 1,	/* fs is block-based filesystem */
+	fsinfo_cap_is_flash_fs		= 2,	/* fs is flash filesystem */
+	fsinfo_cap_is_network_fs	= 3,	/* fs is network filesystem */
+	fsinfo_cap_is_automounter_fs	= 4,	/* fs is automounter special filesystem */
+	fsinfo_cap_automounts		= 5,	/* fs supports automounts */
+	fsinfo_cap_adv_locks		= 6,	/* fs supports advisory file locking */
+	fsinfo_cap_mand_locks		= 7,	/* fs supports mandatory file locking */
+	fsinfo_cap_leases		= 8,	/* fs supports file leases */
+	fsinfo_cap_uids			= 9,	/* fs supports numeric uids */
+	fsinfo_cap_gids			= 10,	/* fs supports numeric gids */
+	fsinfo_cap_projids		= 11,	/* fs supports numeric project ids */
+	fsinfo_cap_id_names		= 12,	/* fs supports user names */
+	fsinfo_cap_id_guids		= 13,	/* fs supports user guids */
+	fsinfo_cap_windows_attrs	= 14,	/* fs has windows attributes */
+	fsinfo_cap_user_quotas		= 15,	/* fs has per-user quotas */
+	fsinfo_cap_group_quotas		= 16,	/* fs has per-group quotas */
+	fsinfo_cap_project_quotas	= 17,	/* fs has per-project quotas */
+	fsinfo_cap_xattrs		= 18,	/* fs has xattrs */
+	fsinfo_cap_journal		= 19,	/* fs has a journal */
+	fsinfo_cap_data_is_journalled	= 20,	/* fs is using data journalling */
+	fsinfo_cap_o_sync		= 21,	/* fs supports O_SYNC */
+	fsinfo_cap_o_direct		= 22,	/* fs supports O_DIRECT */
+	fsinfo_cap_volume_id		= 23,	/* fs has a volume ID */
+	fsinfo_cap_volume_uuid		= 24,	/* fs has a volume UUID */
+	fsinfo_cap_volume_name		= 25,	/* fs has a volume name */
+	fsinfo_cap_volume_fsid		= 26,	/* fs has a volume FSID */
+	fsinfo_cap_cell_name		= 27,	/* fs has a cell name */
+	fsinfo_cap_domain_name		= 28,	/* fs has a domain name */
+	fsinfo_cap_realm_name		= 29,	/* fs has a realm name */
+	fsinfo_cap_iver_all_change	= 30,	/* i_version represents data + meta changes */
+	fsinfo_cap_iver_data_change	= 31,	/* i_version represents data changes only */
+	fsinfo_cap_iver_mono_incr	= 32,	/* i_version incremented monotonically */
+	fsinfo_cap_symlinks		= 33,	/* fs supports symlinks */
+	fsinfo_cap_hard_links		= 34,	/* fs supports hard links */
+	fsinfo_cap_hard_links_1dir	= 35,	/* fs supports hard links in same dir only */
+	fsinfo_cap_device_files		= 36,	/* fs supports bdev, cdev */
+	fsinfo_cap_unix_specials	= 37,	/* fs supports pipe, fifo, socket */
+	fsinfo_cap_resource_forks	= 38,	/* fs supports resource forks/streams */
+	fsinfo_cap_name_case_indep	= 39,	/* Filename case independence is mandatory */
+	fsinfo_cap_name_non_utf8	= 40,	/* fs has non-utf8 names */
+	fsinfo_cap_name_has_codepage	= 41,	/* fs has a filename codepage */
+	fsinfo_cap_sparse		= 42,	/* fs supports sparse files */
+	fsinfo_cap_not_persistent	= 43,	/* fs is not persistent */
+	fsinfo_cap_no_unix_mode		= 44,	/* fs does not support unix mode bits */
+	fsinfo_cap__nr
+};
+
+struct fsinfo_capabilities {
+	__u64	supported_stx_attributes;	/* What statx::stx_attributes are supported */
+	__u32	supported_stx_mask;		/* What statx::stx_mask bits are supported */
+	__u32	supported_ioc_flags;		/* What FS_IOC_* flags are supported */
+	__u8	capabilities[(fsinfo_cap__nr + 7) / 8];
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_timestamp_info).
+ */
+struct fsinfo_timestamp_info {
+	__s64	minimum_timestamp;	/* Minimum timestamp value in seconds */
+	__s64	maximum_timestamp;	/* Maximum timestamp value in seconds */
+	__u16	atime_gran_mantissa;	/* Granularity(secs) = mant * 10^exp */
+	__u16	btime_gran_mantissa;
+	__u16	ctime_gran_mantissa;
+	__u16	mtime_gran_mantissa;
+	__s8	atime_gran_exponent;
+	__s8	btime_gran_exponent;
+	__s8	ctime_gran_exponent;
+	__s8	mtime_gran_exponent;
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_volume_uuid).
+ */
+struct fsinfo_volume_uuid {
+	__u8	uuid[16];
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_server_addresses).
+ *
+ * Find the addresses of the Nth server for a network mount.
+ */
+struct fsinfo_server_addresses {
+	struct __kernel_sockaddr_storage address[0];
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_error_state).
+ *
+ * Retrieve the error state for a filesystem.
+ */
+struct fsinfo_error_state {
+	__u32		io_error;	/* General I/O error counter */
+	__u32		wb_error;	/* Writeback error counter */
+	__u32		bdev_error;	/* Blockdev error counter */
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_io_size).
+ *
+ * Retrieve the optimal I/O size for a filesystem.
+ */
+struct fsinfo_io_size {
+	__u32		block_size;		/* Minimum block granularity for O_DIRECT */
+	__u32		max_single_read_size;	/* Maximum size of a single unbuffered read */
+	__u32		max_single_write_size;	/* Maximum size of a single unbuffered write */
+	__u32		best_read_size;		/* Optimal read size */
+	__u32		best_write_size;	/* Optimal write size */
+};
+
+/*
+ * Information struct for fsinfo(fsinfo_attr_fsinfo).
+ *
+ * This gives information about fsinfo() itself.
+ */
+struct fsinfo_fsinfo {
+	enum fsinfo_attribute	max_attr;	/* Number of supported attributes */
+	enum fsinfo_capability	max_cap;	/* Number of supported capabilities */
+};
+
+#endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/samples/statx/Makefile b/samples/statx/Makefile
index 59df7c25a9d1..9cb9a88e3a10 100644
--- a/samples/statx/Makefile
+++ b/samples/statx/Makefile
@@ -1,7 +1,10 @@
 # List of programs to build
-hostprogs-$(CONFIG_SAMPLE_STATX) := test-statx
+hostprogs-$(CONFIG_SAMPLE_STATX) := test-statx test-fsinfo
 
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
 
 HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
+
+HOSTCFLAGS_test-fsinfo.o += -I$(objtree)/usr/include
+HOSTLOADLIBES_test-fsinfo += -lm
diff --git a/samples/statx/test-fsinfo.c b/samples/statx/test-fsinfo.c
new file mode 100644
index 000000000000..7724390b0aa4
--- /dev/null
+++ b/samples/statx/test-fsinfo.c
@@ -0,0 +1,179 @@
+/* Test the fsinfo() system call
+ *
+ * Copyright (C) 2015 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define _GNU_SOURCE
+#define _ATFILE_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <errno.h>
+#include <time.h>
+#include <math.h>
+#include <sys/syscall.h>
+#include <linux/stat.h>
+#include <linux/fcntl.h>
+#include <sys/stat.h>
+
+#define __NR_fsinfo 326
+
+static __attribute__((unused))
+ssize_t fsinfo(int dfd, const char *filename, unsigned flags,
+	       unsigned request, void *buffer)
+{
+	return syscall(__NR_fsinfo, dfd, filename, flags, request, buffer);
+}
+
+static void dump_fsinfo(struct fsinfo *f)
+{
+	printf("mask  : %x\n", f->f_mask);
+	printf("dev   : %02x:%02x\n", f->f_dev_major, f->f_dev_minor);
+	printf("fs    : type=%x name=%s\n", f->f_fstype, f->f_fs_name);
+	printf("ioc   : %llx\n", (unsigned long long)f->f_supported_ioc_flags);
+	printf("nameln: %u\n", f->f_namelen);
+	printf("flags : %llx\n", (unsigned long long)f->f_flags);
+	printf("times : range=%llx-%llx\n",
+	       (unsigned long long)f->f_min_time,
+	       (unsigned long long)f->f_max_time);
+
+#define print_time(G) \
+	printf(#G"time : gran=%gs\n",			\
+	       (f->f_##G##time_gran_mantissa *		\
+		pow(10., f->f_##G##time_gran_exponent)))
+	print_time(a);
+	print_time(b);
+	print_time(c);
+	print_time(m);
+
+
+	if (f->f_mask & FSINFO_BLOCKS_INFO)
+		printf("blocks: n=%llu fr=%llu av=%llu\n",
+		       (unsigned long long)f->f_blocks,
+		       (unsigned long long)f->f_bfree,
+		       (unsigned long long)f->f_bavail);
+
+	if (f->f_mask & FSINFO_FILES_INFO)
+		printf("files : n=%llu fr=%llu av=%llu\n",
+		       (unsigned long long)f->f_files,
+		       (unsigned long long)f->f_ffree,
+		       (unsigned long long)f->f_favail);
+
+	if (f->f_mask & FSINFO_BSIZE)
+		printf("bsize : %u\n", f->f_bsize);
+
+	if (f->f_mask & FSINFO_FRSIZE)
+		printf("frsize: %u\n", f->f_frsize);
+
+	if (f->f_mask & FSINFO_FSID)
+		printf("fsid  : %llx\n", (unsigned long long)f->f_fsid);
+
+	if (f->f_mask & FSINFO_VOLUME_ID) {
+		int printable = 1, loop;
+		printf("volid : ");
+		for (loop = 0; loop < sizeof(f->f_volume_id); loop++)
+			if (!isprint(f->f_volume_id[loop]))
+				printable = 0;
+		if (printable) {
+			printf("'%.*s'", 16, f->f_volume_id);
+		} else {
+			for (loop = 0; loop < sizeof(f->f_volume_id); loop++) {
+				if (loop % 4 == 0 && loop != 0)
+					printf(" ");
+				printf("%02x", f->f_volume_id[loop]);
+			}
+		}
+		printf("\n");
+	}
+
+	if (f->f_mask & FSINFO_VOLUME_UUID)
+		printf("uuid  : "
+		       "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x"
+		       "-%02x%02x%02x%02x%02x%02x\n",
+		       f->f_volume_uuid[ 0], f->f_volume_uuid[ 1],
+		       f->f_volume_uuid[ 2], f->f_volume_uuid[ 3],
+		       f->f_volume_uuid[ 4], f->f_volume_uuid[ 5],
+		       f->f_volume_uuid[ 6], f->f_volume_uuid[ 7],
+		       f->f_volume_uuid[ 8], f->f_volume_uuid[ 9],
+		       f->f_volume_uuid[10], f->f_volume_uuid[11],
+		       f->f_volume_uuid[12], f->f_volume_uuid[13],
+		       f->f_volume_uuid[14], f->f_volume_uuid[15]);
+	if (f->f_mask & FSINFO_VOLUME_NAME)
+		printf("volume: '%s'\n", f->f_volume_name);
+	if (f->f_mask & FSINFO_DOMAIN_NAME)
+		printf("domain: '%s'\n", f->f_domain_name);
+}
+
+static void dump_hex(unsigned long long *data, int from, int to)
+{
+	unsigned offset, print_offset = 1, col = 0;
+
+	from /= 8;
+	to = (to + 7) / 8;
+
+	for (offset = from; offset < to; offset++) {
+		if (print_offset) {
+			printf("%04x: ", offset * 8);
+			print_offset = 0;
+		}
+		printf("%016llx", data[offset]);
+		col++;
+		if ((col & 3) == 0) {
+			printf("\n");
+			print_offset = 1;
+		} else {
+			printf(" ");
+		}
+	}
+
+	if (!print_offset)
+		printf("\n");
+}
+
+int main(int argc, char **argv)
+{
+	struct fsinfo f;
+	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
+
+	for (argv++; *argv; argv++) {
+		if (strcmp(*argv, "-F") == 0) {
+			atflag |= AT_FORCE_ATTR_SYNC;
+			continue;
+		}
+		if (strcmp(*argv, "-L") == 0) {
+			atflag &= ~AT_SYMLINK_NOFOLLOW;
+			continue;
+		}
+		if (strcmp(*argv, "-A") == 0) {
+			atflag |= AT_NO_AUTOMOUNT;
+			continue;
+		}
+		if (strcmp(*argv, "-R") == 0) {
+			raw = 1;
+			continue;
+		}
+
+		memset(&f, 0xbd, sizeof(f));
+		ret = fsinfo(AT_FDCWD, *argv, atflag, 0, &f);
+		printf("fsinfo(%s) = %d\n", *argv, ret);
+		if (ret < 0) {
+			perror(*argv);
+			exit(1);
+		}
+
+		if (raw)
+			dump_hex((unsigned long long *)&f, 0, sizeof(f));
+
+		dump_fsinfo(&f);
+	}
+	return 0;
+}
