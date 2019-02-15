Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2456C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4E4222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191682;
	bh=T354beYzSKX9jaLyEiLMxRWSCwNVNXXElIwYhxrdRy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YsEyKaXuaAbsclDX9hLZaWsWnXDMg2tBAm04cmwrVJM/rQuUGVEJLZvbLDhP9ucsN
	 Ty6zGT4bgZpWGCyY8eA+ufh0H72KUS0HVkiak4l0f0b5B7XaevmYayoatEp3pLEqpo
	 Q3+7Ok+1PeL+j/wIJ4MnXr0GtEjWUdbwah9QnxSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389491AbfBOAsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:48:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389443AbfBOAsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:48:00 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E172229F;
        Fri, 15 Feb 2019 00:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191679;
        bh=T354beYzSKX9jaLyEiLMxRWSCwNVNXXElIwYhxrdRy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCnCLwLi4KMpA1TxI3aIASI4aE7Q2bPh3PLq1VM5GAH1Hgc0IDrMsE4aVdtVQNQw/
         1gpQBK6ykXxkVzCpuzxxcU3QkEaUrUDxtopneOK4wgEKjXYSueaUpdmV11gggPBYDF
         BPhkebYjCAiDVJlaIlYzMSCmW3T2ufey5py3gS9c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/43] perf cs-etm: Cleaning up function cs_etm__alloc_queue()
Date:   Thu, 14 Feb 2019 21:45:26 -0300
Message-Id: <20190215004539.23571-31-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

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
-- 
2.19.1

