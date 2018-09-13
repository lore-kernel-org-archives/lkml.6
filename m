Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3F7C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEAF20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEAF20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeIMSpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:45:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59178 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIMSpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:45:31 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A00AED18;
        Thu, 13 Sep 2018 13:36:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Yuexing Wang <wangyxlandq@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 24/78] scripts: modpost: check memory allocation results
Date:   Thu, 13 Sep 2018 15:31:11 +0200
Message-Id: <20180913131807.329534579@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -649,7 +649,7 @@ static void handle_modversions(struct mo
 			if (ELF_ST_TYPE(sym->st_info) == STT_SPARC_REGISTER)
 				break;
 			if (symname[0] == '.') {
-				char *munged = strdup(symname);
+				char *munged = NOFAIL(strdup(symname));
 				munged[0] = '_';
 				munged[1] = toupper(munged[1]);
 				symname = munged;
@@ -1312,7 +1312,7 @@ static Elf_Sym *find_elf_symbol2(struct
 static char *sec2annotation(const char *s)
 {
 	if (match(s, init_exit_sections)) {
-		char *p = malloc(20);
+		char *p = NOFAIL(malloc(20));
 		char *r = p;
 
 		*p++ = '_';
@@ -1332,7 +1332,7 @@ static char *sec2annotation(const char *
 			strcat(p, " ");
 		return r;
 	} else {
-		return strdup("");
+		return NOFAIL(strdup(""));
 	}
 }
 
@@ -2033,7 +2033,7 @@ void buf_write(struct buffer *buf, const
 {
 	if (buf->size - buf->pos < len) {
 		buf->size += len + SZ;
-		buf->p = realloc(buf->p, buf->size);
+		buf->p = NOFAIL(realloc(buf->p, buf->size));
 	}
 	strncpy(buf->p + buf->pos, s, len);
 	buf->pos += len;


