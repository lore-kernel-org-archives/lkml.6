Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63906C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8F4208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8F4208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeLKPVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:21:30 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:57997 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeLKPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:21:29 -0500
Received: from office.codethink.co.uk ([148.252.241.226] helo=devhw0)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gWjqV-0002GB-U2; Tue, 11 Dec 2018 15:21:16 +0000
Received: from tpreston by devhw0 with local (Exim 4.89)
        (envelope-from <thomas.preston@codethink.co.uk>)
        id 1gWjqV-0002EC-Go; Tue, 11 Dec 2018 15:21:15 +0000
From:   Thomas Preston <thomas.preston@codethink.co.uk>
To:     akpm@linux-foundation.org, pmladek@suse.com,
        andriy.shevchenko@linux.intel.com, rostedt@goodmis.org,
        geert+renesas@glider.be, corbet@lwn.net, me@tobin.cc,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Cc:     Thomas Preston <thomas.preston@codethink.co.uk>
Subject: [PATCH 1/2] vsprintf: Specify type for union val members
Date:   Tue, 11 Dec 2018 15:21:12 +0000
Message-Id: <20181211152113.8523-2-thomas.preston@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181211152113.8523-1-thomas.preston@codethink.co.uk>
References: <20181211152113.8523-1-thomas.preston@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vsscanf function uses implicit type casting to populate the long
long integers in union val from the obsolete functions simple_strtol()
and simple_strtoll(). However the new functions kstrtol() and kstrtoll()
expect a pointer to the correct type, so we must be explicit about which
type we are using.

Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
---
 lib/vsprintf.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 37a54a6dd594..bbf2ac734711 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2914,8 +2914,8 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 	u8 qualifier;
 	unsigned int base;
 	union {
-		long long s;
-		unsigned long long u;
+		long long sll;
+		unsigned long long ull;
 	} val;
 	s16 field_width;
 	bool is_sign;
@@ -3120,11 +3120,11 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			break;
 
 		if (is_sign)
-			val.s = qualifier != 'L' ?
+			val.sll = qualifier != 'L' ?
 				simple_strtol(str, &next, base) :
 				simple_strtoll(str, &next, base);
 		else
-			val.u = qualifier != 'L' ?
+			val.ull = qualifier != 'L' ?
 				simple_strtoul(str, &next, base) :
 				simple_strtoull(str, &next, base);
 
@@ -3133,9 +3133,9 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 				_parse_integer_fixup_radix(str, &base);
 			while (next - str > field_width) {
 				if (is_sign)
-					val.s = div_s64(val.s, base);
+					val.sll = div_s64(val.sll, base);
 				else
-					val.u = div_u64(val.u, base);
+					val.ull = div_u64(val.ull, base);
 				--next;
 			}
 		}
@@ -3143,36 +3143,36 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		switch (qualifier) {
 		case 'H':	/* that's 'hh' in format */
 			if (is_sign)
-				*va_arg(args, signed char *) = val.s;
+				*va_arg(args, signed char *) = val.sll;
 			else
-				*va_arg(args, unsigned char *) = val.u;
+				*va_arg(args, unsigned char *) = val.ull;
 			break;
 		case 'h':
 			if (is_sign)
-				*va_arg(args, short *) = val.s;
+				*va_arg(args, short *) = val.sll;
 			else
-				*va_arg(args, unsigned short *) = val.u;
+				*va_arg(args, unsigned short *) = val.ull;
 			break;
 		case 'l':
 			if (is_sign)
-				*va_arg(args, long *) = val.s;
+				*va_arg(args, long *) = val.sll;
 			else
-				*va_arg(args, unsigned long *) = val.u;
+				*va_arg(args, unsigned long *) = val.ull;
 			break;
 		case 'L':
 			if (is_sign)
-				*va_arg(args, long long *) = val.s;
+				*va_arg(args, long long *) = val.sll;
 			else
-				*va_arg(args, unsigned long long *) = val.u;
+				*va_arg(args, unsigned long long *) = val.ull;
 			break;
 		case 'z':
-			*va_arg(args, size_t *) = val.u;
+			*va_arg(args, size_t *) = val.ull;
 			break;
 		default:
 			if (is_sign)
-				*va_arg(args, int *) = val.s;
+				*va_arg(args, int *) = val.sll;
 			else
-				*va_arg(args, unsigned int *) = val.u;
+				*va_arg(args, unsigned int *) = val.ull;
 			break;
 		}
 		num++;
-- 
2.11.0

