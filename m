Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB349C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD58F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD58F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbeK0TmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:42:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:55558 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbeK0TmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:42:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 00:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="277498615"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2018 00:45:12 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf intel-pt: Fix error with config term pt=0
Date:   Tue, 27 Nov 2018 10:43:36 +0200
Message-Id: <20181127084336.12142-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users should never use 'pt=0', but if they do it may give a meaningless
error:

	$ perf record -e intel_pt/pt=0/u uname
	Error:
	The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
	event (intel_pt/pt=0/u).

Fix that by forcing 'pt=1'.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index db0ba8caf5a2..af25a7824ee0 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -524,10 +524,18 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
 				    struct perf_evsel *evsel)
 {
 	int err;
+	char c;
 
 	if (!evsel)
 		return 0;
 
+	/*
+	 * If supported, force pass-through config term (pt=1) even if user
+	 * sets pt=0, which avoids senseless kernel errors.
+	 */
+	if (perf_pmu__scan_file(intel_pt_pmu, "format/pt", "%c", &c) == 1)
+		evsel->attr.config |= 1;
+
 	err = intel_pt_val_config_term(intel_pt_pmu, "caps/cycle_thresholds",
 				       "cyc_thresh", "caps/psb_cyc",
 				       evsel->attr.config);
-- 
2.17.1

