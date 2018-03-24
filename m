Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeCXAbj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 20:31:39 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40581 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeCXAbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 20:31:36 -0400
X-Google-Smtp-Source: AG47ELtvMUIbM7OqbYa1VjTOeXVWbI4P0pbvT2N3di5PSPYADhZKLdQn3PptzA7k4IEtHB1FQMTR6A==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 1/4] tty/nozomi: cleanup DUMP() macro
Date: Fri, 23 Mar 2018 14:31:24 -1000
Message-Id: <20180324003127.4287-2-joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180324003127.4287-1-joeypabalinas@gmail.com>
References: <20180324003127.4287-1-joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace snprint() with strscpy() and use max_t() instead of
the conditional operator.

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
2.16.3
