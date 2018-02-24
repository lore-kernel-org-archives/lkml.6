Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226Lm+Vcbd8MBL7L/xah7dw0r9edLiITSzlBBgx+K/ZE2t4O8UIwNKSDUJ8liGxph68UZm5q
ARC-Seal: i=1; a=rsa-sha256; t=1519450158; cv=none;
        d=google.com; s=arc-20160816;
        b=WVm7olJSssy1iHpwSRSYmAyYzujdWuXyqBe6r6OKU/6BkwBzzIg5u3vogBChOOgLBb
         Dwki/8bEdZxuPPtUvwLykZ9HLTe1dsKA6CyWd8QC8jbRNBr9V5WvD2Eh3TIna0saVxfs
         kDc6WhZChBqCLn1pEozBJLo8wGt6nJscaCBniWdww5c6B+VkEsg2CeUdIHxELys1pAxw
         JYh0OtG1ECIOvcJBisdM2bP4irFykJBt6hmJ9T4CQ/mQ1mE5NNxhXqIvuH9+F8STXwva
         1Fm2n6OizumetTktHt0yEeNU9DxtO078gRBI7bdxqugHSYQi5/V7ChKK6SXcdoUPReAn
         DOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=Yqr6xnd6l96F1v4ggXENuFUO2Ugahk64Xkz7wR/31Ew=;
        b=0zhqqXHxjMACTzM5GBbaOwWNlY/EKFlrA+LNAL5eJmEp/gd2ma+gxEDxr0DyZNgX+T
         v+PPNLytCOXPaqzGRXQpQhudsH/xrVNdjBy2RQEbQ0D3KWhb7+qMZZfDoPNM8kIzT7ZO
         xwxzYEcqH5w9YqAnLV/Sd4+dTEhMd6dlQx+s2opbCClvQ43/hpj+shJ0IGAsR/XBNWgx
         bqzfCbl//zbOSGArm1YLQajMFJoAD9w1m6DKNFDWzH7Lr8eGW4tD5vzxibQO0DCrAXlH
         NnMyXeEe0LtVqZQdwhKmXg2hZlqz1k4CMGycaRSQmKN3sKxZVjImp5Fu1JHoG+2hdFar
         tkJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeBXF3R (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 24 Feb 2018 00:29:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeBXF3R (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Feb 2018 00:29:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06DD21741
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
Subject: [PATCH v3 01/18] [BUGFIX] tracing: probeevent: Fix to support minus offset from symbol
Date: Sat, 24 Feb 2018 14:28:52 +0900
Message-Id: <151945013281.27508.4068021929757474274.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151945010287.27508.6226184958678620828.stgit@devbox>
References: <151945010287.27508.6226184958678620828.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593258969628938667?=
X-GMAIL-MSGID: =?utf-8?q?1593258969628938667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In Documentation/trace/kprobetrace.txt, it says

 @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)

However, the parser doesn't parse minus offset correctly, since
commit 2fba0c8867af ("tracing/kprobes: Fix probe offset to be
unsigned") drops minus ("-") offset support for kprobe probe
address usage.

This fixes the traceprobe_split_symbol_offset() to parse minus
offset again with checking the offset range, and add a minus
offset check in kprobe probe address usage.

Fixes: 2fba0c8867af ("tracing/kprobes: Fix probe offset to be unsigned")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Use kstrtol instead of kstrtoul. (Thanks Namhyung!)
---
 kernel/trace/trace_kprobe.c |    4 ++--
 kernel/trace/trace_probe.c  |    8 +++-----
 kernel/trace/trace_probe.h  |    2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5ce9b8cf7be3..b5b1d8aa47d6 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -667,7 +667,7 @@ static int create_trace_kprobe(int argc, char **argv)
 	char *symbol = NULL, *event = NULL, *group = NULL;
 	int maxactive = 0;
 	char *arg;
-	unsigned long offset = 0;
+	long offset = 0;
 	void *addr = NULL;
 	char buf[MAX_EVENT_NAME_LEN];
 
@@ -755,7 +755,7 @@ static int create_trace_kprobe(int argc, char **argv)
 		symbol = argv[1];
 		/* TODO: support .init module functions */
 		ret = traceprobe_split_symbol_offset(symbol, &offset);
-		if (ret) {
+		if (ret || offset < 0) {
 			pr_info("Failed to parse either an address or a symbol.\n");
 			return ret;
 		}
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index d59357308677..d3d1ee820336 100644
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
@@ -328,13 +328,11 @@ int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
 	if (!offset)
 		return -EINVAL;
 
-	tmp = strchr(symbol, '+');
+	tmp = strpbrk(symbol, "+-");
 	if (tmp) {
-		/* skip sign because kstrtoul doesn't accept '+' */
-		ret = kstrtoul(tmp + 1, 0, offset);
+		ret = kstrtol(tmp + 1, 0, offset);
 		if (ret)
 			return ret;
-
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

