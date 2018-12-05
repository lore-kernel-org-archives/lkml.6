Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7317CC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E27208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025928;
	bh=wzviVInhLYQH15eSplGWyLHAXeJbBUwfr0DMy9ZYL6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NekBZJ0H9zSyI8ROgTbd1x2g+nUmVOEa8UE5edpB/zKq9Xw7GkZmvmO48OomDAPaM
	 0ch0jrHsIrnstgvo02RarsQ8bEKJF2qkbDTaVqlUUL42LexpTlEM7lEkdM90vQ42Xm
	 csWBvU1s1MKvQc30lrcp9oL3PMmhFkZ+1WONxGUc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E27208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeLEQF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:05:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbeLEQFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:05:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1996750CB;
        Wed,  5 Dec 2018 16:05:24 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FFD65C5FD;
        Wed,  5 Dec 2018 16:05:22 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH 4/8] perf trace: Add --block option
Date:   Wed,  5 Dec 2018 17:05:05 +0100
Message-Id: <20181205160509.1168-5-jolsa@kernel.org>
In-Reply-To: <20181205160509.1168-1-jolsa@kernel.org>
References: <20181205160509.1168-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 05 Dec 2018 16:05:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --block option to allow trace command pass along
the --block option for record command or to set it for
trace run session, like:

  # perf trace --block kill
  # perf trace --block -p ...
  # perf trace -e raw_syscalls:sys_enter --block -p ...

It's allowed only for syscall tracepoint events
attached to process.

Link: http://lkml.kernel.org/n/tip-ocz7zwwkkx11v0mkxrtcddih@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-trace.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a57a9ae1fd4b..a663ec346a8e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2379,10 +2379,12 @@ static int trace__record(struct trace *trace, int argc, const char **argv)
 	unsigned int majpf_args_nr = ARRAY_SIZE(majpf_args);
 	const char * const minpf_args[] = { "-e", "minor-faults" };
 	unsigned int minpf_args_nr = ARRAY_SIZE(minpf_args);
+	const char * const block_args[] = { "--block", };
+	unsigned int block_args_nr = ARRAY_SIZE(block_args);
 
 	/* +1 is for the event string below */
 	rec_argc = ARRAY_SIZE(record_args) + sc_args_nr + 1 +
-		majpf_args_nr + minpf_args_nr + argc;
+		majpf_args_nr + minpf_args_nr + block_args_nr + argc;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 
 	if (rec_argv == NULL)
@@ -2416,6 +2418,9 @@ static int trace__record(struct trace *trace, int argc, const char **argv)
 		for (i = 0; i < minpf_args_nr; i++)
 			rec_argv[j++] = minpf_args[i];
 
+	if (trace->opts.block)
+		rec_argv[j++] = block_args[0];
+
 	for (i = 0; i < (unsigned int)argc; i++)
 		rec_argv[j++] = argv[i];
 
@@ -3409,6 +3414,8 @@ int cmd_trace(int argc, const char **argv)
 		     trace__parse_events_option),
 	OPT_BOOLEAN(0, "comm", &trace.show_comm,
 		    "show the thread COMM next to its id"),
+	OPT_BOOLEAN(0, "block", &trace.opts.block,
+		    "Request blocked tracing (for syscall tracepoints)"),
 	OPT_BOOLEAN(0, "tool_stats", &trace.show_tool_stats, "show tool stats"),
 	OPT_CALLBACK(0, "expr", &trace, "expr", "list of syscalls/events to trace",
 		     trace__parse_events_option),
@@ -3500,6 +3507,14 @@ int cmd_trace(int argc, const char **argv)
 				       "cgroup monitoring only available in system-wide mode");
 	}
 
+	if (trace.opts.block) {
+		if (!target__has_task(&trace.opts.target) &&
+		    !target__none(&trace.opts.target)) {
+			pr_err("ERROR: Can't use --block on non task targets\n");
+			goto out;
+		}
+	}
+
 	evsel = bpf__setup_output_event(trace.evlist, "__augmented_syscalls__");
 	if (IS_ERR(evsel)) {
 		bpf__strerror_setup_output_event(trace.evlist, PTR_ERR(evsel), bf, sizeof(bf));
-- 
2.17.2

