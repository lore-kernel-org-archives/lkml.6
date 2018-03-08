Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuamGvpa4XLTxz1YqNZl9PEDxEFnGHswhHlJVBYBqOUwTYqK1wQdNBmzlhpo3e8rzFFBICt
ARC-Seal: i=1; a=rsa-sha256; t=1520498670; cv=none;
        d=google.com; s=arc-20160816;
        b=z+WKhLvOHX93obzUUqMT3xiMxHEiJBEFc/ryK8ULFrKRz7/C3U20dmanoTSle81aND
         xf0MkrF0XwszYeMtY4ezbDakEFLo+zbukJgPK+/r/LGk3eCKV5aQz2IIp4lU6L+62ggB
         BTM5zLYuwiGwCF2nAW0CWyr3uZs4cjQ7eV5JU1e/1HBtl6jDx3cDkSLRGkUug0yQeYYm
         JM6JJ376GMuL0xdTlkeynKPXBuNbxLOw7anqw5GJASsx94v+82iW7F5cGw2ttXcCeSHn
         pqRc663iB27728c0la2sXMsl/KMhnVr86duiZKPZnTwzBK9aH4jchJYhk7jQ9vdTUv3J
         S0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=sliGKI2MPPEEFbY5Sc7eWDMOQD4FncA2T51tJ1qIG5c=;
        b=0lIm9ma1DSWnaofQQUtI+nc8hHzlH1MBjcqmaZWtgwrJSNl3knbI0KSNFLx+k82vm7
         m/XiprxKwsMxGFGC2SJT0stCCforR8wnk79zvbPSZyJaXX856Ty7WF8DBxL+GoEe4OLZ
         Fu+94M2xuXGkdvZmnQwdVM6Zqql91TqYq6MWC6iL9J6ir/wIgA9eyNg9HekshLyHSyWe
         PQylscSiwpmjwjHsHn7R+BYp6yJo/xJzBKriOCn9XzwH/Z1bVSKf/iVgMFdSmQjgjTK7
         4BMFKu7AmFk4I7Ipnk3OHJRiI12w/RDzmH0pHFsrCjxEnNr18Tlm+u90PHv4cZfgbPtU
         gxeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935527AbeCHIoa (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 03:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935490AbeCHIo3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 03:44:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DD82172D
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
Subject: [PATCH v5 01/19] [BUGFIX] tracing: probeevent: Fix to support minus offset from symbol
Date: Thu,  8 Mar 2018 17:44:05 +0900
Message-Id: <152049864528.7289.5084202890843376447.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152049860385.7289.14079393589900496424.stgit@devbox>
References: <152049860385.7289.14079393589900496424.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358414300063310?=
X-GMAIL-MSGID: =?utf-8?q?1594358414300063310?=
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 Changes in v3:
  - Use kstrtol instead of kstrtoul. (Thanks Namhyung!)
 Changes in v4:
  - Fix to decode sign. (Thanks Namhyung!)
  - Fix to check UINT_MAX for kprobe offset.
---
 kernel/trace/trace_kprobe.c |    4 ++--
 kernel/trace/trace_probe.c  |    8 +++-----
 kernel/trace/trace_probe.h  |    2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5ce9b8cf7be3..1cd3fb4d70f8 100644
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
+		if (ret || offset < 0 || offset > UINT_MAX) {
 			pr_info("Failed to parse either an address or a symbol.\n");
 			return ret;
 		}
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index d59357308677..daf54bda4dc8 100644
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
+		ret = kstrtol(tmp, 0, offset);
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

