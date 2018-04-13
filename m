Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeDMFIi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:08:38 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54952 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeDMFIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:30 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lg5029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/30] kconfig: begin PARAM state only when seeing a command keyword
Date: Fri, 13 Apr 2018 14:06:20 +0900
Message-Id: <1523595999-27433-12-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
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

Changes in v3: None
Changes in v2: None

 scripts/kconfig/zconf.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 9dc5fe3..5e53348 100644
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
