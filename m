Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbeBPUeH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:34:07 -0500
Received: from alln-iport-7.cisco.com ([173.37.142.94]:63981 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeBPUeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:34:03 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="71347234"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 08/15] initramfs: add newcx format
Date: Fri, 16 Feb 2018 20:33:44 +0000
Message-Id: <1518813234-5874-9-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'newcx' format that adds extended attributes and increased size of
c_mtime and c_filesize fields.

Refer to Documentation/early-userspace/buffer-format.txt for detailed
format description.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 121 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 96 insertions(+), 25 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7f0bbfde94e3..0407e199352e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -54,6 +54,7 @@ static void __init error(char *x)
 /* link hash */
 
 #define N_ALIGN(len) ((((len) + 1) & ~3) + 2)
+#define X_ALIGN(len) ((len + 3) & ~3)
 
 static __initdata struct hash {
 	int ino, minor, major;
@@ -109,14 +110,11 @@ static void __init free_hash(void)
 	}
 }
 
-static long __init do_utime(char *filename, time64_t mtime)
+static long __init do_utime(char *filename, struct timespec64 *mtime)
 {
 	struct timespec64 t[2];
 
-	t[0].tv_sec = mtime;
-	t[0].tv_nsec = 0;
-	t[1].tv_sec = mtime;
-	t[1].tv_nsec = 0;
+	t[0] = t[1] = *mtime;
 
 	return do_utimes(AT_FDCWD, filename, t, AT_SYMLINK_NOFOLLOW);
 }
@@ -125,17 +123,17 @@ static __initdata LIST_HEAD(dir_list);
 struct dir_entry {
 	struct list_head list;
 	char *name;
-	time64_t mtime;
+	struct timespec64 mtime;
 };
 
-static void __init dir_add(const char *name, time64_t mtime)
+static void __init dir_add(const char *name, struct timespec64 *mtime)
 {
 	struct dir_entry *de = kmalloc(sizeof(struct dir_entry), GFP_KERNEL);
 	if (!de)
 		panic("can't allocate dir_entry buffer");
 	INIT_LIST_HEAD(&de->list);
 	de->name = kstrdup(name, GFP_KERNEL);
-	de->mtime = mtime;
+	de->mtime = *mtime;
 	list_add(&de->list, &dir_list);
 }
 
@@ -144,17 +142,18 @@ static void __init dir_utime(void)
 	struct dir_entry *de, *tmp;
 	list_for_each_entry_safe(de, tmp, &dir_list, list) {
 		list_del(&de->list);
-		do_utime(de->name, de->mtime);
+		do_utime(de->name, &de->mtime);
 		kfree(de->name);
 		kfree(de);
 	}
 }
 
 /* cpio header parsing */
-static __initdata time64_t mtime;
+static __initdata struct timespec64 mtime;
 static __initdata u32 ino, major, minor, nlink, rmajor, rminor;
 static __initdata umode_t mode;
-static __initdata u32 body_len, name_len;
+static __initdata u32 name_len, xattr_len;
+static __initdata u64 body_len;
 static __initdata uid_t uid;
 static __initdata gid_t gid;
 static __initdata u32 mode_u32;
@@ -167,6 +166,12 @@ struct cpio_hdr_field {
 	const char *name;
 };
 
