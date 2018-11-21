Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C80C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292572145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292572145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeKUTsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:48:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:7169 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeKUTsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:48:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 01:14:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="110092558"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga001.jf.intel.com with ESMTP; 21 Nov 2018 01:14:33 -0800
Subject: Re: [PATCH 1/4] perf intel-pt: fix potential NULL pointer dereference
 in intel_pt_process_auxtrace_info
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, Julia Lawall <julia.lawall@lip6.fr>
References: <1542786011-18150-1-git-send-email-wen.yang99@zte.com.cn>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1d8f4126-3293-b03e-b059-9b11b35790d1@intel.com>
Date:   Wed, 21 Nov 2018 11:13:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1542786011-18150-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/18 9:40 AM, Wen Yang wrote:
> This patch fixes a possible null pointer dereference in
> intel_pt_process_auxtrace_info, detected by the semantic patch
> deref_null.cocci, with the following warning:
> 
> ./tools/perf/util/intel-pt.c:2579:32-49: ERROR: session -> itrace_synth_opts is NULL but dereferenced.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  tools/perf/util/intel-pt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 149ff36..bac20e8 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -2575,7 +2575,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
>  		pt->synth_opts = *session->itrace_synth_opts;
>  	} else {
> -		itrace_synth_opts__set_default(&pt->synth_opts,
> +		if (session->itrace_synth_opts)
> +			itrace_synth_opts__set_default(&pt->synth_opts,
>  				session->itrace_synth_opts->default_no_sample);
>  		if (use_browser != -1) {
>  			pt->synth_opts.branches = false;
> 

I would prefer to tidy it up more generally, like this:


From: Adrian Hunter <adrian.hunter@intel.com>
Date: Wed, 21 Nov 2018 11:03:04 +0200
Subject: [PATCH] perf auxtrace: Tidy itrace default options setting

Tidy itrace default options setting, reducing duplicated code and making
itrace_synth_opts__set_default() more flexible.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c  | 15 +++++++++++----
 tools/perf/util/auxtrace.h  |  4 ++--
 tools/perf/util/cs-etm.c    |  8 ++------
 tools/perf/util/intel-bts.c | 11 ++++-------
 tools/perf/util/intel-pt.c  |  7 ++-----
 5 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 72d5ba2479bf..d6016fe23c07 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -962,15 +962,20 @@ s64 perf_event__process_auxtrace(struct perf_session *session,
 #define PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ	64
 #define PERF_ITRACE_MAX_LAST_BRANCH_SZ		1024
 
-void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
-				    bool no_sample)
+bool itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
+				    const struct itrace_synth_opts *tool_synth_opts)
 {
+	if (tool_synth_opts && tool_synth_opts->set) {
+		*synth_opts = *tool_synth_opts;
+		return false;
+	}
+
 	synth_opts->branches = true;
 	synth_opts->transactions = true;
 	synth_opts->ptwrites = true;
 	synth_opts->pwr_events = true;
 	synth_opts->errors = true;
-	if (no_sample) {
+	if (tool_synth_opts && tool_synth_opts->default_no_sample) {
 		synth_opts->period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
 		synth_opts->period = 1;
 		synth_opts->calls = true;
@@ -982,6 +987,8 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 	synth_opts->callchain_sz = PERF_ITRACE_DEFAULT_CALLCHAIN_SZ;
 	synth_opts->last_branch_sz = PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ;
 	synth_opts->initial_skip = 0;
+
+	return true;
 }
 
 /*
@@ -1006,7 +1013,7 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 	}
 
 	if (!str) {
-		itrace_synth_opts__set_default(synth_opts, false);
+		itrace_synth_opts__set_default(synth_opts, NULL);
 		return 0;
 	}
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 8e50f96d4b23..74c6d21231ed 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -530,8 +530,8 @@ int perf_event__process_auxtrace_error(struct perf_session *session,
 				       union perf_event *event);
 int itrace_parse_synth_opts(const struct option *opt, const char *str,
 			    int unset);
-void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
-				    bool no_sample);
+bool itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
+				    const struct itrace_synth_opts *tool_synth_opts);
 
 size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp);
 void perf_session__auxtrace_error_inc(struct perf_session *session,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 73430b73570d..a1a20b4f3f82 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1450,13 +1450,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		return 0;
 	}
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
-		etm->synth_opts = *session->itrace_synth_opts;
-	} else {
-		itrace_synth_opts__set_default(&etm->synth_opts,
-				session->itrace_synth_opts->default_no_sample);
+	if (itrace_synth_opts__set_default(&etm->synth_opts,
+					   session->itrace_synth_opts))
 		etm->synth_opts.callchain = false;
-	}
 
 	err = cs_etm__synth_events(etm, session);
 	if (err)
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 7b27d77306c2..197b0599f146 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -914,13 +914,10 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	if (dump_trace)
 		return 0;
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
-		bts->synth_opts = *session->itrace_synth_opts;
-	} else {
-		itrace_synth_opts__set_default(&bts->synth_opts,
-				session->itrace_synth_opts->default_no_sample);
-		if (session->itrace_synth_opts)
-			bts->synth_opts.thread_stack =
+	if (itrace_synth_opts__set_default(&bts->synth_opts,
+					   session->itrace_synth_opts) &&
+	    session->itrace_synth_opts) {
+		bts->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
 	}
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 149ff361ca78..8f4043658e7a 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2572,11 +2572,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		goto err_delete_thread;
 	}
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
-		pt->synth_opts = *session->itrace_synth_opts;
-	} else {
-		itrace_synth_opts__set_default(&pt->synth_opts,
-				session->itrace_synth_opts->default_no_sample);
+	if (itrace_synth_opts__set_default(&pt->synth_opts,
+					   session->itrace_synth_opts)) {
 		if (use_browser != -1) {
 			pt->synth_opts.branches = false;
 			pt->synth_opts.callchain = true;
-- 
2.17.1

