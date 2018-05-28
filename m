Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbeE1J3q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:29:46 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21618 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbeE1JYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInS027506
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 11/31] kconfig: begin PARAM state only when seeing a command keyword
Date: Mon, 28 May 2018 18:21:48 +0900
Message-Id: <1527499328-13213-12-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, any statement line starts with a keyword with TF_COMMAND
flag.  So, the following three lines are dead code.

        alloc_string(yytext, yyleng);
        zconflval.string = text;
        return T_WORD;

If a T_WORD token is returned in this context, it will cause syntax
error in the parser anyway.

The next commit will support the assignment statement where a line
starts with an arbitrary identifier.  So, I want the lexer to switch
to the PARAM state only when it sees a command keyword.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
 - Newly added

Changes in v2: None

 scripts/kconfig/zconf.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index b385590..9a14797 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -102,10 +102,10 @@ n	[A-Za-z0-9_-]
 <COMMAND>{
 	{n}+	{
 		const struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
-		BEGIN(PARAM);
 		current_pos.file = current_file;
 		current_pos.lineno = yylineno;
 		if (id && id->flags & TF_COMMAND) {
+			BEGIN(PARAM);
 			yylval.id = id;
 			return id->token;
 		}
-- 
2.7.4
