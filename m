Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C51C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6E524079
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6E524079
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965800AbeGAQ3C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:29:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933823AbeGAQ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:28:57 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 64F8EAD8;
        Sun,  1 Jul 2018 16:28:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 079/101] perf intel-pt: Fix "Unexpected indirect branch" error
Date:   Sun,  1 Jul 2018 18:22:05 +0200
Message-Id: <20180701160800.332053955@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 9fb523363f6e3984457fee95bb7019395384ffa7 upstream.

Some Atom CPUs can produce FUP packets that contain NLIP (next linear
instruction pointer) instead of CLIP (current linear instruction
pointer).  That will result in "Unexpected indirect branch" errors. Fix
by comparing IP to NLIP in that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1527762225-26024-5-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   17 +++++++++++++++--
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h |    9 +++++++++
 tools/perf/util/intel-pt.c                          |    4 ++++
 3 files changed, 28 insertions(+), 2 deletions(-)

--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -112,6 +112,7 @@ struct intel_pt_decoder {
 	bool have_cyc;
 	bool fixup_last_mtc;
 	bool have_last_ip;
+	enum intel_pt_param_flags flags;
 	uint64_t pos;
 	uint64_t last_ip;
 	uint64_t ip;
@@ -215,6 +216,8 @@ struct intel_pt_decoder *intel_pt_decode
 	decoder->data               = params->data;
 	decoder->return_compression = params->return_compression;
 
+	decoder->flags              = params->flags;
+
 	decoder->period             = params->period;
 	decoder->period_type        = params->period_type;
 
@@ -1012,6 +1015,15 @@ out_no_progress:
 	return err;
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
@@ -1024,7 +1036,8 @@ static int intel_pt_walk_fup(struct inte
 		err = intel_pt_walk_insn(decoder, &intel_pt_insn, ip);
 		if (err == INTEL_PT_RETURN)
 			return 0;
-		if (err == -EAGAIN) {
+		if (err == -EAGAIN ||
+		    intel_pt_fup_with_nlip(decoder, &intel_pt_insn, ip, err)) {
 			if (decoder->set_fup_tx_flags) {
 				decoder->set_fup_tx_flags = false;
 				decoder->tx_flags = decoder->fup_tx_flags;
@@ -1034,7 +1047,7 @@ static int intel_pt_walk_fup(struct inte
 				decoder->state.flags = decoder->fup_tx_flags;
 				return 0;
 			}
-			return err;
+			return -EAGAIN;
 		}
 		decoder->set_fup_tx_flags = false;
 		if (err)
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -53,6 +53,14 @@ enum {
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
@@ -92,6 +100,7 @@ struct intel_pt_params {
 	unsigned int mtc_period;
 	uint32_t tsc_ctc_ratio_n;
 	uint32_t tsc_ctc_ratio_d;
+	enum intel_pt_param_flags flags;
 };
 
 struct intel_pt_decoder;
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -752,6 +752,7 @@ static struct intel_pt_queue *intel_pt_a
 						   unsigned int queue_nr)
 {
 	struct intel_pt_params params = { .get_trace = 0, };
+	struct perf_env *env = pt->machine->env;
 	struct intel_pt_queue *ptq;
 
 	ptq = zalloc(sizeof(struct intel_pt_queue));
@@ -832,6 +833,9 @@ static struct intel_pt_queue *intel_pt_a
 		}
 	}
 
+	if (env->cpuid && !strncmp(env->cpuid, "GenuineIntel,6,92,", 18))
+		params.flags |= INTEL_PT_FUP_WITH_NLIP;
+
 	ptq->decoder = intel_pt_decoder_new(&params);
 	if (!ptq->decoder)
 		goto out_free;


