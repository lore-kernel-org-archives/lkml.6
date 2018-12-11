Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487B0C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1835920855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1835920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeLKPVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:21:33 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:57999 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeLKPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:21:31 -0500
Received: from office.codethink.co.uk ([148.252.241.226] helo=devhw0)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gWjqW-0002GC-0P; Tue, 11 Dec 2018 15:21:16 +0000
Received: from tpreston by devhw0 with local (Exim 4.89)
        (envelope-from <thomas.preston@codethink.co.uk>)
        id 1gWjqV-0002EF-Ki; Tue, 11 Dec 2018 15:21:15 +0000
From:   Thomas Preston <thomas.preston@codethink.co.uk>
To:     akpm@linux-foundation.org, pmladek@suse.com,
        andriy.shevchenko@linux.intel.com, rostedt@goodmis.org,
        geert+renesas@glider.be, corbet@lwn.net, me@tobin.cc,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Cc:     Thomas Preston <thomas.preston@codethink.co.uk>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/2] vsprintf: Stop using obsolete simple_strtoul()
Date:   Tue, 11 Dec 2018 15:21:13 +0000
Message-Id: <20181211152113.8523-3-thomas.preston@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181211152113.8523-1-thomas.preston@codethink.co.uk>
References: <20181211152113.8523-1-thomas.preston@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using the obsolete functions simple_strtoul() and
simple_strtoull(). Instead, we should use the improved kstrtol() and
kstrtoll() functions. To do this, we must copy the current field into a
null-terminated tmpstr and advance the variable `next` manually.

The width of tmpstr has been chosen because no integer field can be
larger than 22 characters (ULLONG_MAX in octal), plus sign, radix,
new-line, null-terminator and some extra for alignment.

This patch fixes a bug with vsscanf. If passing sscan a 16-digit
hex-string like so:

	sscanf("fafafafa0b0b0b0b", "%8x%8x", &hi, &lo)

then the result comes out with hi always being 0.

The issue is that the code calls simple_strtoul() which consumes up
to 16-digits but only returns an unsigned long (8 hex digits on ARM).
The vsscanf() code then checks and finds that the field_width of 8 was
greater than the 16 consumed characters and tries to fix this by:

while (next - str > field_width) {
    if (is_sign)
	    val.s = div_s64(val.s, base);
    else
	    val.u = div_u64(val.u, base);
    --next;
}

However val.{s,u} is already trunacted from the simple_strtoul call
and all that happens is the value gets divided down to zero.

Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 lib/vsprintf.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index bbf2ac734711..ec23e18e8cc6 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -47,6 +47,8 @@
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
 
+#define INT_BUF_LEN 28
+
 /**
  * simple_strtoull - convert a string to an unsigned long long
  * @cp: The start of the string
@@ -2914,7 +2916,9 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 	u8 qualifier;
 	unsigned int base;
 	union {
+		long sl;
 		long long sll;
+		unsigned long ul;
 		unsigned long long ull;
 	} val;
 	s16 field_width;
@@ -3119,14 +3123,30 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		    || (base == 0 && !isdigit(digit)))
 			break;
 
-		if (is_sign)
-			val.sll = qualifier != 'L' ?
-				simple_strtol(str, &next, base) :
-				simple_strtoll(str, &next, base);
-		else
-			val.ull = qualifier != 'L' ?
-				simple_strtoul(str, &next, base) :
-				simple_strtoull(str, &next, base);
+		if (unlikely((field_width+1) > INT_BUF_LEN))
+			return num;
+
+		if (field_width > 0) {
+			char tmpstr[INT_BUF_LEN];
+			int ret;
+
+			strscpy(tmpstr, str, field_width+1);
+
+			if (is_sign)
+				if (qualifier != 'L')
+					ret = kstrtol(tmpstr, base, &val.sl);
+				else
+					ret = kstrtoll(tmpstr, base, &val.sll);
+			else
+				if (qualifier != 'L')
+					ret = kstrtoul(tmpstr, base, &val.ul);
+				else
+					ret = kstrtoull(tmpstr, base, &val.ull);
+			if (ret < 0)
+				return num;
+
+		}
+		next = (char *)str + field_width;
 
 		if (field_width > 0 && next - str > field_width) {
 			if (base == 0)
-- 
2.11.0

