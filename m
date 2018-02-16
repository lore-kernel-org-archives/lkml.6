Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeBPT2S (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:28:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:50718 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbeBPT2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:28:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="32066659"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Tobin C. Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/7] lib/vsprintf: Make decspec global
Date: Fri, 16 Feb 2018 21:28:04 +0200
Message-Id: <20180216192806.68914-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
References: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are places where default specification to print decimal numbers
is in use.

Make it global and convert existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 79f27ebdeb6e..3a02fcaf8ac8 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -693,6 +693,11 @@ char *symbol_string(char *buf, char *end, void *ptr,
 #endif
 }
 
+static const struct printf_spec default_dec_spec = {
+	.base = 10,
+	.precision = -1,
+};
+
 static noinline_for_stack
 char *resource_string(char *buf, char *end, struct resource *res,
 		      struct printf_spec spec, const char *fmt)
@@ -722,11 +727,6 @@ char *resource_string(char *buf, char *end, struct resource *res,
 		.precision = -1,
 		.flags = SMALL | ZEROPAD,
 	};
-	static const struct printf_spec dec_spec = {
-		.base = 10,
-		.precision = -1,
-		.flags = 0,
-	};
 	static const struct printf_spec str_spec = {
 		.field_width = -1,
 		.precision = 10,
@@ -760,10 +760,10 @@ char *resource_string(char *buf, char *end, struct resource *res,
 		specp = &mem_spec;
 	} else if (res->flags & IORESOURCE_IRQ) {
 		p = string(p, pend, "irq ", str_spec);
-		specp = &dec_spec;
+		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_DMA) {
 		p = string(p, pend, "dma ", str_spec);
-		specp = &dec_spec;
+		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_BUS) {
 		p = string(p, pend, "bus ", str_spec);
 		specp = &bus_spec;
@@ -899,9 +899,6 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 	int cur, rbot, rtop;
 	bool first = true;
 
-	/* reused to print numbers */
-	spec = (struct printf_spec){ .base = 10 };
-
 	rbot = cur = find_first_bit(bitmap, nr_bits);
 	while (cur < nr_bits) {
 		rtop = cur;
@@ -916,13 +913,13 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 		}
 		first = false;
 
-		buf = number(buf, end, rbot, spec);
+		buf = number(buf, end, rbot, default_dec_spec);
 		if (rbot < rtop) {
 			if (buf < end)
 				*buf = '-';
 			buf++;
 
-			buf = number(buf, end, rtop, spec);
+			buf = number(buf, end, rtop, default_dec_spec);
 		}
 
 		rbot = cur;
-- 
2.15.1
