Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8C1C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544B020874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYOhmqgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544B020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeFRFLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:11:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44572 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754288AbeFRFKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:10:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id h12-v6so7546816pfk.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 22:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VluCxox9i+3sQWY1zqCtkHVxp5JhXszaU7yPvjVQVQo=;
        b=ZYOhmqgmlPCpkPaX3GPPro7Z9Dne6z9R2muhpb7SRLqgtHtTDwzlw11aC5A3wJXdXd
         +feNQaz4vlmvHWj27G2ltDDCY4Bn7n3r6xXiJprbntvsmqc/PUlGtCYwekFJAxFhq+57
         KUPGkSbsXnUJ9q7FYBFmf+koTxEJRMDVmSZOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VluCxox9i+3sQWY1zqCtkHVxp5JhXszaU7yPvjVQVQo=;
        b=TJ0dDMpOOhyyv7RTPmTRmHdXkb+26q040kKCR9eVc6GelFYM+LtkjiK+SpnwKAIkBO
         yTxDVnGQy4Iu8hSn3S5hfDKFSwKVEtoDa9Aa7bXYwGlte06Y3k3GIwknN4Vvl1DoSyCY
         98yrbdE+tSLflWWxPO2HNggRk6M7fJxP19GuGnasyv6nzVXrRtfV/NJ9xDyDS4hStCcn
         p0Nx13y2wIkcCeJAx30hpqZkLAjgBTU7AFYfGSQo4jAwCsE4+cFhZg0hEzdf2fc7Tjhd
         E59pGYYhwBLUbS6VREHrYwOwcSQFAG8qoKF9Ce8B6SKvSydEwxbH/RcG98Wz/pEWK2wM
         f9PQ==
X-Gm-Message-State: APt69E3w1Tq6WbzIyhnMEveqpnc+sC+yfV3m/bIrjEVvQVR1jeUIeieL
        FMngpTweKDT7IkcMGSJpXv+nhg==
X-Google-Smtp-Source: ADUXVKKc1GAT7Kc3YeW0cB6FhQhWJqk8V2vz7dGqKkIFhey8AIbUz4uQ9g11sKNy0m7x1S+wXfKvmw==
X-Received: by 2002:a63:449:: with SMTP id 70-v6mr9788230pge.229.1529298648903;
        Sun, 17 Jun 2018 22:10:48 -0700 (PDT)
Received: from localhost.localdomain (li1181-92.members.linode.com. [45.79.82.92])
        by smtp.gmail.com with ESMTPSA id l15-v6sm29051710pfg.88.2018.06.17.22.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 22:10:48 -0700 (PDT)
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
Subject: [PATCH v1 4/6] perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
Date:   Mon, 18 Jun 2018 13:09:57 +0800
Message-Id: <1529298599-3876-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
References: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
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

