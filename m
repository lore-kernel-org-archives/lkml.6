Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeDYLN4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:13:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:56918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754040AbeDYLNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:13:42 -0400
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
Subject: [PATCH v5 04/11] vsprintf: Do not check address of well-known strings
Date: Wed, 25 Apr 2018 13:12:44 +0200
Message-Id: <20180425111251.13246-5-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425111251.13246-1-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
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
 lib/vsprintf.c | 83 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2678dfe61d73..5c26a4e71cdf 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -591,15 +591,13 @@ char *widen_string(char *buf, int n, char *end, struct printf_spec spec)
 	return buf;
 }
 
-static noinline_for_stack
-char *string(char *buf, char *end, const char *s, struct printf_spec spec)
+/* Handle string from a well known address. */
+static char *valid_string(char *buf, char *end, const char *s,
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
@@ -613,6 +611,15 @@ char *string(char *buf, char *end, const char *s, struct printf_spec spec)
 }
 
 static noinline_for_stack
+char *string(char *buf, char *end, const char *s,
+		   struct printf_spec spec)
+{
+	if ((unsigned long)s < PAGE_SIZE)
+		s = "(null)";
+
+	return valid_string(buf, end, s, spec);
+}
+
 char *pointer_string(char *buf, char *end, const void *ptr,
 		     struct printf_spec spec)
 {
@@ -670,7 +677,7 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 	if (unlikely(!have_filled_random_ptr_key)) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
-		return string(buf, end, str, spec);
+		return valid_string(buf, end, str, spec);
 	}
 
 #ifdef CONFIG_64BIT
@@ -706,7 +713,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 		if (in_irq() || in_serving_softirq() || in_nmi()) {
 			if (spec.field_width == -1)
 				spec.field_width = 2 * sizeof(ptr);
-			return string(buf, end, "pK-error", spec);
+			return valid_string(buf, end, "pK-error", spec);
 		}
 
 		/*
@@ -820,7 +827,7 @@ char *symbol_string(char *buf, char *end, void *ptr,
 	else
 		sprint_symbol_no_offset(sym, value);
 
-	return string(buf, end, sym, spec);
+	return valid_string(buf, end, sym, spec);
 #else
 	return special_hex_number(buf, end, value, sizeof(void *));
 #endif
@@ -892,27 +899,27 @@ char *resource_string(char *buf, char *end, struct resource *res,
 
 	*p++ = '[';
 	if (res->flags & IORESOURCE_IO) {
-		p = string(p, pend, "io  ", str_spec);
+		p = valid_string(p, pend, "io  ", str_spec);
 		specp = &io_spec;
 	} else if (res->flags & IORESOURCE_MEM) {
-		p = string(p, pend, "mem ", str_spec);
+		p = valid_string(p, pend, "mem ", str_spec);
 		specp = &mem_spec;
 	} else if (res->flags & IORESOURCE_IRQ) {
-		p = string(p, pend, "irq ", str_spec);
+		p = valid_string(p, pend, "irq ", str_spec);
 		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_DMA) {
-		p = string(p, pend, "dma ", str_spec);
+		p = valid_string(p, pend, "dma ", str_spec);
 		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_BUS) {
-		p = string(p, pend, "bus ", str_spec);
+		p = valid_string(p, pend, "bus ", str_spec);
 		specp = &bus_spec;
 	} else {
-		p = string(p, pend, "??? ", str_spec);
+		p = valid_string(p, pend, "??? ", str_spec);
 		specp = &mem_spec;
 		decode = 0;
 	}
 	if (decode && res->flags & IORESOURCE_UNSET) {
-		p = string(p, pend, "size ", str_spec);
+		p = valid_string(p, pend, "size ", str_spec);
 		p = number(p, pend, resource_size(res), *specp);
 	} else {
 		p = number(p, pend, res->start, *specp);
@@ -923,21 +930,21 @@ char *resource_string(char *buf, char *end, struct resource *res,
 	}
 	if (decode) {
 		if (res->flags & IORESOURCE_MEM_64)
-			p = string(p, pend, " 64bit", str_spec);
+			p = valid_string(p, pend, " 64bit", str_spec);
 		if (res->flags & IORESOURCE_PREFETCH)
-			p = string(p, pend, " pref", str_spec);
+			p = valid_string(p, pend, " pref", str_spec);
 		if (res->flags & IORESOURCE_WINDOW)
-			p = string(p, pend, " window", str_spec);
+			p = valid_string(p, pend, " window", str_spec);
 		if (res->flags & IORESOURCE_DISABLED)
-			p = string(p, pend, " disabled", str_spec);
+			p = valid_string(p, pend, " disabled", str_spec);
 	} else {
-		p = string(p, pend, " flags ", str_spec);
+		p = valid_string(p, pend, " flags ", str_spec);
 		p = number(p, pend, res->flags, default_flag_spec);
 	}
 	*p++ = ']';
 	*p = '\0';
 
-	return string(buf, end, sym, spec);
+	return valid_string(buf, end, sym, spec);
 }
 
 static noinline_for_stack
@@ -1105,7 +1112,7 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 	}
 	*p = '\0';
 
-	return string(buf, end, mac_addr, spec);
+	return valid_string(buf, end, mac_addr, spec);
 }
 
 static noinline_for_stack
@@ -1268,7 +1275,7 @@ char *ip6_addr_string(char *buf, char *end, const u8 *addr,
 	else
 		ip6_string(ip6_addr, addr, fmt);
 
-	return string(buf, end, ip6_addr, spec);
+	return valid_string(buf, end, ip6_addr, spec);
 }
 
 static noinline_for_stack
@@ -1279,7 +1286,7 @@ char *ip4_addr_string(char *buf, char *end, const u8 *addr,
 
 	ip4_string(ip4_addr, addr, fmt);
 
-	return string(buf, end, ip4_addr, spec);
+	return valid_string(buf, end, ip4_addr, spec);
 }
 
 static noinline_for_stack
@@ -1341,7 +1348,7 @@ char *ip6_addr_string_sa(char *buf, char *end, const struct sockaddr_in6 *sa,
 	}
 	*p = '\0';
 
-	return string(buf, end, ip6_addr, spec);
+	return valid_string(buf, end, ip6_addr, spec);
 }
 
 static noinline_for_stack
@@ -1376,7 +1383,7 @@ char *ip4_addr_string_sa(char *buf, char *end, const struct sockaddr_in *sa,
 	}
 	*p = '\0';
 
-	return string(buf, end, ip4_addr, spec);
+	return valid_string(buf, end, ip4_addr, spec);
 }
 
 static noinline_for_stack
@@ -1477,7 +1484,7 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 
 	*p = 0;
 
-	return string(buf, end, uuid, spec);
+	return valid_string(buf, end, uuid, spec);
 }
 
 static noinline_for_stack
@@ -1614,13 +1621,13 @@ char *device_node_gen_full_name(const struct device_node *np, char *buf, char *e
 
 	/* special case for root node */
 	if (!parent)
