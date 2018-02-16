Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750934AbeBPTct (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:32:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753782AbeBPTTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691D4217C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Robert Walker <robert.walker@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/41] perf inject: Emit instruction records on ETM trace discontinuity
Date: Fri, 16 Feb 2018 16:17:33 -0300
Message-Id: <20180216191746.11095-29-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Walker <robert.walker@arm.com>

There may be discontinuities in the ETM trace stream due to overflows or
ETM configuration for selective trace.  This patch emits an instruction
sample with the pending branch stack when a TRACE ON packet occurs
indicating a discontinuity in the trace data.

A new packet type CS_ETM_TRACE_ON is added, which is emitted by the low
level decoder when a TRACE ON occurs.  The higher level decoder flushes
the branch stack when this packet is emitted.

Signed-off-by: Robert Walker <robert.walker@arm.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1518607481-4059-3-git-send-email-robert.walker@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  9 +++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        | 80 ++++++++++++++++++-------
 3 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 8ff69dfd725a..640af88331b4 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -328,7 +328,14 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 	}
 
 	return ret;
+}
 
+static ocsd_datapath_resp_t
+cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
+				const uint8_t trace_chan_id)
+{
+	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					     CS_ETM_TRACE_ON);
 }
 
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
@@ -347,6 +354,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		decoder->trace_on = false;
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
+		resp = cs_etm_decoder__buffer_trace_on(decoder,
+						       trace_chan_id);
 		decoder->trace_on = true;
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index a4fdd285b145..743f5f444304 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -24,6 +24,7 @@ struct cs_etm_buffer {
 
 enum cs_etm_sample_type {
 	CS_ETM_RANGE = 1 << 0,
+	CS_ETM_TRACE_ON = 1 << 1,
 };
 
 struct cs_etm_packet {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 6e595d96c04d..1b0d422373be 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -867,6 +867,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 	 */
 	if (etm->synth_opts.last_branch &&
 	    etmq->prev_packet &&
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
 	    etmq->prev_packet->last_instr_taken_branch)
 		cs_etm__update_last_branch_rb(etmq);
 
@@ -920,6 +921,40 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static int cs_etm__flush(struct cs_etm_queue *etmq)
+{
+	int err = 0;
+	struct cs_etm_packet *tmp;
+
+	if (etmq->etm->synth_opts.last_branch &&
+	    etmq->prev_packet &&
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
+		/*
+		 * Generate a last branch event for the branches left in the
+		 * circular buffer at the end of the trace.
+		 *
+		 * Use the address of the end of the last reported execution
+		 * range
+		 */
+		u64 addr = cs_etm__last_executed_instr(etmq->prev_packet);
+
+		err = cs_etm__synth_instruction_sample(
+			etmq, addr,
+			etmq->period_instructions);
+		etmq->period_instructions = 0;
+
+		/*
+		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
+		 * the next incoming packet.
+		 */
+		tmp = etmq->packet;
+		etmq->packet = etmq->prev_packet;
+		etmq->prev_packet = tmp;
+	}
+
+	return err;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -971,32 +1006,31 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					break;
 
-				/*
-				 * If the packet contains an instruction
-				 * range, generate instruction sequence
-				 * events.
-				 */
-				if (etmq->packet->sample_type & CS_ETM_RANGE)
-					err = cs_etm__sample(etmq);
+				switch (etmq->packet->sample_type) {
+				case CS_ETM_RANGE:
+					/*
+					 * If the packet contains an instruction
+					 * range, generate instruction sequence
+					 * events.
+					 */
+					cs_etm__sample(etmq);
+					break;
+				case CS_ETM_TRACE_ON:
+					/*
+					 * Discontinuity in trace, flush
+					 * previous branch stack
+					 */
+					cs_etm__flush(etmq);
+					break;
+				default:
+					break;
+				}
 			}
 		} while (buffer.len > buffer_used);
 
-		/*
-		 * Generate a last branch event for the branches left in
-		 * the circular buffer at the end of the trace.
-		 */
-		if (etm->sample_instructions &&
-		    etmq->etm->synth_opts.last_branch) {
-			struct branch_stack *bs = etmq->last_branch_rb;
-			struct branch_entry *be =
-				&bs->entries[etmq->last_branch_pos];
-
-			err = cs_etm__synth_instruction_sample(
-				etmq, be->to, etmq->period_instructions);
-			if (err)
-				return err;
-		}
-
+		if (err == 0)
+			/* Flush any remaining branch stack entries */
+			err = cs_etm__flush(etmq);
 	}
 
 	return err;
-- 
2.14.3
