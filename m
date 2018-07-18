Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5926AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D612075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D612075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeGRWJj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:09:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbeGRWJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:09:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BFF5401EF0C;
        Wed, 18 Jul 2018 21:29:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A28602156893;
        Wed, 18 Jul 2018 21:29:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Getting rid of the usage of write() -- was Re: [PATCH 00/32] VFS: Introduce filesystem context [ver #9]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15934.1531949389.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 18 Jul 2018 22:29:49 +0100
Message-ID: <15935.1531949389@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 21:29:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 21:29:50 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Al,

I'm thinking of adding in the attached patch as a starting point for replacing
write() as the method by which configuration/actioning is done.

For the moment, it just glues the key and the value back together inside the
kernel and passes that on to the filesystem.  I'm still working on a patch to
pass key,val pairs through, but just the patch below would allow Al to take up
the UAPI bits into linux-next.

David
---
vfs: Add a syscall for configuring and triggering actions on a context

Add a syscall for configuring a filesystem creation context and triggering
actions upon it, to be used in conjunction with fsopen, fspick and fsmount.

    long fsconfig(int fs_fd, unsigned int cmd, const char *key,
                  const void *value, int aux);

Where fs_fd indicates the context, cmd indicates the action to take, key
indicates the parameter name for parameter-setting actions and, if needed,
value points to a buffer containing the value and aux can give more
information for the value.

The following command IDs are proposed:

 (*) fsconfig_set_flag: No value is specified.  The parameter must be
     boolean in nature.  The key may be prefixed with "no" to invert the
     setting. value must be NULL and aux must be 0.

 (*) fsconfig_set_string: A string value is specified.  The parameter can
     be expecting boolean, integer, string or take a path.  A conversion to
     an appropriate type will be attempted (which may include looking up as
     a path).  value points to a NUL-terminated string and aux must be 0.

 (*) fsconfig_set_binary: A binary blob is specified.  value points to
     the blob and aux indicates its size.  The parameter must be expecting
     a blob.

 (*) fsconfig_set_path: A non-empty path is specified.  The parameter must
     be expecting a path object.  value points to a NUL-terminated string
     that is the path and aux is a file descriptor at which to start a
     relative lookup or AT_FDCWD.

 (*) fsconfig_set_path_empty: As fsconfig_set_path, but with AT_EMPTY_PATH
     implied.

 (*) fsconfig_set_fd: An open file descriptor is specified.  value must
     be NULL and aux indicates the file descriptor.

 (*) fsconfig_cmd_create: Trigger superblock creation.

 (*) fsconfig_cmd_reconfigure: Trigger superblock reconfiguration.

For the "set" command IDs, the idea is that the file_system_type will point
to a list of parameters and the types of value that those parameters expect
to take.  The core code can then do the parse and argument conversion and
then give the LSM and FS a cooked option or array of options to use.

Source specification is also done the same way same way, using special keys
"source", "source1", "source2", etc..

[!] Note that, for the moment, the key and value are just glued back
together and handed to the filesystem.  Every filesystem that uses options
uses match_token() and co. to do this, and this will need to be changed -
but not all at once.

Example usage:

    fd = fsopen("ext4", FSOPEN_CLOEXEC);
    fsconfig(fd, fsconfig_set_path, "source", "/dev/sda1", AT_FDCWD);
    fsconfig(fd, fsconfig_set_path_empty, "journal_path", "", journal_fd);
    fsconfig(fd, fsconfig_set_fd, "journal_fd", "", journal_fd);
    fsconfig(fd, fsconfig_set_flag, "user_xattr", NULL, 0);
    fsconfig(fd, fsconfig_set_flag, "noacl", NULL, 0);
    fsconfig(fd, fsconfig_set_string, "sb", "1", 0);
    fsconfig(fd, fsconfig_set_string, "errors", "continue", 0);
    fsconfig(fd, fsconfig_set_string, "data", "journal", 0);
    fsconfig(fd, fsconfig_set_string, "context", "unconfined_u:...", 0);
    fsconfig(fd, fsconfig_cmd_create, NULL, NULL, 0);
    mfd = fsmount(fd, FSMOUNT_CLOEXEC, MS_NOEXEC);

or:

    fd = fsopen("ext4", FSOPEN_CLOEXEC);
    fsconfig(fd, fsconfig_set_string, "source", "/dev/sda1", 0);
    fsconfig(fd, fsconfig_cmd_create, NULL, NULL, 0);
    mfd = fsmount(fd, FSMOUNT_CLOEXEC, MS_NOEXEC);

or:

    fd = fsopen("afs", FSOPEN_CLOEXEC);
    fsconfig(fd, fsconfig_set_string, "source", "#grand.central.org:root.cell", 0);
    fsconfig(fd, fsconfig_cmd_create, NULL, NULL, 0);
    mfd = fsmount(fd, FSMOUNT_CLOEXEC, MS_NOEXEC);

or:

    fd = fsopen("jffs2", FSOPEN_CLOEXEC);
    fsconfig(fd, fsconfig_set_string, "source", "mtd0", 0);
    fsconfig(fd, fsconfig_cmd_create, NULL, NULL, 0);
    mfd = fsmount(fd, FSMOUNT_CLOEXEC, MS_NOEXEC);
---
 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/fs_context.c                        |  177 ++++++++++------
 fs/fsopen.c                            |  363 +++++++++++++++++++++------------
 include/linux/fs_context.h             |    2 
 include/linux/syscalls.h               |    2 
 include/uapi/linux/fs.h                |   14 +
 samples/mount_api/test-fsmount.c       |   24 +-
 8 files changed, 382 insertions(+), 202 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 1c9b56f80cdf..7bc9a6bae788 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -404,3 +404,4 @@
 390	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 391	i386	fspick			sys_fspick			__ia32_sys_fspick
 392	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
+393	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index d2a4d6db4df6..9caf2f0be723 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -349,6 +349,7 @@
 338	common	fsmount			__x64_sys_fsmount
 339	common	fspick			__x64_sys_fspick
 340	common	fsinfo			__x64_sys_fsinfo
+341	common	fsconfig		__x64_sys_fsconfig
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/fs_context.c b/fs/fs_context.c
index f388ab29d37d..071723cf11c8 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -19,10 +19,10 @@
 #include <linux/slab.h>
 #include <linux/magic.h>
 #include <linux/security.h>
-#include <linux/parser.h>
 #include <linux/mnt_namespace.h>
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
+#include <linux/bsearch.h>
 #include <net/net_namespace.h>
 #include <asm/sections.h>
 #include "mount.h"
@@ -45,81 +45,102 @@ struct legacy_fs_context {
 static int legacy_init_fs_context(struct fs_context *fc, struct dentry *dentry);
 static const struct fs_context_operations legacy_fs_context_ops;
 
-static const match_table_t common_set_sb_flag = {
-	{ SB_DIRSYNC,		"dirsync" },
-	{ SB_LAZYTIME,		"lazytime" },
-	{ SB_MANDLOCK,		"mand" },
-	{ SB_POSIXACL,		"posixacl" },
-	{ SB_RDONLY,		"ro" },
-	{ SB_SYNCHRONOUS,	"sync" },
-	{ },
+struct constant_table {
+	const char	*name;
+	int		value;
 };
 
-static const match_table_t common_clear_sb_flag = {
-	{ SB_LAZYTIME,		"nolazytime" },
-	{ SB_MANDLOCK,		"nomand" },
-	{ SB_RDONLY,		"rw" },
-	{ SB_SILENT,		"silent" },
-	{ SB_SYNCHRONOUS,	"async" },
-	{ },
+static const struct constant_table common_set_sb_flag[] = {
+	{ "dirsync",	SB_DIRSYNC },
+	{ "lazytime",	SB_LAZYTIME },
+	{ "mand",	SB_MANDLOCK },
+	{ "posixacl",	SB_POSIXACL },
+	{ "ro",		SB_RDONLY },
+	{ "sync",	SB_SYNCHRONOUS },
 };
 
-static const match_table_t forbidden_sb_flag = {
-	{ 1,	"bind" },
-	{ 1,	"move" },
-	{ 1,	"private" },
-	{ 1,	"remount" },
-	{ 1,	"shared" },
-	{ 1,	"slave" },
-	{ 1,	"unbindable" },
-	{ 1,	"rec" },
-	{ 1,	"noatime" },
-	{ 1,	"relatime" },
-	{ 1,	"norelatime" },
-	{ 1,	"strictatime" },
-	{ 1,	"nostrictatime" },
-	{ 1,	"nodiratime" },
-	{ 1,	"dev" },
-	{ 1,	"nodev" },
-	{ 1,	"exec" },
-	{ 1,	"noexec" },
-	{ 1,	"suid" },
-	{ 1,	"nosuid" },
-	{ },
+static const struct constant_table common_clear_sb_flag[] = {
+	{ "async",	SB_SYNCHRONOUS },
+	{ "nolazytime",	SB_LAZYTIME },
+	{ "nomand",	SB_MANDLOCK },
+	{ "rw",		SB_RDONLY },
+	{ "silent",	SB_SILENT },
 };
 
+static const char *forbidden_sb_flag[] = {
+	"bind",
+	"dev",
+	"exec",
+	"move",
+	"noatime",
+	"nodev",
+	"nodiratime",
+	"noexec",
+	"norelatime",
+	"nostrictatime",
+	"nosuid",
+	"private",
+	"rec",
+	"relatime",
+	"remount",
+	"shared",
+	"slave",
+	"strictatime",
+	"suid",
+	"unbindable",
+};
+
+static int lookup_one(const void *name, const void *entry)
+{
+	const struct constant_table *e = entry;
+	return strcmp(name, e->name);
+}
+
+static int lookup_constant(const struct constant_table tbl[], size_t tbl_size,
+			   const char *name, int not_found)
+{
+	const struct constant_table *e;
+
+	e = bsearch(name, tbl, tbl_size, sizeof(tbl[0]), lookup_one);
+	if (!e)
+		return not_found;
+	return e->value;
+}
+#define lookup_constant(t, n, nf) lookup_constant(t, ARRAY_SIZE(t), (n), (nf))
+
 /*
  * Check for a common mount option that manipulates s_flags.
  */
-static int vfs_parse_sb_flag_option(struct fs_context *fc, char *data)
+static int vfs_parse_sb_flag_option(struct fs_context *fc, const char *key)
 {
-	substring_t args[MAX_OPT_ARGS];
 	unsigned int token;
 
-	token = match_token(data, common_set_sb_flag, args);
+	if (bsearch(key, forbidden_sb_flag, ARRAY_SIZE(forbidden_sb_flag),
+		    sizeof(forbidden_sb_flag[0]),
+		    (int (*)(const void *, const void *))strcmp))
+		return -EINVAL;
+
+	token = lookup_constant(common_set_sb_flag, key, 0);
 	if (token) {
 		fc->sb_flags |= token;
 		return 1;
 	}
 
-	token = match_token(data, common_clear_sb_flag, args);
+	token = lookup_constant(common_clear_sb_flag, key, 0);
 	if (token) {
 		fc->sb_flags &= ~token;
 		return 1;
 	}
 
-	token = match_token(data, forbidden_sb_flag, args);
-	if (token)
-		return -EINVAL;
-
 	return 0;
 }
 
 /**
  * vfs_parse_fs_option - Add a single mount option to a superblock config
  * @fc: The filesystem context to modify
- * @opt: The option to apply.
- * @len: The length of the option.
+ * @key: The parameter name
+ * @value: The parameter value
+ * @v_len: The length of the value
  *
  * A single mount option in string form is applied to the filesystem context
  * being set up.  Certain standard options (for example "ro") are translated
@@ -132,26 +153,51 @@ static int vfs_parse_sb_flag_option(struct fs_context *fc, char *data)
  * Returns 0 on success and a negative error code on failure.  In the event of
  * failure, supplementary error information may have been set.
  */
-int vfs_parse_fs_option(struct fs_context *fc, char *opt, size_t len)
+int vfs_parse_fs_option(struct fs_context *fc, char *key, void *value, size_t v_len)
 {
+	size_t len;
+	char *buf = key;
 	int ret;
 
-	ret = vfs_parse_sb_flag_option(fc, opt);
+	ret = vfs_parse_sb_flag_option(fc, key);
 	if (ret < 0)
 		return ret;
 	if (ret == 1)
 		return 0;
 
-	ret = security_fs_context_parse_option(fc, opt, len);
-	if (ret < 0)
-		return ret;
-	if (ret == 1)
-		return 0;
+	/* Splice together the value and the option and pass to the LSM and FS.
+	 *
+	 * [!] TODO: Need to pass key and value through separately.
+	 */
+	len = strlen(key);
+	if (value) {
+		buf = kmalloc(len + 1 + v_len + 1, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+		memcpy(buf, key, len);
+		buf[len] = '=';
+		len++;
+		memcpy(buf + len, value, v_len);
+		len += v_len;
+		buf[len] = 0;
+	}
 
+	ret = security_fs_context_parse_option(fc, buf, len);
+	if (ret != 0) {
+		if (ret == 1)
+			/* Param belongs to the LSM; don't pass to the FS */
+			ret = 0;
+		goto out;
+	}
+
+	ret = -EINVAL;
 	if (fc->ops->parse_option)
-		return fc->ops->parse_option(fc, opt, len);
+		ret = fc->ops->parse_option(fc, buf, len);
 
-	return -EINVAL;
+out:
+	if (buf != key)
+		kfree(buf);
+	return ret;
 }
 EXPORT_SYMBOL(vfs_parse_fs_option);
 
@@ -205,15 +251,24 @@ EXPORT_SYMBOL(vfs_set_fs_source);
  */
 int generic_parse_monolithic(struct fs_context *fc, void *data, size_t data_size)
 {
-	char *options = data, *opt;
+	char *options = data, *key;
 	int ret;
 
 	if (!options)
 		return 0;
 
-	while ((opt = strsep(&options, ",")) != NULL) {
-		if (*opt) {
-			ret = vfs_parse_fs_option(fc, opt, strlen(opt));
+	while ((key = strsep(&options, ",")) != NULL) {
+		if (*key) {
+			size_t v_len = 0;
+			char *value = strchr(key, '=');
+
+			if (value) {
+				if (value == key)
+					continue;
+				*value++ = 0;
+				v_len = strlen(value);
+			}
+			ret = vfs_parse_fs_option(fc, key, value, v_len);
 			if (ret < 0)
 				return ret;
 		}
diff --git a/fs/fsopen.c b/fs/fsopen.c
index ebcbae8c6f10..c0d8dbe21063 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -16,138 +16,9 @@
 #include <linux/security.h>
 #include <linux/anon_inodes.h>
 #include <linux/namei.h>
+#include <linux/file.h>
 #include "mount.h"
 
-/*
- * Userspace writes configuration data and commands to the fd and we parse it
- * here.  For the moment, we assume a single option or command per write.  Each
- * line written is of the form
- *
- *	<command_type><space><stuff...>
- *
- *	s /dev/sda1				-- Source device
- *	o noatime				-- Option without value
- *	o cell=grand.central.org		-- Option with value
- *	x create				-- Create a superblock
- *	x reconfigure				-- Reconfigure a superblock
- */
-static ssize_t fscontext_write(struct file *file,
-			       const char __user *_buf, size_t len, loff_t *pos)
-{
-	struct fs_context *fc = file->private_data;
-	const struct cred *cred;
-	char opt[2], *data;
-	ssize_t ret;
-
-	if (len < 3 || len > 4095)
-		return -EINVAL;
-
-	if (copy_from_user(opt, _buf, 2) != 0)
-		return -EFAULT;
-	switch (opt[0]) {
-	case 's':
-	case 'o':
-	case 'x':
-		break;
-	default:
-		return -EINVAL;
-	}
-	if (opt[1] != ' ')
-		return -EINVAL;
-
-	data = memdup_user_nul(_buf + 2, len - 2);
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	/* From this point onwards we need to lock the fd against someone
-	 * trying to mount it.
-	 */
-	ret = mutex_lock_interruptible(&fc->uapi_mutex);
-	if (ret < 0)
-		goto err_free;
-
-	/* All operations take place using whatever privilege was granted to
-	 * the caller of fsopen() or fspick().
-	 */
-	cred = override_creds(fc->cred);
-	
-	if (fc->phase == FS_CONTEXT_AWAITING_RECONF) {
-		if (fc->fs_type->init_fs_context) {
-			ret = fc->fs_type->init_fs_context(fc, fc->root);
-			if (ret < 0) {
-				fc->phase = FS_CONTEXT_FAILED;
-				goto err_unlock;
-			}
-		} else {
-			/* Leave legacy context ops in place */
-		}
-
-		/* Do the security check last because ->init_fs_context may
-		 * change the namespace subscriptions.
-		 */
-		ret = security_fs_context_alloc(fc, fc->root);
-		if (ret < 0) {
-			fc->phase = FS_CONTEXT_FAILED;
-			goto err_unlock;
-		}
-
-		fc->phase = FS_CONTEXT_RECONF_PARAMS;
-	}
-
-	ret = -EINVAL;
-	switch (opt[0]) {
-	case 's':
-		if (fc->phase != FS_CONTEXT_CREATE_PARAMS &&
-		    fc->phase != FS_CONTEXT_RECONF_PARAMS)
-			goto wrong_phase;
-		ret = vfs_set_fs_source(fc, data, len - 2);
-		if (ret < 0)
-			goto err_unlock;
-		break;
-
-	case 'o':
-		if (fc->phase != FS_CONTEXT_CREATE_PARAMS &&
-		    fc->phase != FS_CONTEXT_RECONF_PARAMS)
-			goto wrong_phase;
-		ret = vfs_parse_fs_option(fc, data, len - 2);
-		if (ret < 0)
-			goto err_unlock;
-		break;
-
-	case 'x':
-		if (strcmp(data, "create") == 0) {
-			if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
-				goto wrong_phase;
-			fc->phase = FS_CONTEXT_CREATING;
-			ret = vfs_get_tree(fc);
-			if (ret == 0)
-				fc->phase = FS_CONTEXT_AWAITING_MOUNT;
-			else
-				fc->phase = FS_CONTEXT_FAILED;
-		} else {
-			ret = -EOPNOTSUPP;
-		}
-		if (ret < 0)
-			goto err_unlock;
-		break;
-
-	default:
-		goto err_unlock;
-	}
-
-	ret = len;
-err_unlock:
-	revert_creds(cred);
-	mutex_unlock(&fc->uapi_mutex);
-err_free:
-	kfree(data);
-	return ret;
-
-wrong_phase:
-	ret = -EBUSY;
-	goto err_unlock;
-}
-
 /*
  * Allow the user to read back any error, warning or informational messages.
  */
@@ -207,7 +78,6 @@ static int fscontext_release(struct inode *inode, struct file *file)
 
 const struct file_operations fscontext_fops = {
 	.read		= fscontext_read,
-	.write		= fscontext_write,
 	.release	= fscontext_release,
 	.llseek		= no_llseek,
 };
@@ -340,3 +210,234 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 err:
 	return ret;
 }
+
+/*
+ * Check the state and apply the configuration.  Note that this function is
+ * allowed to 'steal' the value by setting *_value to NULL before returning.
+ */
+static int vfs_fsconfig(struct fs_context *fc, enum fsconfig_command cmd,
+			char *key, void **_value, long aux)
+{
+	void *value = *_value;
+	int ret;
+
+	/* We need to reinitialise the context if we have reconfiguration
+	 * pending after creation or a previous reconfiguration.
+	 */
+	if (fc->phase == FS_CONTEXT_AWAITING_RECONF) {
+		if (fc->fs_type->init_fs_context) {
+			ret = fc->fs_type->init_fs_context(fc, fc->root);
+			if (ret < 0) {
+				fc->phase = FS_CONTEXT_FAILED;
+				return ret;
+			}
+		} else {
+			/* Leave legacy context ops in place */
+		}
+
+		/* Do the security check last because ->init_fs_context may
+		 * change the namespace subscriptions.
+		 */
+		ret = security_fs_context_alloc(fc, fc->root);
+		if (ret < 0) {
+			fc->phase = FS_CONTEXT_FAILED;
+			return ret;
+		}
+
+		fc->phase = FS_CONTEXT_RECONF_PARAMS;
+	}
+
+	ret = -EINVAL;
+	switch (cmd) {
+	case fsconfig_set_string:
+		if (fc->phase != FS_CONTEXT_CREATE_PARAMS &&
+		    fc->phase != FS_CONTEXT_RECONF_PARAMS)
+			return -EBUSY;
+		if (strcmp(key, "source") == 0)
+			return vfs_set_fs_source(fc, value, strlen(value));
+		/* Fall through */
+
+	case fsconfig_set_flag:
+	case fsconfig_set_binary:
+		if (fc->phase != FS_CONTEXT_CREATE_PARAMS &&
+		    fc->phase != FS_CONTEXT_RECONF_PARAMS)
+			return -EBUSY;
+		return vfs_parse_fs_option(fc, key, value, aux);
+
+	case fsconfig_set_path:
+	case fsconfig_set_path_empty:
+	case fsconfig_set_fd:
+		if (fc->phase != FS_CONTEXT_CREATE_PARAMS &&
+		    fc->phase != FS_CONTEXT_RECONF_PARAMS)
+			return -EBUSY;
+		BUG(); // TODO
+
+	case fsconfig_cmd_create:
+		if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
+			return -EBUSY;
+		fc->phase = FS_CONTEXT_CREATING;
+		ret = vfs_get_tree(fc);
+		if (ret == 0)
+			fc->phase = FS_CONTEXT_AWAITING_MOUNT;
+		else
+			fc->phase = FS_CONTEXT_FAILED;
+		return ret;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+/**
+ * sys_fsconfig - Set parameters and trigger actions on a context
+ * @fd: The filesystem context to act upon
+ * @cmd: The action to take
+ * @_key: Where appropriate, the parameter key to set
+ * @_value: Where appropriate, the parameter value to set
+ * @aux: Additional information for the value
+ *
+ * This system call is used to set parameters on a context, including
+ * superblock settings, data source and security labelling.
+ *
+ * Actions include triggering the creation of a superblock and the
+ * reconfiguration of the superblock attached to the specified context.
+ *
+ * When setting a parameter, @cmd indicates the type of value being proposed
+ * and @_key indicates the parameter to be altered.
+ *
+ * @_value and @aux are used to specify the value, should a value be required:
+ *
+ * (*) fsconfig_set_flag: No value is specified.  The parameter must be boolean
+ *     in nature.  The key may be prefixed with "no" to invert the
+ *     setting. @_value must be NULL and @aux must be 0.
+ *
+ * (*) fsconfig_set_string: A string value is specified.  The parameter can be
+ *     expecting boolean, integer, string or take a path.  A conversion to an
+ *     appropriate type will be attempted (which may include looking up as a
+ *     path).  @_value points to a NUL-terminated string and @aux must be 0.
+ *
+ * (*) fsconfig_set_binary: A binary blob is specified.  @_value points to the
+ *     blob and @aux indicates its size.  The parameter must be expecting a
+ *     blob.
+ *
+ * (*) fsconfig_set_path: A non-empty path is specified.  The parameter must be
+ *     expecting a path object.  @_value points to a NUL-terminated string that
+ *     is the path and @aux is a file descriptor at which to start a relative
+ *     lookup or AT_FDCWD.
+ *
+ * (*) fsconfig_set_path_empty: As fsconfig_set_path, but with AT_EMPTY_PATH
+ *     implied.
+ *
+ * (*) fsconfig_set_fd: An open file descriptor is specified.  @_value must be
+ *     NULL and @aux indicates the file descriptor.
+ */
+SYSCALL_DEFINE5(fsconfig,
+		int, fd,
+		unsigned int, cmd,
+		const char __user *, _key,
+		const void __user *, _value,
+		int, aux)
+{
+	struct fs_context *fc;
+	struct fd f;
+	void *value = NULL;
+	char *key = NULL;
+	int ret;
+
+	if (fd < 0)
+		return -EINVAL;
+
+	switch (cmd) {
+	case fsconfig_set_flag:
+		if (!_key || _value || aux)
+			return -EINVAL;
+		break;
+	case fsconfig_set_string:
+		if (!_key || !_value || aux)
+			return -EINVAL;
+		break;
+	case fsconfig_set_binary:
+		if (!_key || !_value || aux <= 0 || aux > 1024 * 1024)
+			return -EINVAL;
+		break;
+	case fsconfig_set_path:
+	case fsconfig_set_path_empty:
+		if (!_key || !_value || (aux != AT_FDCWD && aux < 0))
+			return -EINVAL;
+		break;
+	case fsconfig_set_fd:
+		if (!_key || _value || aux < 0)
+			return -EINVAL;
+		break;
+	case fsconfig_cmd_create:
+	case fsconfig_cmd_reconfigure:
+		if (_key || _value || aux)
+			return -EINVAL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	f = fdget(fd);
+	if (!f.file)
+		return -EBADF;
+	ret = -EINVAL;
+	if (f.file->f_op != &fscontext_fops)
+		goto out_f;
+
+	fc = f.file->private_data;
+
+	if (_key) {
+		key = strndup_user(_key, 256);
+		if (IS_ERR(key)) {
+			ret = PTR_ERR(key);
+			goto out_f;
+		}
+	}
+
+	switch (cmd) {
+	case fsconfig_set_string:
+		value = strndup_user(_value, 256);
+		if (IS_ERR(value)) {
+			ret = PTR_ERR(value);
+			goto out_key;
+		}
+		break;
+	case fsconfig_set_binary:
+		value = memdup_user_nul(_value, aux);
+		if (IS_ERR(value)) {
+			ret = PTR_ERR(key);
+			goto out_key;
+		}
+		break;
+	case fsconfig_set_path:
+	case fsconfig_set_path_empty:
+	case fsconfig_set_fd:
+		ret = -EOPNOTSUPP;
+		goto out_key;
+	default:
+		break;
+	}
+
+	ret = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (ret == 0) {
+		ret = vfs_fsconfig(fc, cmd, key, &value, aux);
+		mutex_unlock(&fc->uapi_mutex);
+	}
+
+	switch (cmd) {
+	case fsconfig_set_string:
+	case fsconfig_set_binary:
+		kfree(value);
+		/* Fall through */
+	default:
+		break;
+	}
+out_key:
+	kfree(key);
+out_f:
+	fdput(f);
+	return ret;
+}
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 305fab41e540..b5dc48c206c4 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -99,7 +99,7 @@ extern struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
 extern struct fs_context *vfs_sb_reconfig(struct path *path, unsigned int ms_flags);
 extern struct fs_context *vfs_dup_fs_context(struct fs_context *src);
 extern int vfs_set_fs_source(struct fs_context *fc, const char *source, size_t len);
-extern int vfs_parse_fs_option(struct fs_context *fc, char *opt, size_t len);
+extern int vfs_parse_fs_option(struct fs_context *fc, char *key, void *value, size_t v_len);
 extern int generic_parse_monolithic(struct fs_context *fc, void *data, size_t data_size);
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index da3575dded79..39260701a267 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -911,6 +911,8 @@ asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags)
 asmlinkage long sys_fsinfo(int dfd, const char __user *path,
 			   struct fsinfo_params __user *params,
 			   void __user *buffer, size_t buf_size);
+asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __user *key,
+			     const void __user *value, unsigned int aux);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index c27576d471c2..be70cbac21b4 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -356,4 +356,18 @@ typedef int __bitwise __kernel_rwf_t;
 #define FSPICK_NO_AUTOMOUNT	0x00000004
 #define FSPICK_EMPTY_PATH	0x00000008
 
+/*
+ * The type of fsconfig() call made.
+ */
+enum fsconfig_command {
+	fsconfig_set_flag,		/* Set parameter, supplying no value */
+	fsconfig_set_string,		/* Set parameter, supplying a string value */
+	fsconfig_set_binary,		/* Set parameter, supplying a binary blob value */
+	fsconfig_set_path,		/* Set parameter, supplying an object by path */
+	fsconfig_set_path_empty,	/* Set parameter, supplying an object by (empty) path */
+	fsconfig_set_fd,		/* Set parameter, supplying an object by fd */
+	fsconfig_cmd_create,		/* Invoke superblock creation */
+	fsconfig_cmd_reconfigure,	/* Invoke superblock reconfiguration */
+};
+
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/samples/mount_api/test-fsmount.c b/samples/mount_api/test-fsmount.c
index 44d2dc9fc2a0..ee8db5761a9e 100644
--- a/samples/mount_api/test-fsmount.c
+++ b/samples/mount_api/test-fsmount.c
@@ -16,7 +16,7 @@
 #include <fcntl.h>
 #include <sys/prctl.h>
 #include <sys/wait.h>
-#include <linux/mount.h>
+#include <linux/fs.h>
 #include <linux/unistd.h>
 
 #define E(x) do { if ((x) == -1) { perror(#x); exit(1); } } while(0)
@@ -58,12 +58,6 @@ void mount_error(int fd, const char *s)
 	exit(1);
 }
 
-#define E_write(fd, s)							\
-	do {								\
-		if (write(fd, s, sizeof(s) - 1) == -1)			\
-			mount_error(fd, s);				\
-	} while (0)
-
 static inline int fsopen(const char *fs_name, unsigned int flags)
 {
 	return syscall(__NR_fsopen, fs_name, flags);
@@ -74,6 +68,12 @@ static inline int fsmount(int fsfd, unsigned int flags, unsigned int ms_flags)
 	return syscall(__NR_fsmount, fsfd, flags, ms_flags);
 }
 
+static inline int fsconfig(int fsfd, unsigned int cmd,
+			   const char *key, const void *val, int aux)
+{
+	return syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
+}
+
 static inline int move_mount(int from_dfd, const char *from_pathname,
 			     int to_dfd, const char *to_pathname,
 			     unsigned int flags)
@@ -83,6 +83,12 @@ static inline int move_mount(int from_dfd, const char *from_pathname,
 		       to_dfd, to_pathname, flags);
 }
 
+#define E_fsconfig(fd, cmd, key, val, aux)				\
+	do {								\
+		if (fsconfig(fd, cmd, key, val, aux) == -1)		\
+			mount_error(fd, key ?: "create");		\
+	} while (0)
+
 int main(int argc, char *argv[])
 {
 	int fsfd, mfd;
@@ -94,8 +100,8 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	E_write(fsfd, "s #grand.central.org:root.cell.");
-	E_write(fsfd, "x create");
+	E_fsconfig(fsfd, fsconfig_set_string, "source", "#grand.central.org:root.cell.", 0);
+	E_fsconfig(fsfd, fsconfig_cmd_create, NULL, NULL, 0);
 	
 	mfd = fsmount(fsfd, 0, MS_RDONLY);
 	if (mfd < 0)
