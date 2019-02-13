Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4739CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B5B222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404007AbfBMLsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:48:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:61125 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403993AbfBMLr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:47:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 03:47:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="146480032"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2019 03:47:54 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v0 2/2] perf record: Add --aux-highorder
Date:   Wed, 13 Feb 2019 13:47:16 +0200
Message-Id: <20190213114716.63972-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213114716.63972-1-alexander.shishkin@linux.intel.com>
References: <20190213114716.63972-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow requesting high-order AUX allocations from the perf record command
line. Since this operation requires CAP_SYS_ADMIN, adjust the error message
to suggest this as a potential reason of failure.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 3 ++-
 tools/perf/builtin-record.c           | 2 ++
 tools/perf/perf.h                     | 1 +
 tools/perf/util/evsel.c               | 9 +++++++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..04726b5729c8 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -374,7 +374,8 @@ struct perf_event_attr {
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
-				__reserved_1   : 33;
+				aux_highorder  :  1, /* use high order allocations for AUX data */
+				__reserved_1   : 32;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3fdfbaebd95e..9f8d5eba24a8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1929,6 +1929,8 @@ static struct option __record_options[] = {
 	parse_clockid),
 	OPT_STRING_OPTARG('S', "snapshot", &record.opts.auxtrace_snapshot_opts,
 			  "opts", "AUX area tracing Snapshot Mode", ""),
+	OPT_BOOLEAN(0, "aux-highorder", &record.opts.aux_highorder,
+		    "Use high-order allocation for AUX buffers"),
 	OPT_UINTEGER(0, "proc-map-timeout", &proc_map_timeout,
 			"per thread proc mmap processing timeout in ms"),
 	OPT_BOOLEAN(0, "namespaces", &record.opts.record_namespaces,
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index b120e547ddc7..42f1fa5faeed 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -67,6 +67,7 @@ struct record_opts {
 	bool	     strict_freq;
 	bool	     sample_id;
 	bool	     bpf_event;
+	bool	     aux_highorder;
 	unsigned int freq;
 	unsigned int mmap_pages;
 	unsigned int auxtrace_mmap_pages;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 684c893ca6bc..3f4dc8f79d2f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1098,6 +1098,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	if (evsel->own_cpus || evsel->unit)
 		evsel->attr.read_format |= PERF_FORMAT_ID;
 
+	if (opts->aux_highorder)
+		attr->aux_highorder = 1;
+
 	/*
 	 * Apply event specific term settings,
 	 * it overloads any global configuration.
@@ -1657,6 +1660,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(namespaces, p_unsigned);
 	PRINT_ATTRf(ksymbol, p_unsigned);
 	PRINT_ATTRf(bpf_event, p_unsigned);
+	PRINT_ATTRf(aux_highorder, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
@@ -2891,6 +2895,11 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 				"No permission to enable %s event.\n\n",
 				perf_evsel__name(evsel));
 
+		if (evsel->attr.aux_highorder)
+			printed += scnprintf(msg + printed, size - printed,
+					     "Using --aux-highorder may not be possible with your privilege level,\n"
+					     "which requires CAP_SYS_ADMIN capability. Consider using sudo.\n\n");
+
 		return scnprintf(msg + printed, size - printed,
 		 "You may not have permission to collect %sstats.\n\n"
 		 "Consider tweaking /proc/sys/kernel/perf_event_paranoid,\n"
-- 
2.20.1

