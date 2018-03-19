Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuKTlxojYgfomvybZmJLrcjfqjvUqOsKdDCoKHaUkM/G00NpvWXnz2rkTRQa5alOvgQO5bZ
ARC-Seal: i=1; a=rsa-sha256; t=1521483690; cv=none;
        d=google.com; s=arc-20160816;
        b=SmnPOelDaSsbLm5g5z+8vDtyrbqWrNCSVV4xKYHVjoJlRY4qDvJ0/C+mdZDMXAgJl3
         4x90QYBJrkolxYsPVUlUmCQ1UHF0OgP0bIsxKF1H+W4JD/bH7Kl1zKUFDdwgXf7PJSCs
         mu0Sh74KYijzGTvRMa5RKE1MHPo9L4kpggWGb7RnEtnUqiiKIP/rBS3Kj+ojA9r+o8g/
         q5ex4Nw2G3WwjEnzmkT2rU2gPrLyImox1RDOX7dYdpaq809vGgu4dbkPmEWvJ3xdDpRm
         eDPjKp0DYd2fR37EXkB6f0S+e3Io3aWvEOZLigjRm9medhA4Q3ja6n4l5Nt5Olv9j5OK
         zxLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qxKT5sCi2A1YGhLaTUEWOOuCvvBgqDAXDOBB4Bw2qfw=;
        b=EUQNFWJHjwxWfwh5lr5F1aJBglICA56OAcLxLCUcvcEF3MMeaCsHSrm3mEyM3fERo0
         kXd4TZTjGd+aJhL83t7NHg9o7pY7CIoEHlV67dB/8sTcm6GE84t1vaj4dWj6Xslum3iG
         /lU4eMZjL8Xh806QGHte65/9xAWGLD5/dP40pHd9IVMEPDN0zWKgLBwLMcuRt9srfnoF
         GOykRGENH9gE9wxtt+UG3vEs76ydL1V6MLwUha9ia2l+nbcPnvMhohZAdZNsEcYkQxZq
         NbqTS3MmCwrmu7ydIp4U8z6UHOLLzxQ7AauQTH/I1guBQ2YlTw9l/2laQ/Mh8pMo8UKW
         LJJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	David Ahern <dsahern@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Luis=20Claudio=20Gon=C3=A7alves?= <lclaudio@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Wang Nan <wangnan0@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 081/241] perf trace: Handle unpaired raw_syscalls:sys_exit event
Date: Mon, 19 Mar 2018 19:05:46 +0100
Message-Id: <20180319180754.558913944@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391282331727094?=
X-GMAIL-MSGID: =?utf-8?q?1595391282331727094?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>


[ Upstream commit fd2b2975149f5f7099693027cece81b16842964a ]

Which may happen when we start a tracing session and a thread is waiting
for something like "poll" to return, in which case we better print "?"
both for the syscall entry timestamp and for the duration.

E.g.:

Tracing existing mutt session:

  # perf trace -p `pidof mutt`
          ? (     ?   ): mutt/17135  ... [continued]: poll()) = 1
      0.027 ( 0.013 ms): mutt/17135 read(buf: 0x7ffcb3c42cef, count: 1) = 1
      0.047 ( 0.008 ms): mutt/17135 poll(ufds: 0x7ffcb3c42c50, nfds: 1, timeout_msecs: 1000) = 1
      0.059 ( 0.008 ms): mutt/17135 read(buf: 0x7ffcb3c42cef, count: 1) = 1
  <SNIP>

Before it would print a large number because we'd do:

  ttrace->entry_time - trace->base_time

And entry_time would be 0, while base_time would be the timestamp for
the first event 'perf trace' reads, oops.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Claudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-wbcb93ofva2qdjd5ltn5eeqq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-trace.c |   43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -822,12 +822,21 @@ struct syscall {
 	void		    **arg_parm;
 };
 
