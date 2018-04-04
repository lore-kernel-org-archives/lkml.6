Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeDDI7h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:59:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:34566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeDDI7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:59:32 -0400
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
Subject: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown pointer specifiers
Date: Wed,  4 Apr 2018 10:58:38 +0200
Message-Id: <20180404085843.16050-5-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180404085843.16050-1-pmladek@suse.com>
References: <20180404085843.16050-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few printk formats that make sense only with two or more
specifiers. Also some specifiers make sense only when a kernel feature
is enabled.

The handling of unknown specifiers is strange, inconsistent, and
even leaking the address. For example, netdev_bits() prints the
non-hashed pointer value or clock() prints "(null)".

The best solution seems to be in flags_string(). It does not print any
misleading value. Instead it calls WARN_ONCE() describing the unknown
specifier. Therefore it clearly shows the problem and helps to find it.

Note that WARN_ONCE() used to cause recursive printk(). But it is safe
now because vscnprintf() is called in printk_safe context from
vprintk_emit().

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index dd71738d7a09..5a0d01846a11 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1484,9 +1484,9 @@ char *netdev_bits(char *buf, char *end, const void *addr, const char *fmt)
 		size = sizeof(netdev_features_t);
 		break;
 	default:
-		num = (unsigned long)addr;
-		size = sizeof(unsigned long);
-		break;
+		WARN_ONCE(1, "Unsupported pointer format specifier: %%pN%c\n",
+			  fmt[1]);
+		return buf;
 	}
 
 	return special_hex_number(buf, end, num, size);
@@ -1517,7 +1517,12 @@ static noinline_for_stack
 char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	    const char *fmt)
 {
-	if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
+	if (!IS_ENABLED(CONFIG_HAVE_CLK)) {
+		WARN_ONCE(1, "Unsupported pointer format specifier: %%pC\n");
+		return buf;
+	}
+
+	if (!clk)
 		return string(buf, end, NULL, spec);
 
 	switch (fmt[1]) {
@@ -1529,7 +1534,8 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 #ifdef CONFIG_COMMON_CLK
 		return string(buf, end, __clk_get_name(clk), spec);
 #else
-		return special_hex_number(buf, end, (unsigned long)clk, sizeof(unsigned long));
+		WARN_ONCE(1, "Unsupported pointer format specifier: %%pC\n");
+		return buf;
 #endif
 	}
 }
@@ -1593,7 +1599,8 @@ char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
 		names = gfpflag_names;
 		break;
 	default:
-		WARN_ONCE(1, "Unsupported flags modifier: %c\n", fmt[1]);
+		WARN_ONCE(1, "Unsupported pointer format specifier: %%pG%c\n",
+			  fmt[1]);
 		return buf;
 	}
 
-- 
2.13.6
