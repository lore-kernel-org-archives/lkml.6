Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E82AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4632020837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fk12/YCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4632020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeIABBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:01:48 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33379 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIABBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:01:48 -0400
Received: by mail-wr1-f45.google.com with SMTP id v90-v6so12349090wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DyGBnWZx2nlxc4vEWno/PWe6PjvhGEty03ow5mFqowE=;
        b=Fk12/YCzY6LvgACPt4jmmXv/w8T70WtF0fKOhYx4a4zaj4ka1srfoi26Cft7l0bSzT
         Xal7Wf0FngnMl/RFYksLmZRiu0O8e+YbmQBqCpZYC0uRTmIUoUqxvZPaD8Dwn/sufBOE
         zqr/kb9dw28sm3Nx5X3fh4Fqrc8iAelb8nflM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DyGBnWZx2nlxc4vEWno/PWe6PjvhGEty03ow5mFqowE=;
        b=CW5u2t3vjsylGjpo6IoauqqMjeWvUg3lw6vYQh2fJLQiduITFKaD2MvSrYhd8LLthq
         +EeVSfPg580wBJkW5+A+UPiflSrWw5nIfBo0K3ZgXCdQ5+MthiqAnrYoOtUumxPb51d9
         B+c85VGpOsSia4K3lDcERbojCyTjHoC65GQYYjOUz1AQQ5TGS4JiTwfJJZuXFTdKFWns
         u3yZYDOtinXTSkP4rDhtsUz0BlQ4b/NzF3DcUph4tYC2r8rZtzDdJywS2LTLY3ZEgBeG
         C/kzvtROLvuGEN8CLRtIp0KqUPwMfqJ+98YbgMulWnbQxEWe7uFmRE2yG8ZQ6g0dI+Tq
         rM4Q==
X-Gm-Message-State: APzg51BpANw5nXydCXI/lBPD3JIbERJsnAqnZ+RI0YlwlPqWE7cA4XiN
        4lzBfgOv8za+eoU/cYPpHJgfHA==
X-Google-Smtp-Source: ANB0VdaBOSnURcAyKixLkescAzgurtV4ZnSwKo2YfbMWneHfqCu3JC+KzERkjn6KVJkoJIv9G+nVNw==
X-Received: by 2002:a5d:4a87:: with SMTP id o7-v6mr11265526wrq.132.1535748753541;
        Fri, 31 Aug 2018 13:52:33 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u4-v6sm7659356wro.47.2018.08.31.13.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 13:52:32 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH 3/5] kdb: Remove special case logic from kdb_read()
Date:   Fri, 31 Aug 2018 21:51:40 +0100
Message-Id: <20180831205142.23609-4-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831205142.23609-1-daniel.thompson@linaro.org>
References: <20180831205142.23609-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdb_read() contains special case logic to force it exit after reading
a single character. We can remove all the special case logic by directly
calling the function to read a single character instead. This also
allows us to tidy up the function prototype which, because it now matches
getchar(), we can also rename in order to make its role clearer.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 56 ++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 0ba490728459..f735d859f28b 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -106,7 +106,19 @@ static int kdb_read_handle_escape(char *buf, size_t sz)
 	return -1;
 }
 
-static int kdb_read_get_key(char *buffer, size_t bufsize)
+/*
+ * kdb_getchar
+ *
+ * Read a single character from kdb console (or consoles).
+ *
+ * An escape key could be the start of a vt100 control sequence such as \e[D
+ * (left arrow) or it could be a character in its own right.  The standard
+ * method for detecting the difference is to wait for 2 seconds to see if there
+ * are any other characters.  kdb is complicated by the lack of a timer service
+ * (interrupts are off), by multiple input sources. Escape sequence processing
+ * has to be done as states in the polling loop.
+ */
+static int kdb_getchar(void)
 {
 #define ESCAPE_UDELAY 1000
 #define ESCAPE_DELAY (2*1000000/ESCAPE_UDELAY) /* 2 seconds worth of udelays */
@@ -124,7 +136,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 		}
 
 		key = (*f)();
