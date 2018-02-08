Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226RU34u8pnDZzcjWJZemGjkQDNoxk3+/a719Gcjk4HS4ZPQeUjoE/S7XZWjz6L/n6ybD4rU
ARC-Seal: i=1; a=rsa-sha256; t=1518106812; cv=none;
        d=google.com; s=arc-20160816;
        b=B5VK8yHY/uJlbe+qWZ97OmT2BfwSFu5po4hcrVwsRHPRKPS4okxgMQstIBPRF1UPTq
         Ehr0YNAsLtKGlnS21PrjtSVWob5GldyDieYa92GsoJME7/fcIsM3+kXWjhGGq91at5X2
         pE1SUasWzSWpkyQM/pdn3qwUdfW7InX2ytFzCHI+tdma91DZE1Y5Gt44smfN5ZmM+Dfg
         /UI/JqrrhIilLvHI7KKGfpR255y/244tEWKTJeaRp08fyUk68Ph4G2JEaqrJuHCNnj4y
         GEN9eiPry6myqXTNVsP+AjAi1F+idbfR9yMgQXGe+r95nDIQ15wrYcpFMzaqG0vC822B
         mwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=u39XhiSy2FIvQt8O3MtdRJJg6CV6UlnbVTrzkUrASnw=;
        b=oaLKfEa+2Ze6HjAmg52rY3q+XMEBNTYqDZmWwnLWQqK8heuGBoMq0oOHbNcOCcNuzi
         rU4T0DkLLwVJBS1+sTcEGNQOuPvLMSOQjY3Zvn79hWSgVjLfsWXZ7+1R8ilVH0OGYx3B
         ZwyqR+u8ItxhW2uqGPjM1ZADw6GACSL1Y1os7yvFi6nylsHX0mEvYaWyKYP9w003GFKa
         8d2+c41cJztDgcwRIZwHIvUE2Zz03pLU3lMBLCHmWalVbYam36YgQqREGMbOkixcDXKz
         DF7xwL1CHdY3DULrQFp4x2N3jkmWo4y9B/bUfKysVJ1eNrqAoqSAVHKGm3XtwOclfAbh
         mFnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=rDT1CHPk;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=rDT1CHPk;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w18GJP1E021191
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
Subject: [RFC PATCH 2/7] kconfig: add xrealloc() helper
Date: Fri,  9 Feb 2018 01:19:07 +0900
Message-Id: <1518106752-29228-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368613284137?=
X-GMAIL-MSGID: =?utf-8?q?1591850368613284137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We have xmalloc(), xcalloc() already.  Add xrealloc() as well to save
tedious error handling.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/confdata.c  |  2 +-
 scripts/kconfig/lkc.h       |  1 +
 scripts/kconfig/nconf.gui.c |  2 +-
 scripts/kconfig/symbol.c    |  2 +-
 scripts/kconfig/util.c      | 11 ++++++++++-
 scripts/kconfig/zconf.l     |  2 +-
 6 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index f792739..5c12dc9 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -201,7 +201,7 @@ static int add_byte(int c, char **lineptr, size_t slen, size_t *n)
 	if (new_size > *n) {
 		new_size += LINE_GROWTH - 1;
 		new_size *= 2;
-		nline = realloc(*lineptr, new_size);
+		nline = xrealloc(*lineptr, new_size);
 		if (!nline)
 			return -1;
 
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 16cb62b..4e23feb 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -114,6 +114,7 @@ struct file *file_lookup(const char *name);
 int file_write_dep(const char *name);
 void *xmalloc(size_t size);
 void *xcalloc(size_t nmemb, size_t size);
+void *xrealloc(void *p, size_t size);
 
 struct gstr {
 	size_t len;
diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
index a64b1c3..93e3d0c 100644
--- a/scripts/kconfig/nconf.gui.c
+++ b/scripts/kconfig/nconf.gui.c
@@ -374,7 +374,7 @@ int dialog_inputbox(WINDOW *main_window,
 
 	if (strlen(init)+1 > *result_len) {
 		*result_len = strlen(init)+1;
-		*resultp = result = realloc(result, *result_len);
+		*resultp = result = xrealloc(result, *result_len);
 	}
 
 	/* find the widest line of msg: */
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index c9123ed..bc3ec6a 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -938,7 +938,7 @@ const char *sym_expand_string_value(const char *in)
 		newlen = strlen(res) + strlen(symval) + strlen(src) + 1;
 		if (newlen > reslen) {
 			reslen = newlen;
-			res = realloc(res, reslen);
+			res = xrealloc(res, reslen);
 		}
 
 		strcat(res, symval);
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 0e76042..01ead28 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -104,7 +104,7 @@ void str_append(struct gstr *gs, const char *s)
 	if (s) {
 		l = strlen(gs->s) + strlen(s) + 1;
 		if (l > gs->len) {
-			gs->s   = realloc(gs->s, l);
+			gs->s   = xrealloc(gs->s, l);
 			gs->len = l;
 		}
 		strcat(gs->s, s);
@@ -145,3 +145,12 @@ void *xcalloc(size_t nmemb, size_t size)
 	fprintf(stderr, "Out of memory.\n");
 	exit(1);
 }
+
+void *xrealloc(void *p, size_t size)
+{
+	p = realloc(p, size);
+	if (p)
+		return p;
+	fprintf(stderr, "Out of memory.\n");
+	exit(1);
+}
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 07e074d..0bc43db 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -52,7 +52,7 @@ static void append_string(const char *str, int size)
 	if (new_size > text_asize) {
 		new_size += START_STRSIZE - 1;
 		new_size &= -START_STRSIZE;
-		text = realloc(text, new_size);
+		text = xrealloc(text, new_size);
 		text_asize = new_size;
 	}
 	memcpy(text + text_size, str, size);
-- 
2.7.4
