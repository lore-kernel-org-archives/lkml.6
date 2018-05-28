Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933831AbeE1JZU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:25:20 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:23165 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933652AbeE1JZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:25:09 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInW027506
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
Subject: [PATCH v5 15/31] kconfig: expand lefthand side of assignment statement
Date: Mon, 28 May 2018 18:21:52 +0900
Message-Id: <1527499328-13213-16-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make expands the lefthand side of assignment statements.  In fact,
Kbuild relies on it since kernel makefiles mostly look like this:

  obj-$(CONFIG_FOO) += foo.o

Do likewise in Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 scripts/kconfig/zconf.l | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index a6cbe2d..25bd2b8 100644
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
