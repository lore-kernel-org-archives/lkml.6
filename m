Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754510AbeEaKZN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:25:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:26155 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754457AbeEaKZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:25:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="52233041"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] perf intel-pt: Fix "Unexpected indirect branch" error
Date: Thu, 31 May 2018 13:23:45 +0300
Message-Id: <1527762225-26024-5-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527762225-26024-1-git-send-email-adrian.hunter@intel.com>
References: <1527762225-26024-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Atom CPUs can produce FUP packets that contain NLIP (next linear
instruction pointer) instead of CLIP (current linear instruction pointer).
That will result in "Unexpected indirect branch" errors. Fix by comparing
IP to NLIP in that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 17 +++++++++++++++--
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h |  9 +++++++++
 tools/perf/util/intel-pt.c                          |  4 ++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 881d7c5e5e2a..d404bed7003a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -113,6 +113,7 @@ struct intel_pt_decoder {
 	bool have_cyc;
 	bool fixup_last_mtc;
 	bool have_last_ip;
+	enum intel_pt_param_flags flags;
 	uint64_t pos;
 	uint64_t last_ip;
 	uint64_t ip;
@@ -226,6 +227,8 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->return_compression = params->return_compression;
 	decoder->branch_enable      = params->branch_enable;
 
+	decoder->flags              = params->flags;
+
 	decoder->period             = params->period;
 	decoder->period_type        = params->period_type;
 
@@ -1097,6 +1100,15 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
 	return ret;
 }
 
+static inline bool intel_pt_fup_with_nlip(struct intel_pt_decoder *decoder,
+					  struct intel_pt_insn *intel_pt_insn,
+					  uint64_t ip, int err)
+{
+	return decoder->flags & INTEL_PT_FUP_WITH_NLIP && !err &&
+	       intel_pt_insn->branch == INTEL_PT_BR_INDIRECT &&
+	       ip == decoder->ip + intel_pt_insn->length;
+}
+
 static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
 {
 	struct intel_pt_insn intel_pt_insn;
@@ -1109,10 +1121,11 @@ static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
 		err = intel_pt_walk_insn(decoder, &intel_pt_insn, ip);
 		if (err == INTEL_PT_RETURN)
 			return 0;
-		if (err == -EAGAIN) {
+		if (err == -EAGAIN ||
+		    intel_pt_fup_with_nlip(decoder, &intel_pt_insn, ip, err)) {
 			if (intel_pt_fup_event(decoder))
 				return 0;
-			return err;
+			return -EAGAIN;
 		}
 		decoder->set_fup_tx_flags = false;
 		if (err)
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index fc1752d50019..51c18d67f4ca 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -60,6 +60,14 @@ enum {
 	INTEL_PT_ERR_MAX,
 };
 
+enum intel_pt_param_flags {
+	/*
+	 * FUP packet can contain next linear instruction pointer instead of
+	 * current linear instruction pointer.
+	 */
+	INTEL_PT_FUP_WITH_NLIP	= 1 << 0,
+};
+
 struct intel_pt_state {
 	enum intel_pt_sample_type type;
 	int err;
@@ -106,6 +114,7 @@ struct intel_pt_params {
 	unsigned int mtc_period;
 	uint32_t tsc_ctc_ratio_n;
 	uint32_t tsc_ctc_ratio_d;
+	enum intel_pt_param_flags flags;
 };
 
 struct intel_pt_decoder;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 3db7f0ee52a8..aec68908d604 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -749,6 +749,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 						   unsigned int queue_nr)
 {
 	struct intel_pt_params params = { .get_trace = 0, };
+	struct perf_env *env = pt->machine->env;
 	struct intel_pt_queue *ptq;
 
 	ptq = zalloc(sizeof(struct intel_pt_queue));
@@ -830,6 +831,9 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 		}
 	}
 
+	if (env->cpuid && !strncmp(env->cpuid, "GenuineIntel,6,92,", 18))
+		params.flags |= INTEL_PT_FUP_WITH_NLIP;
+
 	ptq->decoder = intel_pt_decoder_new(&params);
 	if (!ptq->decoder)
 		goto out_free;
-- 
1.9.1