-static size_t fprintf_duration(unsigned long t, FILE *fp)
+/*
+ * We need to have this 'calculated' boolean because in some cases we really
+ * don't know what is the duration of a syscall, for instance, when we start
+ * a session and some threads are waiting for a syscall to finish, say 'poll',
+ * in which case all we can do is to print "( ? ) for duration and for the
+ * start timestamp.
+ */
+static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
 {
 	double duration = (double)t / NSEC_PER_MSEC;
 	size_t printed = fprintf(fp, "(");
 
-	if (duration >= 1.0)
+	if (!calculated)
+		printed += fprintf(fp, "     ?   ");
+	else if (duration >= 1.0)
 		printed += color_fprintf(fp, PERF_COLOR_RED, "%6.3f ms", duration);
 	else if (duration >= 0.01)
 		printed += color_fprintf(fp, PERF_COLOR_YELLOW, "%6.3f ms", duration);
@@ -1030,13 +1039,27 @@ static bool trace__filter_duration(struc
 	return t < (trace->duration_filter * NSEC_PER_MSEC);
 }
 
-static size_t trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
+static size_t __trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
 {
 	double ts = (double)(tstamp - trace->base_time) / NSEC_PER_MSEC;
 
 	return fprintf(fp, "%10.3f ", ts);
 }
 
+/*
+ * We're handling tstamp=0 as an undefined tstamp, i.e. like when we are
+ * using ttrace->entry_time for a thread that receives a sys_exit without
+ * first having received a sys_enter ("poll" issued before tracing session
+ * starts, lost sys_enter exit due to ring buffer overflow).
+ */
+static size_t trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
+{
+	if (tstamp > 0)
+		return __trace__fprintf_tstamp(trace, tstamp, fp);
+
+	return fprintf(fp, "         ? ");
+}
+
 static bool done = false;
 static bool interrupted = false;
 
@@ -1047,10 +1070,10 @@ static void sig_handler(int sig)
 }
 
 static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thread,
-					u64 duration, u64 tstamp, FILE *fp)
+					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
 {
 	size_t printed = trace__fprintf_tstamp(trace, tstamp, fp);
-	printed += fprintf_duration(duration, fp);
+	printed += fprintf_duration(duration, duration_calculated, fp);
 
 	if (trace->multiple_threads) {
 		if (trace->show_comm)
@@ -1452,7 +1475,7 @@ static int trace__printf_interrupted_ent
 
 	duration = sample->time - ttrace->entry_time;
 
-	printed  = trace__fprintf_entry_head(trace, trace->current, duration, ttrace->entry_time, trace->output);
+	printed  = trace__fprintf_entry_head(trace, trace->current, duration, true, ttrace->entry_time, trace->output);
 	printed += fprintf(trace->output, "%-70s) ...\n", ttrace->entry_str);
 	ttrace->entry_pending = false;
 
@@ -1499,7 +1522,7 @@ static int trace__sys_enter(struct trace
 
 	if (sc->is_exit) {
 		if (!(trace->duration_filter || trace->summary_only || trace->min_stack)) {
-			trace__fprintf_entry_head(trace, thread, 1, ttrace->entry_time, trace->output);
+			trace__fprintf_entry_head(trace, thread, 0, false, ttrace->entry_time, trace->output);
 			fprintf(trace->output, "%-70s)\n", ttrace->entry_str);
 		}
 	} else {
@@ -1547,6 +1570,7 @@ static int trace__sys_exit(struct trace
 {
 	long ret;
 	u64 duration = 0;
+	bool duration_calculated = false;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0;
 	struct syscall *sc = trace__syscall_info(trace, evsel, id);
@@ -1577,6 +1601,7 @@ static int trace__sys_exit(struct trace
 		duration = sample->time - ttrace->entry_time;
 		if (trace__filter_duration(trace, duration))
 			goto out;
+		duration_calculated = true;
 	} else if (trace->duration_filter)
 		goto out;
 
@@ -1592,7 +1617,7 @@ static int trace__sys_exit(struct trace
 	if (trace->summary_only)
 		goto out;
 
-	trace__fprintf_entry_head(trace, thread, duration, ttrace->entry_time, trace->output);
+	trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
 
 	if (ttrace->entry_pending) {
 		fprintf(trace->output, "%-70s", ttrace->entry_str);
@@ -1855,7 +1880,7 @@ static int trace__pgfault(struct trace *
 	thread__find_addr_location(thread, sample->cpumode, MAP__FUNCTION,
 			      sample->ip, &al);
 
-	trace__fprintf_entry_head(trace, thread, 0, sample->time, trace->output);
+	trace__fprintf_entry_head(trace, thread, 0, true, sample->time, trace->output);
 
 	fprintf(trace->output, "%sfault [",
 		evsel->attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
