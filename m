Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EDAC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0063320846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0063320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeGZLHa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:07:30 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:46391 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728792AbeGZLHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:07:30 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-110-eHHt89fhM8WP-fOyLlxLRw-1; Thu, 26 Jul 2018 10:51:22 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 26 Jul 2018 10:53:01 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 26 Jul 2018 10:53:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "'yamada.masahiro@socionext.com'" <yamada.masahiro@socionext.com>,
        "'michal.lkml@markovi.net'" <michal.lkml@markovi.net>
Subject: [PATCH v2] scripts: Detect invalid .o files created by objtool.
Thread-Topic: [PATCH v2] scripts: Detect invalid .o files created by objtool.
Thread-Index: AdQgGLh7PYZxMOlYSQi/8LvLaBR9JgErCT8Q
Date:   Thu, 26 Jul 2018 09:53:01 +0000
Message-ID: <b44a52ad2f5d4e939a52e750f776582f@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: eHHt89fhM8WP-fOyLlxLRw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The objtool code that generates to ORC unwind tables found a bug
in libelf that causes the section headers to not be rewritten.
The next access to the output file generates a 'File format not recognised'
error from objdump or ld.

Module compilation uses 'objdump ... | grep -q ...' and the objump
error is treated the same as the grep not finding the required line.
This means the build doesn't even stop.

Detect errors from objdump when building modules.

Verify (with objdump -h) that the file modified by objtool is valid.
If invalid suggest updating libelf.so or disabling the ORC unwinder.

Signed-off-by: David Laight <david.laight@aculab.com>
---

v2: Add missing $ escaping $$obj_headers

 scripts/Makefile.build | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index e7889f4..200b02c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -193,7 +193,9 @@ else
 cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<

 cmd_modversions_c =								\
-	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then		\
+	if ! obj_headers=$$($(OBJDUMP) -h $(@D)/.tmp_$(@F)); then		\
+		false;								\
+	elif echo "$$obj_headers" | grep -q __ksymtab; then			\
 		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
 		    > $(@D)/.tmp_$(@F:.o=.ver);					\
 										\
@@ -277,7 +279,14 @@ endif
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
 cmd_objtool = $(if $(patsubst y%,, \
 	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
-	$(__objtool_obj) $(objtool_args) "$(objtool_o)";)
+	$(__objtool_obj) $(objtool_args) "$(objtool_o)" && { \
+		$(OBJDUMP) -h "$(objtool_o)" >/dev/null 2>&1 || { \
+			echo >&2 "******* objtool generated the invalid file $(objtool_o)"; \
+			echo >&2 "******* Update libelf.so or disable the ORC unwinder"; \
+			/bin/false; \
+		}; \
+	};)
+
 objtool_obj = $(if $(patsubst y%,, \
 	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
 	$(__objtool_obj))
--
1.8.1.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

