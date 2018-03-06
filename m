Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeCFSMD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:12:03 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:54354 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753042AbeCFSMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:12:02 -0500
From: Adam Borowski <kilobyte@angband.pl>
To: Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Cc: Adam Borowski <kilobyte@angband.pl>
Date: Tue,  6 Mar 2018 19:11:21 +0100
Message-Id: <20180306181122.11449-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
References: <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
X-SA-Exim-Connect-IP: 2a02:a312:c201:ce80::6
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 1/2] vsprintf: distinguish between (null), (err) and (invalid) pointer derefs
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to print an object pointed to by a bad (usually ERR_PTR) pointer
is a not so surprising error.  Our code handles them inconsistently:
 * two places print (null) if ptr<PAGE_SIZE
 * one place prints (null) if abs(ptr)<PAGE_SIZE
 * one place prints (null) only if !ptr

Obviously, saying (null) for a small but non-0 value is misleading.
Thus, let's print:
 * (null) for exactly 0
 * (err) if last page && abs(ptr)<=MAX_ERRNO
 * (invalid) otherwise

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 lib/vsprintf.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..1c2c3cc5a321 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -47,6 +47,8 @@
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
 
+#define BAD_PTR_STRING(x) (!(x) ? "(null)" : IS_ERR(x) ? "(err)" : "(invalid)")
+
 /**
  * simple_strtoull - convert a string to an unsigned long long
  * @cp: The start of the string
@@ -588,7 +590,7 @@ char *string(char *buf, char *end, const char *s, struct printf_spec spec)
 	size_t lim = spec.precision;
 
 	if ((unsigned long)s < PAGE_SIZE)
-		s = "(null)";
+		s = BAD_PTR_STRING(s);
 
 	while (lim--) {
 		char c = *s++;
@@ -1582,7 +1584,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 		return string(buf, end, "(!OF)", spec);
 
 	if ((unsigned long)dn < PAGE_SIZE)
-		return string(buf, end, "(null)", spec);
+		return string(buf, end, BAD_PTR_STRING(dn), spec);
 
 	/* simple case without anything any more format specifiers */
 	fmt++;
@@ -1851,12 +1853,12 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 
 	if (!ptr && *fmt != 'K' && *fmt != 'x') {
 		/*
-		 * Print (null) with the same width as a pointer so it makes
-		 * tabular output look nice.
+		 * Print (null)/etc with the same width as a pointer so it
+		 * makes tabular output look nice.
 		 */
 		if (spec.field_width == -1)
 			spec.field_width = default_width;
-		return string(buf, end, "(null)", spec);
+		return string(buf, end, BAD_PTR_STRING(ptr), spec);
 	}
 
 	switch (*fmt) {
@@ -2575,7 +2577,7 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 
 			if ((unsigned long)save_str > (unsigned long)-PAGE_SIZE
 					|| (unsigned long)save_str < PAGE_SIZE)
-				save_str = "(null)";
+				save_str = BAD_PTR_STRING(save_str);
 			len = strlen(save_str) + 1;
 			if (str + len < end)
 				memcpy(str, save_str, len);
-- 
2.16.2
