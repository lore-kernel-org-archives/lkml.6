Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAD6ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC0C20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4amVDhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC0C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeJYToi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbeJYToh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:44:37 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC59B20848;
        Thu, 25 Oct 2018 11:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465939;
        bh=WbHzXZGJ5tubIv0Ok1KioSH/tQKgHDNtGAJTZwb6uwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4amVDhyFFYwszSFpaNBB3vBSNRh+00JjQGwAesGd6AixsUCEa1La/3vO7pSX5/RV
         qlUYe6vaN13ECpXPJIj+k6uLBhhivZetFwUnz2DU25Nv9caC2n74leWZJ/2i5GQtoA
         ZvXAzm0tp3q6bioqr6Sg8MSqWmwhp9qG1iuAvjXo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/37] perf script: Make itrace script default to all calls
Date:   Thu, 25 Oct 2018 08:10:28 -0300
Message-Id: <20181025111031.3440-35-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

By default 'perf script' for itrace outputs sampled instructions or
branches. In my experience this is confusing to users because it's hard
to correlate with real program behavior. The sampling makes sense for
tools like 'perf report' that actually sample to reduce the run time,
but run time is normally not a problem for 'perf script'.  It's better
to give an accurate representation of the program flow.

Default 'perf script' to output all calls for itrace. That's a much saner
default. The old behavior can be still requested with 'perf script'
--itrace=ibxwpe100000

v2: Fix ETM build failure
v3: Really fix ETM build failure (Kim Phillips)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Link: http://lkml.kernel.org/r/20180920180540.14039-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 411ea175bcaf..6099c722a679 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3131,7 +3131,10 @@ int cmd_script(int argc, const char **argv)
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
index c4617bcfd521..72d5ba2479bf 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -962,16 +962,23 @@ s64 perf_event__process_auxtrace(struct perf_session *session,
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
@@ -999,7 +1006,7 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 	}
 
 	if (!str) {
-		itrace_synth_opts__set_default(synth_opts);
+		itrace_synth_opts__set_default(synth_opts, false);
 		return 0;
 	}
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index d88f6e9eb461..8e50f96d4b23 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -58,6 +58,7 @@ enum itrace_period_type {
 /**
  * struct itrace_synth_opts - AUX area tracing synthesis options.
  * @set: indicates whether or not options have been set
+ * @default_no_sample: Default to no sampling.
  * @inject: indicates the event (not just the sample) must be fully synthesized
  *          because 'perf inject' will write it out
  * @instructions: whether to synthesize 'instructions' events
@@ -82,6 +83,7 @@ enum itrace_period_type {
  */
 struct itrace_synth_opts {
 	bool			set;
+	bool			default_no_sample;
 	bool			inject;
 	bool			instructions;
 	bool			branches;
@@ -528,7 +530,8 @@ int perf_event__process_auxtrace_error(struct perf_session *session,
 				       union perf_event *event);
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
index 48c1d415c6b0..ffa385a029b3 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2559,7 +2559,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
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
2.14.4

