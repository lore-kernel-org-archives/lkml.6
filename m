Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF84ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5C0214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGJbAv+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5C0214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbeIXVFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbeIXVFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:05:53 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBF3720C0A;
        Mon, 24 Sep 2018 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801398;
        bh=oaggM3j5SJjdy/ZXhuvePQ3cy4UtzHFlO3U/2gI74hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGJbAv+Z4FZLNCq+0TAskwv5+/ARMcCYnBdzxxlUhoFr/nScBnmHDI3PI9OWaa9gg
         BGu5u0hJpTJBfVB80F1Q3lhp5LZTLlZs+Yv9wDkL6JOCOGUNpoR9DEv4YHJbBu5kth
         XFPmOVpNvvncwoHYa7XfhAZWO2NY3elEvgNNc1QE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/27] perf tools: Report itrace options in help
Date:   Mon, 24 Sep 2018 12:02:17 -0300
Message-Id: <20180924150242.14235-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

I often forget all the options that --itrace accepts. Instead of burying
them in the man page only report them in the normal command line help
too to make them easier accessible.

v2: Align

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/r/20180914031038.4160-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c |  3 ++-
 tools/perf/builtin-report.c |  2 +-
 tools/perf/builtin-script.c |  2 +-
 tools/perf/util/auxtrace.h  | 19 +++++++++++++++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index b4a29f435b06..eda41673c4f3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -798,7 +798,8 @@ int cmd_inject(int argc, const char **argv)
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
index 7507e4d6dce1..c0703979c51d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1104,7 +1104,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
 		     "how to display percentage of filtered entries", parse_filter_percentage),
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
-			    "Instruction Tracing options",
+			    "Instruction Tracing options\n" ITRACE_HELP,
 			    itrace_parse_synth_opts),
 	OPT_BOOLEAN(0, "full-source-path", &srcline_full_filename,
 			"Show full source file name path for source lines"),
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 765391b6c88c..66699dd351e0 100644
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
index a86b7eab6673..0a6ce9c4fc11 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -576,6 +576,23 @@ static inline void auxtrace__free(struct perf_session *session)
 	return session->auxtrace->free(session);
 }
 
+#define ITRACE_HELP \
+"				i:	    		synthesize instructions events\n"		\
+"				b:	    		synthesize branches events\n"		\
+"				c:	    		synthesize branches events (calls only)\n"	\
+"				r:	    		synthesize branches events (returns only)\n" \
+"				x:	    		synthesize transactions events\n"		\
+"				w:	    		synthesize ptwrite events\n"		\
+"				p:	    		synthesize power events\n"			\
+"				e:	    		synthesize error events\n"			\
+"				d:	    		create a debug log\n"			\
+"				g[len]:     		synthesize a call chain (use with i or x)\n" \
+"				l[len]:     		synthesize last branch entries (use with i or x)\n" \
+"				sNUMBER:    		skip initial number of events\n"		\
+"				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
+"				concatenate multiple options. Default is ibxwpe or cewp\n"
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
2.14.4

