Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1499ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAEB20657
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAEB20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbeIRS7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:59:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:12531 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbeIRS7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:59:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 06:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="92760316"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by orsmga002.jf.intel.com with ESMTP; 18 Sep 2018 06:26:42 -0700
Subject: Re: [PATCH v5 6/9] perf, tools, script: Make itrace script default to
 all calls
To:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kim.phillips@arm.com, Andi Kleen <ak@linux.intel.com>
References: <20180918123214.26728-1-andi@firstfloor.org>
 <20180918123214.26728-7-andi@firstfloor.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fa942e47-9654-dfa2-7a57-744b5fd3b790@intel.com>
Date:   Tue, 18 Sep 2018 16:24:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918123214.26728-7-andi@firstfloor.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/18 15:32, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> By default perf script for itrace outputs sampled instructions or
> branches. In my experience this is confusing to users because it's
> hard to correlate with real program behavior. The sampling makes
> sense for tools like report that actually sample to reduce
> the run time, but run time is normally not a problem for perf script.
> It's better to give an accurate representation of the program flow.
> 
> Default perf script to output all calls for itrace. That's a much saner
> default. The old behavior can be still requested with
> perf script --itrace=ibxwpe100000
> 
> v2: Fix ETM build failure
> v3: Really fix ETM build failure (Kim Phillips)
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/itrace.txt |  7 ++++---
>  tools/perf/builtin-script.c         |  5 ++++-
>  tools/perf/util/auxtrace.c          | 17 ++++++++++++-----
>  tools/perf/util/auxtrace.h          |  5 ++++-
>  tools/perf/util/cs-etm.c            |  3 ++-
>  tools/perf/util/intel-bts.c         |  3 ++-
>  tools/perf/util/intel-pt.c          |  3 ++-
>  7 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
> index a3abe04c779d..c2182cbabde3 100644
> --- a/tools/perf/Documentation/itrace.txt
> +++ b/tools/perf/Documentation/itrace.txt
> @@ -11,10 +11,11 @@
>  		l	synthesize last branch entries (use with i or x)
>  		s       skip initial number of events
>  
> -	The default is all events i.e. the same as --itrace=ibxwpe
> +	The default is all events i.e. the same as --itrace=ibxwpe,
> +	except for perf script where it is --itrace=ce
>  
> -	In addition, the period (default 100000) for instructions events
> -	can be specified in units of:
> +	In addition, the period (default 100000, except for perf script where it is 1)
> +	for instructions events can be specified in units of:
>  
>  		i	instructions
>  		t	ticks
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 57df6f7cff28..d3a463766e2d 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3112,7 +3112,10 @@ int cmd_script(int argc, const char **argv)
>  	char *rec_script_path = NULL;
>  	char *rep_script_path = NULL;
>  	struct perf_session *session;
> -	struct itrace_synth_opts itrace_synth_opts = { .set = false, };
> +	struct itrace_synth_opts itrace_synth_opts = {
> +		.set = false,
> +		.default_no_sample = true,
> +	};
>  	char *script_path = NULL;
>  	const char **__argv;
>  	int i, j, err = 0;
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index db1511359c5e..2363a41f0e81 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -964,16 +964,23 @@ s64 perf_event__process_auxtrace(struct perf_tool *tool,
>  #define PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ	64
>  #define PERF_ITRACE_MAX_LAST_BRANCH_SZ		1024
>  
> -void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts)
> +void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
> +				    bool no_sample)

Rather than pass no_sample, what about passing the whole of the tool's
options i.e.

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index db1511359c5e..d4db61626a5f 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -964,8 +964,14 @@ s64 perf_event__process_auxtrace(struct perf_tool *tool,
 #define PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ	64
 #define PERF_ITRACE_MAX_LAST_BRANCH_SZ		1024
 
-void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts)
+bool itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
+				    const struct itrace_synth_opts *tool_synth_opts)
 {
+	if (tool_synth_opts && tool_synth_opts->set) {
+		*synth_opts = *tool_synth_opts;
+		return false;
+	}
+
 	synth_opts->instructions = true;
 	synth_opts->branches = true;
 	synth_opts->transactions = true;
@@ -977,6 +983,8 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts)
 	synth_opts->callchain_sz = PERF_ITRACE_DEFAULT_CALLCHAIN_SZ;
 	synth_opts->last_branch_sz = PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ;
 	synth_opts->initial_skip = 0;
+
+	return true;
 }
 
 /*
@@ -1001,7 +1009,7 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 	}
 
 	if (!str) {
-		itrace_synth_opts__set_default(synth_opts);
+		itrace_synth_opts__set_default(synth_opts, NULL);
 		return 0;
 	}
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index a516a891d7ea..172c92a8c596 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -528,7 +528,8 @@ int perf_event__process_auxtrace_error(struct perf_tool *tool,
 				       struct perf_session *session);
 int itrace_parse_synth_opts(const struct option *opt, const char *str,
 			    int unset);
-void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts);
+bool itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
+				    const struct itrace_synth_opts *tool_synth_opts);
 
 size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp);
 void perf_session__auxtrace_error_inc(struct perf_session *session,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2ae640257fdb..45b9a2b9f473 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1429,12 +1429,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		return 0;
 	}
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
-		etm->synth_opts = *session->itrace_synth_opts;
-	} else {
-		itrace_synth_opts__set_default(&etm->synth_opts);
+	if (itrace_synth_opts__set_default(&etm->synth_opts,
+					   session->itrace_synth_opts))
 		etm->synth_opts.callchain = false;
-	}
 
 	err = cs_etm__synth_events(etm, session);
 	if (err)
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 7f0c83b6332b..2d96f4743789 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -907,12 +907,9 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	if (dump_trace)
 		return 0;
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
-		bts->synth_opts = *session->itrace_synth_opts;
-	} else {
-		itrace_synth_opts__set_default(&bts->synth_opts);
-		if (session->itrace_synth_opts)
-			bts->synth_opts.thread_stack =
+	if (itrace_synth_opts__set_default(&bts->synth_opts,
+					   session->itrace_synth_opts)) {
+		bts->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
 	}
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index aec68908d604..b6ac8ac2f4c3 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2551,10 +2551,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		goto err_delete_thread;
 	}
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
-		pt->synth_opts = *session->itrace_synth_opts;
-	} else {
-		itrace_synth_opts__set_default(&pt->synth_opts);
+	if (itrace_synth_opts__set_default(&pt->synth_opts,
+					   session->itrace_synth_opts)) {
 		if (use_browser != -1) {
 			pt->synth_opts.branches = false;
 			pt->synth_opts.callchain = true;
