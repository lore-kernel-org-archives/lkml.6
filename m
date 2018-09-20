Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ED4ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0796021529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0796021529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbeITSqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:46:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:5264 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387730AbeITSqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:46:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 06:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="74829240"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2018 06:02:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/6] perf intel-pt: Add decoder flags for trace begin / end
Date:   Thu, 20 Sep 2018 16:00:47 +0300
Message-Id: <20180920130048.31432-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920130048.31432-1-adrian.hunter@intel.com>
References: <20180920130048.31432-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the decoder would indicate begin / end by a branch from / to
zero. That hides useful information, in particular when a trace ends with a
call. To prepare for remedying that, add Intel PT decoder flags for trace
begin / end and map them to the existing sample flags.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h | 2 ++
 tools/perf/util/intel-pt.c                          | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 51c18d67f4ca..ed088d4726ba 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -37,6 +37,8 @@ enum intel_pt_sample_type {
 	INTEL_PT_EX_STOP	= 1 << 6,
 	INTEL_PT_PWR_EXIT	= 1 << 7,
 	INTEL_PT_CBR_CHG	= 1 << 8,
+	INTEL_PT_TRACE_BEGIN	= 1 << 9,
+	INTEL_PT_TRACE_END	= 1 << 10,
 };
 
 enum intel_pt_period_type {
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index aec68908d604..48c1d415c6b0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -908,6 +908,11 @@ static void intel_pt_sample_flags(struct intel_pt_queue *ptq)
 		ptq->insn_len = ptq->state->insn_len;
 		memcpy(ptq->insn, ptq->state->insn, INTEL_PT_INSN_BUF_SZ);
 	}
+
+	if (ptq->state->type & INTEL_PT_TRACE_BEGIN)
+		ptq->flags |= PERF_IP_FLAG_TRACE_BEGIN;
+	if (ptq->state->type & INTEL_PT_TRACE_END)
+		ptq->flags |= PERF_IP_FLAG_TRACE_END;
 }
 
 static int intel_pt_setup_queue(struct intel_pt *pt,
-- 
2.17.1

