Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754098AbeDYLNv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:13:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:56957 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753850AbeDYLNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:13:48 -0400
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v5 06/11] vsprintf: Factor out %p[iI] handler as ip_addr_string()
Date: Wed, 25 Apr 2018 13:12:46 +0200
Message-Id: <20180425111251.13246-7-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425111251.13246-1-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the non-trivial code from the long pointer() function. We are going
to add a check for the access to the address that will make it even more
complicated.

Also it is better to warn about unknown specifier instead of falling
back to the %p behavior. It will help people to understand what is
going wrong. They expect the IP address and not a pointer anyway
in this situation.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 57 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 587175a528b7..92793060bb1f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1387,6 +1387,39 @@ char *ip4_addr_string_sa(char *buf, char *end, const struct sockaddr_in *sa,
 }
 
 static noinline_for_stack
+char *ip_addr_string(char *buf, char *end, const void *ptr,
+		     struct printf_spec spec, const char *fmt)
+{
+	char *err_fmt_msg;
+
+	switch (fmt[1]) {
+	case '6':
+		return ip6_addr_string(buf, end, ptr, spec, fmt);
+	case '4':
+		return ip4_addr_string(buf, end, ptr, spec, fmt);
+	case 'S': {
+		const union {
+			struct sockaddr		raw;
+			struct sockaddr_in	v4;
+			struct sockaddr_in6	v6;
+		} *sa = ptr;
+
+		switch (sa->raw.sa_family) {
+		case AF_INET:
+			return ip4_addr_string_sa(buf, end, &sa->v4, spec, fmt);
+		case AF_INET6:
+			return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
+		default:
+			return valid_string(buf, end, "(invalid address)",
+					    spec);
+		}}
+	}
+
+	err_fmt_msg = fmt[0] == 'i' ? "(%pi?)" : "(%pI?)";
+	return valid_string(buf, end, err_fmt_msg, spec);
+}
+
+static noinline_for_stack
 char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		     const char *fmt)
 {
@@ -1888,29 +1921,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 					 * 4:	001.002.003.004
 					 * 6:   000102...0f
 					 */
-		switch (fmt[1]) {
-		case '6':
-			return ip6_addr_string(buf, end, ptr, spec, fmt);
-		case '4':
-			return ip4_addr_string(buf, end, ptr, spec, fmt);
-		case 'S': {
-			const union {
-				struct sockaddr		raw;
-				struct sockaddr_in	v4;
-				struct sockaddr_in6	v6;
-			} *sa = ptr;
-
-			switch (sa->raw.sa_family) {
-			case AF_INET:
-				return ip4_addr_string_sa(buf, end, &sa->v4, spec, fmt);
-			case AF_INET6:
-				return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
-			default:
-				return valid_string(buf, end,
-						    "(invalid address)", spec);
-			}}
-		}
-		break;
+		return ip_addr_string(buf, end, ptr, spec, fmt);
 	case 'E':
 		return escaped_string(buf, end, ptr, spec, fmt);
 	case 'U':
-- 
2.13.6
