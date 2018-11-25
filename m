Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9636C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582FF20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582FF20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeKYUKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:10:21 -0500
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:55257 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727379AbeKYUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 15:10:20 -0500
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Nov 2018 15:10:20 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id E281418017AB6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 09:13:54 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 21FA8182CED34;
        Sun, 25 Nov 2018 09:13:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fight67_21f37406c4050
X-Filterd-Recvd-Size: 4910
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 25 Nov 2018 09:13:53 +0000 (UTC)
Message-ID: <8eb7769cb8550e82105b71ba67fd603394e23b1e.camel@perches.com>
Subject: RFC: script to convert vsprintf uses of %pf to %ps and %pF to %pS
From:   Joe Perches <coupons@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 25 Nov 2018 01:13:51 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 04b8eb7a4ccd ("symbol lookup: introduce dereference_symbol_descriptor()}"

deprecated vsprintf extension %pf and %pF.

There are approximately these total uses of the symbolic
lookup vsprintf extensions %p[SsFf]:

$ git grep '".*[^%]%p[SsFf]' | \
  grep -oh '%p[SsFf]' | sort | uniq -c | sort -rn
    231 %pS
     65 %ps
     60 %pf
     47 %pF

which is about a 3:1 ratio favoring %pS

so a script to convert all the %pf uses to %ps and %pF uses to %pS
could be useful.

There are a few files that appear should not be converted.

$ git grep -w --name-only -i '%pf'| \
  grep -vP '^(?:Documentation|tools|include/linux/freezer.h)'| \
  xargs sed -i -e 's/%pf/%ps/g' -e 's/%pF/%pS/g'

If that script above is run, it leaves the following patch
to be applied:
---
 Documentation/core-api/printk-formats.rst | 10 ----------
 lib/vsprintf.c                            | 12 ++----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index ff48b55040ef..ab5a6d1b05c0 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -70,8 +70,6 @@ Symbols/Function Pointers
 
 	%pS	versatile_init+0x0/0x110
 	%ps	versatile_init
-	%pF	versatile_init+0x0/0x110
-	%pf	versatile_init
 	%pSR	versatile_init+0x9/0x110
 		(with __builtin_extract_return_addr() translation)
 	%pB	prev_fn_of_versatile_init+0x88/0x88
@@ -81,14 +79,6 @@ The ``S`` and ``s`` specifiers are used for printing a pointer in symbolic
 format. They result in the symbol name with (S) or without (s)
 offsets. If KALLSYMS are disabled then the symbol address is printed instead.
 
-Note, that the ``F`` and ``f`` specifiers are identical to ``S`` (``s``)
-and thus deprecated. We have ``F`` and ``f`` because on ia64, ppc64 and
-parisc64 function pointers are indirect and, in fact, are function
-descriptors, which require additional dereferencing before we can lookup
-the symbol. As of now, ``S`` and ``s`` perform dereferencing on those
-platforms (when needed), so ``F`` and ``f`` exist for compatibility
-reasons only.
-
 The ``B`` specifier results in the symbol name with offsets and should be
 used when printing stack backtraces. The specifier takes into
 consideration the effect of compiler optimisations which may occur
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 37a54a6dd594..393002bf5298 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -795,7 +795,7 @@ char *symbol_string(char *buf, char *end, void *ptr,
 #ifdef CONFIG_KALLSYMS
 	if (*fmt == 'B')
 		sprint_backtrace(sym, value);
-	else if (*fmt != 'f' && *fmt != 's')
+	else if (*fmt != 's')
 		sprint_symbol(sym, value);
 	else
 		sprint_symbol_no_offset(sym, value);
@@ -1756,9 +1756,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
  *
  * - 'S' For symbolic direct pointers (or function descriptors) with offset
  * - 's' For symbolic direct pointers (or function descriptors) without offset
- * - 'F' Same as 'S'
- * - 'f' Same as 's'
- * - '[FfSs]R' as above with __builtin_extract_return_addr() translation
+ * - '[Ss]R' as above with __builtin_extract_return_addr() translation
  * - 'B' For backtraced symbolic direct pointers with offset
  * - 'R' For decoded struct resource, e.g., [mem 0x0-0x1f 64bit pref]
  * - 'r' For raw struct resource, e.g., [mem 0x0-0x1f flags 0x201]
@@ -1872,8 +1870,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	}
 
 	switch (*fmt) {
-	case 'F':
-	case 'f':
 	case 'S':
 	case 's':
 		ptr = dereference_symbol_descriptor(ptr);
@@ -2603,8 +2599,6 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 			/* Dereference of functions is still OK */
 			case 'S':
 			case 's':
-			case 'F':
-			case 'f':
 			case 'x':
 			case 'K':
 				save_arg(void *);
@@ -2779,8 +2773,6 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 			switch (*fmt) {
 			case 'S':
 			case 's':
-			case 'F':
-			case 'f':
 			case 'x':
 			case 'K':
 				process = true;
---


