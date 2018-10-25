Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B98ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FAD2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="foA1NeT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FAD2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeJYTna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeJYTn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:29 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55162075D;
        Thu, 25 Oct 2018 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465871;
        bh=T8+wDm897shX7Hu/vc//IxlIl4ZzspOsoKsJXtRS8G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=foA1NeT9RE3aCyJmGzQRBd9J/YszICjCw4uRQ1cOmtwnmAODIuhiEr/Eox3PfH3lF
         6MTqVy7Dgzfe8zIkHdY2YYyqxxvH63kohnSdEd6epwuXiUV76JIBZbhXiu0jMq5yP7
         q1xmVIN61wnStxSVFDJWdZhBK1qksjvQ5II0BeGU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 08/37] perf evsel: Introduce per event max_events property
Date:   Thu, 25 Oct 2018 08:10:02 -0300
Message-Id: <20181025111031.3440-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This simply adds the field to 'struct perf_evsel' and allows setting
it via the event parser, to test it lets trace trace:

First look at where in a function that receives an evsel we can put a probe
to read how evsel->max_events was setup:

  # perf probe -x ~/bin/perf -L trace__event_handler
  <trace__event_handler@/home/acme/git/perf/tools/perf/builtin-trace.c:0>
        0  static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
                                          union perf_event *event __maybe_unused,
                                          struct perf_sample *sample)
        3  {
        4         struct thread *thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
        5         int callchain_ret = 0;

        7         if (sample->callchain) {
        8                 callchain_ret = trace__resolve_callchain(trace, evsel, sample, &callchain_cursor);
        9                 if (callchain_ret == 0) {
       10                         if (callchain_cursor.nr < trace->min_stack)
       11                                 goto out;
       12                         callchain_ret = 1;
                          }
                  }

See what variables we can probe at line 7:

  # perf probe -x ~/bin/perf -V trace__event_handler:7
  Available variables at trace__event_handler:7
          @<trace__event_handler+89>
                  int     callchain_ret
                  struct perf_evsel*      evsel
                  struct perf_sample*     sample
                  struct thread*  thread
                  struct trace*   trace
                  union perf_event*       event

Add a probe at that line asking for evsel->max_events to be collected and named
as "max_events":

  # perf probe -x ~/bin/perf trace__event_handler:7 'max_events=evsel->max_events'
  Added new event:
    probe_perf:trace__event_handler (on trace__event_handler:7 in /home/acme/bin/perf with max_events=evsel->max_events)

  You can now use it in all perf tools, such as:

  	perf record -e probe_perf:trace__event_handler -aR sleep 1

Now use 'perf trace', here aliased to just 'trace' and trace trace, i.e.
the first 'trace' is tracing just that 'probe_perf:trace__event_handler' event,
while the traced trace is tracing all scheduler tracepoints, will stop at two
events (--max-events 2) and will just set evsel->max_events for all the sched
tracepoints to 9, we will see the output of both traces intermixed:

  # trace -e *perf:*event_handler trace --max-events 2 -e sched:*/nr=9/
       0.000 :0/0 sched:sched_waking:comm=rcu_sched pid=10 prio=120 target_cpu=000
       0.009 :0/0 sched:sched_wakeup:comm=rcu_sched pid=10 prio=120 target_cpu=000
       0.000 trace/23949 probe_perf:trace__event_handler:(48c34a) max_events=0x9
       0.046 trace/23949 probe_perf:trace__event_handler:(48c34a) max_events=0x9
  #

Now, if the traced trace sends its output to /dev/null, we'll see just
what the first level trace outputs: that evsel->max_events is indeed
being set to 9:

  # trace -e *perf:*event_handler trace -o /dev/null --max-events 2 -e sched:*/nr=9/
       0.000 trace/23961 probe_perf:trace__event_handler:(48c34a) max_events=0x9
       0.030 trace/23961 probe_perf:trace__event_handler:(48c34a) max_events=0x9
  #

Now that we can set evsel->max_events, we can go to the next step, honour that
per-event property in 'perf trace'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-og00yasj276joem6e14l1eas@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c        | 4 ++++
 tools/perf/util/evsel.h        | 3 +++
 tools/perf/util/parse-events.c | 8 ++++++++
 tools/perf/util/parse-events.h | 1 +
 tools/perf/util/parse-events.l | 1 +
 5 files changed, 17 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 29d7b97f66fb..7e95ec1c19a8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -232,6 +232,7 @@ void perf_evsel__init(struct perf_evsel *evsel,
 	evsel->leader	   = evsel;
 	evsel->unit	   = "";
 	evsel->scale	   = 1.0;
+	evsel->max_events  = ULONG_MAX;
 	evsel->evlist	   = NULL;
 	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->node);
@@ -793,6 +794,9 @@ static void apply_config_terms(struct perf_evsel *evsel,
 		case PERF_EVSEL__CONFIG_TERM_MAX_STACK:
 			max_stack = term->val.max_stack;
 			break;
+		case PERF_EVSEL__CONFIG_TERM_MAX_EVENTS:
+			evsel->max_events = term->val.max_events;
+			break;
 		case PERF_EVSEL__CONFIG_TERM_INHERIT:
 			/*
 			 * attr->inherit should has already been set by
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4107c39f4a54..ad5d615c6db6 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -46,6 +46,7 @@ enum term_type {
 	PERF_EVSEL__CONFIG_TERM_STACK_USER,
 	PERF_EVSEL__CONFIG_TERM_INHERIT,
 	PERF_EVSEL__CONFIG_TERM_MAX_STACK,
+	PERF_EVSEL__CONFIG_TERM_MAX_EVENTS,
 	PERF_EVSEL__CONFIG_TERM_OVERWRITE,
 	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
 	PERF_EVSEL__CONFIG_TERM_BRANCH,
@@ -65,6 +66,7 @@ struct perf_evsel_config_term {
 		bool	inherit;
 		bool	overwrite;
 		char	*branch;
+		unsigned long max_events;
 	} val;
 	bool weak;
 };
@@ -99,6 +101,7 @@ struct perf_evsel {
 	struct perf_counts	*prev_raw_counts;
 	int			idx;
 	u32			ids;
+	unsigned long		max_events;
 	char			*name;
 	double			scale;
 	const char		*unit;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f8cd3e7c9186..59be3466d64d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -926,6 +926,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_NOINHERIT]		= "no-inherit",
 	[PARSE_EVENTS__TERM_TYPE_INHERIT]		= "inherit",
 	[PARSE_EVENTS__TERM_TYPE_MAX_STACK]		= "max-stack",
+	[PARSE_EVENTS__TERM_TYPE_MAX_EVENTS]		= "nr",
 	[PARSE_EVENTS__TERM_TYPE_OVERWRITE]		= "overwrite",
 	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
 	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
@@ -1037,6 +1038,9 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
 		CHECK_TYPE_VAL(NUM);
 		break;
+	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
+		CHECK_TYPE_VAL(NUM);
+		break;
 	default:
 		err->str = strdup("unknown term");
 		err->idx = term->err_term;
@@ -1084,6 +1088,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_INHERIT:
 	case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
 	case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
+	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
 		return config_term_common(attr, term, err);
@@ -1162,6 +1167,9 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
 			ADD_CONFIG_TERM(MAX_STACK, max_stack, term->val.num);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
+			ADD_CONFIG_TERM(MAX_EVENTS, max_events, term->val.num);
+			break;
 		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 1 : 0);
 			break;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 4473dac27aee..5ed035cbcbb7 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -71,6 +71,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_NOINHERIT,
 	PARSE_EVENTS__TERM_TYPE_INHERIT,
 	PARSE_EVENTS__TERM_TYPE_MAX_STACK,
+	PARSE_EVENTS__TERM_TYPE_MAX_EVENTS,
 	PARSE_EVENTS__TERM_TYPE_NOOVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_OVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 5f761f3ed0f3..7805c71aaae2 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -269,6 +269,7 @@ time			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_TIME); }
 call-graph		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CALLGRAPH); }
 stack-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_STACKSIZE); }
 max-stack		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_MAX_STACK); }
+nr			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_MAX_EVENTS); }
 inherit			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_INHERIT); }
 no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
 overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
-- 
2.14.4

