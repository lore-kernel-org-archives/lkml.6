Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C304DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC54222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191687;
	bh=AKvOAUDF1A6gHIdwLmTBGhV9WD7vf/DuM++OockH3WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SbtIN8T6K+4C3Gwfj+gfRc+QtRKXV9XnbIOIFIj0ys+EqtkaVZgVs5R6TNxvoCfEs
	 Th48+eIyoUvpiGJLo7CkhLHJpi9ZVAwpfyQHH+fDllogxlUXvr6TKnOQAjwyOy8ARa
	 /9/pGNtgXbE4O2UAOJhNur7exyrDWtp9s6cNAUMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfBOAsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:48:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389493AbfBOAsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:48:04 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D97222D0;
        Fri, 15 Feb 2019 00:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191684;
        bh=AKvOAUDF1A6gHIdwLmTBGhV9WD7vf/DuM++OockH3WY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYL3kK/27dviTrzAVZv0ZSys8F+e8m4Fz6myrjHj7RKCHT7vvsq3ktMpjOKja57KY
         6lz+tYBZ0nSssyRFoWX2SWyb3dK8sxLsmh5eYboFZEBS4Xssa4ZGm4z+D/YPR1YQns
         zizGHQWIoRE1GnXsMWrjv0naKJYmuvWcXXrf+3J8=
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
Subject: [PATCH 31/43] perf cs-etm: Rethink kernel address initialisation
Date:   Thu, 14 Feb 2019 21:45:27 -0300
Message-Id: <20190215004539.23571-32-acme@kernel.org>
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

Moving initialisation of the kernel start address to function
cs_etm__setup_queues(), considered to be the common denominator for
queue initialisation.  That way we don't have to repeat the same code
at different places.

No change of functionatlity is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-10-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index c9a5b4935209..2d2de898ea68 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -523,6 +523,9 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
 	unsigned int i;
 	int ret;
 
+	if (!etm->kernel_start)
+		etm->kernel_start = machine__kernel_start(etm->machine);
+
 	for (i = 0; i < etm->queues.nr_queues; i++) {
 		ret = cs_etm__setup_queue(etm, &etm->queues.queue_array[i], i);
 		if (ret)
@@ -1490,14 +1493,10 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
-	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_buffer buffer;
 	size_t buffer_used, processed;
 	int err = 0;
 
-	if (!etm->kernel_start)
-		etm->kernel_start = machine__kernel_start(etm->machine);
-
 	/* Go through each buffer in the queue and decode them one by one */
 	while (1) {
 		buffer_used = 0;
-- 
2.19.1

