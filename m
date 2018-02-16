Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbeBPUeL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:34:11 -0500
Received: from alln-iport-5.cisco.com ([173.37.142.92]:39133 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbeBPUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:34:07 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="71365216"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 11/15] gen_init_cpio: add newcx format
Date: Fri, 16 Feb 2018 20:33:47 +0000
Message-Id: <1518813234-5874-12-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "newcx" format that supports extended attributes and has increased
size of c_mtime and c_filesize fields.

Added -x option to select "newcx" format. Default is "newc".

Refer to Documentation/early-userspace/buffer-format.txt for detailed
format description.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 usr/gen_init_cpio.c | 69 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 7a2a6d85345d..25afd5b4af77 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -21,6 +21,8 @@
 #define xstr(s) #s
 #define str(s) xstr(s)
 
+static int newcx;
+static unsigned int cpio_hdr_size;
 static unsigned int offset;
 static unsigned int ino = 721;
 static time_t default_mtime;
@@ -56,7 +58,7 @@ static void push_rest(const char *name)
 	putchar(0);
 	offset += name_len;
 
-	tmp_ofs = name_len + 110;
+	tmp_ofs = name_len + cpio_hdr_size;
 	while (tmp_ofs & 3) {
 		putchar(0);
 		offset++;
@@ -77,6 +79,7 @@ struct cpio_header {
 	int rdevmajor;
 	int rdevminor;
 	size_t namesize;
+	size_t xattrsize;
 	unsigned int check;
 };
 
@@ -84,24 +87,44 @@ static void push_hdr(const struct cpio_header *hdr)
 {
 	char s[256];
 
-	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
-		   "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",
-		hdr->ino,
-		hdr->mode,
-		(long)hdr->uid,
-		(long)hdr->gid,
-		hdr->nlink,
-		(long)hdr->mtime,
-		(unsigned int)hdr->filesize,
-		hdr->devmajor,
-		hdr->devminor,
-		hdr->rdevmajor,
-		hdr->rdevminor,
-		(unsigned int)hdr->namesize,
-		hdr->check);
+	if (newcx) {
+		sprintf(s, "%s%08X%08X%08lX%08lX%08X%016llX%08X"
+			   "%016llX%08X%08X%08X%08X%08X%08X",
+			"070703",
+			hdr->ino,
+			hdr->mode,
+			(long)hdr->uid,
+			(long)hdr->gid,
+			hdr->nlink,
+			(long long)hdr->mtime,
+			0,
+			(long long)hdr->filesize,
+			hdr->devmajor,
+			hdr->devminor,
+			hdr->rdevmajor,
+			hdr->rdevminor,
+			(unsigned int)hdr->namesize,
+			(unsigned int)hdr->xattrsize);
+	} else {
+		sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
+			   "%08X%08X%08X%08X%08X%08X%08X",
+			"070701",
+			hdr->ino,
+			hdr->mode,
+			(long)hdr->uid,
+			(long)hdr->gid,
+			hdr->nlink,
+			(long)hdr->mtime,
+			(unsigned int)hdr->filesize,
+			hdr->devmajor,
+			hdr->devminor,
+			hdr->rdevmajor,
+			hdr->rdevminor,
+			(unsigned int)hdr->namesize,
+			hdr->check);
+	}
 	fputs(s, stdout);
-	offset += 110;
+	offset += cpio_hdr_size;
 }
 
 static void cpio_trailer(void)
@@ -301,7 +324,7 @@ static int cpio_mkfile(const char *name, const char *location,
 {
 	char *filebuf = NULL;
 	struct stat buf;
-	long size;
+	size_t size;
 	int file = -1;
 	int retval;
 	int rc = -1;
@@ -450,7 +473,7 @@ static int cpio_mkfile_line(const char *line)
 static void usage(const char *prog)
 {
 	fprintf(stderr, "Usage:\n"
-		"\t%s [-t <timestamp>] <cpio_list>\n"
+		"\t%s [-t <timestamp>] [-x] <cpio_list>\n"
 		"\n"
 		"<cpio_list> is a file containing newline separated entries that\n"
 		"describe the files to be included in the initramfs archive:\n"
@@ -527,7 +550,7 @@ int main (int argc, char *argv[])
 
 	default_mtime = time(NULL);
 	while (1) {
-		int opt = getopt(argc, argv, "t:h");
+		int opt = getopt(argc, argv, "t:h:x");
 		char *invalid;
 
 		if (opt == -1)
@@ -542,12 +565,16 @@ int main (int argc, char *argv[])
 				exit(1);
 			}
 			break;
+		case 'x':
+			newcx = 1;
+			break;
 		case 'h':
 		case '?':
 			usage(argv[0]);
 			exit(opt == 'h' ? 0 : 1);
 		}
 	}
+	cpio_hdr_size = newcx ? 134 : 110;
 
 	if (argc - optind != 1) {
 		usage(argv[0]);
-- 
2.10.3.dirty
