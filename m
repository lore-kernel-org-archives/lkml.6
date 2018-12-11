Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A266C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EB120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOVRRj3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EB120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeLKHlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:41:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39027 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLKHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:41:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so1076932wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9g52Maa9hrzNxiLroyiPhb7DsGqolHn0KBXL8Oe3cxA=;
        b=AOVRRj3DAzXBvvvc7X1HDL2OqCHGBwgEcjzWquJbDEjQ3PzsUzt811+8fdVsimCPan
         qWsHTu0kAiufn4tM5yoppqPZ3lAFtroAghua2uIZBii6EIBNT5b/k8GPlB0j5ohrJcq7
         NuDfKgxaBc0Vg2nmV5otgd8bo9iwy4tW54xFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9g52Maa9hrzNxiLroyiPhb7DsGqolHn0KBXL8Oe3cxA=;
        b=O22QHplkpT/I0YXIz2Ya40qrBKcfALFDnQC27AVkeX7sNZOKenlhgEDAbkVLA8okjq
         cmDekzTF3ucbRCRIEFXSGexGw7+wNn2wa5aUHh84Ur7eoWwB2Dp94lmMdOE744Myc/2C
         lV6N16eo2RXS8O/MnV9ElBd/2UJRmH4uq/zX2QHvo5iryC2E/u81yh0fqbNgkPO3sR9+
         dLQaGHlh273Ugm4f5SP2uSo4LupCruVTge88d1KoSgr87AhfkgpKqOf2//O/YYKaG103
         Rafqbna30M3DxCAAayKu4z+vCoWXbsaK9NpRcEK58Wj2uJhciskOQKXKNSprtMWJtpSe
         XM/g==
X-Gm-Message-State: AA+aEWYH+bBR8kfR8Qj/Tf0ZEtCR8dtgN6bB6ngWizIsFJA1OFQHnVAT
        rei3F1ZjVjRUxhedYb3z9uq1mw==
X-Google-Smtp-Source: AFSGD/WNBuJPiQrKoJn4Ap8WAvYLTcFJecTVi/FGBbwHHmsHE8WMRM4TLz2ir6TpGqdNg8kj/atc/Q==
X-Received: by 2002:a1c:1688:: with SMTP id 130mr1220916wmw.86.1544514061494;
        Mon, 10 Dec 2018 23:41:01 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 23:41:00 -0800 (PST)
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
Subject: [PATCH v3 8/8] perf cs-etm: Generate branch sample for exception packet
Date:   Tue, 11 Dec 2018 15:38:28 +0800
Message-Id: <1544513908-16805-9-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The exception packet appears as one element with 'elem_type' ==
OCSD_GEN_TRC_ELEM_EXCEPTION or OCSD_GEN_TRC_ELEM_EXCEPTION_RET,
which present for exception entry and exit respectively.  The decoder
set packet fields 'packet->exc' and 'packet->exc_ret' to indicate the
exception packets; but exception packets don't have dedicated sample
type and shares the same sample type CS_ETM_RANGE with normal
instruction packets.

As result, the exception packets are taken as normal instruction packets
and this introduces confusion to mix different packet types.
Furthermore, these instruction range packets will be processed for
branch sample only when 'packet->last_instr_taken_branch' is true,
otherwise they will be omitted, this can introduce mess for exception
and exception returning due we don't have complete address range info
for context switching.

To process exception packets properly, this patch introduce two new
sample type: CS_ETM_EXCEPTION and CS_ETM_EXCEPTION_RET; for these two
kind packets, they will be handled by cs_etm__exception().  The func
cs_etm__exception() forces to set previous CS_ETM_RANGE packet flag
'prev_packet->last_instr_taken_branch' to true, this matches well with
the program flow when the exception is trapped from user space to kernel
space, no matter if the most recent flow has branch taken or not; this
is also safe for returning to user space after exception handling.

After exception packets have their own sample type, the packet fields
'packet->exc' and 'packet->exc_ret' aren't needed anymore, so remove
them.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 26 +++++++++++++++++------
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  4 ++--
 tools/perf/util/cs-etm.c                        | 28 +++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index cda6f07..8c15557 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -290,8 +290,6 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].instr_count = 0;
 		decoder->packet_buffer[i].last_instr_taken_branch = false;
 		decoder->packet_buffer[i].last_instr_size = 0;
-		decoder->packet_buffer[i].exc = false;
-		decoder->packet_buffer[i].exc_ret = false;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -319,8 +317,6 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 
 	decoder->packet_buffer[et].sample_type = sample_type;
 	decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
-	decoder->packet_buffer[et].exc = false;
-	decoder->packet_buffer[et].exc_ret = false;
 	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
 	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
 	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
@@ -397,6 +393,22 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
 					     CS_ETM_DISCONTINUITY);
 }
 
+static ocsd_datapath_resp_t
+cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
+				 const uint8_t trace_chan_id)
+{
+	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					     CS_ETM_EXCEPTION);
+}
+
+static ocsd_datapath_resp_t
+cs_etm_decoder__buffer_exception_ret(struct cs_etm_decoder *decoder,
+				     const uint8_t trace_chan_id)
+{
+	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					     CS_ETM_EXCEPTION_RET);
+}
+
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 				const void *context,
 				const ocsd_trc_index_t indx __maybe_unused,
@@ -420,10 +432,12 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		decoder->packet_buffer[decoder->tail].exc = true;
+		resp = cs_etm_decoder__buffer_exception(decoder,
+							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
-		decoder->packet_buffer[decoder->tail].exc_ret = true;
+		resp = cs_etm_decoder__buffer_exception_ret(decoder,
+							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
 	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index a272317..a6407d4 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -26,6 +26,8 @@ enum cs_etm_sample_type {
 	CS_ETM_EMPTY,
 	CS_ETM_RANGE,
 	CS_ETM_DISCONTINUITY,
+	CS_ETM_EXCEPTION,
+	CS_ETM_EXCEPTION_RET,
 };
 
 enum cs_etm_isa {
@@ -43,8 +45,6 @@ struct cs_etm_packet {
 	u32 instr_count;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
-	u8 exc;
-	u8 exc_ret;
 	int cpu;
 };
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index cea3158..27a374d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1000,6 +1000,25 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static int cs_etm__exception(struct cs_etm_queue *etmq)
+{
+	/*
+	 * When the exception packet is inserted, whether the last instruction
+	 * in previous range packet is taken branch or not, we need to force
+	 * to set 'prev_packet->last_instr_taken_branch' to true.  This ensures
+	 * to generate branch sample for the instruction range before the
+	 * exception is trapped to kernel or before the exception returning.
+	 *
+	 * The exception packet includes the dummy address values, so don't
+	 * swap PACKET with PREV_PACKET.  This keeps PREV_PACKET to be useful
+	 * for generating instruction and branch samples.
+	 */
+	if (etmq->prev_packet->sample_type == CS_ETM_RANGE)
+		etmq->prev_packet->last_instr_taken_branch = true;
+
+	return 0;
+}
+
 static int cs_etm__flush(struct cs_etm_queue *etmq)
 {
 	int err = 0;
@@ -1148,6 +1167,15 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					cs_etm__sample(etmq);
 					break;
+				case CS_ETM_EXCEPTION:
+				case CS_ETM_EXCEPTION_RET:
+					/*
+					 * If the exception packet is coming,
+					 * make sure the previous instruction
+					 * range packet to be handled properly.
+					 */
+					cs_etm__exception(etmq);
+					break;
 				case CS_ETM_DISCONTINUITY:
 					/*
 					 * Discontinuity in trace, flush
-- 
2.7.4

