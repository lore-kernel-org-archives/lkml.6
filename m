Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8B62229F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191673;
	bh=59/Jn+pGlKT7JzKEMbIhX3CYYQrWCvYqFcJL9XeciIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0rE4/MrskSvIu3AD/DKls4pu9pE8fT61a4B6a4g2rJlane5NyjwEUZ/KNtX7NozsT
	 HNelwl6HzsO0D8YPapqoTwrJulTHDoQ3IlMemrDjMn2xXSeWlOExaJTmS9xENlllCj
	 Zw8b+jwAyNUK8x0GS5q/L/0t+wlVRNuxrBgHJTUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbfBOArw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389377AbfBOArq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:47:46 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF36222D0;
        Fri, 15 Feb 2019 00:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191665;
        bh=59/Jn+pGlKT7JzKEMbIhX3CYYQrWCvYqFcJL9XeciIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FvhgmoLipdaH5yxlQDP9ynnnPY0u5qu5F3dhw/fttZ6B/bnoTDQcOyXeBsgKQY/+T
         j2kK7SlFj6CJDvVgYGrHLPBaPfCr8axPhuxoBe9wIGgDmmp9kn/qhc6lfU6Wbwe6yK
         A4yfOZakYbHAn1Ag7SA1DjExUIhCZWi+ZS7lrl88=
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
Subject: [PATCH 27/43] perf cs-etm: Fix memory leak in error path
Date:   Thu, 14 Feb 2019 21:45:23 -0300
Message-Id: <20190215004539.23571-28-acme@kernel.org>
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

Memory allocated for variable 't_params' isn't released properly in the
error path of function cs_etm_queue *cs_etm__alloc_queue() and
cs_etm__dump_event(), something this patch addresses.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-6-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3011c6cae531..aac07f950074 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -175,6 +175,10 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
+
+	if (!t_params)
+		return;
+
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
 			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
@@ -206,14 +210,12 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, NULL,
 					CS_ETM_OPERATION_PRINT))
-		return;
+		goto out_free;
 
 	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-	zfree(&t_params);
-
 	if (!decoder)
-		return;
+		goto out_free;
 	do {
 		size_t consumed;
 
@@ -228,6 +230,9 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	} while (buffer_used < buffer->size);
 
 	cs_etm_decoder__free(decoder);
+
+out_free:
+	zfree(&t_params);
 }
 
 static int cs_etm__flush_events(struct perf_session *session,
@@ -379,7 +384,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 {
 	int i;
 	struct cs_etm_decoder_params d_params;
-	struct cs_etm_trace_params  *t_params;
+	struct cs_etm_trace_params  *t_params = NULL;
 	struct cs_etm_queue *etmq;
 	size_t szp = sizeof(struct cs_etm_packet);
 
@@ -461,8 +466,6 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 
 	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-	zfree(&t_params);
-
 	if (!etmq->decoder)
 		goto out_free;
 
@@ -475,6 +478,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 					      cs_etm__mem_access))
 		goto out_free_decoder;
 
+	zfree(&t_params);
+
 	etmq->offset = 0;
 	etmq->period_instructions = 0;
 
@@ -483,6 +488,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 out_free_decoder:
 	cs_etm_decoder__free(etmq->decoder);
 out_free:
+	zfree(&t_params);
 	zfree(&etmq->event_buf);
 	zfree(&etmq->last_branch);
 	zfree(&etmq->last_branch_rb);
-- 
2.19.1

