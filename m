Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+RuLuRU/4ZgFUbvI5trC4/TY3qGXG+OImTsuUyY25CJviCFUafOoXZGmBOZJNRmp/2znje
ARC-Seal: i=1; a=rsa-sha256; t=1524652760; cv=none;
        d=google.com; s=arc-20160816;
        b=uqufMZ/8nPJ12phUfKUNYoWGWWyNacrB6UJkuP63Jy+zlmkxlqzaSVxuKvsO00woK+
         3zFY3zvN0VgGUmlV/08ZCAygeafh3R0sM9AWTTUoBtbxREwEDfwu53e6PpUBzwpPLBi1
         +ILrHj+DpJQ1fcCn63bUyvyy3ZlqWCSXNlE3msWRKkkHPEdTuIPUb8LKHqPtbvdD/2J8
         44KnDHC0SQDnd/MdF8Xi6WRNaNt06xRMJJNq1jvdD1+IhOpAi5O5SEvzEVMXQQXPscIz
         W9mfdv2tbvKQmw6mDJRKiz+5sRVCA9lB5ZNBHX0aKvSdy4caTmPJhIfsyirBlXn5kjix
         Ycqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=I2qhSZ4mxa5of6j5snzJsIahr+Yeicuw1mZTD1ubQk8=;
        b=MdFMdhUgJxGTPcJhQszozH+mtEJ1yKrtCRUGk3zMRXhtKZkj8rdUXSnweoUf+GfTau
         1e6KtKN4mBfM9KXO1laWWVhEs99mySX99arjGzoMebIyuQgvXqWSa7qYAyEY7tbQ447+
         Htf87r2Uxf7eyOtRLYY71M0hm7+cFrHaMWmFeagAKPz54oqGYxzTXns0XhKlkCJCwLdn
         l72/CBbzNIwbcvdKm3lS/iwiRQHjN5mm0GGcwo9CQrjRfbHlkcRS6A7ac5puAcjngcgW
         wMwxUVNABHPg++p7tYEJ6Y13N6Ocb4sfOQIYNODL/N/jS3Rh+Dak9fdxjri0BMamUsii
         zT/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 058/183] kconfig: Dont leak main menus during parsing
Date: Wed, 25 Apr 2018 12:34:38 +0200
Message-Id: <20180425103244.870152031@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714293319572620?=
X-GMAIL-MSGID: =?utf-8?q?1598714293319572620?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Magnusson <ulfalizer@gmail.com>


[ Upstream commit 0724a7c32a54e3e50d28e19e30c59014f61d4e2c ]

If a 'mainmenu' entry appeared in the Kconfig files, two things would
leak:

	- The 'struct property' allocated for the default "Linux Kernel
	  Configuration" prompt.

	- The string for the T_WORD/T_WORD_QUOTE prompt after the
	  T_MAINMENU token, allocated on the heap in zconf.l.

To fix it, introduce a new 'no_mainmenu_stmt' nonterminal that matches
if there's no 'mainmenu' and adds the default prompt. That means the
prompt only gets allocated once regardless of whether there's a
'mainmenu' statement or not, and managing it becomes simple.

Summary from Valgrind on 'menuconfig' (ARCH=x86) before the fix:

	LEAK SUMMARY:
	   definitely lost: 344,568 bytes in 14,352 blocks
	   ...

Summary after the fix:

	LEAK SUMMARY:
	   definitely lost: 344,440 bytes in 14,350 blocks
	   ...

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/kconfig/zconf.y |   33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -108,7 +108,27 @@ static struct menu *current_menu, *curre
 %%
 input: nl start | start;
 
-start: mainmenu_stmt stmt_list | stmt_list;
+start: mainmenu_stmt stmt_list | no_mainmenu_stmt stmt_list;
+
+/* mainmenu entry */
+
+mainmenu_stmt: T_MAINMENU prompt nl
+{
+	menu_add_prompt(P_MENU, $2, NULL);
+};
+
+/* Default main menu, if there's no mainmenu entry */
+
+no_mainmenu_stmt: /* empty */
+{
+	/*
+	 * Hack: Keep the main menu title on the heap so we can safely free it
+	 * later regardless of whether it comes from the 'prompt' in
+	 * mainmenu_stmt or here
+	 */
+	menu_add_prompt(P_MENU, strdup("Linux Kernel Configuration"), NULL);
+};
+
 
 stmt_list:
 	  /* empty */
@@ -351,13 +371,6 @@ if_block:
 	| if_block choice_stmt
 ;
 
-/* mainmenu entry */
-
-mainmenu_stmt: T_MAINMENU prompt nl
-{
-	menu_add_prompt(P_MENU, $2, NULL);
-};
-
 /* menu entry */
 
 menu: T_MENU prompt T_EOL
@@ -502,6 +515,7 @@ word_opt: /* empty */			{ $$ = NULL; }
 
 void conf_parse(const char *name)
 {
+	const char *tmp;
 	struct symbol *sym;
 	int i;
 
@@ -509,7 +523,6 @@ void conf_parse(const char *name)
 
 	sym_init();
 	_menu_init();
-	rootmenu.prompt = menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
 
 	if (getenv("ZCONF_DEBUG"))
 		zconfdebug = 1;
@@ -519,8 +532,10 @@ void conf_parse(const char *name)
 	if (!modules_sym)
 		modules_sym = sym_find( "n" );
 
+	tmp = rootmenu.prompt->text;
 	rootmenu.prompt->text = _(rootmenu.prompt->text);
 	rootmenu.prompt->text = sym_expand_string_value(rootmenu.prompt->text);
+	free((char*)tmp);
 
 	menu_finalize(&rootmenu);
 	for_all_symbols(i, sym) {
