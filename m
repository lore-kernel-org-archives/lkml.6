Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D226C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5FD20854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUK19Me+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5FD20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeKKOrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:47:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38527 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeKKOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:47:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id f2-v6so5193602wme.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 21:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fmD++TcGuvp1soHonkx5687mfGEN7WjEJXPPOJvoda0=;
        b=kUK19Me+7lAMeZI7F+H+A9idmNoAgmo/vgIcfn3SurdVr8OkqgwqlG20A/EI2H83og
         tWTS8LHtNsWUTVmLPZg3TsDAtU1ND8JxG23SSG43hQr9hq6WNQMImR2XM4CZExxPMtA7
         aYPEZ0FM2DfLMRHM7rsc4yjdBBFiMUfFXECEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fmD++TcGuvp1soHonkx5687mfGEN7WjEJXPPOJvoda0=;
        b=KO0nRavpQNduSQx3i81oncRMzen6RWE1+Bxd1iQIHci4Kumelg62epXco5AKgk2X8a
         UfrbU+YrGJ5oBL2EKEzkKXOAy/SQL06xxz+/PEXLE0c03WrM83jQh9cBsFELH7ns/LBJ
         37ycEccvgiCsjHPlm3u3oqMI3Thlf++Zz0rlFBjcqX1ABy1zs59y12B3e5eITFMr1zs6
         YWuwMBS27m6omaRwDmmTOIGOVvS7ja3T5ua/3nGOO1X3qPLT/H1f3DHZzEoxd6gaUgIu
         +zTkcixdr7Ma6NBf2IZV+k7HGfQ5hPAkVhPmlJ312XS4pYk5RsnzYVzUd7R8hfGfGLCb
         2WpA==
X-Gm-Message-State: AGRZ1gJsEYrOPbD+NQBRMonwXzJPQ8DLLb4S5ThSUB7FV6Hq/mi4l3vG
        mcYETmJd6tatzmt/tNFqavrmB8PgXvfgdQ==
X-Google-Smtp-Source: AJdET5d1w1WiREOdr8dmuP+C3KIEb7QPmzMszJkOyS3tV1C7YCGEHfT2NU7xmTBPutAcGPi0+AC3UQ==
X-Received: by 2002:a1c:a757:: with SMTP id q84-v6mr4054957wme.61.1541912421659;
        Sat, 10 Nov 2018 21:00:21 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id t187-v6sm4463802wmt.45.2018.11.10.21.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Nov 2018 21:00:21 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/5] perf cs-etm: Support for NO_SYNC packet
Date:   Sun, 11 Nov 2018 12:59:41 +0800
Message-Id: <1541912383-19915-4-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in OpenCSD (CoreSight decoder lib), in the decoding stream
it includes one trace element with type OCSD_GEN_TRC_ELEM_NO_SYNC; the
element indicates 'either at start of decode, or after overflow / bad
packet', we should take it as a signal for the tracing off and this will
cause tracing discontinuity.  From the trace dump with 'perf script',
sometimes the element OCSD_GEN_TRC_ELEM_NO_SYNC collaborates with
element OCSD_GEN_TRC_ELEM_TRACE_ON to show the tracing flow have been
turned off and on, in this case the cs-etm code has handled TRACE_ON
packet well so we observe the tracing discontinuity; but in another case
it only inserts the element OCSD_GEN_TRC_ELEM_NO_SYNC into instructions
packets, we miss to handle the case if has only standalone NO_SYNC
element and users cannot receive the info for tracing discontinuity.

This patch introduces new type CS_ETM_TRACE_OFF to generate packet for
receiving element OCSD_GEN_TRC_ELEM_NO_SYNC from decoder; when generate
sample, CS_ETM_TRACE_OFF packet has almost the same behaviour with
CS_ETM_TRACE_ON packet: both of them invokes cs_etm__flush() to generate
samples for the previous instructions packet, and in cs_etm__sample() it
also needs to generate samples if TRACE_OFF packet is followed by one
sequential instructions packet.  This patch also converts the address to
0 for TRACE_OFF packet, this is same with TRACE_ON packet as well.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  7 ++++---
 tools/perf/util/cs-etm.c                        | 15 +++++++++++----
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 5efb616..9d52727 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -369,6 +369,14 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 }
 
 static ocsd_datapath_resp_t
+cs_etm_decoder__buffer_trace_off(struct cs_etm_decoder *decoder,
+				 const uint8_t trace_chan_id)
+{
+	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					     CS_ETM_TRACE_OFF);
+}
+
+static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
 				const uint8_t trace_chan_id)
 {
@@ -389,6 +397,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
+		resp = cs_etm_decoder__buffer_trace_off(decoder,
+							trace_chan_id);
 		decoder->trace_on = false;
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 9351bd1..a38c97c 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -23,9 +23,10 @@ struct cs_etm_buffer {
 };
 
 enum cs_etm_sample_type {
-	CS_ETM_EMPTY = 0,
-	CS_ETM_RANGE = 1 << 0,
-	CS_ETM_TRACE_ON = 1 << 1,
+	CS_ETM_EMPTY		= 0,
+	CS_ETM_RANGE		= 1 << 0,
+	CS_ETM_TRACE_ON		= 1 << 1,
+	CS_ETM_TRACE_OFF	= 1 << 2,
 };
 
 enum cs_etm_isa {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f4fa877..2a0cef9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -517,8 +517,9 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 {
-	/* Returns 0 for the CS_ETM_TRACE_ON packet */
-	if (packet->sample_type == CS_ETM_TRACE_ON)
+	/* Returns 0 for TRACE_ON and TRACE_OFF packets */
+	if (packet->sample_type == CS_ETM_TRACE_ON ||
+	    packet->sample_type == CS_ETM_TRACE_OFF)
 		return 0;
 
 	return packet->start_addr;
@@ -527,8 +528,9 @@ static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 static inline
 u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
 {
-	/* Returns 0 for the CS_ETM_TRACE_ON packet */
-	if (packet->sample_type == CS_ETM_TRACE_ON)
+	/* Returns 0 for TRACE_ON and TRACE_OFF packets */
+	if (packet->sample_type == CS_ETM_TRACE_ON ||
+	    packet->sample_type == CS_ETM_TRACE_OFF)
 		return 0;
 
 	return packet->end_addr - packet->last_instr_size;
@@ -930,6 +932,10 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 		if (etmq->prev_packet->sample_type == CS_ETM_TRACE_ON)
 			generate_sample = true;
 
+		/* Generate sample for tracing off packet */
+		if (etmq->prev_packet->sample_type == CS_ETM_TRACE_OFF)
+			generate_sample = true;
+
 		/* Generate sample for branch taken packet */
 		if (etmq->prev_packet->sample_type == CS_ETM_RANGE &&
 		    etmq->prev_packet->last_instr_taken_branch)
@@ -1085,6 +1091,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					cs_etm__sample(etmq);
 					break;
 				case CS_ETM_TRACE_ON:
+				case CS_ETM_TRACE_OFF:
 					/*
 					 * Discontinuity in trace, flush
 					 * previous branch stack
-- 
2.7.4