+static __initdata enum cpio_format {
+	CPIO_NO_MAGIC,
+	CPIO_NEWC,
+	CPIO_NEWCX,
+} cpio_format;
+
 #define HDR_FIELD(type, field, variable) \
 	{ .offset = offsetof(type, field) + \
 	  BUILD_BUG_ON_ZERO(sizeof(*(variable))*2 < FIELD_SIZEOF(type, field)),\
@@ -177,9 +182,11 @@ struct cpio_hdr_field {
 
 #define NEWC_FIELD(field, variable) \
 		HDR_FIELD(struct cpio_newc_header, field, variable)
+#define NEWCX_FIELD(field, variable) \
+		HDR_FIELD(struct cpio_newcx_header, field, variable)
 
-#define CPIO_MAX_HEADER_SIZE sizeof(struct cpio_newc_header)
-#define CPIO_MAX_FIELD_SIZE 8
+#define CPIO_MAX_HEADER_SIZE sizeof(struct cpio_newcx_header)
+#define CPIO_MAX_FIELD_SIZE 16
 #define CPIO_MAGIC_SIZE 6
 
 struct cpio_newc_header {
@@ -204,7 +211,7 @@ static struct cpio_hdr_field cpio_newc_header_info[] __initdata = {
 	NEWC_FIELD(c_uid, &uid),
 	NEWC_FIELD(c_gid, &gid),
 	NEWC_FIELD(c_nlink, &nlink),
-	NEWC_FIELD(c_mtime, &mtime),
+	NEWC_FIELD(c_mtime, &mtime.tv_sec),
 	NEWC_FIELD(c_filesize, &body_len),
 	NEWC_FIELD(c_devmajor, &major),
 	NEWC_FIELD(c_devminor, &minor),
@@ -214,10 +221,46 @@ static struct cpio_hdr_field cpio_newc_header_info[] __initdata = {
 	{ 0 },
 };
 
+struct cpio_newcx_header {
+	char    c_ino[8];
+	char    c_mode[8];
+	char    c_uid[8];
+	char    c_gid[8];
+	char    c_nlink[8];
+	char    c_mtime[16];
+	char    c_mtime_nsec[8];
+	char    c_filesize[16];
+	char    c_devmajor[8];
+	char    c_devminor[8];
+	char    c_rdevmajor[8];
+	char    c_rdevminor[8];
+	char    c_namesize[8];
+	char    c_xattrsize[8];
+};
+
+static struct cpio_hdr_field cpio_newcx_header_info[] __initdata = {
+	NEWCX_FIELD(c_ino, &ino),
+	NEWCX_FIELD(c_mode, &mode_u32),
+	NEWCX_FIELD(c_uid, &uid),
+	NEWCX_FIELD(c_gid, &gid),
+	NEWCX_FIELD(c_nlink, &nlink),
+	NEWCX_FIELD(c_mtime, &mtime.tv_sec),
+	NEWCX_FIELD(c_mtime_nsec, &mtime.tv_nsec),
+	NEWCX_FIELD(c_filesize, &body_len),
+	NEWCX_FIELD(c_devmajor, &major),
+	NEWCX_FIELD(c_devminor, &minor),
+	NEWCX_FIELD(c_rdevmajor, &rmajor),
+	NEWCX_FIELD(c_rdevminor, &rminor),
+	NEWCX_FIELD(c_namesize, &name_len),
+	NEWCX_FIELD(c_xattrsize, &xattr_len),
+	{ 0 },
+};
+
 static void __init parse_header(char *s)
 {
 	char buf[CPIO_MAX_FIELD_SIZE + 1];
-	struct cpio_hdr_field *field = cpio_newc_header_info;
+	struct cpio_hdr_field *field = (cpio_format == CPIO_NEWC) ?
+		cpio_newc_header_info : cpio_newcx_header_info;
 
 	while (field->size) {
 		int ret = 0;
@@ -243,7 +286,12 @@ static void __init parse_header(char *s)
 			pr_err("invalid cpio header field (%d)", ret);
 		field++;
 	}
+
 	mode = mode_u32;
+	if (cpio_format != CPIO_NEWCX) {
+		xattr_len = 0;
+		mtime.tv_nsec = 0;
+	}
 }
 
 /* FSM */
@@ -254,6 +302,7 @@ static int __init do_format(void);
 static int __init do_header(void);
 static int __init do_skip(void);
 static int __init do_name(void);
+static int __init do_xattrs(void);
 static int __init do_create(void);
 static int __init do_copy(void);
 static int __init do_symlink(void);
@@ -291,7 +340,7 @@ static void __init read_into(char *buf, unsigned size, fsm_state_t next)
 	}
 }
 
-static __initdata char *header_buf, *symlink_buf, *name_buf;
+static __initdata char *header_buf, *symlink_buf, *name_buf, *xattr_buf;
 
 static int __init do_start(void)
 {
@@ -315,22 +364,34 @@ static int __init do_collect(void)
 
 static int __init do_format(void)
 {
-	if (memcmp(collected, "070707", CPIO_MAGIC_SIZE) == 0) {
+	int header_size = 0;
+
+	cpio_format = CPIO_NO_MAGIC;
+
+	if (!memcmp(collected, "070707", CPIO_MAGIC_SIZE)) {
 		error("incorrect cpio method used: use -H newc option");
 		return 1;
+	} else if (!memcmp(collected, "070701", CPIO_MAGIC_SIZE)) {
+		cpio_format = CPIO_NEWC;
+		header_size = sizeof(struct cpio_newc_header);
+	} else if (!memcmp(collected, "070703", CPIO_MAGIC_SIZE)) {
+		cpio_format = CPIO_NEWCX;
+		header_size = sizeof(struct cpio_newcx_header);
 	}
-	if (memcmp(collected, "070701", CPIO_MAGIC_SIZE)) {
+
+	if (cpio_format == CPIO_NO_MAGIC) {
 		error("no cpio magic");
 		return 1;
 	}
-	read_into(header_buf, sizeof(struct cpio_newc_header), do_header);
+	read_into(header_buf, header_size, do_header);
 	return 0;
 }
 
 static int __init do_header(void)
 {
 	parse_header(collected);
-	next_header = this_header + N_ALIGN(name_len) + body_len;
+	next_header = this_header + N_ALIGN(name_len) + X_ALIGN(xattr_len) +
+		      body_len;
 	next_header = (next_header + 3) & ~3;
 	state = do_skip;
 	if (name_len <= 0 || name_len > PATH_MAX)
@@ -400,9 +461,17 @@ static int __init do_name(void)
 	}
 	memcpy_optional(name_buf, collected, N_ALIGN(name_len));
 	state = do_create;
+	if (xattr_len > 0)
+		read_into(xattr_buf, X_ALIGN(xattr_len), do_xattrs);
 	return 0;
 }
 
+static int __init do_xattrs(void)
+{
+	/* Do nothing for now */
+	state = do_create;
+	return 0;
+}
 
 static __initdata int wfd;
 
@@ -431,7 +500,7 @@ static int __init do_create(void)
 		sys_mkdir(name_buf, mode);
 		sys_chown(name_buf, uid, gid);
 		sys_chmod(name_buf, mode);
-		dir_add(name_buf, mtime);
+		dir_add(name_buf, &mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link(name_buf) == 0) {
@@ -439,7 +508,7 @@ static int __init do_create(void)
 			sys_mknod(name_buf, mode, rdev);
 			sys_chown(name_buf, uid, gid);
 			sys_chmod(name_buf, mode);
-			do_utime(name_buf, mtime);
+			do_utime(name_buf, &mtime);
 		}
 	} else if (S_ISLNK(mode)) {
 		if (body_len > PATH_MAX)
@@ -455,7 +524,7 @@ static int __init do_copy(void)
 		if (xwrite(wfd, victim, body_len) != body_len)
 			error("write error");
 		sys_close(wfd);
-		do_utime(name_buf, mtime);
+		do_utime(name_buf, &mtime);
 		eat(body_len);
 		state = do_skip;
 		return 0;
@@ -475,7 +544,7 @@ static int __init do_symlink(void)
 	clean_path(name_buf, 0);
 	sys_symlink(symlink_buf, name_buf);
 	sys_lchown(name_buf, uid, gid);
-	do_utime(name_buf, mtime);
+	do_utime(name_buf, &mtime);
 	state = do_skip;
 	next_state = do_reset;
 	return 0;
@@ -529,8 +598,9 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	header_buf = kmalloc(CPIO_MAX_HEADER_SIZE, GFP_KERNEL);
 	symlink_buf = kmalloc(PATH_MAX + 1, GFP_KERNEL);
 	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
+	xattr_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 
-	if (!header_buf || !symlink_buf || !name_buf)
+	if (!header_buf || !symlink_buf || !name_buf || !xattr_buf)
 		panic("can't allocate buffers");
 
 	state = do_start;
@@ -575,6 +645,7 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 		len -= my_inptr;
 	}
 	dir_utime();
+	kfree(xattr_buf);
 	kfree(name_buf);
 	kfree(symlink_buf);
 	kfree(header_buf);
-- 
2.10.3.dirty
