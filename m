Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KPbG1PEDeF17Ce6MI8p/riehRB7Rps3x4dP2c27abAWDTJPIBltFoFCv0BS+UEX6yKsJe
ARC-Seal: i=1; a=rsa-sha256; t=1522168690; cv=none;
        d=google.com; s=arc-20160816;
        b=rOA2Di/iBYbbsa+wbm5yQ0pJ2RMm84OfhljntjcxseKWsgx1zGTwkgqXtTIDFxECQQ
         jjJC+nfsgGVbMYIyeaOWvpGaD2Zr2C+QVoUTDuJgqxhiErppAAz0Pl6Ioyy0eQFWgXCJ
         uJbjmSZpttoDrChzEcHKh+g58ugM/nLuVFPhbJ+d15b8PI8Pj+im4xHjT6w6SdFysFQe
         6t6iS3aDLH8+nboFjnivXWUPstVea7WrYm0qgK/TSP7uYHRdk3cUk+igvG8ogs3Hj7FM
         BsKB3+611n2Bt0yX8qdg6jc9FEBrSiTKqq765LX3OBqKRKP5HLKVoeqHJRJmpa+Bsayw
         v8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+pioxM4/uPI5pyDbJ2QwlcfOYW+VlA1zyuHyl8/PhHo=;
        b=c/PBbfMM8cxQMYL/8dDmyxaMadeX1JEJKpx8Oa0VdVYVjv+eG9q8aVmHPkxRErOnxl
         SBUyo0u+uGn3qmsu/jWr5mEcqDDXi3pqetv2hqS0R9/frnkhMl/v9xPRhUx8gvejdXaL
         9jE5vf4YnTYet1SNy2ZvAX4kpzdQcLxNbJS00rYGg7O9t6nY+dvqy6q9UCn8UFk9LbAD
         HXpxhgxKFo8JuQYxDx4EOvl1qI5ZdBUdcDxJdt0eO/caNl+BMauazmQOfvFwilD6ICAF
         CRiifRqUcQ2eNO+uZgbqnZD0XKFCHxGj5rd4j5Mm9GLF82QlK7Qc0+ayLo+dYXUzyRlx
         YxJw==
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
Subject: [PATCH 4.14 064/101] tracing: probeevent: Fix to support minus offset from symbol
Date: Tue, 27 Mar 2018 18:27:36 +0200
Message-Id: <20180327162753.928778968@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109015176163963?=
X-GMAIL-MSGID: =?utf-8?q?1596109556916004909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -354,7 +354,7 @@ extern int traceprobe_conflict_field_nam
 extern void traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
-extern int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset);
+extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
 
 extern ssize_t traceprobe_probes_write(struct file *file,
 		const char __user *buffer, size_t count, loff_t *ppos,
