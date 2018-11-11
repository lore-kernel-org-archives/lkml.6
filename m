Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B703C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F9120854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uro2G0dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F9120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeKKOsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:48:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52907 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeKKOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:47:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so5384144wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 21:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jZ25mbwgDMiV9nnmDqIiPF/+ngrYDveBFk4YG++0cIY=;
        b=Uro2G0dQHwvBrnMO0YlyZHQuZdz4eHov8QSnTHeJXpXHZE4EslFv4WZa/aa0BWvr5P
         /P+v6ux/xQWLYb+MXHaEmdAhp902+Pnz5FFAhZoGdDtW3TOJpyvXfNOt+1YuKYM2PYRQ
         GeTIXm0slFqj9EKsR3koIfPELL0Ly8Mb4B3wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jZ25mbwgDMiV9nnmDqIiPF/+ngrYDveBFk4YG++0cIY=;
        b=oSnI8fCcgY7JNf5TzXEVBFYqXciY+SxzUY1ndjxxtZUm7W31PdFpOmD/qieZaL/s/Z
         FNYhy27PGn0NBkrx2kN4il6v1mXKKRQd1TsO9jVVT0VSXqn/1d8AwqHgjLysEd8+LjH/
         yn6QtA00SiZde2Ev862SelwWbDgFA7GYClPp9oP8glmSGYi66TTD0ImeJe+/lsRixRBZ
         /sUwfsTzCadvrXETn6rzua2TLVdY74GKnaL7uQ4c9Gr4B0kOfnUI/bMQ+zx2L5Sc7Kx6
         NHGrWXCgUKo1WXRIoLtUw8hWK4/zI8SMvtdiSHDcLjmQTBae1dpQrerYqQ1vvq/sl/9U
         SuAA==
X-Gm-Message-State: AGRZ1gJ2k7z+ELIRYP3Tp8vY7UyHycK8bnk2xoQxWA3E1+KJTvBSXzKg
        UTSjV1l953PPyCURoGcESE3ZJw==
X-Google-Smtp-Source: AJdET5doJMyzb3mEJQ6gu0QNWCGPxynyN6l9fjDalYr4cdAUkpE6ENA6z0Z5YuqiKhqCsEysfacL3Q==
X-Received: by 2002:a1c:af47:: with SMTP id y68-v6mr412603wme.33.1541912429566;
        Sat, 10 Nov 2018 21:00:29 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id t187-v6sm4463802wmt.45.2018.11.10.21.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Nov 2018 21:00:28 -0800 (PST)
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
Subject: [PATCH v1 5/5] perf cs-etm: Track exception number
Date:   Sun, 11 Nov 2018 12:59:43 +0800
Message-Id: <1541912383-19915-6-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an exception packet comes, it contains the info for exception
number; the exception number indicates the exception types, so from it
we can know if the exception is taken for interrupt, system call or
other traps, etc.  But because the exception return packet cannot
delivery exception number correctly by decoder thus when prepare sample
flags we cannot know what's type for exception return.

This patch adds a new 'exc_num' array in decoder structure to record
exception number per CPU, the exception number is recorded in the array
when the exception packet comes and this exception number can be used by
exception return packet.  If detect there have discontinuous trace with
TRACE_ON or TRACE_OFF packet, the exception number is set to invalid
value.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 67 ++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index b8cb7a3e..d1a6cbc 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -43,6 +43,7 @@ struct cs_etm_decoder {
 	u32 packet_count;
 	u32 head;
 	u32 tail;
+	u32 *exc_num;
 	struct cs_etm_packet packet_buffer[MAX_BUFFER];
 };
 
@@ -368,24 +369,64 @@ static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_trace_off(struct cs_etm_decoder *decoder,
 				 const uint8_t trace_chan_id)
 {
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_TRACE_OFF);
+	int ret;
+	struct cs_etm_packet *packet;
+
+	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					    CS_ETM_TRACE_OFF);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+
+	/* Clear execption number for discontinuous trace */
+	decoder->exc_num[packet->cpu] = UINT32_MAX;
+
+	return ret;
 }
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
 				const uint8_t trace_chan_id)
 {
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_TRACE_ON);
+	int ret;
+	struct cs_etm_packet *packet;
+
+	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					    CS_ETM_TRACE_ON);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+
+	/* Clear execption number for discontinuous trace */
+	decoder->exc_num[packet->cpu] = UINT32_MAX;
+
+	return ret;
 }
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
+				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
 {
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_EXCEPTION);
+	int ret;
+	struct cs_etm_packet *packet;
+
+	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					    CS_ETM_EXCEPTION);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+
+	/*
+	 * Exception number is recorded per CPU and later can be used
+	 * for exception return instruction analysis.
+	 */
+	decoder->exc_num[packet->cpu] = elem->exception_number;
+
+	return ret;
 }
 
 static ocsd_datapath_resp_t
@@ -423,7 +464,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(decoder,
+		resp = cs_etm_decoder__buffer_exception(decoder, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
@@ -511,6 +552,10 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	if (!decoder)
 		return NULL;
 
+	decoder->exc_num = zalloc(sizeof(*decoder->exc_num) * num_cpu);
+	if (!decoder->exc_num)
+		goto err_free_decoder;
+
 	decoder->data = d_params->data;
 	decoder->prev_return = OCSD_RESP_CONT;
 	cs_etm_decoder__clear_buffer(decoder);
@@ -531,7 +576,7 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	decoder->dcd_tree = ocsd_create_dcd_tree(format, flags);
 
 	if (decoder->dcd_tree == 0)
-		goto err_free_decoder;
+		goto err_free_decoder_exc_num;
 
 	/* init library print logging support */
 	ret = cs_etm_decoder__init_def_logger_printing(d_params, decoder);
@@ -542,6 +587,9 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
 
 	for (i = 0; i < num_cpu; i++) {
+		/* init expcetion number to an invalid value */
+		decoder->exc_num[i] = UINT32_MAX;
+
 		ret = cs_etm_decoder__create_etm_decoder(d_params,
 							 &t_params[i],
 							 decoder);
@@ -553,6 +601,8 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 
 err_free_decoder_tree:
 	ocsd_destroy_dcd_tree(decoder->dcd_tree);
+err_free_decoder_exc_num:
+	free(decoder->exc_num);
 err_free_decoder:
 	free(decoder);
 	return NULL;
@@ -613,5 +663,6 @@ void cs_etm_decoder__free(struct cs_etm_decoder *decoder)
 
 	ocsd_destroy_dcd_tree(decoder->dcd_tree);
 	decoder->dcd_tree = NULL;
+	free(decoder->exc_num);
 	free(decoder);
 }
-- 
2.7.4

