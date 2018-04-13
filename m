Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeDMFIj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:08:39 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54947 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeDMFIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:30 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lg9029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/30] kconfig: expand lefthand side of assignment statement
Date: Fri, 13 Apr 2018 14:06:24 +0900
Message-Id: <1523595999-27433-16-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make allows variable references in the lefthand side of assignment.

  X = A
  Y = B
  $(X)$(Y) = 1

This does 'AB = 1'  Do likewise in Kconfig as well.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 scripts/kconfig/zconf.l | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index c68ca56b..ae33e9b 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -114,6 +114,13 @@ n	[A-Za-z0-9_-]
 		yylval.string = text;
 		return T_VARIABLE;
 	}
+	({n}|$)+	{
+		/* this token includes at least one '$' */
+		yylval.string = expand_token(yytext, yyleng);
+		if (strlen(yylval.string))
+			return T_VARIABLE;
+		free(yylval.string);
+	}
 	"="	{ BEGIN(ASSIGN_VAL); yylval.flavor = VAR_RECURSIVE; return T_ASSIGN; }
 	":="	{ BEGIN(ASSIGN_VAL); yylval.flavor = VAR_SIMPLE; return T_ASSIGN; }
 	"+="	{ BEGIN(ASSIGN_VAL); yylval.flavor = VAR_APPEND; return T_ASSIGN; }
-- 
2.7.4
