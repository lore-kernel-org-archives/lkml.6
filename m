Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AD5ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61763208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61763208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbeIXRje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:39:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50396 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeIXRjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:39:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4EC35106D;
        Mon, 24 Sep 2018 11:37:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Yuexing Wang <wangyxlandq@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 007/105] scripts: modpost: check memory allocation results
Date:   Mon, 24 Sep 2018 13:32:53 +0200
Message-Id: <20180924113113.997971917@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 1f3aa9002dc6a0d59a4b599b4fc8f01cf43ef014 ]

Fix missing error check for memory allocation functions in
scripts/mod/modpost.c.

Fixes kernel bugzilla #200319:
https://bugzilla.kernel.org/show_bug.cgi?id=200319

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yuexing Wang <wangyxlandq@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/mod/modpost.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -647,7 +647,7 @@ static void handle_modversions(struct mo
 			if (ELF_ST_TYPE(sym->st_info) == STT_SPARC_REGISTER)
 				break;
 			if (symname[0] == '.') {
-				char *munged = strdup(symname);
+				char *munged = NOFAIL(strdup(symname));
 				munged[0] = '_';
 				munged[1] = toupper(munged[1]);
 				symname = munged;
@@ -1248,7 +1248,7 @@ static Elf_Sym *find_elf_symbol2(struct
 static char *sec2annotation(const char *s)
 {
 	if (match(s, init_exit_sections)) {
-		char *p = malloc(20);
+		char *p = NOFAIL(malloc(20));
 		char *r = p;
 
 		*p++ = '_';
@@ -1268,7 +1268,7 @@ static char *sec2annotation(const char *
 			strcat(p, " ");
 		return r;
 	} else {
-		return strdup("");
+		return NOFAIL(strdup(""));
 	}
 }
 
@@ -1826,7 +1826,7 @@ void buf_write(struct buffer *buf, const
 {
 	if (buf->size - buf->pos < len) {
 		buf->size += len + SZ;
-		buf->p = realloc(buf->p, buf->size);
+		buf->p = NOFAIL(realloc(buf->p, buf->size));
 	}
 	strncpy(buf->p + buf->pos, s, len);
 	buf->pos += len;


