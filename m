Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4FCECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3736D2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3736D2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeKIBke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:40:34 -0500
Received: from anholt.net ([50.246.234.109]:33198 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeKIBke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:40:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 13C3D10A1314;
        Thu,  8 Nov 2018 08:04:25 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id CLRm8vxMDk-K; Thu,  8 Nov 2018 08:04:23 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1076E10A04D0;
        Thu,  8 Nov 2018 08:04:23 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 511812FE1B8E; Thu,  8 Nov 2018 08:04:22 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Nayan Deshmukh <nayan26deshmukh@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] Revert "drm/sched: fix timeout handling v2"
Date:   Thu,  8 Nov 2018 08:04:21 -0800
Message-Id: <20181108160422.17743-2-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108160422.17743-1-eric@anholt.net>
References: <20181108160422.17743-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0efd2d2f68cd5dbddf4ecd974c33133257d16a8e.  Fixes
this failure in V3D GPU reset:

[ 1418.227796] Unable to handle kernel NULL pointer dereference at virtual address 00000018
[ 1418.235947] pgd = dc4c55ca
[ 1418.238695] [00000018] *pgd=80000040004003, *pmd=00000000
[ 1418.244132] Internal error: Oops: 206 [#1] SMP ARM
[ 1418.248934] Modules linked in:
[ 1418.252001] CPU: 0 PID: 10253 Comm: kworker/0:0 Not tainted 4.19.0-rc6+ #486
[ 1418.259058] Hardware name: Broadcom STB (Flattened Device Tree)
[ 1418.265002] Workqueue: events drm_sched_job_timedout
[ 1418.269986] PC is at dma_fence_remove_callback+0x8/0x50
[ 1418.275218] LR is at drm_sched_job_timedout+0x4c/0x118
...
[ 1418.415891] [<c086b754>] (dma_fence_remove_callback) from [<c06e7e6c>] (drm_sched_job_timedout+0x4c/0x118)
[ 1418.425571] [<c06e7e6c>] (drm_sched_job_timedout) from [<c0242500>] (process_one_work+0x2c8/0x7bc)
[ 1418.434552] [<c0242500>] (process_one_work) from [<c0242a38>] (worker_thread+0x44/0x590)
[ 1418.442663] [<c0242a38>] (worker_thread) from [<c0249b10>] (kthread+0x160/0x168)
[ 1418.450076] [<c0249b10>] (kthread) from [<c02010ac>] (ret_from_fork+0x14/0x28)

Cc: Christian König <christian.koenig@amd.com>
Cc: Nayan Deshmukh <nayan26deshmukh@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/scheduler/sched_main.c | 30 +-------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 44fe587aaef9..bd7d11c47202 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -249,41 +249,13 @@ static void drm_sched_job_timedout(struct work_struct *work)
 {
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_job *job;
-	int r;
 
 	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
-
-	spin_lock(&sched->job_list_lock);
-	list_for_each_entry_reverse(job, &sched->ring_mirror_list, node) {
-		struct drm_sched_fence *fence = job->s_fence;
-
-		if (!dma_fence_remove_callback(fence->parent, &fence->cb))
-			goto already_signaled;
-	}
-
 	job = list_first_entry_or_null(&sched->ring_mirror_list,
 				       struct drm_sched_job, node);
-	spin_unlock(&sched->job_list_lock);
 
 	if (job)
-		sched->ops->timedout_job(job);
-
-	spin_lock(&sched->job_list_lock);
-	list_for_each_entry(job, &sched->ring_mirror_list, node) {
-		struct drm_sched_fence *fence = job->s_fence;
-
-		if (!fence->parent || !list_empty(&fence->cb.node))
-			continue;
-
-		r = dma_fence_add_callback(fence->parent, &fence->cb,
-					   drm_sched_process_job);
-		if (r)
-			drm_sched_process_job(fence->parent, &fence->cb);
-
-already_signaled:
-		;
-	}
-	spin_unlock(&sched->job_list_lock);
+		job->sched->ops->timedout_job(job);
 }
 
 /**
-- 
2.19.1

