Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE1DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E26218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171049;
	bh=SzXNKAVH7qpfXaEEgI6MQqFFg4rSlHPQTbTsXI9ZwjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wbmxRIQ2hAe25SKglG/vJUu26u+fwLupowFb3OkrLQF5UQWLW6g16T/sghFI6zXoA
	 ObwGGsp/+6YVLXgkZ4AgVo+8vGzKXX9LH9jJ/BsWDMMMfo2Vm3GPHb9oPfvubtfHPx
	 dJNQJSv6ijxzhxcwN+fmdNvwSB7G+qVe+fynuHaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeLRWKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeLRWKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:10:46 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D2DD21871;
        Tue, 18 Dec 2018 22:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171045;
        bh=SzXNKAVH7qpfXaEEgI6MQqFFg4rSlHPQTbTsXI9ZwjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCf7/wibsbK6Q7gyaJrEphxQYecW8zX+6b+OkMxxqCXEYcLK85UA4GKjBvOO72yt7
         vOQ/ZT2o0jdznX5rLW9H1Ia9lply9WVvtELVpnKU2hfSToOoi+0kCy0++ssyIuUTGV
         4OLUlkhF/A4V5Xg5NABvsv3ADN+eguDO6HEfE3TU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Walker <robert.walker@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/63] perf cs-etm: Rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY
Date:   Tue, 18 Dec 2018 19:07:00 -0300
Message-Id: <20181218220733.15839-31-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

TRACE_ON element is used at the beginning of trace, it also can be
appeared in the middle of trace data to indicate discontinuity; for
example, it's possible to see multiple TRACE_ON elements in the trace
stream if the trace is being limited by address range filtering.

Furthermore, except TRACE_ON element is for discontinuity, NO_SYNC and
EO_TRACE also can be used to indicate discontinuity, though they are
used for different scenarios for which the trace is interrupted.

This patch renames sample type CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY,
firstly the new name describes more closely the purpose of the packet;
secondly this is a preparation for other output elements which also
cause the trace discontinuity thus they can share the same one packet
type.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-6-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 +++++-----
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  2 +-
 tools/perf/util/cs-etm.c                        | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 97b39b1f5759..1039f364f4cc 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -390,11 +390,11 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
-				const uint8_t trace_chan_id)
+cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
+					   const uint8_t trace_chan_id)
 {
 	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_TRACE_ON);
+					     CS_ETM_DISCONTINUITY);
 }
 
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
@@ -412,8 +412,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
-		resp = cs_etm_decoder__buffer_trace_on(decoder,
-						       trace_chan_id);
+		resp = cs_etm_decoder__buffer_discontinuity(decoder,
+							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
 		resp = cs_etm_decoder__buffer_range(decoder, elem,
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 3819a04a2c27..a27231722e27 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -25,7 +25,7 @@ struct cs_etm_buffer {
 enum cs_etm_sample_type {
 	CS_ETM_EMPTY,
 	CS_ETM_RANGE,
-	CS_ETM_TRACE_ON,
+	CS_ETM_DISCONTINUITY,
 };
 
 enum cs_etm_isa {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ffc4fe5c0b7e..cea3158915d3 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -562,8 +562,8 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 {
-	/* Returns 0 for the CS_ETM_TRACE_ON packet */
-	if (packet->sample_type == CS_ETM_TRACE_ON)
+	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
+	if (packet->sample_type == CS_ETM_DISCONTINUITY)
 		return 0;
 
 	return packet->start_addr;
@@ -572,8 +572,8 @@ static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 static inline
 u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
 {
-	/* Returns 0 for the CS_ETM_TRACE_ON packet */
-	if (packet->sample_type == CS_ETM_TRACE_ON)
+	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
+	if (packet->sample_type == CS_ETM_DISCONTINUITY)
 		return 0;
 
 	return packet->end_addr - packet->last_instr_size;
@@ -972,7 +972,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 		bool generate_sample = false;
 
 		/* Generate sample for tracing on packet */
-		if (etmq->prev_packet->sample_type == CS_ETM_TRACE_ON)
+		if (etmq->prev_packet->sample_type == CS_ETM_DISCONTINUITY)
 			generate_sample = true;
 
 		/* Generate sample for branch taken packet */
@@ -1148,7 +1148,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					cs_etm__sample(etmq);
 					break;
-				case CS_ETM_TRACE_ON:
+				case CS_ETM_DISCONTINUITY:
 					/*
 					 * Discontinuity in trace, flush
 					 * previous branch stack
-- 
2.19.2

