Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524635290; cv=none;
        d=google.com; s=arc-20160816;
        b=ltN8ctpZei+W+sFcL+NV0DB6OBPpzYq4MSOs9zPFgNi4xcyhJ3xXDucn7GMsPkSoRq
         f6NCp1qhRU0tRZoCeE3nnf3MuLUfZJ7PIvZAYH5vQOJxkdBbDMzZSzAogWS3gqBbglpX
         0pPca2oy8yLMJHMRcGJTYOO+D811tuxcz9IrDiQKx/t3sQZpFA1E+p2QeB2gnCIDjm/s
         EmQGzd+0DXPCgpfJs59V6G9+zNUdiP1OjL2gdLhsVyFvdUJO06sXAMiHguknjEnyh4UT
         EZLwe+6Lybv/iNOgZxOaiQ9Ro0b19hiLwcv7+qtN0t7/pnHZjfQO2LaFEdDcsOIs7CB4
         a0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=lMi5pxK3BOyQ7ChzFEMFNE3LB0pf1GMyjBKaXdAouX4=;
        b=H8lIbxCXQiHuEAG/JX/UxGIhrdH0q/TCX1xzpxC7z03zwTNaUWFG6DlJC+C4dXyb8T
         lYRhqmOm5G1xWy1LR50b1S0Kzp8jKotcRKd+B/Q2tYGDgtPDFREfR/NWXbyNV00o6cpD
         eo7QGr/Uo0eJrlqwxDDwJJ3hE5Qe1yvwNSPitTnHmiTu17Yqq6fyunYYsbaFtekNFEVj
         y9Hf32JrWPmkB1LvqT4nErwEhgQgT8bvLAmpJ/E3dxC3Sf53McO/DMT8nWGdCYLPhbEc
         AU0GUGl67WUMuq+w3jy71mtawHyiAhjfI1MVJeKCPlIJfOszD8p1fhhI891ZM4QwyIZO
         5Oyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=di2MV487;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=di2MV487;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx495aqw0iLu5pW88JhKeKgCF4BtZ8DLCQJyZMNJwVfn/6FPXLethgnaTXxE/p98zfVi23sGyaQ==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v4 1/2] tty/nozomi: cleanup DUMP() macro
Date: Tue, 24 Apr 2018 19:48:03 -1000
Message-Id: <58b559776732f0fc14b1c30ec7da6fc27c3f1cc8.1524634929.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.35.g90bbd502d54fe92035.dirty
In-Reply-To: <cover.1524634929.git.joeypabalinas@gmail.com>
References: <cover.1524634929.git.joeypabalinas@gmail.com>
In-Reply-To: <cover.1524634929.git.joeypabalinas@gmail.com>
References: <cover.1524634929.git.joeypabalinas@gmail.com>
X-Mailer-Send-Delay: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598668996565319671?=
X-GMAIL-MSGID: =?utf-8?q?1598695974186338348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace snprint() with strscpy() and use min_t() instead of
the conditional operator to clamp buffer length.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 drivers/tty/nozomi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index b57b35066ebea94639..f26bf1d1e9ee0e74eb 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -70,23 +70,23 @@ do {							\
 
 /* TODO: rewrite to optimize macros... */
 
 #define TMP_BUF_MAX 256
 
-#define DUMP(buf__,len__) \
-  do {  \
-    char tbuf[TMP_BUF_MAX] = {0};\
-    if (len__ > 1) {\
-	snprintf(tbuf, len__ > TMP_BUF_MAX ? TMP_BUF_MAX : len__, "%s", buf__);\
-	if (tbuf[len__-2] == '\r') {\
-		tbuf[len__-2] = 'r';\
-	} \
-	DBG1("SENDING: '%s' (%d+n)", tbuf, len__);\
-    } else {\
-	DBG1("SENDING: '%s' (%d)", tbuf, len__);\
-    } \
-} while (0)
+#define DUMP(buf__, len__)						\
+	do {								\
+		char tbuf[TMP_BUF_MAX] = {0};				\
+		if (len__ > 1) {					\
+			u32 data_len = min_t(u32, len__, TMP_BUF_MAX);	\
+			strscpy(tbuf, buf__, data_len);			\
+			if (tbuf[data_len - 2] == '\r')			\
+				tbuf[data_len - 2] = 'r';		\
+			DBG1("SENDING: '%s' (%d+n)", tbuf, len__);	\
+		} else {						\
+			DBG1("SENDING: '%s' (%d)", tbuf, len__);	\
+		}							\
+	} while (0)
 
 /*    Defines */
 #define NOZOMI_NAME		"nozomi"
 #define NOZOMI_NAME_TTY		"nozomi_tty"
 #define DRIVER_DESC		"Nozomi driver"
-- 
2.17.0.rc1.35.g90bbd502d54fe92035.dirty
