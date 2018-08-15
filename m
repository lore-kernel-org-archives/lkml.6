Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4865BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B812152D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XPaXwiTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B812152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeHOWYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:24:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59502 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeHOWYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=REit2rzsb5WkTUr7mOiBEVmwkKhMmXIllsCt9e/cppo=; b=XPaXwiTtS13Etn8mIUixrJF7jf
        BOGGAbOlFs1NC15zZdmTY4idLB9Sa4pftrMHTMDhNIRcJlK2hhvGbidAF9O+YvMEUBa72ddJXUcNp
        SGzatRxTXOyYVVEUW9h+QzuoxtVXuQQ7p6+Qya2br2G4xrR3W53Vsf+/Ddi1H/o2vq/z8lGKt5wVb
        GZNQLldNeoYmctGQei9Xxt08Zf0cN76VXj2M/UgD0vb1EVrJ5y4QxCU3XGdqT9qL2GimkfIwIisMZ
        KeTMo+03pQJBREa9lrcvwrsP+15k8iJZ0TujE+drQMbOMQXKdtTXaK0XJPgtT3SxipJhQyUUfdmCp
        fK//CnUQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fq1VB-0004aU-Af; Wed, 15 Aug 2018 19:30:41 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Yuexing Wang <wangyxlandq@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] scripts: modpost: check memory allocation results
Message-ID: <eafb5a94-f140-27f2-bc91-c6b95a18c97d@infradead.org>
Date:   Wed, 15 Aug 2018 12:30:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix missing error check for memory allocation functions in
scripts/mod/modpost.c.

Fixes kernel bugzilla #200319:
https://bugzilla.kernel.org/show_bug.cgi?id=200319

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yuexing Wang <wangyxlandq@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
---
v2: add checks in more places

 scripts/mod/modpost.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20180814.orig/scripts/mod/modpost.c
+++ linux-next-20180814/scripts/mod/modpost.c
@@ -672,7 +672,7 @@ static void handle_modversions(struct mo
 			if (ELF_ST_TYPE(sym->st_info) == STT_SPARC_REGISTER)
 				break;
 			if (symname[0] == '.') {
-				char *munged = strdup(symname);
+				char *munged = NOFAIL(strdup(symname));
 				munged[0] = '_';
 				munged[1] = toupper(munged[1]);
 				symname = munged;
@@ -1318,7 +1318,7 @@ static Elf_Sym *find_elf_symbol2(struct
 static char *sec2annotation(const char *s)
 {
 	if (match(s, init_exit_sections)) {
-		char *p = malloc(20);
+		char *p = NOFAIL(malloc(20));
 		char *r = p;
 
 		*p++ = '_';
@@ -1338,7 +1338,7 @@ static char *sec2annotation(const char *
 			strcat(p, " ");
 		return r;
 	} else {
-		return strdup("");
+		return NOFAIL(strdup(""));
 	}
 }
 
@@ -2036,7 +2036,7 @@ void buf_write(struct buffer *buf, const
 {
 	if (buf->size - buf->pos < len) {
 		buf->size += len + SZ;
-		buf->p = realloc(buf->p, buf->size);
+		buf->p = NOFAIL(realloc(buf->p, buf->size));
 	}
 	strncpy(buf->p + buf->pos, s, len);
 	buf->pos += len;


