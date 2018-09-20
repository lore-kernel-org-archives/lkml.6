Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD282C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914062152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914062152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbeITSqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:46:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:5248 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387756AbeITSqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:46:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 06:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="74829208"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2018 06:02:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/6] perf script: Enhance sample flags for trace begin / end
Date:   Thu, 20 Sep 2018 16:00:43 +0300
Message-Id: <20180920130048.31432-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920130048.31432-1-adrian.hunter@intel.com>
References: <20180920130048.31432-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow for different combinations of sample flags with "trace begin" or
"trace end".

Previously, the Intel PT decoder would indicate begin / end by a branch
from / to zero. That hides useful information, in particular when a trace
ends with a call. Before remedying that, prepare 'perf script' to display
sample flags with more combinations that include trace begin / end. In
those cases display 'tr start' and 'tr end' separately.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6176bae177c2..4982380ba96d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1255,6 +1255,18 @@ static struct {
 	{0, NULL}
 };
 
+static const char *sample_flags_to_name(u32 flags)
+{
+	int i;
+
+	for (i = 0; sample_flags[i].name ; i++) {
+		if (sample_flags[i].flags == flags)
+			return sample_flags[i].name;
+	}
+
+	return NULL;
+}
+
 static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 {
 	const char *chars = PERF_IP_FLAG_CHARS;
@@ -1264,11 +1276,20 @@ static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 	char str[33];
 	int i, pos = 0;
 
-	for (i = 0; sample_flags[i].name ; i++) {
-		if (sample_flags[i].flags == (flags & ~PERF_IP_FLAG_IN_TX)) {
-			name = sample_flags[i].name;
-			break;
-		}
+	name = sample_flags_to_name(flags & ~PERF_IP_FLAG_IN_TX);
+	if (name)
+		return fprintf(fp, "  %-15s%4s ", name, in_tx ? "(x)" : "");
+
+	if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
+		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_BEGIN));
+		if (name)
+			return fprintf(fp, "  tr strt %-7s%4s ", name, in_tx ? "(x)" : "");
+	}
+
+	if (flags & PERF_IP_FLAG_TRACE_END) {
+		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_END));
+		if (name)
+			return fprintf(fp, "  tr end  %-7s%4s ", name, in_tx ? "(x)" : "");
 	}
 
 	for (i = 0; i < n; i++, flags >>= 1) {
@@ -1281,10 +1302,7 @@ static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 	}
 	str[pos] = 0;
 
-	if (name)
-		return fprintf(fp, "  %-7s%4s ", name, in_tx ? "(x)" : "");
-
-	return fprintf(fp, "  %-11s ", str);
+	return fprintf(fp, "  %-19s ", str);
 }
 
 struct printer_data {
-- 
2.17.1