-
 		if (key == -1) {
 			if (escape_delay) {
 				udelay(ESCAPE_UDELAY);
@@ -134,14 +145,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 			continue;
 		}
 
-		if (bufsize <= 2) {
-			if (key == '\r')
-				key = '\n';
-			*buffer++ = key;
-			*buffer = '\0';
-			return -1;
-		}
-
 		if (escape_delay == 0 && key == '\e') {
 			escape_delay = ESCAPE_DELAY;
 			ped = escape_data;
@@ -183,17 +186,7 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
  *	function.  It is not reentrant - it relies on the fact
  *	that while kdb is running on only one "master debug" cpu.
  * Remarks:
- *
- * The buffer size must be >= 2.  A buffer size of 2 means that the caller only
- * wants a single key.
- *
- * An escape key could be the start of a vt100 control sequence such as \e[D
- * (left arrow) or it could be a character in its own right.  The standard
- * method for detecting the difference is to wait for 2 seconds to see if there
- * are any other characters.  kdb is complicated by the lack of a timer service
- * (interrupts are off), by multiple input sources and by the need to sometimes
- * return after just one key.  Escape sequence processing has to be done as
- * states in the polling loop.
+ *	The buffer size must be >= 2.
  */
 
 static char *kdb_read(char *buffer, size_t bufsize)
@@ -228,9 +221,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	*cp = '\0';
 	kdb_printf("%s", buffer);
 poll_again:
-	key = kdb_read_get_key(buffer, bufsize);
-	if (key == -1)
-		return buffer;
+	key = kdb_getchar();
 	if (key != 9)
 		tab = 0;
 	switch (key) {
@@ -738,7 +729,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 
 	/* check for having reached the LINES number of printed lines */
 	if (kdb_nextline >= linecount) {
-		char buf1[16] = "";
+		char ch;
 
 		/* Watch out for recursion here.  Any routine that calls
 		 * kdb_printf will come back through here.  And kdb_read
@@ -773,39 +764,38 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 		if (logging)
 			printk("%s", moreprompt);
 
-		kdb_read(buf1, 2); /* '2' indicates to return
-				    * immediately after getting one key. */
+		ch = kdb_getchar();
 		kdb_nextline = 1;	/* Really set output line 1 */
 
 		/* empty and reset the buffer: */
 		kdb_buffer[0] = '\0';
 		next_avail = kdb_buffer;
 		size_avail = sizeof(kdb_buffer);
-		if ((buf1[0] == 'q') || (buf1[0] == 'Q')) {
+		if ((ch == 'q') || (ch == 'Q')) {
 			/* user hit q or Q */
 			KDB_FLAG_SET(CMD_INTERRUPT); /* command interrupted */
 			KDB_STATE_CLEAR(PAGER);
 			/* end of command output; back to normal mode */
 			kdb_grepping_flag = 0;
 			kdb_printf("\n");
-		} else if (buf1[0] == ' ') {
+		} else if (ch == ' ') {
 			kdb_printf("\r");
 			suspend_grep = 1; /* for this recursion */
-		} else if (buf1[0] == '\n') {
+		} else if (ch == '\n' || ch == '\r') {
 			kdb_nextline = linecount - 1;
 			kdb_printf("\r");
 			suspend_grep = 1; /* for this recursion */
-		} else if (buf1[0] == '/' && !kdb_grepping_flag) {
+		} else if (ch == '/' && !kdb_grepping_flag) {
 			kdb_printf("\r");
 			kdb_getstr(kdb_grep_string, KDB_GREP_STRLEN,
 				   kdbgetenv("SEARCHPROMPT") ?: "search> ");
 			*strchrnul(kdb_grep_string, '\n') = '\0';
 			kdb_grepping_flag += KDB_GREPPING_FLAG_SEARCH;
 			suspend_grep = 1; /* for this recursion */
-		} else if (buf1[0] && buf1[0] != '\n') {
+		} else if (ch && ch != '\n') {
 			/* user hit something other than enter */
 			suspend_grep = 1; /* for this recursion */
-			if (buf1[0] != '/')
+			if (ch != '/')
 				kdb_printf(
 				    "\nOnly 'q', 'Q' or '/' are processed at "
 				    "more prompt, input ignored\n");
-- 
2.17.1

