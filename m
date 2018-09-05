Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B08C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92B820839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAZAxpF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92B820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeIFChJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:08 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BF92083E;
        Wed,  5 Sep 2018 22:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185096;
        bh=eldVP5gMj/MFCmVmOSqTDz+eXaAbDBwW5Z+SehRBtZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAZAxpF7AmrmwRJ+W8e0HkFG5RihMypI1Hd0dpuws06OGPQHuBVYBEVzj84d18Yz2
         HVU/of/r3uDgg42Aq9XTj8Zt4NmxQ819KFvwIsiNS4Y8a7EOpGA+/0Nvi7x1F+E3Ks
         1GAZFAXmSGAasoZiIrvJGLg69qhbUAgYqGaSwj2I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/77] perf trace: Pass augmented args to the arg formatters when available
Date:   Wed,  5 Sep 2018 19:03:24 -0300
Message-Id: <20180905220440.20256-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If the tracepoint payload is bigger than what a syscall expected from
what is in its format file in tracefs, then that will be used as
augmented args, i.e. the expansion of syscall arg pointers, with things
like a filename, structs, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-bsbqx7xi2ot4q9bf570f7tqs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 28 ++++++++++++++++++++++------
 tools/perf/trace/beauty/beauty.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 22ab8e67c760..7deae6c8cb25 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -856,10 +856,12 @@ static struct syscall_fmt *syscall_fmt__find(const char *name)
 /*
  * is_exit: is this "exit" or "exit_group"?
  * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
+ * args_size: sum of the sizes of the syscall arguments, anything after that is augmented stuff: pathname for openat, etc.
  */
 struct syscall {
 	struct event_format *tp_format;
 	int		    nr_args;
+	int		    args_size;
 	bool		    is_exit;
 	bool		    is_open;
 	struct format_field *args;
@@ -1258,10 +1260,12 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 
 static int syscall__set_arg_fmts(struct syscall *sc)
 {
-	struct format_field *field;
+	struct format_field *field, *last_field = NULL;
 	int idx = 0, len;
 
 	for (field = sc->args; field; field = field->next, ++idx) {
+		last_field = field;
+
 		if (sc->fmt && sc->fmt->arg[idx].scnprintf)
 			continue;
 
@@ -1292,6 +1296,9 @@ static int syscall__set_arg_fmts(struct syscall *sc)
 		}
 	}
 
+	if (last_field)
+		sc->args_size = last_field->offset + last_field->size;
+
 	return 0;
 }
 
@@ -1472,14 +1479,18 @@ static size_t syscall__scnprintf_val(struct syscall *sc, char *bf, size_t size,
 }
 
 static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
-				      unsigned char *args, struct trace *trace,
-				      struct thread *thread)
+				      unsigned char *args, void *augmented_args, int augmented_args_size,
+				      struct trace *trace, struct thread *thread)
 {
 	size_t printed = 0;
 	unsigned long val;
 	u8 bit = 1;
 	struct syscall_arg arg = {
 		.args	= args,
+		.augmented = {
+			.size = augmented_args_size,
+			.args = augmented_args,
+		},
 		.idx	= 0,
 		.mask	= 0,
 		.trace  = trace,
@@ -1692,7 +1703,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	printed += scnprintf(msg + printed, trace__entry_str_size - printed, "%s(", sc->name);
 
 	printed += syscall__scnprintf_args(sc, msg + printed, trace__entry_str_size - printed,
-					   args, trace, thread);
+					   args, NULL, 0, trace, thread);
 
 	if (sc->is_exit) {
 		if (!(trace->duration_filter || trace->summary_only || trace->failure_only || trace->min_stack)) {
@@ -1723,7 +1734,8 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
 	struct syscall *sc = trace__syscall_info(trace, evsel, id);
 	char msg[1024];
-	void *args;
+	void *args, *augmented_args = NULL;
+	int augmented_args_size;
 
 	if (sc == NULL)
 		return -1;
@@ -1738,7 +1750,11 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 		goto out_put;
 
 	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
-	syscall__scnprintf_args(sc, msg, sizeof(msg), args, trace, thread);
+	augmented_args_size = sample->raw_size - sc->args_size;
+	if (augmented_args_size > 0)
+		augmented_args = sample->raw_data + sc->args_size;
+
+	syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%s", msg);
 	err = 0;
 out_put:
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 9615af5d412b..6ca044d3d851 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -30,9 +30,34 @@ struct thread;
 
 size_t pid__scnprintf_fd(struct trace *trace, pid_t pid, int fd, char *bf, size_t size);
 
+/**
+ * augmented_arg: extra payload for syscall pointer arguments
+ 
+ * If perf_sample->raw_size is more than what a syscall sys_enter_FOO puts,
+ * then its the arguments contents, so that we can show more than just a
+ * pointer. This will be done initially with eBPF, the start of that is at the
+ * tools/perf/examples/bpf/augmented_syscalls.c example for the openat, but
+ * will eventually be done automagically caching the running kernel tracefs
+ * events data into an eBPF C script, that then gets compiled and its .o file
+ * cached for subsequent use. For char pointers like the ones for 'open' like
+ * syscalls its easy, for the rest we should use DWARF or better, BTF, much
+ * more compact.
+ *
+ * @size: 8 if all we need is an integer, otherwise all of the augmented arg.
+ * @int_arg: will be used for integer like pointer contents, like 'accept's 'upeer_addrlen'
+ * @value: u64 aligned, for structs, pathnames
+ */
+struct augmented_arg {
+	int  size;
+	int  int_arg;
+	u64  value[];
+};
+
 /**
  * @val: value of syscall argument being formatted
  * @args: All the args, use syscall_args__val(arg, nth) to access one
+ * @augmented_args: Extra data that can be collected, for instance, with eBPF for expanding the pathname for open, etc
+ * @augmented_args_size: augmented_args total payload size
  * @thread: tid state (maps, pid, tid, etc)
  * @trace: 'perf trace' internals: all threads, etc
  * @parm: private area, may be an strarray, for instance
@@ -43,6 +68,10 @@ size_t pid__scnprintf_fd(struct trace *trace, pid_t pid, int fd, char *bf, size_
 struct syscall_arg {
 	unsigned long val;
 	unsigned char *args;
+	struct {
+		struct augmented_arg *args;
+		int		     size;
+	} augmented;
 	struct thread *thread;
 	struct trace  *trace;
 	void	      *parm;
-- 
2.14.4

