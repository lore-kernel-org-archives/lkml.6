Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493l9VuORS8EzKB78yZf+174fBKonUBw+YMiSXK5dZh+sZgbr/bPBgBeiCa1UhzoirHLvRp
ARC-Seal: i=1; a=rsa-sha256; t=1523021167; cv=none;
        d=google.com; s=arc-20160816;
        b=kW2urgT+wjzLQb/TAV4xOEmiSRde7i+Pc9vLMy5PDbjZO237BiYlLKIugP7x1+jFUt
         d+JbzXW828TDiaEvqg7jRni2nhKiydjbyIZKlasrE80il0harbHeq5njN4hyZLNPM/rT
         OGkNhmZ5EcRgMp/aYQ2+lV3WERjjb0ka65WV9Zvqp8GCSkZ4NNRni7rr7GVSYAJWCly8
         te5LUtKkNdSQDaFCOUVE0SZm0snFY2Oqaj9ysOaL1qDDbQ3sq4kGI9UxUDAIWNaLN0Fx
         O+A8WCTsmu8VbzLEhEu4DBOD5BX28oBmDuRZWlEWeQjA0uk3E3xpMCZKM4wLkjsWqpJI
         dvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7E7LhylHanCn+TuHAyaFVloouIUyYViiNh1DccXyndg=;
        b=ZKo0TohAmidVXrLK+HoCxJcU19NHdIJw3s/fNPPAVbQPiSO4tw/ALF6f+0/bLCNFGN
         tTAsWH2jbc5eW7ybK5kFpM7YrHUHt+BxQQYVmWptIt9Yicwst8nBqiwQvGLvvb/hf5Qj
         e1xMVZE1ZQLS77NEIliMU1pyBiX+AdN8cZK8k7g88MpKY+aoE9JkHCKCOrI530h00fjp
         MC6x16e2JYD1VHNWYwqsAh5DjAIKm2FP0f++a7YXnZGAlbd+GPG41qIiL+LMdKrMPXyF
         ec5xNfjzrQY8EhUZN1UjC9o7IUrgJqyvTWrkzyr64wHsDJhUEXmln8sMx4UgDtq4JOsh
         UL9Q==
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
Subject: [PATCH 3.18 14/93] tracing: probeevent: Fix to support minus offset from symbol
Date: Fri,  6 Apr 2018 15:22:43 +0200
Message-Id: <20180406084225.588379342@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003443827229770?=
X-GMAIL-MSGID: =?utf-8?q?1597003443827229770?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -611,7 +611,7 @@ static int create_trace_kprobe(int argc,
 	bool is_return = false, is_delete = false;
 	char *symbol = NULL, *event = NULL, *group = NULL;
 	char *arg;
-	unsigned long offset = 0;
+	long offset = 0;
 	void *addr = NULL;
 	char buf[MAX_EVENT_NAME_LEN];
 
@@ -679,7 +679,7 @@ static int create_trace_kprobe(int argc,
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
@@ -291,7 +291,7 @@ static fetch_func_t get_fetch_size_funct
 }
 
 /* Split symbol and offset. */
-int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
+int traceprobe_split_symbol_offset(char *symbol, long *offset)
 {
 	char *tmp;
 	int ret;
@@ -299,13 +299,11 @@ int traceprobe_split_symbol_offset(char
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
@@ -341,7 +341,7 @@ extern int traceprobe_conflict_field_nam
 extern void traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
-extern int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset);
+extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
 
 extern ssize_t traceprobe_probes_write(struct file *file,
 		const char __user *buffer, size_t count, loff_t *ppos,
