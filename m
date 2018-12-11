Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0C0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B4E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PM3xYxmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B4E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeLKHku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:40:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35481 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLKHks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:40:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so1096814wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8QxeFRHi4qMd6sFFXgNwZ7/cePOdaHaHqRD9zBqmzN0=;
        b=PM3xYxmRvN7QFw/ApSK0f06969XEiMhna7Uv/Jkq2k11tmt8+LvU9ZXYgOc6wBQV3w
         aVjr4v+dCjLpMjEdFy/3zVB5ocLwNsTODs0yUKijLmQFNzdLu0i1493yErLraGO5E5DE
         5OyuM+U8w0K60gn+K/R54JuWbGABvZCA3kpmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8QxeFRHi4qMd6sFFXgNwZ7/cePOdaHaHqRD9zBqmzN0=;
        b=hlTlttDjSXEh20SGC3NziwZ2UldVmNm17VvISMlwGNqjDHFDbl2pYaHXkx3BBVWlHV
         nrmoseHzmFctgXI8h7sLW6DlWSRYdvSx+o59ugYqF/pBP1bIiR+BOoa71vbgPrHjOSUA
         klZdwwWMPwztrsUCNE7kL0XebqbROMFRLjFAhz0c7F7PIc8eNQpjaXwZ0z+cmAY76gyg
         jnKOf3FPsiXRLQUj/y5fOO0/SIJtFYHM/w9OaJJ55ysFtVoR+oRCyN+KyqzXowqmWlWP
         3Ieici9ZLK/S41HmUlKkl6f8ZnrR6nhalKf/WtyP7c/QEf84tMJLFuq9jv2bnXjmwttV
         gu3A==
X-Gm-Message-State: AA+aEWZTmTBLolHfNfhWXYYnxPf3cCoJlMnidR0bILfsmPQStBdhF5Pz
        JaWi/MkHMojdUnbAaxpmfOilbQ==
X-Google-Smtp-Source: AFSGD/V00h7XRR/tjP7v2kH+nYU+zPbPOGUHxGQWpwdiB1CiowvpJtqWW/+Cdi+nSyfP6ggJfEH/sw==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr1354069wmj.0.1544514047002;
        Mon, 10 Dec 2018 23:40:47 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 23:40:46 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>
Subject: [PATCH v3 5/8] perf cs-etm: Rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY
Date:   Tue, 11 Dec 2018 15:38:25 +0800
Message-Id: <1544513908-16805-6-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRACE_ON element is used at the beginning of trace, it also can be
appeared in the middle of trace data to indicate discontinuity; for
example, it's possible to see multiple TRACE_ON elements in the trace
stream if the trace is being limited by address range filtering.

Furthermore, except TRACE_ON element is for discontinuity, NO_SYNC and
EO_TRACE also can be used to indicate discontinuity, though they are
used for different scenarios for trace is interrupted.

This patch is to rename sample type CS_ETM_TRACE_ON to
CS_ETM_DISCONTINUITY, firstly the new name describes more closely the
purpose of the packet; secondly this is a preparation for other output
elements which also cause the trace discontinuity thus they can share
the same one packet type.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 +++++-----
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  2 +-
 tools/perf/util/cs-etm.c                        | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 97b39b1..1039f364 100644
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
index 3819a04..a272317 100644
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
index ffc4fe5..cea3158 100644
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
2.7.4

