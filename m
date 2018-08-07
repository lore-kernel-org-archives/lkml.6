Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4764C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F312157F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V70a9Q7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F312157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbeHGPXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:23:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34168 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388540AbeHGPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:23:47 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so7115059plo.1;
        Tue, 07 Aug 2018 06:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lsOtx16AxfbBHSko8SMIaVbUyhKMO7+gBiA+J7XcJzs=;
        b=V70a9Q7g/He681U5/rsuJ64Y6CUyUrNMV/kgGWqgSbJV9shccikPAZUArvLRcTy1xC
         VVsZV0Zn/F429OX35e5O81G6j+GunhO8dLcmAPUNYHYQE6Xtr74mnswuga4rF5Ay7+EB
         G02VVwp0ZxdS6wZBEDPk+jaj8ygfL3T37ZfYmbPpxL7IS1QYpdT7uGBUCNnQJRTXS1PQ
         iNKURoVmGXMbNWbDjllNAm6zzKArK5JN8U8nWAeDkEVpx+hQGX5ihpWf6oyLx1oFVk6t
         h0e2QfCxRD9wUPMX2m0WOa4/y3hp922LtODaNB6FioJ4YA3NpXJSkzi1kVPVlVGoztF0
         lcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lsOtx16AxfbBHSko8SMIaVbUyhKMO7+gBiA+J7XcJzs=;
        b=pFwL13buKNbirQcqxJCoNYm6skoXEKhSaCn5ZhfjV8ahrNYb1AvyEp3pEi0Acoq1I8
         HKyRwVpE01GM85OWAj21ugSdBW/xlFuVMyCDjzCq4cZLIMEZ8t+Q2ttpigVuoQ1K+o38
         dhlJ8K9u+YsIiKztX+QnrzNyniD5WTMP5HMkCj/aQfrcadtdHeeS9g0TXsqLeLAuy1Dy
         VX0PL459dejFvglFRdz/CCT3nGqoH8JWo6AngYqMbN5MaazbNKwa5uiYQlCe5hh5jvDb
         BJPGTXAt4KeH4bjE+7qAAZMf0x1sDhWylsdQaDCsdSPTPej09QNy8UeRXeCmXZG+oZIp
         NX1Q==
X-Gm-Message-State: AOUpUlE57J9aklqqtwNm0/KGYtQ6Rfawz34jKMhFmT1rTE4ONmq5mvoO
        qUH6+o1/dYf2cLH44kXhoNs=
X-Google-Smtp-Source: AAOMgpeVxDmnx5gABr39DOCCY9o8CrvjYZpJ7FIxsJ0/ZI8Z1QMIhMCvcCJ+P+l5ybw8Gwh0uZ7fvg==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1-v6mr18059215plp.20.1533647371539;
        Tue, 07 Aug 2018 06:09:31 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 73-v6sm5339229pfu.20.2018.08.07.06.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 06:09:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] gpu: host1x: Cancel only job that actually got stuck
Date:   Tue,  7 Aug 2018 16:07:11 +0300
Message-Id: <20180807130713.1016-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807130713.1016-1-digetx@gmail.com>
References: <20180807130713.1016-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host1x doesn't have information about jobs inter-dependency, that is
something that will become available once host1x will get a proper
jobs scheduler implementation. Currently a hang job causes other unrelated
jobs to be canceled, that is a relic from downstream driver which is
irrelevant to upstream. Let's cancel only the hanging job and not to touch
other jobs in queue.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/cdma.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 91df51e631b2..75f339f5df6f 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -348,13 +348,11 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 	}
 
 	/*
-	 * Walk the sync_queue, first incrementing with the CPU syncpts that
-	 * are partially executed (the first buffer) or fully skipped while
-	 * still in the current context (slots are also NOP-ed).
+	 * Increment with CPU the remaining syncpts of a partially executed job.
 	 *
-	 * At the point contexts are interleaved, syncpt increments must be
-	 * done inline with the pushbuffer from a GATHER buffer to maintain
-	 * the order (slots are modified to be a GATHER of syncpt incrs).
+	 * Syncpt increments must be done inline with the pushbuffer from a
+	 * GATHER buffer to maintain the order (slots are modified to be a
+	 * GATHER of syncpt incrs).
 	 *
 	 * Note: save in restart_addr the location where the timed out buffer
 	 * started in the PB, so we can start the refetch from there (with the
@@ -362,20 +360,15 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 	 * properly for this buffer and resources are freed.
 	 */
 
-	dev_dbg(dev, "%s: perform CPU incr on pending same ctx buffers\n",
-		__func__);
+	dev_dbg(dev, "%s: perform CPU incr on pending buffers\n", __func__);
 
 	if (!list_empty(&cdma->sync_queue))
 		restart_addr = job->first_get;
 	else
 		restart_addr = cdma->last_pos;
 
-	/* do CPU increments as long as this context continues */
-	list_for_each_entry_from(job, &cdma->sync_queue, list) {
-		/* different context, gets us out of this loop */
-		if (job->client != cdma->timeout.client)
-			break;
-
+	/* do CPU increments for the remaining syncpts */
+	if (job) {
 		/* won't need a timeout when replayed */
 		job->timeout = 0;
 
@@ -388,20 +381,8 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 		host1x_hw_cdma_timeout_cpu_incr(host1x, cdma, job->first_get,
 						syncpt_incrs, job->syncpt_end,
 						job->num_slots);
-
-		syncpt_val += syncpt_incrs;
 	}
 
-	/*
-	 * The following sumbits from the same client may be dependent on the
-	 * failed submit and therefore they may fail. Force a small timeout
-	 * to make the queue cleanup faster.
-	 */
-
-	list_for_each_entry_from(job, &cdma->sync_queue, list)
-		if (job->client == cdma->timeout.client)
-			job->timeout = min_t(unsigned int, job->timeout, 500);
-
 	dev_dbg(dev, "%s: finished sync_queue modification\n", __func__);
 
 	/* roll back DMAGET and start up channel again */
-- 
2.18.0

