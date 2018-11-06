Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C64C46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9133D20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TejTZV6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9133D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbeKFVcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbeKFVcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:32:12 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760C720869;
        Tue,  6 Nov 2018 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541506038;
        bh=4ZK4QkXMvFw+XihUH2+zJ3aK6XRECnA2l/5LkHsX4j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TejTZV6wJwe3At1BkI+wnkIPXSSz4W9iTF/G4wclJUkYFa4m+8XI6vAQPo6RchDba
         eAgfLPBsfIunVKhbHEHIkagC6UvwJtKOLbXDNJtKhdgyQ+dFWoHiZTFP7dZbDI9jW0
         s6Go36mQtYcl2V/NiP4nOGcCU9cRz8y/BHXwdnEo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/18] perf intel-pt: Add more event information to debug log
Date:   Tue,  6 Nov 2018 09:06:08 -0300
Message-Id: <20181106120612.8262-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

More event information is useful for debugging, especially MMAP events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/20181105073505.8129-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 86cc9a64e982..149ff361ca78 100644
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
@@ -2010,9 +2020,9 @@ static int intel_pt_process_event(struct perf_session *session,
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
2.14.4

