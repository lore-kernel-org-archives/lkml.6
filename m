Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeBPUhS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:37:18 -0500
Received: from alln-iport-3.cisco.com ([173.37.142.90]:11980 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeBPUeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:34:04 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="72038407"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 09/15] initramfs: set extended attributes
Date: Fri, 16 Feb 2018 20:33:45 +0000
Message-Id: <1518813234-5874-10-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

This patch writes out the extended attributes included in the cpio file.
As the "security.ima" xattr needs to be written after the file data.
this patch separates extracting and setting the xattrs by defining new
do_setxattrs state.

[kamensky: fixed restoring of xattrs for symbolic links by using
           sys_lsetxattr() instead of sys_setxattr()]

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 0407e199352e..ac636097aee5 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -306,6 +306,7 @@ static int __init do_xattrs(void);
 static int __init do_create(void);
 static int __init do_copy(void);
 static int __init do_symlink(void);
+static int __init do_setxattrs(void);
 static int __init do_reset(void);
 
 typedef int (*fsm_state_t)(void);
@@ -468,7 +469,7 @@ static int __init do_name(void)
 
 static int __init do_xattrs(void)
 {
-	/* Do nothing for now */
+	memcpy_optional(xattr_buf, collected, xattr_len);
 	state = do_create;
 	return 0;
 }
@@ -477,8 +478,7 @@ static __initdata int wfd;
 
 static int __init do_create(void)
 {
-	state = do_skip;
-	next_state = do_reset;
+	state = do_setxattrs;
 	clean_path(name_buf, mode);
 	if (S_ISREG(mode)) {
 		int ml = maybe_link(name_buf);
@@ -511,8 +511,11 @@ static int __init do_create(void)
 			do_utime(name_buf, &mtime);
 		}
 	} else if (S_ISLNK(mode)) {
-		if (body_len > PATH_MAX)
+		if (body_len > PATH_MAX) {
+			state = do_skip;
+			next_state = do_reset;
 			return 0;
+		}
 		read_into(symlink_buf, body_len, do_symlink);
 	}
 	return 0;
@@ -526,7 +529,7 @@ static int __init do_copy(void)
 		sys_close(wfd);
 		do_utime(name_buf, &mtime);
 		eat(body_len);
-		state = do_skip;
+		state = do_setxattrs;
 		return 0;
 	} else {
 		if (xwrite(wfd, victim, byte_count) != byte_count)
@@ -545,8 +548,52 @@ static int __init do_symlink(void)
 	sys_symlink(symlink_buf, name_buf);
 	sys_lchown(name_buf, uid, gid);
 	do_utime(name_buf, &mtime);
+	state = do_setxattrs;
+	return 0;
+}
+
+struct xattr_hdr {
+	char c_size[8]; /* total size including c_size field */
+	char c_data[];  /* <name>\0<value> */
+};
+
+static int __init do_setxattrs(void)
+{
+	char *buf = xattr_buf;
+	char *bufend = buf + xattr_len;
+	struct xattr_hdr *hdr;
+	char str[sizeof(hdr->c_size) + 1];
+
 	state = do_skip;
 	next_state = do_reset;
+	if (!xattr_len)
+		return 0;
+
+	str[sizeof(hdr->c_size)] = 0;
+
+	while (buf < bufend) {
+		char *xattr_name, *xattr_value;
+		unsigned long xattr_entry_size, xattr_value_size;
+		int ret;
+
+		hdr = (struct xattr_hdr *)buf;
+		memcpy(str, hdr->c_size, sizeof(hdr->c_size));
+		ret = kstrtoul(str, 16, &xattr_entry_size);
+		buf += xattr_entry_size;
+		if (ret || buf > bufend) {
+			error("malformed xattrs");
+			break;
+		}
+
+		xattr_name = hdr->c_data;
+		xattr_value = xattr_name + strlen(xattr_name) + 1;
+		xattr_value_size = buf - xattr_value;
+
+		ret = sys_lsetxattr(name_buf, xattr_name, xattr_value,
+				xattr_value_size, 0);
+		pr_debug("%s: %s size: %lu val: %s (ret: %d)\n", name_buf,
+				xattr_name, xattr_value_size, xattr_value, ret);
+	}
 	return 0;
 }
 
-- 
2.10.3.dirty
