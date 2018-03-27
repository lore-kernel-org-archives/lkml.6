Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49JOJk8uioUK+HRQHaYsr03XSUuEBLBP2YYh00g2THHqEn6Q3bCH/7xygcztb471xJPdrhY
ARC-Seal: i=1; a=rsa-sha256; t=1522168894; cv=none;
        d=google.com; s=arc-20160816;
        b=TfTzM+Obf1gCjzmUa6XSbpPIhfnT1qXLLqCsgb+G65j4HLEz6LU9JZlqPmarJh7OoV
         10uy8cWG2vnhv9+qiyq9WkZ6CkUOqX9nKdt7NtL+CaBZsfagikwpDZCx1gZf1lO8eBFQ
         3wZ8hVETau6DsdpjZrnFvC2P9mE0Q4p/p4mBvAKR2h7Q8tRtcLiOgEOXvxgseMnuGrmz
         5HBXer8equBU2AzUq9v2WwuxlEP8HgKsM2jLasYLIIfaWVO3AyiMBNv3LrDNCLy4GENb
         Ka5sA20jx1dvR0BY1S4iZJTSEjeAaDdcjaIp2Y4xwD7Amm+XQ+weLbRG2qEIUjrbQn9/
         Y9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LqSM9g5SgrWN0iiuxooLpy7XfQ9qMLagU11PFVBp2wU=;
        b=xjG9FXpL5tiG1+/+AQjRh3CI6CRHdjX3fp/zC5MJKJ3P5TKLXsihJqoGKRdYv3CZK+
         XefqY/bPm/dGdtE/lhPUE8k4TWLhuVLu+j6hF0gvYJ03YOy7i5CWXlkKHQ5JHtEzTiXU
         Rc1q3kzkTH1eLrzMVb73gaoWUFSGm/FdxKKrbGTvGqaXpNpxV2Ij90ZSN0bUbBnc54jL
         dgUo1JBNhF0t6Fap9OmkOgyX6UDFZIXJ3oojcB43lcCTvF/40Gpjg/hQbwzfMT5dNKio
         tdFlNwHUW2ifo/czgn/NvJQmSiLKAb9q0cp+NYw2mk5+56ZidI1qRdnrY2ifbZ1+Mzsu
         y9JQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.15 069/105] tracing: probeevent: Fix to support minus offset from symbol
Date: Tue, 27 Mar 2018 18:27:49 +0200
Message-Id: <20180327162802.204928236@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109015176163963?=
X-GMAIL-MSGID: =?utf-8?q?1596109770706082246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit c5d343b6b7badd1f5fe0873eff2e8d63a193e732 upstream.

In Documentation/trace/kprobetrace.txt, it says

 @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)

However, the parser doesn't parse minus offset correctly, since
commit 2fba0c8867af ("tracing/kprobes: Fix probe offset to be
unsigned") drops minus ("-") offset support for kprobe probe
address usage.

This fixes the traceprobe_split_symbol_offset() to parse minus
offset again with checking the offset range, and add a minus
offset check in kprobe probe address usage.

Link: http://lkml.kernel.org/r/152129028983.31874.13419301530285775521.stgit@devbox

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 2fba0c8867af ("tracing/kprobes: Fix probe offset to be unsigned")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_kprobe.c |    4 ++--
 kernel/trace/trace_probe.c  |    8 +++-----
 kernel/trace/trace_probe.h  |    2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -635,7 +635,7 @@ static int create_trace_kprobe(int argc,
 	char *symbol = NULL, *event = NULL, *group = NULL;
 	int maxactive = 0;
 	char *arg;
-	unsigned long offset = 0;
+	long offset = 0;
 	void *addr = NULL;
 	char buf[MAX_EVENT_NAME_LEN];
 
@@ -723,7 +723,7 @@ static int create_trace_kprobe(int argc,
 		symbol = argv[1];
 		/* TODO: support .init module functions */
 		ret = traceprobe_split_symbol_offset(symbol, &offset);
-		if (ret) {
+		if (ret || offset < 0 || offset > UINT_MAX) {
 			pr_info("Failed to parse either an address or a symbol.\n");
 			return ret;
 		}
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -320,7 +320,7 @@ static fetch_func_t get_fetch_size_funct
 }
 
 /* Split symbol and offset. */
-int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
+int traceprobe_split_symbol_offset(char *symbol, long *offset)
 {
 	char *tmp;
 	int ret;
@@ -328,13 +328,11 @@ int traceprobe_split_symbol_offset(char
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
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -353,7 +353,7 @@ extern int traceprobe_conflict_field_nam
 extern void traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
-extern int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset);
+extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
 
 /* Sum up total data length for dynamic arraies (strings) */
 static nokprobe_inline int
