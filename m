Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226XonXtY4IFh8E+prcoSAaNggWX63BxJ+Mpx5gRaZKl6Fil+HP4LaxBq8dQ83+vNS9eJ9B1
ARC-Seal: i=1; a=rsa-sha256; t=1518106812; cv=none;
        d=google.com; s=arc-20160816;
        b=dkH5KJXsb60ael5i7VrULTHz6DQNgihg2kwykLygGc/O9hXC5Qj2XASgF0C73ugagd
         qelSkVbs92cyhtr9EkFyl6D2DqbcBgRx58NKjmiM0MsOI5Wpk9FzRmPdjUu1l5xv2drm
         4s2JnS2/cAZQsGIKufrUyiTo7s35JZ2LYgiavtiXUejhAhdeYrxRPpSpC56Uds31jGiH
         6j9jL54TWVDSD6RmDBcuu+WaIWpcntmIEwWMz/unTKy3W7zEJnfhNksPu7Gs7iYP//NY
         niYnWdfCgrKC1Zlk9uyED5/bo3Nk4VpjScaZEZAmEWaVMwO2uGFLmg7o/ihUDnc2ZrxC
         /OVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=I9Hg17wLX5kmhRTYQxGVGOrJ6uikTpQIK1iRwVy31w4=;
        b=HZe/8i1ziifTZJGfc5a2O+DPQv1Y1aMi37dVTy3PF51pK7vkUX5R4IDQC4712qHVbT
         lGR1eQZ3RfCHLuXzGavxRjNEW2Zf2rzQrVPCsn1/i8ZtXOc445aRGRb6tDmLsHot/Mga
         rkf+IzZ8VVLwyj/do1/4VCOMTE44lNrP+iCW5I125eML1VzYF7iNuWjo5zE12q+VQKor
         5TLb8NNvMvEbewO1bvIz/sCCO4vTfbCPpXgS6eP3+rzE7oHVD4tOnqnzTRKCk7QFbo9/
         XBqqO1RPKwc3TGG+d33vGX27IdgRnnbQ4813nuPGgR7k/N2K0yiL7dJc77Ac5kW0jQKA
         bS0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=uOpsnhMm;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=uOpsnhMm;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w18GJP1F021191
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/7] kconfig: remove const qualifier from sym_expand_string_value()
Date: Fri,  9 Feb 2018 01:19:08 +0900
Message-Id: <1518106752-29228-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850369071440330?=
X-GMAIL-MSGID: =?utf-8?q?1591850369071440330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This function returns realloc'ed memory, so the returned pointer
must be passed to free() when done.  Change the return value type
to save casting.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/lkc_proto.h | 2 +-
 scripts/kconfig/symbol.c    | 2 +-
 scripts/kconfig/util.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index 5d86e2d..9dc8abf 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -31,7 +31,7 @@ extern struct symbol * symbol_hash[SYMBOL_HASHSIZE];
 
 struct symbol * sym_lookup(const char *name, int flags);
 struct symbol * sym_find(const char *name);
-const char * sym_expand_string_value(const char *in);
+char *sym_expand_string_value(const char *in);
 const char * sym_escape_string_value(const char *in);
 struct symbol ** sym_re_search(const char *pattern);
 const char * sym_type_name(enum symbol_type type);
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index bc3ec6a..893eae6 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -901,7 +901,7 @@ struct symbol *sym_find(const char *name)
  * name to be expanded shall be prefixed by a '$'. Unknown symbol expands to
  * the empty string.
  */
-const char *sym_expand_string_value(const char *in)
+char *sym_expand_string_value(const char *in)
 {
 	const char *src;
 	char *res;
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 01ead28..befaec9 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -14,11 +14,11 @@
 struct file *file_lookup(const char *name)
 {
 	struct file *file;
-	const char *file_name = sym_expand_string_value(name);
+	char *file_name = sym_expand_string_value(name);
 
 	for (file = file_list; file; file = file->next) {
 		if (!strcmp(name, file->name)) {
-			free((void *)file_name);
+			free(file_name);
 			return file;
 		}
 	}
-- 
2.7.4
