Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F73C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E592146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfBHPYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:24:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:59930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728053AbfBHPYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:24:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09862B142;
        Fri,  8 Feb 2019 15:24:21 +0000 (UTC)
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
Subject: [PATCH v6 3/9] vsprintf: Do not check address of well-known strings
Date:   Fri,  8 Feb 2019 16:23:04 +0100
Message-Id: <20190208152310.29531-4-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190208152310.29531-1-pmladek@suse.com>
References: <20190208152310.29531-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to check the address using probe_kernel_address(). It will
be more expensive and it does not make sense for well known address.

This patch splits the string() function. The variant without the check
is then used on locations that handle string constants or strings defined
as local variables.

This patch does not change the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 81 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 76ce12b278c3..0b6209854f5c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -592,15 +592,13 @@ char *widen_string(char *buf, int n, char *end, struct printf_spec spec)
 	return buf;
 }
 
-static noinline_for_stack
-char *string(char *buf, char *end, const char *s, struct printf_spec spec)
+/* Handle string from a well known address. */
+static char *string_nocheck(char *buf, char *end, const char *s,
+			  struct printf_spec spec)
 {
 	int len = 0;
 	size_t lim = spec.precision;
 
-	if ((unsigned long)s < PAGE_SIZE)
-		s = "(null)";
-
 	while (lim--) {
 		char c = *s++;
 		if (!c)
@@ -614,6 +612,15 @@ char *string(char *buf, char *end, const char *s, struct printf_spec spec)
 }
 
 static noinline_for_stack
+char *string(char *buf, char *end, const char *s,
+		   struct printf_spec spec)
+{
+	if ((unsigned long)s < PAGE_SIZE)
+		s = "(null)";
+
+	return string_nocheck(buf, end, s, spec);
+}
+
 char *pointer_string(char *buf, char *end, const void *ptr,
 		     struct printf_spec spec)
 {
@@ -700,7 +707,7 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
-		return string(buf, end, str, spec);
+		return string_nocheck(buf, end, str, spec);
 	}
 
 #ifdef CONFIG_64BIT
@@ -736,7 +743,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 		if (in_irq() || in_serving_softirq() || in_nmi()) {
 			if (spec.field_width == -1)
 				spec.field_width = 2 * sizeof(ptr);
-			return string(buf, end, "pK-error", spec);
+			return string_nocheck(buf, end, "pK-error", spec);
 		}
 
 		/*
@@ -850,7 +857,7 @@ char *symbol_string(char *buf, char *end, void *ptr,
 	else
 		sprint_symbol_no_offset(sym, value);
 
-	return string(buf, end, sym, spec);
+	return string_nocheck(buf, end, sym, spec);
 #else
 	return special_hex_number(buf, end, value, sizeof(void *));
 #endif
@@ -936,27 +943,27 @@ char *resource_string(char *buf, char *end, struct resource *res,
 
 	*p++ = '[';
 	if (res->flags & IORESOURCE_IO) {
-		p = string(p, pend, "io  ", str_spec);
+		p = string_nocheck(p, pend, "io  ", str_spec);
 		specp = &io_spec;
 	} else if (res->flags & IORESOURCE_MEM) {
-		p = string(p, pend, "mem ", str_spec);
+		p = string_nocheck(p, pend, "mem ", str_spec);
 		specp = &mem_spec;
 	} else if (res->flags & IORESOURCE_IRQ) {
-		p = string(p, pend, "irq ", str_spec);
+		p = string_nocheck(p, pend, "irq ", str_spec);
 		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_DMA) {
-		p = string(p, pend, "dma ", str_spec);
+		p = string_nocheck(p, pend, "dma ", str_spec);
 		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_BUS) {
-		p = string(p, pend, "bus ", str_spec);
+		p = string_nocheck(p, pend, "bus ", str_spec);
 		specp = &bus_spec;
 	} else {
-		p = string(p, pend, "??? ", str_spec);
+		p = string_nocheck(p, pend, "??? ", str_spec);
 		specp = &mem_spec;
 		decode = 0;
 	}
 	if (decode && res->flags & IORESOURCE_UNSET) {
-		p = string(p, pend, "size ", str_spec);
+		p = string_nocheck(p, pend, "size ", str_spec);
 		p = number(p, pend, resource_size(res), *specp);
 	} else {
 		p = number(p, pend, res->start, *specp);
@@ -967,21 +974,21 @@ char *resource_string(char *buf, char *end, struct resource *res,
 	}
 	if (decode) {
 		if (res->flags & IORESOURCE_MEM_64)
-			p = string(p, pend, " 64bit", str_spec);
+			p = string_nocheck(p, pend, " 64bit", str_spec);
 		if (res->flags & IORESOURCE_PREFETCH)
-			p = string(p, pend, " pref", str_spec);
+			p = string_nocheck(p, pend, " pref", str_spec);
 		if (res->flags & IORESOURCE_WINDOW)
-			p = string(p, pend, " window", str_spec);
+			p = string_nocheck(p, pend, " window", str_spec);
 		if (res->flags & IORESOURCE_DISABLED)
-			p = string(p, pend, " disabled", str_spec);
+			p = string_nocheck(p, pend, " disabled", str_spec);
 	} else {
-		p = string(p, pend, " flags ", str_spec);
+		p = string_nocheck(p, pend, " flags ", str_spec);
 		p = number(p, pend, res->flags, default_flag_spec);
 	}
 	*p++ = ']';
 	*p = '\0';
 
-	return string(buf, end, sym, spec);
+	return string_nocheck(buf, end, sym, spec);
 }
 
 static noinline_for_stack
@@ -1149,7 +1156,7 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 	}
 	*p = '\0';
 
-	return string(buf, end, mac_addr, spec);
+	return string_nocheck(buf, end, mac_addr, spec);
 }
 
 static noinline_for_stack
@@ -1312,7 +1319,7 @@ char *ip6_addr_string(char *buf, char *end, const u8 *addr,
 	else
 		ip6_string(ip6_addr, addr, fmt);
 
-	return string(buf, end, ip6_addr, spec);
+	return string_nocheck(buf, end, ip6_addr, spec);
 }
 
 static noinline_for_stack
@@ -1323,7 +1330,7 @@ char *ip4_addr_string(char *buf, char *end, const u8 *addr,
 
 	ip4_string(ip4_addr, addr, fmt);
 
-	return string(buf, end, ip4_addr, spec);
+	return string_nocheck(buf, end, ip4_addr, spec);
 }
 
 static noinline_for_stack
@@ -1385,7 +1392,7 @@ char *ip6_addr_string_sa(char *buf, char *end, const struct sockaddr_in6 *sa,
 	}
 	*p = '\0';
 
-	return string(buf, end, ip6_addr, spec);
+	return string_nocheck(buf, end, ip6_addr, spec);
 }
 
 static noinline_for_stack
@@ -1420,7 +1427,7 @@ char *ip4_addr_string_sa(char *buf, char *end, const struct sockaddr_in *sa,
 	}
 	*p = '\0';
 
-	return string(buf, end, ip4_addr, spec);
+	return string_nocheck(buf, end, ip4_addr, spec);
 }
 
 static noinline_for_stack
@@ -1521,7 +1528,7 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 
 	*p = 0;
 
-	return string(buf, end, uuid, spec);
+	return string_nocheck(buf, end, uuid, spec);
 }
 
 static noinline_for_stack
@@ -1735,13 +1742,13 @@ char *device_node_gen_full_name(const struct device_node *np, char *buf, char *e
 
 	/* special case for root node */
 	if (!parent)
-		return string(buf, end, "/", default_str_spec);
+		return string_nocheck(buf, end, "/", default_str_spec);
 
 	for (depth = 0; parent->parent; depth++)
 		parent = parent->parent;
 
 	for ( ; depth >= 0; depth--) {
-		buf = string(buf, end, "/", default_str_spec);
+		buf = string_nocheck(buf, end, "/", default_str_spec);
 		buf = string(buf, end, device_node_name_for_depth(np, depth),
 			     default_str_spec);
 	}
@@ -1769,10 +1776,10 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	str_spec.field_width = -1;
 
 	if (!IS_ENABLED(CONFIG_OF))
-		return string(buf, end, "(!OF)", spec);
+		return string_nocheck(buf, end, "(!OF)", spec);
 
 	if ((unsigned long)dn < PAGE_SIZE)
-		return string(buf, end, "(null)", spec);
+		return string_nocheck(buf, end, "(null)", spec);
 
 	/* simple case without anything any more format specifiers */
 	fmt++;
@@ -1813,7 +1820,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 			tbuf[2] = of_node_check_flag(dn, OF_POPULATED) ? 'P' : '-';
 			tbuf[3] = of_node_check_flag(dn, OF_POPULATED_BUS) ? 'B' : '-';
 			tbuf[4] = 0;
-			buf = string(buf, end, tbuf, str_spec);
+			buf = string_nocheck(buf, end, tbuf, str_spec);
 			break;
 		case 'c':	/* major compatible string */
 			ret = of_property_read_string(dn, "compatible", &p);
@@ -1824,10 +1831,10 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 			has_mult = false;
 			of_property_for_each_string(dn, "compatible", prop, p) {
 				if (has_mult)
-					buf = string(buf, end, ",", str_spec);
-				buf = string(buf, end, "\"", str_spec);
+					buf = string_nocheck(buf, end, ",", str_spec);
+				buf = string_nocheck(buf, end, "\"", str_spec);
 				buf = string(buf, end, p, str_spec);
-				buf = string(buf, end, "\"", str_spec);
+				buf = string_nocheck(buf, end, "\"", str_spec);
 
 				has_mult = true;
 			}
@@ -1966,7 +1973,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		 */
 		if (spec.field_width == -1)
 			spec.field_width = default_width;
-		return string(buf, end, "(null)", spec);
+		return string_nocheck(buf, end, "(null)", spec);
 	}
 
 	switch (*fmt) {
@@ -2022,7 +2029,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 			case AF_INET6:
 				return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
 			default:
-				return string(buf, end, "(invalid address)", spec);
+				return string_nocheck(buf, end, "(invalid address)", spec);
 			}}
 		}
 		break;
-- 
2.13.7

