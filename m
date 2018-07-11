Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814E9C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353FA20862
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXQJoJag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353FA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeGKHtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:49:42 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33834 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeGKHtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:49:42 -0400
Received: by mail-pf0-f196.google.com with SMTP id e10-v6so17882391pfn.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IiQfwRzRhFenPKx3syT6YyzO11tbIr5zqBzOVPhTzi8=;
        b=QXQJoJaglHOWDMCetJj+TAAOswR1/izRmxSO0hGE1iL2cnnz1bUm/PnB0903/jLfn/
         OyP09mVMvUq1CA52tmFv3cw01cYaUdI7kPKc/58t3/IaqXJZInFx6i5DBQItiOLew04a
         Y+eVm4EDuEB7m/zhaynTQU/8exKN46fh91JZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IiQfwRzRhFenPKx3syT6YyzO11tbIr5zqBzOVPhTzi8=;
        b=Bs6hOS/XpsfhcqEkU94W5EcZcJGsezefI5EE/V4RNWmNq8Jfp9lG9CN9FfA4bcqW+W
         oRTn2S4etwN+OO0c+AJbQ+3NHzN0dkdDVZfd8Kf3WkvvvXHnV23Mvi8NSzMqPpyQIA9f
         C6bMXxv8+BhiBlyckWQDmiUTlvZh5ggB3FAqhYnXrHfHBx8E31Wn6MB/oQiBBUGvz5J6
         pcxel0UU3hCwsJ008LM1RR03HMQ2YNafw+5jYT72npuQq0ISdhsggt3kt74T3WFS4Z8I
         wJLYQP7ZS01RMw3x5mPpQnt0ico2uahxwM4bE7JnorwlU5Wn8Ea8+FNluLwm/EjrMdTo
         SBIg==
X-Gm-Message-State: APt69E0dvXBcIyxEOJAT3RlmXLNPoLJbKnV8B6DWhICH+R4NkFNUc4PB
        1yir7XVkrwLTw4ThpVEmxdzkBw==
X-Google-Smtp-Source: AAOMgpfel0JRJNqI1zNCO+hhILrThAQXwwubxngx5QjWaC204ZxSaHAF8arTO+w6hhNvQurc0wC0gg==
X-Received: by 2002:a63:6986:: with SMTP id e128-v6mr3732916pgc.294.1531295204182;
        Wed, 11 Jul 2018 00:46:44 -0700 (PDT)
Received: from localhost.localdomain (li1192-169.members.linode.com. [45.79.93.169])
        by smtp.gmail.com with ESMTPSA id 16-v6sm9260374pfp.6.2018.07.11.00.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 00:46:43 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/6] perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
Date:   Wed, 11 Jul 2018 15:45:43 +0800
Message-Id: <1531295145-596-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For CS_ETM_TRACE_ON packet, its fields 'packet->start_addr' and
'packet->end_addr' equal to 0xdeadbeefdeadbeefUL which are emitted in
the decoder layer as dummy value, but the dummy value is pointless for
branch sample when we use 'perf script' command to check program flow.

This patch is a preparation to support CS_ETM_TRACE_ON packet for
branch sample, it converts the dummy address value to zero for more
readable; this is accomplished by cs_etm__last_executed_instr() and
cs_etm__first_executed_instr().  The later one is a new function
introduced by this patch.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ae7c9c88..976db84 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -494,6 +494,10 @@ static inline void cs_etm__reset_last_branch_rb(struct cs_etm_queue *etmq)
 
 static inline u64 cs_etm__last_executed_instr(struct cs_etm_packet *packet)
 {
+	/* Returns 0 for the CS_ETM_TRACE_ON packet */
+	if (packet->sample_type == CS_ETM_TRACE_ON)
+		return 0;
+
 	/*
 	 * The packet records the execution range with an exclusive end address
 	 *
@@ -505,6 +509,15 @@ static inline u64 cs_etm__last_executed_instr(struct cs_etm_packet *packet)
 	return packet->end_addr - A64_INSTR_SIZE;
 }
 
+static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
+{
+	/* Returns 0 for the CS_ETM_TRACE_ON packet */
+	if (packet->sample_type == CS_ETM_TRACE_ON)
+		return 0;
+
+	return packet->start_addr;
+}
+
 static inline u64 cs_etm__instr_count(const struct cs_etm_packet *packet)
 {
 	/*
@@ -546,7 +559,7 @@ static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq)
 
 	be       = &bs->entries[etmq->last_branch_pos];
 	be->from = cs_etm__last_executed_instr(etmq->prev_packet);
-	be->to	 = etmq->packet->start_addr;
+	be->to	 = cs_etm__first_executed_instr(etmq->packet);
 	/* No support for mispredict */
 	be->flags.mispred = 0;
 	be->flags.predicted = 1;
@@ -701,7 +714,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
 	sample.ip = cs_etm__last_executed_instr(etmq->prev_packet);
 	sample.pid = etmq->pid;
 	sample.tid = etmq->tid;
-	sample.addr = etmq->packet->start_addr;
+	sample.addr = cs_etm__first_executed_instr(etmq->packet);
 	sample.id = etmq->etm->branches_id;
 	sample.stream_id = etmq->etm->branches_id;
 	sample.period = 1;
-- 
2.7.4

