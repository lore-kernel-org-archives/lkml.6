Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeDYLNy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:13:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:56938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752823AbeDYLNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:13:47 -0400
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
Subject: [PATCH v5 05/11] vsprintf: Consolidate handling of unknown pointer specifiers
Date: Wed, 25 Apr 2018 13:12:45 +0200
Message-Id: <20180425111251.13246-6-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425111251.13246-1-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few printk formats that make sense only with two or more
specifiers. Also some specifiers make sense only when a kernel feature
is enabled.

The handling of unknown specifiers is strange, inconsistent, and
even leaking the address. For example, netdev_bits() prints the
non-hashed pointer value or clock() prints "(null)".

Using WARN() looks like an overkill for this type of error. pr_warn()
is not good either. It would by handled via printk_sage buffer and
it might be hard to match it with the problematic string.

A reasonable compromise seems to be writing the unknown format specifier
into the original string with a question mark, for example (%pC?).
It should be self-explaining enough. Note that it is in brackets
to follow the (null) style.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 5c26a4e71cdf..587175a528b7 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1488,7 +1488,8 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 }
 
 static noinline_for_stack
-char *netdev_bits(char *buf, char *end, const void *addr, const char *fmt)
+char *netdev_bits(char *buf, char *end, const void *addr,
+		  struct printf_spec spec, const char *fmt)
 {
 	unsigned long long num;
 	int size;
@@ -1499,9 +1500,7 @@ char *netdev_bits(char *buf, char *end, const void *addr, const char *fmt)
 		size = sizeof(netdev_features_t);
 		break;
 	default:
-		num = (unsigned long)addr;
-		size = sizeof(unsigned long);
-		break;
+		return valid_string(buf, end, "(%pN?)", spec);
 	}
 
 	return special_hex_number(buf, end, num, size);
@@ -1532,7 +1531,10 @@ static noinline_for_stack
 char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	    const char *fmt)
 {
-	if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
+	if (!IS_ENABLED(CONFIG_HAVE_CLK))
+		return valid_string(buf, end, "(%pC?)", spec);
+
+	if (!clk)
 		return string(buf, end, NULL, spec);
 
 	switch (fmt[1]) {
@@ -1544,7 +1546,7 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 #ifdef CONFIG_COMMON_CLK
 		return string(buf, end, __clk_get_name(clk), spec);
 #else
-		return special_hex_number(buf, end, (unsigned long)clk, sizeof(unsigned long));
+		return valid_string(buf, end, "(%pC?)", spec);
 #endif
 	}
 }
@@ -1577,7 +1579,8 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 }
 
 static noinline_for_stack
-char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
+char *flags_string(char *buf, char *end, void *flags_ptr,
+		   struct printf_spec spec, const char *fmt)
 {
 	unsigned long flags;
 	const struct trace_print_flags *names;
@@ -1598,8 +1601,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
 		names = gfpflag_names;
 		break;
 	default:
-		WARN_ONCE(1, "Unsupported flags modifier: %c\n", fmt[1]);
-		return buf;
+		return valid_string(buf, end, "(%pG?)", spec);
 	}
 
 	return format_flags(buf, end, flags, names);
@@ -1655,7 +1657,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	str_spec.field_width = -1;
 
 	if (!IS_ENABLED(CONFIG_OF))
-		return valid_string(buf, end, "(!OF)", spec);
+		return valid_string(buf, end, "(%OF?)", spec);
 
 	if ((unsigned long)dn < PAGE_SIZE)
 		return valid_string(buf, end, "(null)", spec);
@@ -1926,7 +1928,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'K':
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':
-		return netdev_bits(buf, end, ptr, fmt);
+		return netdev_bits(buf, end, ptr, spec, fmt);
 	case 'a':
 		return address_val(buf, end, ptr, fmt);
 	case 'd':
@@ -1943,7 +1945,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 #endif
 
 	case 'G':
-		return flags_string(buf, end, ptr, fmt);
+		return flags_string(buf, end, ptr, spec, fmt);
 	case 'O':
 		switch (fmt[1]) {
 		case 'F':
-- 
2.13.6
