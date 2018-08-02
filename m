Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3680C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A256A2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A256A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeHBKEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:04:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50941 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbeHBKEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:04:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728Da4A3431350
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:13:36 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728DZLj3431346;
        Thu, 2 Aug 2018 01:13:35 -0700
Date:   Thu, 2 Aug 2018 01:13:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-6035b6804bdfd662c8ee6226dc90f3764060ec73@git.kernel.org>
Cc:     kim.phillips@arm.com, mike.leach@linaro.org, jolsa@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, robert.walker@arm.com,
        peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        mathieu.poirier@linaro.org, namhyung@kernel.org, leo.yan@linaro.org
Reply-To: linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          mathieu.poirier@linaro.org, leo.yan@linaro.org,
          namhyung@kernel.org, acme@redhat.com, kim.phillips@arm.com,
          mike.leach@linaro.org, jolsa@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, robert.walker@arm.com, peterz@infradead.org,
          hpa@zytor.com
In-Reply-To: <1531295145-596-5-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-5-git-send-email-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Support dummy address value for
 CS_ETM_TRACE_ON packet
Git-Commit-ID: 6035b6804bdfd662c8ee6226dc90f3764060ec73
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6035b6804bdfd662c8ee6226dc90f3764060ec73
Gitweb:     https://git.kernel.org/tip/6035b6804bdfd662c8ee6226dc90f3764060ec73
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Wed, 11 Jul 2018 15:45:43 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 10:58:29 -0300

perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet

For CS_ETM_TRACE_ON packet, its fields 'packet->start_addr' and
'packet->end_addr' equal to 0xdeadbeefdeadbeefUL which are emitted in
the decoder layer as dummy value, but the dummy value is pointless for
branch sample when we use 'perf script' command to check program flow.

This patch is a preparation to support CS_ETM_TRACE_ON packet for branch
sample, it converts the dummy address value to zero for more readable;
this is accomplished by cs_etm__last_executed_instr() and
cs_etm__first_executed_instr().  The later one is a new function
introduced by this patch.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1531295145-596-5-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ae7c9c880cb2..976db8483478 100644
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
