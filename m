Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225TgExb2WBdNYqM6axNoznPxtErIMojfMj+EvZ1FBsynsOIYQWC9CkGZA5vo1KWBfYGn8P9
ARC-Seal: i=1; a=rsa-sha256; t=1518806386; cv=none;
        d=google.com; s=arc-20160816;
        b=EPGexqt8QboxOWIhRTxb6gWL0n8X67MUkO942h5uDBdCR8hQLC8qLmZmJVLdpP1Tgf
         EWNNdpEzEGjEb8glX5yB8QtbsMZc109wKXVIk0Lm660JQwiT7fhRvezw9VGn+89RxTeA
         O2KN/bwKVCOY3AkjhF+RhqABkbfdj2GwoulAkZxpnSInS0IvHADec48rrp6EWCAWv6ZB
         Wg4cGBmFuJ/ly1W3wLJi1TrTSyPTpoQNLziD06Pjl6OUmjpY1/CNIqzcDADBANfqDfnt
         uWPKKXIUqfbuB8LlDtr5hO5x6HXiX/JQb0kLJ8Ha5xzgeXSlSJGrw752PlKC1GPtxTbN
         tRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=x37G/JrybxXhVfsvSRijeqSjd9Vmal2cBfU3vCqzxWI=;
        b=lnACF9k4OtMbvHVPp4yvp4Q54TOMYLfy4cDOjW15ECc1eSI53XOThDRfmdpa8AnySq
         0yH49KNO20TGsaeOuxMDtR6boRzkMsMjr11WMUWydNvbBQlD/lDprKgC8ZsNSL0xVIXH
         xET4Mps/sbtANTQcdU2ddBPhkn++B6S0YzPb7uvaVi0J2wfoWHIvcQQQIuqW6/imGGzw
         smb6didosu0O6uNjPH7tO1QQq9JiGNAFbE4Ut5GiQ3KPrrhYvvln92R4jZ6yXS9vm3sn
         cDqkP+dK6zE7QI+A+brFSShWEHMVfVZe4eIkyWTmnk0aK4My/040dp/uM47Mwq/Wocx3
         9IOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=ZAEzv6Vt;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=ZAEzv6Vt;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBT6013418
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/23] kconfig: add xstrdup() helper
Date: Sat, 17 Feb 2018 03:38:31 +0900
Message-Id: <1518806331-7101-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583925439348866?=
X-GMAIL-MSGID: =?utf-8?q?1592583925439348866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We already have xmalloc(), xcalloc(), and xrealloc(().  Add xstrdup()
as well to save tedious error handling.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/confdata.c  |  2 +-
 scripts/kconfig/kxgettext.c |  2 +-
 scripts/kconfig/lkc.h       |  1 +
 scripts/kconfig/symbol.c    |  4 ++--
 scripts/kconfig/util.c      | 11 +++++++++++
 scripts/kconfig/zconf.y     |  2 +-
 6 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 5c12dc9..df26c7b 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -178,7 +178,7 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 	case S_HEX:
 	done:
 		if (sym_string_valid(sym, p)) {
-			sym->def[def].val = strdup(p);
+			sym->def[def].val = xstrdup(p);
 			sym->flags |= def_flags;
 		} else {
 			if (def != S_DEF_AUTO)
diff --git a/scripts/kconfig/kxgettext.c b/scripts/kconfig/kxgettext.c
index 2858738..240880a 100644
--- a/scripts/kconfig/kxgettext.c
+++ b/scripts/kconfig/kxgettext.c
@@ -101,7 +101,7 @@ static struct message *message__new(const char *msg, char *option,
 	if (self->files == NULL)
 		goto out_fail;
 
-	self->msg = strdup(msg);
+	self->msg = xstrdup(msg);
 	if (self->msg == NULL)
 		goto out_fail_msg;
 
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 4e23feb..2d5ec2d 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -115,6 +115,7 @@ int file_write_dep(const char *name);
 void *xmalloc(size_t size);
 void *xcalloc(size_t nmemb, size_t size);
 void *xrealloc(void *p, size_t size);
+char *xstrdup(const char *s);
 
 struct gstr {
 	size_t len;
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index cca9663..2220bc4 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -183,7 +183,7 @@ static void sym_validate_range(struct symbol *sym)
 		sprintf(str, "%lld", val2);
 	else
 		sprintf(str, "0x%llx", val2);
-	sym->curr.val = strdup(str);
+	sym->curr.val = xstrdup(str);
 }
 
 static void sym_set_changed(struct symbol *sym)
@@ -849,7 +849,7 @@ struct symbol *sym_lookup(const char *name, int flags)
 				   : !(symbol->flags & (SYMBOL_CONST|SYMBOL_CHOICE))))
 				return symbol;
 		}
-		new_name = strdup(name);
+		new_name = xstrdup(name);
 	} else {
 		new_name = NULL;
 		hash = 0;
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index b98a79e..c6f6e21 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -154,3 +154,14 @@ void *xrealloc(void *p, size_t size)
 	fprintf(stderr, "Out of memory.\n");
 	exit(1);
 }
+
+char *xstrdup(const char *s)
+{
+	char *p;
+
+	p = strdup(s);
+	if (p)
+		return p;
+	fprintf(stderr, "Out of memory.\n");
+	exit(1);
+}
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 4893676..ad6305b 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -127,7 +127,7 @@ no_mainmenu_stmt: /* empty */
 	 * later regardless of whether it comes from the 'prompt' in
 	 * mainmenu_stmt or here
 	 */
-	menu_add_prompt(P_MENU, strdup("Linux Kernel Configuration"), NULL);
+	menu_add_prompt(P_MENU, xstrdup("Linux Kernel Configuration"), NULL);
 };
 
 
-- 
2.7.4
