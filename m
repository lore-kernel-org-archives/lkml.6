Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeBPUgw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:36:52 -0500
Received: from alln-iport-5.cisco.com ([173.37.142.92]:39133 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeBPUeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:34:05 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="71365210"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 10/15] gen_init_cpio: move header formatting into function
Date: Fri, 16 Feb 2018 20:33:46 +0000
Message-Id: <1518813234-5874-11-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPIO header is generated in multiple places with the same sprintf()
format string. Move formatting into a single function in preparation
to adding a new cpio format.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 usr/gen_init_cpio.c | 186 ++++++++++++++++++++++++++--------------------------
 1 file changed, 92 insertions(+), 94 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 03b21189d58b..7a2a6d85345d 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -64,34 +64,55 @@ static void push_rest(const char *name)
 	}
 }
 
-static void push_hdr(const char *s)
+struct cpio_header {
+	unsigned int ino;
+	unsigned int mode;
+	uid_t uid;
+	gid_t gid;
+	unsigned int nlink;
+	time_t mtime;
+	size_t filesize;
+	int devmajor;
+	int devminor;
+	int rdevmajor;
+	int rdevminor;
+	size_t namesize;
+	unsigned int check;
+};
+
+static void push_hdr(const struct cpio_header *hdr)
 {
+	char s[256];
+
+	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
+		   "%08X%08X%08X%08X%08X%08X%08X",
+		"070701",
+		hdr->ino,
+		hdr->mode,
+		(long)hdr->uid,
+		(long)hdr->gid,
+		hdr->nlink,
+		(long)hdr->mtime,
+		(unsigned int)hdr->filesize,
+		hdr->devmajor,
+		hdr->devminor,
+		hdr->rdevmajor,
+		hdr->rdevminor,
+		(unsigned int)hdr->namesize,
+		hdr->check);
 	fputs(s, stdout);
 	offset += 110;
 }
 
 static void cpio_trailer(void)
 {
-	char s[256];
 	const char name[] = "TRAILER!!!";
+	struct cpio_header hdr = {
+		.nlink = 1,
+		.namesize = strlen(name)+1,
+	};
 
-	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
-		0,			/* ino */
-		0,			/* mode */
-		(long) 0,		/* uid */
-		(long) 0,		/* gid */
-		1,			/* nlink */
-		(long) 0,		/* mtime */
-		0,			/* filesize */
-		0,			/* major */
-		0,			/* minor */
-		0,			/* rmajor */
-		0,			/* rminor */
-		(unsigned)strlen(name)+1, /* namesize */
-		0);			/* chksum */
-	push_hdr(s);
+	push_hdr(&hdr);
 	push_rest(name);
 
 	while (offset % 512) {
@@ -103,27 +124,21 @@ static void cpio_trailer(void)
 static int cpio_mkslink(const char *name, const char *target,
 			 unsigned int mode, uid_t uid, gid_t gid)
 {
-	char s[256];
-
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
-		ino++,			/* ino */
-		S_IFLNK | mode,		/* mode */
-		(long) uid,		/* uid */
-		(long) gid,		/* gid */
-		1,			/* nlink */
-		(long) default_mtime,	/* mtime */
-		(unsigned)strlen(target)+1, /* filesize */
-		3,			/* major */
-		1,			/* minor */
-		0,			/* rmajor */
-		0,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
-		0);			/* chksum */
-	push_hdr(s);
+	struct cpio_header hdr = {
+		.ino = ino++,
+		.mode = S_IFLNK | mode,
+		.uid = uid,
+		.gid = gid,
+		.nlink = 1,
+		.mtime = default_mtime,
+		.filesize = strlen(target)+1,
+		.devmajor = 3,
+		.devminor = 1,
+		.namesize = strlen(name)+1,
+	};
+	push_hdr(&hdr);
 	push_string(name);
 	push_pad();
 	push_string(target);
@@ -152,27 +167,20 @@ static int cpio_mkslink_line(const char *line)
 static int cpio_mkgeneric(const char *name, unsigned int mode,
 		       uid_t uid, gid_t gid)
 {
-	char s[256];
-
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
-		ino++,			/* ino */
-		mode,			/* mode */
-		(long) uid,		/* uid */
-		(long) gid,		/* gid */
-		2,			/* nlink */
-		(long) default_mtime,	/* mtime */
-		0,			/* filesize */
-		3,			/* major */
-		1,			/* minor */
-		0,			/* rmajor */
-		0,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
-		0);			/* chksum */
-	push_hdr(s);
+	struct cpio_header hdr = {
+		.ino = ino++,
+		.mode = mode,
+		.uid = uid,
+		.gid = gid,
+		.nlink = 2,
+		.mtime = default_mtime,
+		.devmajor = 3,
+		.devminor = 1,
+		.namesize = strlen(name)+1,
+	};
+	push_hdr(&hdr);
 	push_rest(name);
 	return 0;
 }
@@ -241,8 +249,6 @@ static int cpio_mknod(const char *name, unsigned int mode,
 		       uid_t uid, gid_t gid, char dev_type,
 		       unsigned int maj, unsigned int min)
 {
-	char s[256];
-
 	if (dev_type == 'b')
 		mode |= S_IFBLK;
 	else
@@ -250,23 +256,20 @@ static int cpio_mknod(const char *name, unsigned int mode,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
-		ino++,			/* ino */
-		mode,			/* mode */
-		(long) uid,		/* uid */
-		(long) gid,		/* gid */
-		1,			/* nlink */
-		(long) default_mtime,	/* mtime */
-		0,			/* filesize */
-		3,			/* major */
-		1,			/* minor */
-		maj,			/* rmajor */
-		min,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
-		0);			/* chksum */
-	push_hdr(s);
+	struct cpio_header hdr = {
+		.ino = ino++,
+		.mode = mode,
+		.uid = uid,
+		.gid = gid,
+		.nlink = 1,
+		.mtime = default_mtime,
+		.devmajor = 3,
+		.devminor = 1,
+		.rdevmajor = maj,
+		.rdevminor = min,
+		.namesize = strlen(name)+1,
+	};
+	push_hdr(&hdr);
 	push_rest(name);
 	return 0;
 }
@@ -296,7 +299,6 @@ static int cpio_mkfile(const char *name, const char *location,
 			unsigned int mode, uid_t uid, gid_t gid,
 			unsigned int nlinks)
 {
-	char s[256];
 	char *filebuf = NULL;
 	struct stat buf;
 	long size;
@@ -340,23 +342,19 @@ static int cpio_mkfile(const char *name, const char *location,
 		if (name[0] == '/')
 			name++;
 		namesize = strlen(name) + 1;
-		sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-		       "%08lX%08X%08X%08X%08X%08X%08X",
-			"070701",		/* magic */
-			ino,			/* ino */
-			mode,			/* mode */
-			(long) uid,		/* uid */
-			(long) gid,		/* gid */
-			nlinks,			/* nlink */
-			(long) buf.st_mtime,	/* mtime */
-			size,			/* filesize */
-			3,			/* major */
-			1,			/* minor */
-			0,			/* rmajor */
-			0,			/* rminor */
-			namesize,		/* namesize */
-			0);			/* chksum */
-		push_hdr(s);
+		struct cpio_header hdr = {
+			.ino = ino,
+			.mode = mode,
+			.uid = uid,
+			.gid = gid,
+			.nlink = nlinks,
+			.mtime = buf.st_mtime,
+			.filesize = size,
+			.devmajor = 3,
+			.devminor = 1,
+			.namesize = namesize,
+		};
+		push_hdr(&hdr);
 		push_string(name);
 		push_pad();
 
-- 
2.10.3.dirty
