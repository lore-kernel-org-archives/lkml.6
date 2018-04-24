Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524609562; cv=none;
        d=google.com; s=arc-20160816;
        b=G9qdloxKoVF1H7qhNv+1vtCJtixxCZ0gDBWlyIqVOgEjs7rsUfjQYiNM1cHB09FVh2
         z6Xcb95wd1s5+uhDH4aFZH+lwmB0HWrMl0ZjMtYaC9gv/MMo+CvQISPRGYVt1IXMqt2S
         h1m78m6ED/1nwWqWv7lLAO29TsPlv/hKKb7DtwtwzGMSUm+dwH4QeunWkTg0iXj2Y4AJ
         yan6bKIa84x55OLtOnbD7kLs16DTlH7oMBIBH1WfWA/jAlW4V+GTZY58KC1YZqNavMht
         xzLA81HkeT9y2MTMP1EeWSQqWCiAWEg3/rJHRSDX230cVghuVcLYMjSlA3RsGElFNpEI
         D5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=LZBv/G15CQUpOC+K1BD9S8x1CFIvRfiLEviH+kXatsw=;
        b=uoy2/1a3JtDSUq/KzAPP0r8Iwm33tduuJ1YKr48fG/4mL5i5AD+idXZq/whJexBtLH
         6N7/Q11o1P6/oFdXp19FMx9ZU6RYfYVXAuuBQO+O5IwnSwISAXvZ1QcmRWJXQiJVUWcN
         1qHT4IBx5XhdHqWTIKfbEJpvjC7TJx5KfQUn7PMGtrVjqvfhBvL2eK3Ijh6Aby2cYtQI
         v3wOAV8STyxo5iIiIgLj2YZcmJ0gHevl5SW8xtDZ7/tPTt05YtZ2yGUcYHGQD8vYDtxJ
         K02iuxH4goFfTYWER+3M3t32gk3/J8FPV8y1RJTXqnCzUaVahcoDv2jUnoLTnNN8Tw7l
         8OpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KQrQo/+7;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KQrQo/+7;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/xxfnBfgNGEP3ZJc4XcroQYY2eW8umX/ggSsJ/KimhNyqb1pAlKsprl/pveKv4mDq7jhi30g==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v3 1/2] tty/nozomi: cleanup DUMP() macro
Date: Tue, 24 Apr 2018 12:39:14 -1000
Message-Id: <58b559776732f0fc14b1c30ec7da6fc27c3f1cc8.1524606061.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.35.g90bbd502d54fe92035.dirty
In-Reply-To: <cover.1524606061.git.joeypabalinas@gmail.com>
References: <cover.1524606061.git.joeypabalinas@gmail.com>
In-Reply-To: <cover.1524606061.git.joeypabalinas@gmail.com>
References: <cover.1524606061.git.joeypabalinas@gmail.com>
X-Mailer-Send-Delay: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598668996565319671?=
X-GMAIL-MSGID: =?utf-8?q?1598668996565319671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace snprint() with strscpy() and use min_t() instead of
the conditional operator to clamp buffer length.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index b57b35066ebea94639..f26bf1d1e9ee0e74eb 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -72,19 +72,19 @@ do {							\
 
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
-- 
2.17.0.rc1.35.g90bbd502d54fe92035.dirty
