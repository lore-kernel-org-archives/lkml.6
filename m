Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E05FC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5EB20870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtudAmWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5EB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJ1VUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:20:05 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35879 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1VUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:20:05 -0400
Received: by mail-wr1-f53.google.com with SMTP id y16so5730469wrw.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 05:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XgY8Dmsgnyr0i5Rac8Jw8Y7UJTS++BaAcXwdM3B2J1U=;
        b=OtudAmWs506HqkYJfYy3vJ55svZ6VkX2cZMqUz9i+JhuoF2ntYElB0mEaTq2N1lkkD
         5vH4qtzn7Fk7FwM70EGM5ZXMMBL2jYbFDNAxCFaUwUYNGUMRDgBfQXVTtu2FzQYvOM1B
         PqGdvhB4hSFV3uF3d+76h3QcSxjkjqPyWirAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XgY8Dmsgnyr0i5Rac8Jw8Y7UJTS++BaAcXwdM3B2J1U=;
        b=ZTnn4YekZTQ+7TaCR8Lh2oXbaepKELgKqPan4YTPgQs2f1W604m05Ov1DfJQyZl6Tq
         lSJzVfq+v4OpQHVQEDpXWuU+fKg+DfBEYys+YV9PTv5IaTuziR3K5p0Lw/Uoyca6n1P4
         93rn6Mvot305zl5rlTAJqzrGQDnasbBRXXjoO4VnGyiaf8u/cm6tbyadSKAxp2fkNzI4
         lh4RCZPrPuJn/YFDyuU79ZlLaLNq0VFDow+btzOtW54QdNd/u1VuglJwqE/sfbNkg0ti
         b0kzQ2+qVCPfhNGiVNBxq45zMGxKcWSOZERumXElRhsRKDstv2JE6XxrAx0ccfT1yvFX
         2+7A==
X-Gm-Message-State: AGRZ1gJ+zIvHETUYkYRGc36EjlYjEfLNmL08id+m88C2ALzgaiVHQSF6
        ZDZjiqEiI22pWUR2SsrE/342HA==
X-Google-Smtp-Source: AJdET5drWtdY1i8bsNRTUoYTOcn9DJTr80GkVnx0B1xuNd/1jTxdotEZhbiwHQspoxTxv6+dt8jNJA==
X-Received: by 2002:adf:ef41:: with SMTP id c1-v6mr10536749wrp.33.1540730132437;
        Sun, 28 Oct 2018 05:35:32 -0700 (PDT)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id v30-v6sm18926830wra.67.2018.10.28.05.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Oct 2018 05:35:31 -0700 (PDT)
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
Subject: [PATCH v1 4/4] perf cs-etm: Add support sample flags
Date:   Sun, 28 Oct 2018 20:34:55 +0800
Message-Id: <1540730095-6732-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540730095-6732-1-git-send-email-leo.yan@linaro.org>
References: <1540730095-6732-1-git-send-email-leo.yan@linaro.org>
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

This patch includes two fixing up: if there has TRACE_ON packet in the
middle of instruction packets, the TRACE_ON packet indicates the trace
is discontinuous, so append the flag PERF_IP_FLAG_TRACE_END to the
previous packet; if the coming packet is exception packet or exception
return packet, also update the previous packet for exception specific
flags.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 00a95d7..7e36dcf 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -655,7 +655,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.stream_id = etmq->etm->instructions_id;
 	sample.period = period;
 	sample.cpu = etmq->packet->cpu;
-	sample.flags = 0;
+	sample.flags = etmq->prev_packet->flags;
 	sample.insn_len = 1;
 	sample.cpumode = event->header.misc;
 
@@ -711,7 +711,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
 	sample.stream_id = etmq->etm->branches_id;
 	sample.period = 1;
 	sample.cpu = etmq->packet->cpu;
-	sample.flags = 0;
+	sample.flags = etmq->prev_packet->flags;
 	sample.cpumode = PERF_RECORD_MISC_USER;
 
 	/*
@@ -945,9 +945,13 @@ static int cs_etm__exception(struct cs_etm_queue *etmq)
 	 * The exception packet includes the dummy address values, so don't
 	 * swap PACKET with PREV_PACKET.  This keeps PREV_PACKET to be useful
 	 * for generating instruction and branch samples.
+	 *
+	 * Also update flags so can tell perf it is exception related.
 	 */
-	if (etmq->prev_packet->sample_type == CS_ETM_RANGE)
+	if (etmq->prev_packet->sample_type == CS_ETM_RANGE) {
 		etmq->prev_packet->last_instr_taken_branch = true;
+		etmq->prev_packet->flags = etmq->packet->flags;
+	}
 
 	return 0;
 }
@@ -965,6 +969,14 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	if (etmq->prev_packet->sample_type == CS_ETM_EMPTY)
 		goto swap_packet;
 
+	/*
+	 * The start tracing packet is in the middle of instruction range
+	 * packets, this means the trace is discontinuous; so need to set
+	 * the previous packet flag to PERF_IP_FLAG_TRACE_END.
+	 */
+	if (etmq->prev_packet->sample_type == CS_ETM_RANGE)
+		etmq->prev_packet->flags |= PERF_IP_FLAG_TRACE_END;
+
 	if (etmq->etm->synth_opts.last_branch &&
 	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
 		/*
-- 
2.7.4

