Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbeDAI4l (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 04:56:41 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:43850 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753000AbeDAI4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 04:56:39 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, pantelis.antoniou@konsulko.com,
        mark.rutland@arm.com, pmladek@suse.com,
        andriy.shevchenko@linux.intel.com, joe@perches.com, corbet@lwn.net,
        me@tobin.cc, sergey.senozhatsky@gmail.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] lib: vsprintf: Implement %pCOW
Date: Sun,  1 Apr 2018 10:56:21 +0200
Message-Id: <20180401085622.7754-2-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180401085622.7754-1-richard@nod.at>
References: <20180401085622.7754-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new format string to print in cowsay format.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 lib/vsprintf.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..a48df6f1c3f0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1693,6 +1693,55 @@ static int __init initialize_ptr_random(void)
 }
 early_initcall(initialize_ptr_random);
 
+static char *cowsay(char *buf, char *end, void *ptr)
+{
+	static char dashes[] = {[0 ... 256] = '-'};
+	static char unders[] = {[0 ... 256] = '_'};
+	static char spaces[] = {[0 ... 256] = ' '};
+	static struct cow_type {
+		int num_lines;
+		char *cow_lines[];
+	} default_cow = {
+		.num_lines = 5,
+		.cow_lines = {
+			"\\   ^__^",
+			" \\  (oo)\\_______",
+			"    (__)\\       )\\/\\",
+			"        ||----w |",
+			"        ||     ||",
+		},
+	};
+
+	int i, n;
+	char *orig_buf = buf;
+	char *str = ptr;
+	int len = strlen(str);
+
+	n = snprintf(buf, end - buf, "  %.*s\n< %s >\n  %.*s\n", len, unders,
+		     str, len, dashes);
+	if (n < 0 || buf + n >= end)
+		goto cow_too_fat;
+
+	buf += n;
+
+	for (i = 0; i < default_cow.num_lines; i++) {
+		n = snprintf(buf, end - buf, "%.*s%s\n", len / 2, spaces,
+			     default_cow.cow_lines[i]);
+		if (n < 0 || buf + n >= end)
+			goto cow_too_fat;
+
+		buf += n;
+	}
+
+	return buf;
+
+cow_too_fat:
+	n = snprintf(orig_buf, end - orig_buf, "%s\n", str);
+	if (n > 0)
+		orig_buf += n;
+	return orig_buf;
+}
+
 /* Maps a pointer to a 32 bit unique identifier. */
 static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 {
@@ -1941,6 +1990,9 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'd':
 		return dentry_name(buf, end, ptr, spec, fmt);
 	case 'C':
+		if (fmt[1] == 'O' && fmt[2] == 'W')
+			return cowsay(buf, end, ptr);
+
 		return clock(buf, end, ptr, spec, fmt);
 	case 'D':
 		return dentry_name(buf, end,
-- 
2.13.6
