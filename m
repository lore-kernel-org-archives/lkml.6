Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFB8C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0FF20872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQgyYqdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0FF20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeKKO4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:56:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54138 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeKKO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:56:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id f10-v6so5386255wme.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 21:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pL2xknDZRwx/bgQqRwh/znrlZfSxh+MEAgrn8ZwKjac=;
        b=kQgyYqdQSKpbnqwzWAvdB/oKD3LzuVUyZUN0jf65YU7d65DqRtXR1tqf9objsH0bWn
         h5bsPDarwmSjDUILJSqluaLGlL2x7c+tk2BS2Uvf+bd2Bqfb2CpG2uLR17mj0cmH66ns
         /LPm3OxoxSGB/QDvKDyOWonsbd1qp9lsGOyRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pL2xknDZRwx/bgQqRwh/znrlZfSxh+MEAgrn8ZwKjac=;
        b=PXJkx2EehxVRQxp06XOYUvi+DlZ/NTYl/JdlYbcsxXbUkz0sEfl57v61BF7hO56+9U
         0s9s4K++Dme8cJpinW+OZnaO5ht8qfeP+dhMemHILoShDVW7yKo/g0VQACMLL05ac6HB
         MsT6vMwzKCfrBAUatrYZdbnqpff+pKuomWPskPS/Rr0JIxta45N5+EKo8XueMjdPhsPS
         q5zrhMq946rUPNY/Aqz5IgiG1Z/aidyOzjhskT3leM35Py5EaX2RYweTsClTUGVMuADT
         sZqiw/kcxmb6mvp/K+WzWCCe/2NyHwI23gRyQ1DNmjLxHlrMqPqSKO3qILH9ZNbYP28U
         0wBA==
X-Gm-Message-State: AGRZ1gLb2yuAkYG/WvGNCBdXGTVfVFAIzbZ5MVwFuWBee6vB6fyiSX/j
        C7ZoARi2ichROwvChZL/QWO3y8XEAZP79w==
X-Google-Smtp-Source: AJdET5fIMe8rnnM02LlmxpuUq9PQiV8scd0EiDBdVwD0p+/Kf2B1mFCJv/4C47ZUOvcmuXJORiUbUQ==
X-Received: by 2002:a1c:6754:: with SMTP id b81-v6mr4118328wmc.104.1541912919839;
        Sat, 10 Nov 2018 21:08:39 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id b66-v6sm4471045wmb.21.2018.11.10.21.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Nov 2018 21:08:39 -0800 (PST)
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
Subject: [PATCH v2 2/2] perf cs-etm: Add support sample flags
Date:   Sun, 11 Nov 2018 13:07:56 +0800
Message-Id: <1541912876-20967-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
References: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have prepared the flags in the packet structure, so need to copy
the related value into sample structure thus perf tool can facilitate
sample flags.

The PREV_PACKET contains the branch instruction flags and PACKET
actually contains the flags for next branch instruction.  So this patch
is to set sample flags with 'etmq->prev_packet->flags'.

This patch includes three fixing up for sample flags based on the
packets context:

- If the packet is exception packet or exception return packet, update
  the previous packet for exception specific flags;
- If there has TRACE_ON or TRACE_OFF packet in the middle of instruction
  packets, this indicates the trace is discontinuous, so append the flag
  PERF_IP_FLAG_TRACE_END to the previous packet to indicate the trace
  has been ended;
- If one instruction packet is behind TRACE_OFF packet, this instruction
  is restarting trace packet.  So set flag PERF_IP_FLAG_TRACE_START to
  TRACE_OFF packet if one, this flag isn't used by TRACE_OFF packet but
  used to indicate trace restarting when generate sample.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 455f132..afca6f3 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -676,7 +676,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.stream_id = etmq->etm->instructions_id;
 	sample.period = period;
 	sample.cpu = etmq->packet->cpu;
-	sample.flags = 0;
+	sample.flags = etmq->prev_packet->flags;
 	sample.insn_len = 1;
 	sample.cpumode = event->sample.header.misc;
 
@@ -735,7 +735,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
 	sample.stream_id = etmq->etm->branches_id;
 	sample.period = 1;
 	sample.cpu = etmq->packet->cpu;
-	sample.flags = 0;
+	sample.flags = etmq->prev_packet->flags;
 	sample.cpumode = event->sample.header.misc;
 
 	/*
@@ -878,6 +878,43 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static void cs_etm__fixup_flags(struct cs_etm_queue *etmq)
+{
+	/*
+	 * Decoding stream might insert one TRACE_OFF packet in the
+	 * middle of instruction packets, this means it doesn't
+	 * contain the pair packets with TRACE_OFF and TRACE_ON.
+	 * For this case, the instruction packet follows with
+	 * TRACE_OFF packet so we need to fixup prev_packet with flag
+	 * PERF_IP_FLAG_TRACE_BEGIN, this flag finally is used by the
+	 * instruction packet to generate samples.
+	 */
+	if (etmq->prev_packet->sample_type == CS_ETM_TRACE_OFF &&
+	    etmq->packet->sample_type == CS_ETM_RANGE)
+		etmq->prev_packet->flags = PERF_IP_FLAG_BRANCH |
+					   PERF_IP_FLAG_TRACE_BEGIN;
+
+	if (etmq->prev_packet->sample_type == CS_ETM_RANGE) {
+		/*
+		 * When the exception packet is inserted, update flags
+		 * so tell perf it is exception related branches.
+		 */
+		if (etmq->packet->sample_type == CS_ETM_EXCEPTION ||
+		    etmq->packet->sample_type == CS_ETM_EXCEPTION_RET)
+			etmq->prev_packet->flags = etmq->packet->flags;
+
+		/*
+		 * The trace is discontinuous, weather this is caused by
+		 * TRACE_ON packet or TRACE_OFF packet is coming, if the
+		 * previous packet is instruction packet, simply set flag
+		 * PERF_IP_FLAG_TRACE_END for previous packet.
+		 */
+		if (etmq->packet->sample_type == CS_ETM_TRACE_ON ||
+		    etmq->packet->sample_type == CS_ETM_TRACE_OFF)
+			etmq->prev_packet->flags |= PERF_IP_FLAG_TRACE_END;
+	}
+}
+
 static int cs_etm__sample(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -1100,6 +1137,8 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					break;
 
+				cs_etm__fixup_flags(etmq);
+
 				switch (etmq->packet->sample_type) {
 				case CS_ETM_RANGE:
 					/*
-- 
2.7.4

