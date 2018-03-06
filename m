Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbeCFSME (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:12:04 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:54352 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeCFSMC (ORCPT
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
Date: Tue,  6 Mar 2018 19:11:22 +0100
Message-Id: <20180306181122.11449-2-kilobyte@angband.pl>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306181122.11449-1-kilobyte@angband.pl>
References: <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
 <20180306181122.11449-1-kilobyte@angband.pl>
X-SA-Exim-Connect-IP: 2a02:a312:c201:ce80::6
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 2/2] vsprintf: don't dereference pointers to the first or last page
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As old code to avoid so is inconsistent, let's unify it within a single
macro.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 lib/vsprintf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 1c2c3cc5a321..4914dac03f0a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -47,6 +47,8 @@
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
 
+#define IS_BAD_PTR(x) ((unsigned long)(x) >= (unsigned long)-PAGE_SIZE \
+				|| (unsigned long)(x) < PAGE_SIZE)
 #define BAD_PTR_STRING(x) (!(x) ? "(null)" : IS_ERR(x) ? "(err)" : "(invalid)")
 
 /**
@@ -589,7 +591,7 @@ char *string(char *buf, char *end, const char *s, struct printf_spec spec)
 	int len = 0;
 	size_t lim = spec.precision;
 
-	if ((unsigned long)s < PAGE_SIZE)
+	if (IS_BAD_PTR(s))
 		s = BAD_PTR_STRING(s);
 
 	while (lim--) {
@@ -1583,7 +1585,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	if (!IS_ENABLED(CONFIG_OF))
 		return string(buf, end, "(!OF)", spec);
 
-	if ((unsigned long)dn < PAGE_SIZE)
+	if (IS_BAD_PTR(dn))
 		return string(buf, end, BAD_PTR_STRING(dn), spec);
 
 	/* simple case without anything any more format specifiers */
@@ -1851,7 +1853,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 {
 	const int default_width = 2 * sizeof(void *);
 
-	if (!ptr && *fmt != 'K' && *fmt != 'x') {
+	if (IS_BAD_PTR(ptr) && *fmt != 'K' && *fmt != 'x') {
 		/*
 		 * Print (null)/etc with the same width as a pointer so it
 		 * makes tabular output look nice.
@@ -2575,8 +2577,7 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 			const char *save_str = va_arg(args, char *);
 			size_t len;
 
-			if ((unsigned long)save_str > (unsigned long)-PAGE_SIZE
-					|| (unsigned long)save_str < PAGE_SIZE)
+			if (IS_BAD_PTR(save_ptr))
 				save_str = BAD_PTR_STRING(save_str);
 			len = strlen(save_str) + 1;
 			if (str + len < end)
-- 
2.16.2