-		return string(buf, end, "/", default_str_spec);
+		return valid_string(buf, end, "/", default_str_spec);
 
 	for (depth = 0; parent->parent; depth++)
 		parent = parent->parent;
 
 	for ( ; depth >= 0; depth--) {
-		buf = string(buf, end, "/", default_str_spec);
+		buf = valid_string(buf, end, "/", default_str_spec);
 		buf = string(buf, end, device_node_name_for_depth(np, depth),
 			     default_str_spec);
 	}
@@ -1648,10 +1655,10 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	str_spec.field_width = -1;
 
 	if (!IS_ENABLED(CONFIG_OF))
-		return string(buf, end, "(!OF)", spec);
+		return valid_string(buf, end, "(!OF)", spec);
 
 	if ((unsigned long)dn < PAGE_SIZE)
-		return string(buf, end, "(null)", spec);
+		return valid_string(buf, end, "(null)", spec);
 
 	/* simple case without anything any more format specifiers */
 	fmt++;
@@ -1687,7 +1694,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 			tbuf[2] = of_node_check_flag(dn, OF_POPULATED) ? 'P' : '-';
 			tbuf[3] = of_node_check_flag(dn, OF_POPULATED_BUS) ? 'B' : '-';
 			tbuf[4] = 0;
-			buf = string(buf, end, tbuf, str_spec);
+			buf = valid_string(buf, end, tbuf, str_spec);
 			break;
 		case 'c':	/* major compatible string */
 			ret = of_property_read_string(dn, "compatible", &p);
@@ -1698,10 +1705,11 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 			has_mult = false;
 			of_property_for_each_string(dn, "compatible", prop, p) {
 				if (has_mult)
-					buf = string(buf, end, ",", str_spec);
-				buf = string(buf, end, "\"", str_spec);
+					buf = valid_string(buf, end, ",",
+							   str_spec);
+				buf = valid_string(buf, end, "\"", str_spec);
 				buf = string(buf, end, p, str_spec);
-				buf = string(buf, end, "\"", str_spec);
+				buf = valid_string(buf, end, "\"", str_spec);
 
 				has_mult = true;
 			}
@@ -1840,7 +1848,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		 */
 		if (spec.field_width == -1)
 			spec.field_width = default_width;
-		return string(buf, end, "(null)", spec);
+		return valid_string(buf, end, "(null)", spec);
 	}
 
 	switch (*fmt) {
@@ -1896,7 +1904,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 			case AF_INET6:
 				return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
 			default:
-				return string(buf, end, "(invalid address)", spec);
+				return valid_string(buf, end,
+						    "(invalid address)", spec);
 			}}
 		}
 		break;
-- 
2.13.6
