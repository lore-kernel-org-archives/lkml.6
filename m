Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B63A218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479080;
	bh=wbGvc1+Ey2JEhbb1aqcjUBYL2cT79p+ugjCfc1KU7xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qPuQ4WSzDlcT9Kylz0/iIAmEXbdFjTpVLBlAPqjZQi4QbBYWAY/57J+M8erqyQ152
	 2uvy+WS1r48gvldvGuz9y8wKy0yZ/LUsVEP93CtP7Dqk55Olf1uFHbL+cDlfIuS4PB
	 FLnUJ/hEME5qfN4rkyQ8unF/B2bP5h63iLfpcMQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfBFSvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfBFSvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:51:16 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA43F218B0;
        Wed,  6 Feb 2019 18:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479075;
        bh=wbGvc1+Ey2JEhbb1aqcjUBYL2cT79p+ugjCfc1KU7xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrdrFEh5ZKYuKsfL8vHJN/Epu4SpyxQCQ1SJF92TcWAxyPKaCgu/giXANAXXdyg4B
         LyE++7QW9VwO7k/RpIJHTpOkuMmuAE8MTz3qB0qrlZfKkqt0vr+o8V/aqUuaYJsHuD
         FpMN7K+POyF9DsubRDiCTK1H3xmroVfHaM6DT728=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        coresight ml <coresight@lists.linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/53] perf cs-etm: Set sample flags for instruction range packet
Date:   Wed,  6 Feb 2019 15:48:47 -0300
Message-Id: <20190206184903.24054-38-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The perf sample data contains flags to indicate the hardware trace data
is belonging to which type branch instruction, thus this can be used to
print out the human readable string.  Arm CoreSight ETM sample data is
missed to set flags and it is always set to zeros, this results in perf
tool skips to print string for instruction types.

This patch is to set branch instruction flags for instruction range
packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190129122842.32041-3-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  2 +
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                      | 90 ++++++++++++++++++-
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 8a19310500d9..e98ee49a1527 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -293,6 +293,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].last_instr_type = 0;
 		decoder->packet_buffer[i].last_instr_subtype = 0;
 		decoder->packet_buffer[i].last_instr_cond = 0;
+		decoder->packet_buffer[i].flags = 0;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -329,6 +330,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].last_instr_type = 0;
 	decoder->packet_buffer[et].last_instr_subtype = 0;
 	decoder->packet_buffer[et].last_instr_cond = 0;
+	decoder->packet_buffer[et].flags = 0;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 7cdd6a9c68a7..23600e57a215 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -45,6 +45,7 @@ struct cs_etm_packet {
 	u32 instr_count;
 	u32 last_instr_type;
 	u32 last_instr_subtype;
+	u32 flags;
 	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 27a374ddf661..d05cac5295f1 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -12,6 +12,7 @@
 #include <linux/log2.h>
 #include <linux/types.h>
 
+#include <opencsd/ocsd_if_types.h>
 #include <stdlib.h>
 
 #include "auxtrace.h"
@@ -719,7 +720,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.stream_id = etmq->etm->instructions_id;
 	sample.period = period;
 	sample.cpu = etmq->packet->cpu;
-	sample.flags = 0;
+	sample.flags = etmq->prev_packet->flags;
 	sample.insn_len = 1;
 	sample.cpumode = event->sample.header.misc;
 
@@ -778,7 +779,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
 	sample.stream_id = etmq->etm->branches_id;
 	sample.period = 1;
 	sample.cpu = etmq->packet->cpu;
-	sample.flags = 0;
+	sample.flags = etmq->prev_packet->flags;
 	sample.cpumode = event->sample.header.misc;
 
 	/*
@@ -1107,6 +1108,80 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
+{
+	struct cs_etm_packet *packet = etmq->packet;
+
+	switch (packet->sample_type) {
+	case CS_ETM_RANGE:
+		/*
+		 * Immediate branch instruction without neither link nor
+		 * return flag, it's normal branch instruction within
+		 * the function.
+		 */
+		if (packet->last_instr_type == OCSD_INSTR_BR &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_NONE) {
+			packet->flags = PERF_IP_FLAG_BRANCH;
+
+			if (packet->last_instr_cond)
+				packet->flags |= PERF_IP_FLAG_CONDITIONAL;
+		}
+
+		/*
+		 * Immediate branch instruction with link (e.g. BL), this is
+		 * branch instruction for function call.
+		 */
+		if (packet->last_instr_type == OCSD_INSTR_BR &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_BR_LINK)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL;
+
+		/*
+		 * Indirect branch instruction with link (e.g. BLR), this is
+		 * branch instruction for function call.
+		 */
+		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_BR_LINK)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL;
+
+		/*
+		 * Indirect branch instruction with subtype of
+		 * OCSD_S_INSTR_V7_IMPLIED_RET, this is explicit hint for
+		 * function return for A32/T32.
+		 */
+		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_V7_IMPLIED_RET)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_RETURN;
+
+		/*
+		 * Indirect branch instruction without link (e.g. BR), usually
+		 * this is used for function return, especially for functions
+		 * within dynamic link lib.
+		 */
+		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_NONE)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_RETURN;
+
+		/* Return instruction for function return. */
+		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_V8_RET)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_RETURN;
+		break;
+	case CS_ETM_DISCONTINUITY:
+	case CS_ETM_EXCEPTION:
+	case CS_ETM_EXCEPTION_RET:
+	case CS_ETM_EMPTY:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -1158,6 +1233,17 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					break;
 
+				/*
+				 * Since packet addresses are swapped in packet
+				 * handling within below switch() statements,
+				 * thus setting sample flags must be called
+				 * prior to switch() statement to use address
+				 * information before packets swapping.
+				 */
+				err = cs_etm__set_sample_flags(etmq);
+				if (err < 0)
+					break;
+
 				switch (etmq->packet->sample_type) {
 				case CS_ETM_RANGE:
 					/*
-- 
2.20.1

