Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20246C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4E320880
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXV2PMnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4E320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJ1VT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:19:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52102 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1VT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:19:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so5493448wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U7cmISxeRZ1YwLrjSKN+D2EuVL5W5QQOYfw6cRMxHkY=;
        b=PXV2PMnMXWkkrw884OjFKnkkvnIqbKgFYlt9+5+3lrbb4vqDFR57bxltFMDRDDoIve
         tZ0Y4LydxU0z6ifAd1ZnyYgHWopiNMWFj+OwSf7hfACPkspB9qXdPq674pafwmWFYGh3
         9XuzQZleiQM4sKwXrFTNqXlyaYrD7kgPBcLuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U7cmISxeRZ1YwLrjSKN+D2EuVL5W5QQOYfw6cRMxHkY=;
        b=VEU5+jnsvC1/TZeKfs+CA4dErbbNfH0gPpWztj4hgTe8JK4YMGNgW4wprEjG1LyZMb
         KG8f6n0WcwVSRJAO4pLbfTo+R/axI5TJDeRFqsiGhF2EfmJPh0cOvR4MHBEGodMG+VIP
         r6veoW1tn9Kpq1gs+f7Ol8SlvB7PgBuZRNgmck05rfmvGhKxhrSyupJBi6VoY4Ut6B2F
         CFTd143rta6hqcsFE6jUEO+48+Q4I3nQwdnrQx/mwZm1tn+UcBQrOEGF0noGvOWnBB3O
         BtsIkUFYL+lePjIsdqyc/r453CW++Eqsbf/aKlvusMQ7clBXSkrq7VsbwoeBLETgxa6U
         SuRw==
X-Gm-Message-State: AGRZ1gKmzgR5RcwDZnl0f8YAYmwiBlqp7Z+odpk0NS8n0xycoCG2EsHC
        +lrc5V1ne3imOI9K9uTk49LnOg==
X-Google-Smtp-Source: AJdET5f4A3cSplygFF1kgFPUoNEz7N307lgE10SvyHq8ShPp8xvbjwKQvBC6/xNOTygE09C3hrfsUA==
X-Received: by 2002:a1c:dcc:: with SMTP id 195-v6mr10665965wmn.117.1540730123521;
        Sun, 28 Oct 2018 05:35:23 -0700 (PDT)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id v30-v6sm18926830wra.67.2018.10.28.05.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Oct 2018 05:35:22 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/4] perf cs-etm: Track exception number
Date:   Sun, 28 Oct 2018 20:34:53 +0800
Message-Id: <1540730095-6732-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540730095-6732-1-git-send-email-leo.yan@linaro.org>
References: <1540730095-6732-1-git-send-email-leo.yan@linaro.org>
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
TRACE_ON packet, the exception number is set to invalid value.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 51 ++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 0f29534..efc4332 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -43,6 +43,7 @@ struct cs_etm_decoder {
 	u32 packet_count;
 	u32 head;
 	u32 tail;
+	u32 *exc_num;
 	struct cs_etm_packet packet_buffer[MAX_BUFFER];
 };
 
@@ -368,16 +369,44 @@ static ocsd_datapath_resp_t
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
@@ -413,7 +442,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(decoder,
+		resp = cs_etm_decoder__buffer_exception(decoder, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
@@ -501,6 +530,10 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	if (!decoder)
 		return NULL;
 
+	decoder->exc_num = zalloc(sizeof(*decoder->exc_num) * num_cpu);
+	if (!decoder->exc_num)
+		goto err_free_decoder;
+
 	decoder->data = d_params->data;
 	decoder->prev_return = OCSD_RESP_CONT;
 	cs_etm_decoder__clear_buffer(decoder);
@@ -521,7 +554,7 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	decoder->dcd_tree = ocsd_create_dcd_tree(format, flags);
 
 	if (decoder->dcd_tree == 0)
-		goto err_free_decoder;
+		goto err_free_decoder_exc_num;
 
 	/* init library print logging support */
 	ret = cs_etm_decoder__init_def_logger_printing(d_params, decoder);
@@ -532,6 +565,9 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
 
 	for (i = 0; i < num_cpu; i++) {
+		/* init expcetion number to an invalid value */
+		decoder->exc_num[i] = UINT32_MAX;
+
 		ret = cs_etm_decoder__create_etm_decoder(d_params,
 							 &t_params[i],
 							 decoder);
@@ -543,6 +579,8 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 
 err_free_decoder_tree:
 	ocsd_destroy_dcd_tree(decoder->dcd_tree);
+err_free_decoder_exc_num:
+	free(decoder->exc_num);
 err_free_decoder:
 	free(decoder);
 	return NULL;
@@ -603,5 +641,6 @@ void cs_etm_decoder__free(struct cs_etm_decoder *decoder)
 
 	ocsd_destroy_dcd_tree(decoder->dcd_tree);
 	decoder->dcd_tree = NULL;
+	free(decoder->exc_num);
 	free(decoder);
 }
-- 
2.7.4

