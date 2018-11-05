Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E63ECDE46
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A7D204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A7D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeKEQzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:55:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:52102 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbeKEQzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:55:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 23:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="105448760"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga001.jf.intel.com with ESMTP; 04 Nov 2018 23:36:52 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf intel-pt: Add more event information to debug log
Date:   Mon,  5 Nov 2018 09:35:04 +0200
Message-Id: <20181105073505.8129-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105073505.8129-1-adrian.hunter@intel.com>
References: <20181105073505.8129-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More event information is useful for debugging, especially MMAP events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-log.c |  5 +++++
 tools/perf/util/intel-pt-decoder/intel-pt-log.h |  1 +
 tools/perf/util/intel-pt.c                      | 16 +++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.c b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
index e02bc7b166a0..5e64da270f97 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
@@ -31,6 +31,11 @@ static FILE *f;
 static char log_name[MAX_LOG_NAME];
 bool intel_pt_enable_logging;
 
+void *intel_pt_log_fp(void)
+{
+	return f;
+}
+
 void intel_pt_log_enable(void)
 {
 	intel_pt_enable_logging = true;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.h b/tools/perf/util/intel-pt-decoder/intel-pt-log.h
index 45b64f93f358..cc084937f701 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.h
@@ -22,6 +22,7 @@
 
 struct intel_pt_pkt;
 
+void *intel_pt_log_fp(void);
 void intel_pt_log_enable(void);
 void intel_pt_log_disable(void);
 void intel_pt_log_set_name(const char *name);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index ffa385a029b3..71339d1d4340 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -206,6 +206,16 @@ static void intel_pt_dump_event(struct intel_pt *pt, unsigned char *buf,
 	intel_pt_dump(pt, buf, len);
 }
 
+static void intel_pt_log_event(union perf_event *event)
+{
+	FILE *f = intel_pt_log_fp();
+
+	if (!intel_pt_enable_logging || !f)
+		return;
+
+	perf_event__fprintf(event, f);
+}
+
 static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *a,
 				   struct auxtrace_buffer *b)
 {
@@ -2004,9 +2014,9 @@ static int intel_pt_process_event(struct perf_session *session,
 		 event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
 		err = intel_pt_context_switch(pt, event, sample);
 
-	intel_pt_log("event %s (%u): cpu %d time %"PRIu64" tsc %#"PRIx64"\n",
-		     perf_event__name(event->header.type), event->header.type,
-		     sample->cpu, sample->time, timestamp);
+	intel_pt_log("event %u: cpu %d time %"PRIu64" tsc %#"PRIx64" ",
+		     event->header.type, sample->cpu, sample->time, timestamp);
+	intel_pt_log_event(event);
 
 	return err;
 }
-- 
2.17.1

