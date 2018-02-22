Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226fI057psdHgeWnGdOZKjpHUEEWk77eWkBTPTBdq+57db8wYaczk/eXCyTOM5+7KbQ3tpUe
ARC-Seal: i=1; a=rsa-sha256; t=1519285554; cv=none;
        d=google.com; s=arc-20160816;
        b=h7IEsrcm2aJA2rYxaw9/bEcCngBt22K+OZ2oqYnjgamFrCLGfKfPNP9Q+UOkotbsvG
         axbPEX5deCVj2HY0FJKKoHvQz+iZdCYyMvd10q7g5YjKeKy2MwDKcwZNW4lRbUr1T5BF
         UiZxW5rMaB+T5n3FJsgjRYNPDTswb2jKk7INml8/lTTw6Y4w0lhpqnSZu+YK06zM1fiZ
         i/7VF9+cgL3145dvqr5MxPqnjl2uWP99sisAm8iRWj5aL0QaCnCZFzKcF9iD68bVzT6Z
         nm2FhMTst2GZncGCiwu56+rW4iseUXCHe1VfqNDIbtdfwgq7HJm8pVfxvjLc3l/b06gr
         8H8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=d/g6c79dSwrsdHMLWTfctTtQN7CQ9IWpdJSrEC843DI=;
        b=md0v85bQNVtvNv5Iualz1oITSqDcuf7D8mFRMFGa4tJid9GeCrILySunlcyj/Te9/e
         /46LAjF2NvGUsW0Tnhcyk1e0lXKkQ/gsKkMnVKKgYNQytGOCbOHb5xWQeZYXfl0VsSPp
         p1wr9Vwz+i+et7VGW1TQ1TiGGn75q3H/GXPQEPdf1qJzO8oINWQpJMFzL1QuUcjnLQgl
         vGqz+iYf0F4ElslJlGID9+meSYo2LJ9WCIbtOIjy4ua2ImSHstYs/fGZFpicafoqs8tV
         O2/ULK0PXIAak/NWEDeozAtCErh/ER+sKNAxnv35HWgbzuXIG0otX+U7lP/PthBAIdET
         1AEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeBVHp1 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 22 Feb 2018 02:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:57052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752559AbeBVHp0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Feb 2018 02:45:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121B921784
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
Subject: [BUGFIX PATCH v2.1] tracing: probeevent: Fix to support minus offset from symbol
Date: Thu, 22 Feb 2018 16:45:01 +0900
Message-Id: <151928550073.16058.5161938919130863384.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221205341.3fd69b35@gandalf.local.home>
References: <20180221205341.3fd69b35@gandalf.local.home>
In-Reply-To: <20180221205341.3fd69b35@gandalf.local.home>
References: <20180221205341.3fd69b35@gandalf.local.home>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593022783015757505?=
X-GMAIL-MSGID: =?utf-8?q?1593086369486946075?=
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
 Changes in v2.1:
  - Fix to ensure the offset value is less than LONG_MAX.
  - Fail if the offset is minus when traceprobe_split_symbol_offset()
    is used for the probe address.
  - Add Fixes tag.
---
 kernel/trace/trace_kprobe.c |    4 ++--
 kernel/trace/trace_probe.c  |   15 ++++++++++-----
 kernel/trace/trace_probe.h  |    2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

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
index d59357308677..ec3856147fdd 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -320,21 +320,26 @@ static fetch_func_t get_fetch_size_function(const struct fetch_type *type,
 }
 
 /* Split symbol and offset. */
-int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
+int traceprobe_split_symbol_offset(char *symbol, long *offset)
 {
+	unsigned long ul;
 	char *tmp;
 	int ret;
 
 	if (!offset)
 		return -EINVAL;
 
-	tmp = strchr(symbol, '+');
+	tmp = strpbrk(symbol, "+-");
 	if (tmp) {
-		/* skip sign because kstrtoul doesn't accept '+' */
-		ret = kstrtoul(tmp + 1, 0, offset);
+		ret = kstrtoul(tmp + 1, 0, &ul);
 		if (ret)
 			return ret;
-
+		if (ul > LONG_MAX)
+			return -E2BIG;
+		if (*tmp == '-')
+			*offset = -ul;
+		else
+			*offset = ul;
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

