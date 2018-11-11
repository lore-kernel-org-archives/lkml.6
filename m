Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EA5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C3E20854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3mp1ml1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C3E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeKKOrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:47:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34333 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeKKOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:47:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so5850046wre.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 21:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r42JAcC4xD23EwVm77cfqI4lnpyXT4DHtW2OTOkNuyQ=;
        b=Q3mp1ml16u22ZjAMIb4zMwp256Th9H6BpIP4qB3YeOb/Mfi2BNQ176XUbKAr8Il5K/
         S+kS0uAZM8212ozC+aBjVVRdM2OdWXq5wzXFGXzCYPNknA6E/16eT+Gv/TVqYt/iz/hl
         muYb2k/CcP6Tad/U+AHQsBszd0NXTvL3ona8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r42JAcC4xD23EwVm77cfqI4lnpyXT4DHtW2OTOkNuyQ=;
        b=tfXFgyyFmMUXD6oonb5+Uf30qChLAN+/HTAnKyjjgs1iHM9tcfK/G3zIwbbAu4rdz+
         60Ou/+5QeXo+58GFwz7EbRkbTIR5pQrgiRKxKJFCImbEmmJiP3kLGtJ04nPspsQcaHf1
         Ryr6w8mVOZ4mzHOm9Z8ckwGYwRTnN20NsmvRlAoUZjLRtcfCanqFB7rfaZnGsZP3+i6I
         dLa7Slg6Rg9NWD5eLiQyy39w77jj+89bxRUaac64I3bAEtg6wKkwv3etunLY0oixCDb+
         AfdfvIp5xN+Iexijm2FU2NEGhQbaxs7RvNGW89DJJsmGK09Pe6Fp82c1HNhahWcRt0rJ
         K4nA==
X-Gm-Message-State: AGRZ1gKXlsLHTjiaEL0yFqIWeTUtthnCFAuztp+trxa8aZpbC9slsyrH
        QyFwCKGhDDWUzB0X/5rcptvO+9zk12/+hQ==
X-Google-Smtp-Source: AJdET5dtRw60mFNxzbQ1LDBqHm9pltpNS38B/2t5k2o38SL5yzRvzQW8H1gZCy6l3DYdPIFpEOmPTA==
X-Received: by 2002:adf:f24d:: with SMTP id b13-v6mr12334822wrp.142.1541912425654;
        Sat, 10 Nov 2018 21:00:25 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id t187-v6sm4463802wmt.45.2018.11.10.21.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Nov 2018 21:00:24 -0800 (PST)
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
Subject: [PATCH v1 4/5] perf cs-etm: Generate branch sample for exception packet
Date:   Sun, 11 Nov 2018 12:59:42 +0800
Message-Id: <1541912383-19915-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
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
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 26 +++++++++++++++++------
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  4 ++--
 tools/perf/util/cs-etm.c                        | 28 +++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 9d52727..b8cb7a3e 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -269,8 +269,6 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].instr_count = 0;
 		decoder->packet_buffer[i].last_instr_taken_branch = false;
 		decoder->packet_buffer[i].last_instr_size = 0;
-		decoder->packet_buffer[i].exc = false;
-		decoder->packet_buffer[i].exc_ret = false;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -298,8 +296,6 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 
 	decoder->packet_buffer[et].sample_type = sample_type;
 	decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
-	decoder->packet_buffer[et].exc = false;
-	decoder->packet_buffer[et].exc_ret = false;
 	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
 	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
 	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
@@ -384,6 +380,22 @@ cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
 					     CS_ETM_TRACE_ON);
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
@@ -411,10 +423,12 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
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
 	case OCSD_GEN_TRC_ELEM_EO_TRACE:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index a38c97c..0d1c18d 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -27,6 +27,8 @@ enum cs_etm_sample_type {
 	CS_ETM_RANGE		= 1 << 0,
 	CS_ETM_TRACE_ON		= 1 << 1,
 	CS_ETM_TRACE_OFF	= 1 << 2,
+	CS_ETM_EXCEPTION	= 1 << 3,
+	CS_ETM_EXCEPTION_RET	= 1 << 4,
 };
 
 enum cs_etm_isa {
@@ -44,8 +46,6 @@ struct cs_etm_packet {
 	u32 instr_count;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
-	u8 exc;
-	u8 exc_ret;
 	int cpu;
 };
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2a0cef9..455f132 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -961,6 +961,25 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
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
 static int cs_etm__flush(struct cs_etm_queue *etmq, bool new_packet)
 {
 	int err = 0;
@@ -1090,6 +1109,15 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
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
 				case CS_ETM_TRACE_ON:
 				case CS_ETM_TRACE_OFF:
 					/*
-- 
2.7.4

