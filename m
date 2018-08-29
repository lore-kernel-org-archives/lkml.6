Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B950CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1D9205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1D9205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeH2VQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:16:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:63250 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbeH2VQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:16:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 10:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="258251948"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2018 10:18:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7770F300E01; Wed, 29 Aug 2018 10:18:36 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 01/10] perf tools: Report itrace options in help
Date:   Wed, 29 Aug 2018 10:18:25 -0700
Message-Id: <20180829171834.6590-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829171834.6590-1-andi@firstfloor.org>
References: <20180829171834.6590-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

I often forget all the options that --itrace accepts. Instead of burying
them in the man page only report them in the normal command line help
too to make them easier accessible.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-inject.c |  3 ++-
 tools/perf/builtin-report.c |  2 +-
 tools/perf/builtin-script.c |  2 +-
 tools/perf/util/auxtrace.h  | 19 +++++++++++++++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a3b346359ba0..b649a0511ed8 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -803,7 +803,8 @@ int cmd_inject(int argc, const char **argv)
 			   "kallsyms pathname"),
 		OPT_BOOLEAN('f', "force", &data.force, "don't complain, do it"),
 		OPT_CALLBACK_OPTARG(0, "itrace", &inject.itrace_synth_opts,
-				    NULL, "opts", "Instruction Tracing options",
+				    NULL, "opts", "Instruction Tracing options\n"
+				    ITRACE_HELP,
 				    itrace_parse_synth_opts),
 		OPT_BOOLEAN(0, "strip", &inject.strip,
 			    "strip non-synthesized events (use with --itrace)"),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 02f7a3c27761..d48ea050e95e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1105,7 +1105,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
 		     "how to display percentage of filtered entries", parse_filter_percentage),
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
-			    "Instruction Tracing options",
+			    "Instruction Tracing options\n" ITRACE_HELP,
 			    itrace_parse_synth_opts),
 	OPT_BOOLEAN(0, "full-source-path", &srcline_full_filename,
 			"Show full source file name path for source lines"),
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 568ddfac3213..910e0f1f2876 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3193,7 +3193,7 @@ int cmd_script(int argc, const char **argv)
 	OPT_BOOLEAN(0, "ns", &nanosecs,
 		    "Use 9 decimal places when displaying time"),
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
-			    "Instruction Tracing options",
+			    "Instruction Tracing options\n" ITRACE_HELP,
 			    itrace_parse_synth_opts),
 	OPT_BOOLEAN(0, "full-source-path", &srcline_full_filename,
 			"Show full source file name path for source lines"),
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e731f55da072..f3f7ad6ae202 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -576,6 +576,23 @@ static inline void auxtrace__free(struct perf_session *session)
 	return session->auxtrace->free(session);
 }
 
+#define ITRACE_HELP \
+"		i	    synthesize instructions events\n"		\
+"		b	    synthesize branches events\n"		\
+"		c	    synthesize branches events (calls only)\n"	\
+"		r	    synthesize branches events (returns only)\n" \
+"		x	    synthesize transactions events\n"		\
+"		w	    synthesize ptwrite events\n"		\
+"		p	    synthesize power events\n"			\
+"		e	    synthesize error events\n"			\
+"		d	    create a debug log\n"			\
+"		g[len]       synthesize a call chain (use with i or x)\n" \
+"		l[len]       synthesize last branch entries (use with i or x)\n" \
+"		sNUMBER      skip initial number of events\n"		\
+"		PERIOD[ns|us|ms|i|t]   specify period to sample stream\n" \
+"		concatenate multiple options. Default is ibxwpe\n"
+
+
 #else
 
 static inline struct auxtrace_record *
@@ -716,6 +733,8 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 				   struct perf_evlist *evlist, int idx,
 				   bool per_cpu);
 
+#define ITRACE_HELP ""
+
 #endif
 
 #endif
-- 
2.17.1

