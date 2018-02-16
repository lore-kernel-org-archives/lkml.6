Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeBPUjW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:39:22 -0500
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:52500 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbeBPUd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:33:58 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="346479128"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 02/15] initramfs: replace states with function pointers
Date: Fri, 16 Feb 2018 20:33:38 +0000
Message-Id: <1518813234-5874-3-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the FSM states are mapped directly to function pointers. Extra
level of intirection is not needed and makes navigation over the code
harder. One can't jump between states directly when browsing code (e.g.
with cscope). Need to go through actions[] array each time.

Replace states with their action function pointers. No behaviour change.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 73 +++++++++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7e99a0038942..49cd2681a26f 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -187,16 +187,17 @@ static void __init parse_header(char *s)
 
 /* FSM */
 
-static __initdata enum state {
-	Start,
-	Collect,
-	GotHeader,
-	SkipIt,
-	GotName,
-	CopyFile,
-	GotSymlink,
-	Reset
-} state, next_state;
+static int __init do_start(void);
+static int __init do_collect(void);
+static int __init do_header(void);
+static int __init do_skip(void);
+static int __init do_name(void);
+static int __init do_copy(void);
+static int __init do_symlink(void);
+static int __init do_reset(void);
+
+typedef int (*fsm_state_t)(void);
+static __initdata fsm_state_t state, next_state;
 
 static __initdata char *victim;
 static unsigned long byte_count __initdata;
@@ -214,7 +215,7 @@ static __initdata char *collected;
 static long remains __initdata;
 static __initdata char *collect;
 
-static void __init read_into(char *buf, unsigned size, enum state next)
+static void __init read_into(char *buf, unsigned size, fsm_state_t next)
 {
 	if (byte_count >= size) {
 		collected = victim;
@@ -224,7 +225,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 		collect = collected = buf;
 		remains = size;
 		next_state = next;
-		state = Collect;
+		state = do_collect;
 	}
 }
 
@@ -232,7 +233,7 @@ static __initdata char *header_buf, *symlink_buf, *name_buf;
 
 static int __init do_start(void)
 {
-	read_into(header_buf, 110, GotHeader);
+	read_into(header_buf, 110, do_header);
 	return 0;
 }
 
@@ -263,7 +264,7 @@ static int __init do_header(void)
 	parse_header(collected);
 	next_header = this_header + N_ALIGN(name_len) + body_len;
 	next_header = (next_header + 3) & ~3;
-	state = SkipIt;
+	state = do_skip;
 	if (name_len <= 0 || name_len > PATH_MAX)
 		return 0;
 	if (S_ISLNK(mode)) {
@@ -271,12 +272,12 @@ static int __init do_header(void)
 			return 0;
 		collect = collected = symlink_buf;
 		remains = N_ALIGN(name_len) + body_len;
-		next_state = GotSymlink;
-		state = Collect;
+		next_state = do_symlink;
+		state = do_collect;
 		return 0;
 	}
 	if (S_ISREG(mode) || !body_len)
-		read_into(name_buf, N_ALIGN(name_len), GotName);
+		read_into(name_buf, N_ALIGN(name_len), do_name);
 	return 0;
 }
 
@@ -327,8 +328,8 @@ static __initdata int wfd;
 
 static int __init do_name(void)
 {
-	state = SkipIt;
-	next_state = Reset;
+	state = do_skip;
+	next_state = do_reset;
 	if (strcmp(collected, "TRAILER!!!") == 0) {
 		free_hash();
 		return 0;
@@ -348,7 +349,7 @@ static int __init do_name(void)
 				if (body_len)
 					sys_ftruncate(wfd, body_len);
 				vcollected = kstrdup(collected, GFP_KERNEL);
-				state = CopyFile;
+				state = do_copy;
 			}
 		}
 	} else if (S_ISDIR(mode)) {
@@ -377,7 +378,7 @@ static int __init do_copy(void)
 		do_utime(vcollected, mtime);
 		kfree(vcollected);
 		eat(body_len);
-		state = SkipIt;
+		state = do_skip;
 		return 0;
 	} else {
 		if (xwrite(wfd, victim, byte_count) != byte_count)
@@ -395,29 +396,19 @@ static int __init do_symlink(void)
 	sys_symlink(collected + N_ALIGN(name_len), collected);
 	sys_lchown(collected, uid, gid);
 	do_utime(collected, mtime);
-	state = SkipIt;
-	next_state = Reset;
+	state = do_skip;
+	next_state = do_reset;
 	return 0;
 }
 
-static __initdata int (*actions[])(void) = {
-	[Start]		= do_start,
-	[Collect]	= do_collect,
-	[GotHeader]	= do_header,
-	[SkipIt]	= do_skip,
-	[GotName]	= do_name,
-	[CopyFile]	= do_copy,
-	[GotSymlink]	= do_symlink,
-	[Reset]		= do_reset,
-};
-
 static long __init write_buffer(char *buf, unsigned long len)
 {
 	byte_count = len;
 	victim = buf;
 
-	while (!actions[state]())
-		;
+	do
+		pr_debug("state: %pf\n", state);
+	while (!state());
 	return len - byte_count;
 }
 
@@ -433,11 +424,11 @@ static long __init flush_buffer(void *bufv, unsigned long len)
 		if (c == '0') {
 			buf += written;
 			len -= written;
-			state = Start;
+			state = do_start;
 		} else if (c == 0) {
 			buf += written;
 			len -= written;
-			state = Reset;
+			state = do_reset;
 		} else
 			error("junk in compressed archive");
 	}
@@ -462,13 +453,13 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	if (!header_buf || !symlink_buf || !name_buf)
 		panic("can't allocate buffers");
 
-	state = Start;
+	state = do_start;
 	this_header = 0;
 	message = NULL;
 	while (!message && len) {
 		loff_t saved_offset = this_header;
 		if (*buf == '0' && !(this_header & 3)) {
-			state = Start;
+			state = do_start;
 			written = write_buffer(buf, len);
 			buf += written;
 			len -= written;
@@ -497,7 +488,7 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 			}
 		} else
 			error("junk in compressed archive");
-		if (state != Reset)
+		if (state != do_reset)
 			error("junk in compressed archive");
 		this_header = saved_offset + my_inptr;
 		buf += my_inptr;
-- 
2.10.3.dirty
