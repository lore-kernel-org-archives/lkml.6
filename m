Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6894C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA512077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA512077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbeHWMSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:18:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732248AbeHWMSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:18:24 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A359C9A;
        Thu, 23 Aug 2018 08:49:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 120/324] perf tools: Fix crash caused by accessing feat_ops[HEADER_LAST_FEATURE]
Date:   Thu, 23 Aug 2018 09:53:06 +0200
Message-Id: <20180823075001.914511008@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

[ Upstream commit 92ead7ee30c80f8852d28735cbcb9d79bc85f715 ]

perf_event__process_feature() accesses feat_ops[HEADER_LAST_FEATURE]
which is not defined and thus perf is crashing. HEADER_LAST_FEATURE is
used as an end marker for the perf report but it's unused for perf
script/annotate. Ignore HEADER_LAST_FEATURE for perf script/annotate,
just like it is done in 'perf report'.

Before:
  # perf record -o - ls | perf script
  <SNIP 'ls' output>
  Segmentation fault (core dumped)
  #

After:
  # perf record -o - ls | perf script
  <SNIP 'ls' output>
  Segmentation fault (core dumped)
  ls 7031 4392.099856:  250000 cpu-clock:uhH:  7f5e0ce7cd60
  ls 7031 4392.100355:  250000 cpu-clock:uhH:  7f5e0c706ef7
  #

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 57b5de463925 ("perf report: Support forced leader feature in pipe mode")
Link: http://lkml.kernel.org/r/20180625124220.6434-4-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-annotate.c |   11 ++++++++++-
 tools/perf/builtin-report.c   |    3 ++-
 tools/perf/builtin-script.c   |   11 ++++++++++-
 tools/perf/util/header.c      |    2 +-
 4 files changed, 23 insertions(+), 4 deletions(-)

--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -283,6 +283,15 @@ out_put:
 	return ret;
 }
 
+static int process_feature_event(struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_session *session)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(tool, event, session);
+	return 0;
+}
+
 static int hist_entry__tty_annotate(struct hist_entry *he,
 				    struct perf_evsel *evsel,
 				    struct perf_annotate *ann)
@@ -471,7 +480,7 @@ int cmd_annotate(int argc, const char **
 			.attr	= perf_event__process_attr,
 			.build_id = perf_event__process_build_id,
 			.tracing_data   = perf_event__process_tracing_data,
-			.feature	= perf_event__process_feature,
+			.feature	= process_feature_event,
 			.ordered_events = true,
 			.ordering_requires_timestamps = true,
 		},
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -226,7 +226,8 @@ static int process_feature_event(struct
 	}
 
 	/*
-	 * All features are received, we can force the
+	 * (feat_id = HEADER_LAST_FEATURE) is the end marker which
+	 * means all features are received, now we can force the
 	 * group if needed.
 	 */
 	setup_forced_leader(rep, session->evlist);
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3042,6 +3042,15 @@ int process_cpu_map_event(struct perf_to
 	return set_maps(script);
 }
 
+static int process_feature_event(struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_session *session)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(tool, event, session);
+	return 0;
+}
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 static int perf_script__process_auxtrace_info(struct perf_tool *tool,
 					      union perf_event *event,
@@ -3086,7 +3095,7 @@ int cmd_script(int argc, const char **ar
 			.attr		 = process_attr,
 			.event_update   = perf_event__process_event_update,
 			.tracing_data	 = perf_event__process_tracing_data,
-			.feature	 = perf_event__process_feature,
+			.feature	 = process_feature_event,
 			.build_id	 = perf_event__process_build_id,
 			.id_index	 = perf_event__process_id_index,
 			.auxtrace_info	 = perf_script__process_auxtrace_info,
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3450,7 +3450,7 @@ int perf_event__process_feature(struct p
 		pr_warning("invalid record type %d in pipe-mode\n", type);
 		return 0;
 	}
-	if (feat == HEADER_RESERVED || feat > HEADER_LAST_FEATURE) {
+	if (feat == HEADER_RESERVED || feat >= HEADER_LAST_FEATURE) {
 		pr_warning("invalid record type %d in pipe-mode\n", type);
 		return -1;
 	}


