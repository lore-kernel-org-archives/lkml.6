Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx4+oeh9YG0fGEV5bAYkP6wWQUXs5fg8pQ53kl3+BFKaFnqjP7NG1bN34kDR1mcI6ogRu9ajz
ARC-Seal: i=1; a=rsa-sha256; t=1522128618; cv=none;
        d=google.com; s=arc-20160816;
        b=pRzOqmTk+aur0pzUNKwuskZn2mJ/7j5EN8e/lv0i892BZ/l1U4fp+GwHecdDa+GJ38
         GfXqbJnbmmfryXmnmJ3Y2TT7aoTs6lqywFSCWOSVErXI3r7ixQ7xbLu9RPPsZ9Th/6I2
         3unucYR7mTCCh6Cpw9b6ZujtzqCYoasO4DY0fywX9T141voGeE83tO42JHcvbQCWb2ka
         QPnfSYUGTX6H87WGS+QfrJlwKtuFcBjthWf9hUbhK3bv924nfE2uFOjs2W9VYQxraysB
         u7uZ1XeoKHEhKC0ydQY8YAn5ZhHNj1/pu5iLmCWKezWqt8MHZEKPrOz0n4msJkPW8QAd
         XPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=DJg7hGbemINDwGQx8+jEc01G97qTOgH9soG1HjzbY7o=;
        b=BhPz7VXprFOogWZC8HALyXAg028wzi0JPN+gRId6swg3syQUrr67ltwyOOEBZKSkZf
         aO05yjdwe3R5d4HqvOFJlsdjausqT1qdNLtxmD+RCalh0ke5rf8T2TOA8n/x66Z84UEP
         bMX9rpDpOiAh+I/M1stYPZ/UXkc7JrspiKhCG60zAyDZpgTcPVV17aMC3qgF3bJCv6Y0
         90wXfY9CVKKUaBPfJjBfnR1YJFQ9mB/XqYih1ey5tv0q3vXz/mKGlnF6QwfzWLav3xi6
         I087gm6e3J/vXyUQ2++I4j4yhb8A9PzKPMZ7SkeQMrX5fbbcp0uU+CddwxSt2JojeGlK
         I9+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=HCz6Rh5M;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=HCz6Rh5M;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLp011947
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/21] kconfig: remove string expansion for mainmenu after yyparse()
Date: Tue, 27 Mar 2018 14:29:20 +0900
Message-Id: <1522128575-5326-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537936435253?=
X-GMAIL-MSGID: =?utf-8?q?1596067537936435253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that environments are expanded in the lexer, conf_parse() does
not need to explicitly expand $ARCH and $KERNELVERSION in the mainmenu.

The hack introduced by commit 0724a7c32a54 ("kconfig: Don't leak
main menus during parsing") can go away.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Simplify the patch.  Just remove the text expansion.

 scripts/kconfig/zconf.y | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 4ff4ac9..d8120c7 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -109,7 +109,7 @@ static struct menu *current_menu, *current_entry;
 %%
 input: nl start | start;
 
-start: mainmenu_stmt stmt_list | no_mainmenu_stmt stmt_list;
+start: mainmenu_stmt stmt_list | stmt_list;
 
 /* mainmenu entry */
 
@@ -118,19 +118,6 @@ mainmenu_stmt: T_MAINMENU prompt nl
 	menu_add_prompt(P_MENU, $2, NULL);
 };
 
-/* Default main menu, if there's no mainmenu entry */
-
-no_mainmenu_stmt: /* empty */
-{
-	/*
-	 * Hack: Keep the main menu title on the heap so we can safely free it
-	 * later regardless of whether it comes from the 'prompt' in
-	 * mainmenu_stmt or here
-	 */
-	menu_add_prompt(P_MENU, xstrdup("Linux Kernel Configuration"), NULL);
-};
-
-
 stmt_list:
 	  /* empty */
 	| stmt_list common_stmt
@@ -528,7 +515,6 @@ word_opt: /* empty */			{ $$ = NULL; }
 
 void conf_parse(const char *name)
 {
-	const char *tmp;
 	struct symbol *sym;
 	int i;
 
@@ -544,10 +530,10 @@ void conf_parse(const char *name)
 	if (!modules_sym)
 		modules_sym = sym_find( "n" );
 
-	tmp = rootmenu.prompt->text;
-	rootmenu.prompt->text = _(rootmenu.prompt->text);
-	rootmenu.prompt->text = expand_string_value(rootmenu.prompt->text);
-	free((char*)tmp);
+	if (!menu_has_prompt(&rootmenu)) {
+		current_entry = &rootmenu;
+		menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
+	}
 
 	menu_finalize(&rootmenu);
 	for_all_symbols(i, sym) {
-- 
2.7.4
