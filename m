Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBPT2Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:28:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:45195 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeBPT2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:28:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="204896812"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Tobin C. Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/7] lib/vsprintf: Remove useless NULL checks
Date: Fri, 16 Feb 2018 21:28:03 +0200
Message-Id: <20180216192806.68914-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
References: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer can't be NULL since it's first what has been done in the
pointer().

Remove useless checks.

Note we leave check for !CONFIG_HAVE_CLK to make compiler
to optimize code away when possible.

Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 360e751305bf..79f27ebdeb6e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -813,10 +813,6 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		/* nothing to print */
 		return buf;
 
-	if (ZERO_OR_NULL_PTR(addr))
-		/* NULL pointer */
-		return string(buf, end, NULL, spec);
-
 	switch (fmt[1]) {
 	case 'C':
 		separator = ':';
@@ -1255,10 +1251,6 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	if (spec.field_width == 0)
 		return buf;				/* nothing to print */
 
-	if (ZERO_OR_NULL_PTR(addr))
-		return string(buf, end, NULL, spec);	/* NULL pointer */
-
-
 	do {
 		switch (fmt[count++]) {
 		case 'a':
@@ -1442,7 +1434,7 @@ static noinline_for_stack
 char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	    const char *fmt)
 {
-	if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
+	if (!IS_ENABLED(CONFIG_HAVE_CLK))
 		return string(buf, end, NULL, spec);
 
 	switch (fmt[1]) {
@@ -1581,9 +1573,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	if (!IS_ENABLED(CONFIG_OF))
 		return string(buf, end, "(!OF)", spec);
 
-	if ((unsigned long)dn < PAGE_SIZE)
-		return string(buf, end, "(null)", spec);
-
 	/* simple case without anything any more format specifiers */
 	fmt++;
 	if (fmt[0] == '\0' || strcspn(fmt,"fnpPFcC") > 0)
-- 
2.15.1
