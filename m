Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224QdoC1vWXlIGab0WzJXCj2hUOPTkQL5x/O7kt7Lqd1VxwOTimkEuAp0nAf2tnl3w83MeM1
ARC-Seal: i=1; a=rsa-sha256; t=1519224913; cv=none;
        d=google.com; s=arc-20160816;
        b=VeLB5OH9okzn88vXlRWpqNPey6K2F9He/4vozV8UQ+k+6N5sI3EdsEatWbZRZvqlal
         5R2i2w5qJ5MG1caqP6LPc70iwSQWiANVoSuhOuTSk4I3+KB+CC5IxQVFU5rsvMZL94MN
         0Km919fdOPmXKkwkWGV6+eq++b4cjGMYNOfCmzkMb7mYcHFWul2kNa2hEvF9JO/Xo8T+
         7/49W24011uval51kE9qnodX9xeAFEoXNH2YBJ9kEq/wAP6YtN2KQyMn82Id3ja5XYfY
         OvS/5l3xMV5VQnupS1+S2WsEWc3N5PrJAJT/jrCS8yXkQgjoGG08UkZRpAJNkEiaqeLE
         l6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=JFVQwWt0ntBNcWi4X5g8LHyM1BC3e5e1hR6w2w1EhqY=;
        b=xjNL8qVgRRMF5AEvgf8aQzoSQfbYJ1FKGQImLnCSK4VMx04tc8YR4s0VqtAShZbqGB
         Btzfnf+NAl4lagUBVV4423Iil5QozTVdz3Ehq41HGobAwUzB/0jm5uI1WIyO5KMuQbGL
         zJJuPvuVlcjTjJpRiM2uFHznwfWROyvm0TpdyMMvK6Y/yAkyRXHKYOv/AGik3Hd1PzHb
         LX4PB/LYyWr6UgdTn6vFMxoUGqHte2JmQxndmTk1q8F+LVfwMZV7Et9Wx31YR+7wnL9e
         7WLUTt6ZiukZbKvrj5nsFAwbZ4dEysKvooRPf5FFetq8qnqZEqx9Y+Y8HYZRdvXnPWEN
         px2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965201AbeBUOzD (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 09:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964777AbeBUOzB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 09:55:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C878205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v2 01/17] tracing: probeevent: Fix to support minus offset from symbol
Date: Wed, 21 Feb 2018 23:54:37 +0900
Message-Id: <151922487738.6217.16114601174401123273.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151922484560.6217.1143686155616343906.stgit@devbox>
References: <151922484560.6217.1143686155616343906.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593022783015757505?=
X-GMAIL-MSGID: =?utf-8?q?1593022783015757505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In Documentation/trace/kprobetrace.txt, it says

 @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)

However, the parser doesn't parse minus offset correctly.
This fixes the parser to get minus offset correctly.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    2 +-
 kernel/trace/trace_probe.c  |   10 +++++-----
 kernel/trace/trace_probe.h  |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5ce9b8cf7be3..dab4a5b54269 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -754,7 +754,7 @@ static int create_trace_kprobe(int argc, char **argv)
 		/* a symbol specified */
 		symbol = argv[1];
 		/* TODO: support .init module functions */
-		ret = traceprobe_split_symbol_offset(symbol, &offset);
+		ret = traceprobe_split_symbol_offset(symbol, (long *)&offset);
 		if (ret) {
 			pr_info("Failed to parse either an address or a symbol.\n");
 			return ret;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index d59357308677..3e291a754862 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -320,7 +320,7 @@ static fetch_func_t get_fetch_size_function(const struct fetch_type *type,
 }
 
 /* Split symbol and offset. */
-int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
+int traceprobe_split_symbol_offset(char *symbol, long *offset)
 {
 	char *tmp;
 	int ret;
@@ -328,13 +328,13 @@ int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
 	if (!offset)
 		return -EINVAL;
 
-	tmp = strchr(symbol, '+');
+	tmp = strpbrk(symbol, "+-");
 	if (tmp) {
-		/* skip sign because kstrtoul doesn't accept '+' */
-		ret = kstrtoul(tmp + 1, 0, offset);
+		ret = kstrtoul(tmp + 1, 0, (unsigned long *)offset);
 		if (ret)
 			return ret;
-
+		if (*tmp == '-')
+			*offset = -(*offset);
 		*tmp = '\0';
 	} else
 		*offset = 0;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 0745f895f780..75daff22ccea 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -365,7 +365,7 @@ extern int traceprobe_conflict_field_name(const char *name,
 extern void traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
-extern int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset);
+extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
 
 /* Sum up total data length for dynamic arraies (strings) */
 static nokprobe_inline int

