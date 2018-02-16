Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeBPUhr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:37:47 -0500
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:17582 "EHLO
        rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbeBPUeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:34:02 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="350021939"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 07/15] initramfs: split header layout information from parsing function
Date: Fri, 16 Feb 2018 20:33:43 +0000
Message-Id: <1518813234-5874-8-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Header parsing has hardcoded assumption about header field size and
layout. It is hard to modify the function to parse a new format.

Move information about size and layout into a data structure to
make parsing code more generic and simplify adding a new format.
This also removes some magic numbers.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 122 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 92 insertions(+), 30 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index b3d39c8793be..7f0bbfde94e3 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -150,39 +150,100 @@ static void __init dir_utime(void)
 	}
 }
 
-static __initdata time64_t mtime;
-
 /* cpio header parsing */
-
-static __initdata unsigned long ino, major, minor, nlink;
+static __initdata time64_t mtime;
+static __initdata u32 ino, major, minor, nlink, rmajor, rminor;
 static __initdata umode_t mode;
-static __initdata unsigned long body_len, name_len;
+static __initdata u32 body_len, name_len;
 static __initdata uid_t uid;
 static __initdata gid_t gid;
-static __initdata unsigned rdev;
+static __initdata u32 mode_u32;
+
+struct cpio_hdr_field {
+	size_t offset;
+	size_t size;
+	void *out;
+	size_t out_size;
+	const char *name;
+};
+
+#define HDR_FIELD(type, field, variable) \
+	{ .offset = offsetof(type, field) + \
+	  BUILD_BUG_ON_ZERO(sizeof(*(variable))*2 < FIELD_SIZEOF(type, field)),\
+	  .size = FIELD_SIZEOF(type, field), \
+	  .out = variable, \
+	  .out_size = sizeof(*(variable)), \
+	  .name = #field }
+
+#define NEWC_FIELD(field, variable) \
+		HDR_FIELD(struct cpio_newc_header, field, variable)
+
+#define CPIO_MAX_HEADER_SIZE sizeof(struct cpio_newc_header)
+#define CPIO_MAX_FIELD_SIZE 8
+#define CPIO_MAGIC_SIZE 6
+
+struct cpio_newc_header {
+	char    c_ino[8];
+	char    c_mode[8];
+	char    c_uid[8];
+	char    c_gid[8];
+	char    c_nlink[8];
+	char    c_mtime[8];
+	char    c_filesize[8];
+	char    c_devmajor[8];
+	char    c_devminor[8];
+	char    c_rdevmajor[8];
+	char    c_rdevminor[8];
+	char    c_namesize[8];
+	char    c_check[8];
+};
+
+static struct cpio_hdr_field cpio_newc_header_info[] __initdata = {
+	NEWC_FIELD(c_ino, &ino),
+	NEWC_FIELD(c_mode, &mode_u32),
+	NEWC_FIELD(c_uid, &uid),
+	NEWC_FIELD(c_gid, &gid),
+	NEWC_FIELD(c_nlink, &nlink),
+	NEWC_FIELD(c_mtime, &mtime),
+	NEWC_FIELD(c_filesize, &body_len),
+	NEWC_FIELD(c_devmajor, &major),
+	NEWC_FIELD(c_devminor, &minor),
+	NEWC_FIELD(c_rdevmajor, &rmajor),
+	NEWC_FIELD(c_rdevminor, &rminor),
+	NEWC_FIELD(c_namesize, &name_len),
+	{ 0 },
+};
 
 static void __init parse_header(char *s)
 {
-	unsigned long parsed[12];
-	char buf[9];
-	int i;
-
-	buf[8] = '\0';
-	for (i = 0; i < 12; i++, s += 8) {
-		memcpy(buf, s, 8);
-		parsed[i] = simple_strtoul(buf, NULL, 16);
+	char buf[CPIO_MAX_FIELD_SIZE + 1];
+	struct cpio_hdr_field *field = cpio_newc_header_info;
+
+	while (field->size) {
+		int ret = 0;
+
+		memcpy(buf, s + field->offset, field->size);
+		buf[field->size] = '\0';
+		switch (field->out_size) {
+		case sizeof(u32):
+			ret = kstrtou32(buf, 16, field->out);
+			pr_debug("cpio field %s: %u, buf: %s\n",
+				 field->name, *(u32 *)field->out, buf);
+			break;
+		case sizeof(u64):
+			ret = kstrtou64(buf, 16, field->out);
+			pr_debug("cpio field %s: %llu, buf: %s\n",
+				 field->name, *(u64 *)field->out, buf);
+			break;
+		default:
+			BUG_ON(1);
+		}
+
+		if (ret)
+			pr_err("invalid cpio header field (%d)", ret);
+		field++;
 	}
-	ino = parsed[0];
-	mode = parsed[1];
-	uid = parsed[2];
-	gid = parsed[3];
-	nlink = parsed[4];
-	mtime = parsed[5]; /* breaks in y2106 */
-	body_len = parsed[6];
-	major = parsed[7];
-	minor = parsed[8];
-	rdev = new_encode_dev(MKDEV(parsed[9], parsed[10]));
-	name_len = parsed[11];
+	mode = mode_u32;
 }
 
 /* FSM */
@@ -234,7 +295,7 @@ static __initdata char *header_buf, *symlink_buf, *name_buf;
 
 static int __init do_start(void)
 {
-	read_into(header_buf, 6, do_format);
+	read_into(header_buf, CPIO_MAGIC_SIZE, do_format);
 	return 0;
 }
 
@@ -254,15 +315,15 @@ static int __init do_collect(void)
 
 static int __init do_format(void)
 {
-	if (memcmp(collected, "070707", 6)==0) {
+	if (memcmp(collected, "070707", CPIO_MAGIC_SIZE) == 0) {
 		error("incorrect cpio method used: use -H newc option");
 		return 1;
 	}
-	if (memcmp(collected, "070701", 6)) {
+	if (memcmp(collected, "070701", CPIO_MAGIC_SIZE)) {
 		error("no cpio magic");
 		return 1;
 	}
-	read_into(header_buf, 104, do_header);
+	read_into(header_buf, sizeof(struct cpio_newc_header), do_header);
 	return 0;
 }
 
@@ -374,6 +435,7 @@ static int __init do_create(void)
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link(name_buf) == 0) {
+			u32 rdev = new_encode_dev(MKDEV(rmajor, rminor));
 			sys_mknod(name_buf, mode, rdev);
 			sys_chown(name_buf, uid, gid);
 			sys_chmod(name_buf, mode);
@@ -464,7 +526,7 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	const char *compress_name;
 	static __initdata char msg_buf[64];
 
-	header_buf = kmalloc(104, GFP_KERNEL);
+	header_buf = kmalloc(CPIO_MAX_HEADER_SIZE, GFP_KERNEL);
 	symlink_buf = kmalloc(PATH_MAX + 1, GFP_KERNEL);
 	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
 
-- 
2.10.3.dirty
