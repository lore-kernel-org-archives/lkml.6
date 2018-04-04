Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDDJAi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:00:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34585 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbeDDI7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:59:35 -0400
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 5/9] vsprintf: Factor out %p[iI] handler as ip_addr_string()
Date: Wed,  4 Apr 2018 10:58:39 +0200
Message-Id: <20180404085843.16050-6-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180404085843.16050-1-pmladek@suse.com>
References: <20180404085843.16050-1-pmladek@suse.com>
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
 lib/vsprintf.c | 54 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 5a0d01846a11..88b80c7059f0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1319,6 +1319,37 @@ char *ip4_addr_string_sa(char *buf, char *end, const struct sockaddr_in *sa,
 }
 
 static noinline_for_stack
+char *ip_addr_string(char *buf, char *end, const void *ptr,
+		     struct printf_spec spec, const char *fmt)
+{
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
+			return __string(buf, end, "(invalid address)", spec);
+		}}
+	}
+
+	WARN_ONCE(1, "Unsupported pointer format specifier: %%p%c%c\n",
+		  fmt[0], fmt[1]);
+	return buf;
+}
+
+static noinline_for_stack
 char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		     const char *fmt)
 {
@@ -1909,28 +1940,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
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
-				return __string(buf, end, "(invalid address)", spec);
-			}}
-		}
-		break;
+		return ip_addr_string(buf, end, ptr, spec, fmt);
 	case 'E':
 		return escaped_string(buf, end, ptr, spec, fmt);
 	case 'U':
-- 
2.13.6
