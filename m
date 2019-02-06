Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4118C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D472075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfBFKla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:41:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:23275 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbfBFKl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:41:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 02:41:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="115647659"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.56])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2019 02:41:25 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] perf auxtrace: Define auxtrace record alignment
Date:   Wed,  6 Feb 2019 12:39:43 +0200
Message-Id: <20190206103947.15750-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206103947.15750-1-adrian.hunter@intel.com>
References: <20190206103947.15750-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define auxtrace record alignment so that it can be referenced elsewhere.

Note this is preparation for patch "perf intel-pt: Fix overlap calculation
for padding"

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/util/auxtrace.c | 4 ++--
 tools/perf/util/auxtrace.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 94a22cc8004c..ad186d3255d1 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1279,9 +1279,9 @@ static int __auxtrace_mmap__read(struct perf_mmap *map,
 	}
 
 	/* padding must be written by fn() e.g. record__process_auxtrace() */
-	padding = size & 7;
+	padding = size & (PERF_AUXTRACE_RECORD_ALIGNMENT - 1);
 	if (padding)
-		padding = 8 - padding;
+		padding = PERF_AUXTRACE_RECORD_ALIGNMENT - padding;
 
 	memset(&ev, 0, sizeof(ev));
 	ev.auxtrace.header.type = PERF_RECORD_AUXTRACE;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 8e50f96d4b23..fac32482db61 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -40,6 +40,9 @@ struct record_opts;
 struct auxtrace_info_event;
 struct events_stats;
 
+/* Auxtrace records must have the same alignment as perf event records */
+#define PERF_AUXTRACE_RECORD_ALIGNMENT 8
+
 enum auxtrace_type {
 	PERF_AUXTRACE_UNKNOWN,
 	PERF_AUXTRACE_INTEL_PT,
-- 
2.17.1

