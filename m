Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53282C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A222146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfBHPYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:24:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:60044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728097AbfBHPY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:24:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2ACAB145;
        Fri,  8 Feb 2019 15:24:27 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v6 7/9] vsprintf: Consolidate handling of unknown pointer specifiers
Date:   Fri,  8 Feb 2019 16:23:08 +0100
Message-Id: <20190208152310.29531-8-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190208152310.29531-1-pmladek@suse.com>
References: <20190208152310.29531-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few printk formats that make sense only with two or more
specifiers. Also some specifiers make sense only when a kernel feature
is enabled.

The handling of unknown specifiers is inconsistent and not helpful.
Using WARN() looks like an overkill for this type of error. pr_warn()
is not good either. It would by handled via printk_safe buffer and
it might be hard to match it with the problematic string.

A reasonable compromise seems to be writing the unknown format specifier
into the original string with a question mark, for example (%pC?).
It should be self-explaining enough. Note that it is in brackets
to follow the (null) style.

Note that the changes in test_printf.c revert many changes made
by the commit 4d42c44727a062e233 ("lib/vsprintf: Print time and
date in human readable format via %pt\n"). The format %pt does
not longer produce a hashed pointer.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/test_printf.c | 39 ++++-----------------------------------
 lib/vsprintf.c    | 28 +++++++++++++++++-----------
 2 files changed, 21 insertions(+), 46 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 659b6cc0d483..159bb78b3992 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -250,11 +250,12 @@ plain_format(void)
 #endif	/* BITS_PER_LONG == 64 */
 
 static int __init
-plain_hash_to_buffer(const void *p, char *buf, size_t len)
+plain_hash(void)
 {
+	char buf[PLAIN_BUF_SIZE];
 	int nchars;
 
-	nchars = snprintf(buf, len, "%p", p);
+	nchars = snprintf(buf, sizeof(buf), "%p", PTR);
 
 	if (nchars != PTR_WIDTH)
 		return -1;
@@ -265,20 +266,6 @@ plain_hash_to_buffer(const void *p, char *buf, size_t len)
 		return 0;
 	}
 
-	return 0;
-}
-
-
-static int __init
-plain_hash(void)
-{
-	char buf[PLAIN_BUF_SIZE];
-	int ret;
-
-	ret = plain_hash_to_buffer(PTR, buf, PLAIN_BUF_SIZE);
-	if (ret)
-		return ret;
-
 	if (strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
 		return -1;
 
@@ -309,23 +296,6 @@ plain(void)
 }
 
 static void __init
-test_hashed(const char *fmt, const void *p)
-{
-	char buf[PLAIN_BUF_SIZE];
-	int ret;
-
-	/*
-	 * No need to increase failed test counter since this is assumed
-	 * to be called after plain().
-	 */
-	ret = plain_hash_to_buffer(p, buf, PLAIN_BUF_SIZE);
-	if (ret)
-		return;
-
-	test(buf, fmt, p);
-}
-
-static void __init
 symbol_ptr(void)
 {
 }
@@ -462,8 +432,7 @@ struct_rtc_time(void)
 		.tm_year = 118,
 	};
 
-	test_hashed("%pt", &tm);
-
+	test("(%ptR?)", "%pt", &tm);
 	test("2018-11-26T05:35:43", "%ptR", &tm);
 	test("0118-10-26T05:35:43", "%ptRr", &tm);
 	test("05:35:43|2018-11-26", "%ptRt|%ptRd", &tm, &tm);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index ab59db1c1146..d8509f6adda6 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1434,6 +1434,8 @@ static noinline_for_stack
 char *ip_addr_string(char *buf, char *end, const void *ptr,
 		     struct printf_spec spec, const char *fmt)
 {
+	char *err_fmt_msg;
+
 	switch (fmt[1]) {
 	case '6':
 		return ip6_addr_string(buf, end, ptr, spec, fmt);
@@ -1456,7 +1458,8 @@ char *ip_addr_string(char *buf, char *end, const void *ptr,
 		}}
 	}
 
-	return ptr_to_id(buf, end, ptr, spec);
+	err_fmt_msg = fmt[0] == 'i' ? "(%pi?)" : "(%pI?)";
+	return string_nocheck(buf, end, err_fmt_msg, spec);
 }
 
 static noinline_for_stack
@@ -1584,7 +1587,7 @@ char *netdev_bits(char *buf, char *end, const void *addr,
 		size = sizeof(netdev_features_t);
 		break;
 	default:
-		return ptr_to_id(buf, end, addr, spec);
+		return string_nocheck(buf, end, "(%pN?)", spec);
 	}
 
 	return special_hex_number(buf, end, num, size);
@@ -1688,7 +1691,7 @@ char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
 	case 'R':
 		return rtc_str(buf, end, (const struct rtc_time *)ptr, fmt);
 	default:
-		return ptr_to_id(buf, end, ptr, spec);
+		return string_nocheck(buf, end, "(%ptR?)", spec);
 	}
 }
 
@@ -1696,7 +1699,10 @@ static noinline_for_stack
 char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	    const char *fmt)
 {
-	if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
+	if (!IS_ENABLED(CONFIG_HAVE_CLK))
+		return string_nocheck(buf, end, "(%pC?)", spec);
+
+	if (!clk)
 		return string(buf, end, NULL, spec);
 
 	switch (fmt[1]) {
@@ -1705,7 +1711,7 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 #ifdef CONFIG_COMMON_CLK
 		return string(buf, end, __clk_get_name(clk), spec);
 #else
-		return ptr_to_id(buf, end, clk, spec);
+		return string_nocheck(buf, end, "(%pC?)", spec);
 #endif
 	}
 }
@@ -1738,7 +1744,8 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 }
 
 static noinline_for_stack
-char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
+char *flags_string(char *buf, char *end, void *flags_ptr,
+		   struct printf_spec spec, const char *fmt)
 {
 	unsigned long flags;
 	const struct trace_print_flags *names;
@@ -1759,8 +1766,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
 		names = gfpflag_names;
 		break;
 	default:
-		WARN_ONCE(1, "Unsupported flags modifier: %c\n", fmt[1]);
-		return buf;
+		return string_nocheck(buf, end, "(%pG?)", spec);
 	}
 
 	return format_flags(buf, end, flags, names);
@@ -1816,7 +1822,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	str_spec.field_width = -1;
 
 	if (!IS_ENABLED(CONFIG_OF))
-		return string_nocheck(buf, end, "(!OF)", spec);
+		return string_nocheck(buf, end, "(%pOF?)", spec);
 
 	if ((unsigned long)dn < PAGE_SIZE)
 		return string_nocheck(buf, end, "(null)", spec);
@@ -1895,7 +1901,7 @@ static char *kobject_string(char *buf, char *end, void *ptr,
 		return device_node_string(buf, end, ptr, spec, fmt + 1);
 	}
 
-	return ptr_to_id(buf, end, ptr, spec);
+	return string_nocheck(buf, end, "(%pO?)", spec);
 }
 
 /*
@@ -2091,7 +2097,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 #endif
 
 	case 'G':
-		return flags_string(buf, end, ptr, fmt);
+		return flags_string(buf, end, ptr, spec, fmt);
 	case 'O':
 		return kobject_string(buf, end, ptr, spec, fmt);
 	case 'x':
-- 
2.13.7

