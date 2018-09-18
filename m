Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7ECC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FE4214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FE4214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeIRSE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:04:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:17588 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbeIRSE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:04:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 05:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="73947670"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 18 Sep 2018 05:32:32 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 683B0301A71; Tue, 18 Sep 2018 05:32:31 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, kim.phillips@arm.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 6/9] perf, tools, script: Make itrace script default to all calls
Date:   Tue, 18 Sep 2018 05:32:11 -0700
Message-Id: <20180918123214.26728-7-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918123214.26728-1-andi@firstfloor.org>
References: <20180918123214.26728-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

By default perf script for itrace outputs sampled instructions or
branches. In my experience this is confusing to users because it's
hard to correlate with real program behavior. The sampling makes
sense for tools like report that actually sample to reduce
the run time, but run time is normally not a problem for perf script.
It's better to give an accurate representation of the program flow.

Default perf script to output all calls for itrace. That's a much saner
default. The old behavior can be still requested with
perf script --itrace=ibxwpe100000

v2: Fix ETM build failure
v3: Really fix ETM build failure (Kim Phillips)
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/itrace.txt |  7 ++++---
 tools/perf/builtin-script.c         |  5 ++++-
 tools/perf/util/auxtrace.c          | 17 ++++++++++++-----
 tools/perf/util/auxtrace.h          |  5 ++++-
 tools/perf/util/cs-etm.c            |  3 ++-
 tools/perf/util/intel-bts.c         |  3 ++-
 tools/perf/util/intel-pt.c          |  3 ++-
 7 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index a3abe04c779d..c2182cbabde3 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -11,10 +11,11 @@
 		l	synthesize last branch entries (use with i or x)
 		s       skip initial number of events
 
-	The default is all events i.e. the same as --itrace=ibxwpe
+	The default is all events i.e. the same as --itrace=ibxwpe,
+	except for perf script where it is --itrace=ce
 
-	In addition, the period (default 100000) for instructions events
-	can be specified in units of:
+	In addition, the period (default 100000, except for perf script where it is 1)
+	for instructions events can be specified in units of:
 
 		i	instructions
 		t	ticks
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 57df6f7cff28..d3a463766e2d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3112,7 +3112,10 @@ int cmd_script(int argc, const char **argv)
 	char *rec_script_path = NULL;
 	char *rep_script_path = NULL;
 	struct perf_session *session;
-	struct itrace_synth_opts itrace_synth_opts = { .set = false, };
+	struct itrace_synth_opts itrace_synth_opts = {
+		.set = false,
+		.default_no_sample = true,
+	};
 	char *script_path = NULL;
 	const char **__argv;
 	int i, j, err = 0;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index db1511359c5e..2363a41f0e81 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -964,16 +964,23 @@ s64 perf_event__process_auxtrace(struct perf_tool *tool,
 #define PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ	64
 #define PERF_ITRACE_MAX_LAST_BRANCH_SZ		1024
 
-void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts)
+void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
+				    bool no_sample)
 {
-	synth_opts->instructions = true;
 	synth_opts->branches = true;
 	synth_opts->transactions = true;
 	synth_opts->ptwrites = true;
 	synth_opts->pwr_events = true;
 	synth_opts->errors = true;
-	synth_opts->period_type = PERF_ITRACE_DEFAULT_PERIOD_TYPE;
-	synth_opts->period = PERF_ITRACE_DEFAULT_PERIOD;
+	if (no_sample) {
+		synth_opts->period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
+		synth_opts->period = 1;
+		synth_opts->calls = true;
+	} else {
+		synth_opts->instructions = true;
+		synth_opts->period_type = PERF_ITRACE_DEFAULT_PERIOD_TYPE;
+		synth_opts->period = PERF_ITRACE_DEFAULT_PERIOD;
+	}
 	synth_opts->callchain_sz = PERF_ITRACE_DEFAULT_CALLCHAIN_SZ;
 	synth_opts->last_branch_sz = PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ;
 	synth_opts->initial_skip = 0;
@@ -1001,7 +1008,7 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 	}
 
 	if (!str) {
-		itrace_synth_opts__set_default(synth_opts);
+		itrace_synth_opts__set_default(synth_opts, false);
 		return 0;
 	}
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index a516a891d7ea..ff611cc6fd75 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -56,6 +56,7 @@ enum itrace_period_type {
 /**
  * struct itrace_synth_opts - AUX area tracing synthesis options.
  * @set: indicates whether or not options have been set
+ * @default_no_sample: Default to no sampling.
  * @inject: indicates the event (not just the sample) must be fully synthesized
  *          because 'perf inject' will write it out
  * @instructions: whether to synthesize 'instructions' events
@@ -80,6 +81,7 @@ enum itrace_period_type {
  */
 struct itrace_synth_opts {
 	bool			set;
+	bool			default_no_sample;
 	bool			inject;
 	bool			instructions;
 	bool			branches;
@@ -528,7 +530,8 @@ int perf_event__process_auxtrace_error(struct perf_tool *tool,
 				       struct perf_session *session);
 int itrace_parse_synth_opts(const struct option *opt, const char *str,
 			    int unset);
-void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts);
+void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
+				    bool no_sample);
 
 size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp);
 void perf_session__auxtrace_error_inc(struct perf_session *session,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2ae640257fdb..3b37d66dc533 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1432,7 +1432,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
 		etm->synth_opts = *session->itrace_synth_opts;
 	} else {
-		itrace_synth_opts__set_default(&etm->synth_opts);
+		itrace_synth_opts__set_default(&etm->synth_opts,
+				session->itrace_synth_opts->default_no_sample);
 		etm->synth_opts.callchain = false;
 	}
 
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 7f0c83b6332b..3b3a3d55dca1 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -910,7 +910,8 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
 		bts->synth_opts = *session->itrace_synth_opts;
 	} else {
-		itrace_synth_opts__set_default(&bts->synth_opts);
+		itrace_synth_opts__set_default(&bts->synth_opts,
+				session->itrace_synth_opts->default_no_sample);
 		if (session->itrace_synth_opts)
 			bts->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index aec68908d604..c6c934c8f615 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2554,7 +2554,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
 		pt->synth_opts = *session->itrace_synth_opts;
 	} else {
-		itrace_synth_opts__set_default(&pt->synth_opts);
+		itrace_synth_opts__set_default(&pt->synth_opts,
+				session->itrace_synth_opts->default_no_sample);
 		if (use_browser != -1) {
 			pt->synth_opts.branches = false;
 			pt->synth_opts.callchain = true;
-- 
2.17.1

