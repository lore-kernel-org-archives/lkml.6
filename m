Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeDDJAW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:00:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:34597 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751326AbeDDI7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:59:37 -0400
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
Subject: [PATCH v4 6/9] vsprintf: Factor out %pV handler as va_format()
Date: Wed,  4 Apr 2018 10:58:40 +0200
Message-Id: <20180404085843.16050-7-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180404085843.16050-1-pmladek@suse.com>
References: <20180404085843.16050-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code from the long pointer() function. We are going to add a check
for the access to the address that will make it even more complicated.

This patch does not change the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 88b80c7059f0..f20eaa3f0092 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1410,6 +1410,19 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 }
 
 static noinline_for_stack
+char *va_format(char *buf, char *end, struct va_format *va_fmt)
+{
+	va_list va;
+
+	va_copy(va, *va_fmt->va);
+	buf += vsnprintf(buf, end > buf ? end - buf : 0,
+			 va_fmt->fmt, va);
+	va_end(va);
+
+	return buf;
+}
+
+static noinline_for_stack
 char *uuid_string(char *buf, char *end, const u8 *addr,
 		  struct printf_spec spec, const char *fmt)
 {
@@ -1946,15 +1959,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'U':
 		return uuid_string(buf, end, ptr, spec, fmt);
 	case 'V':
-		{
-			va_list va;
-
-			va_copy(va, *((struct va_format *)ptr)->va);
-			buf += vsnprintf(buf, end > buf ? end - buf : 0,
-					 ((struct va_format *)ptr)->fmt, va);
-			va_end(va);
-			return buf;
-		}
+		return va_format(buf, end, ptr);
 	case 'K':
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':
-- 
2.13.6
