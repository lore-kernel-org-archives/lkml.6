Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4C7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C5420675
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393242AbfBOJoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:44:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50609 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389363AbfBOJoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:44:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9hvTP1118929
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:43:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9hvRs1118926;
        Fri, 15 Feb 2019 01:43:57 -0800
Date:   Fri, 15 Feb 2019 01:43:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-4f5b37139fb3178b3db4e876eec0f2e92c82ac45@git.kernel.org>
Cc:     jolsa@redhat.com, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, tglx@linutronix.de, leo.yan@linaro.org,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, peterz@infradead.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          acme@redhat.com, peterz@infradead.org, mingo@kernel.org,
          leo.yan@linaro.org, hpa@zytor.com, jolsa@redhat.com,
          mathieu.poirier@linaro.org, suzuki.poulose@arm.com
In-Reply-To: <20190212171618.25355-9-mathieu.poirier@linaro.org>
References: <20190212171618.25355-9-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Cleaning up function
 cs_etm__alloc_queue()
Git-Commit-ID: 4f5b37139fb3178b3db4e876eec0f2e92c82ac45
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

Commit-ID:  4f5b37139fb3178b3db4e876eec0f2e92c82ac45
Gitweb:     https://git.kernel.org/tip/4f5b37139fb3178b3db4e876eec0f2e92c82ac45
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 12 Feb 2019 10:16:13 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:07 -0300

perf cs-etm: Cleaning up function cs_etm__alloc_queue()

Function cs_etm__alloc_queue() should only be concerned with the allocation
of memory for the etmq and accompanying decoder.  Everything else should
be done in the calling function.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-9-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4cc9fce97a86..c9a5b4935209 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -405,8 +405,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	return len;
 }
 
-static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
-						unsigned int queue_nr)
+static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 {
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params = NULL;
@@ -444,12 +443,6 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (!etmq->event_buf)
 		goto out_free;
 
-	etmq->etm = etm;
-	etmq->queue_nr = queue_nr;
-	etmq->pid = -1;
-	etmq->tid = -1;
-	etmq->cpu = -1;
-
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 
@@ -479,10 +472,6 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 		goto out_free_decoder;
 
 	zfree(&t_params);
-
-	etmq->offset = 0;
-	etmq->period_instructions = 0;
-
 	return etmq;
 
 out_free_decoder:
@@ -503,24 +492,30 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_queue *queue,
 			       unsigned int queue_nr)
 {
+	int ret = 0;
 	struct cs_etm_queue *etmq = queue->priv;
 
 	if (list_empty(&queue->head) || etmq)
-		return 0;
+		goto out;
 
-	etmq = cs_etm__alloc_queue(etm, queue_nr);
+	etmq = cs_etm__alloc_queue(etm);
 
-	if (!etmq)
-		return -ENOMEM;
+	if (!etmq) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	queue->priv = etmq;
-
-	if (queue->cpu != -1)
-		etmq->cpu = queue->cpu;
-
+	etmq->etm = etm;
+	etmq->queue_nr = queue_nr;
+	etmq->cpu = queue->cpu;
 	etmq->tid = queue->tid;
+	etmq->pid = -1;
+	etmq->offset = 0;
+	etmq->period_instructions = 0;
 
-	return 0;
+out:
+	return ret;
 }
 
 static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
