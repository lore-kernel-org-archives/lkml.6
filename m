Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9536ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5CB20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5CB20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbeGPICF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:02:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeGPICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:02:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 052E5CA4;
        Mon, 16 Jul 2018 07:36:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.17 07/67] drm/etnaviv: bring back progress check in job timeout handler
Date:   Mon, 16 Jul 2018 09:34:36 +0200
Message-Id: <20180716073444.276938236@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <l.stach@pengutronix.de>

commit 2c83a726d6fbb5d130d8f2edd82a258adb675ac3 upstream.

When the hangcheck handler was replaced by the DRM scheduler timeout
handling we dropped the forward progress check, as this might allow
clients to hog the GPU for a long time with a big job.

It turns out that even reasonably well behaved clients like the
Armada Xorg driver occasionally trip over the 500ms timeout. Bring
back the forward progress check to get rid of the userspace regression.

We would still like to fix userspace to submit smaller batches
if possible, but that is for another day.

Cc: <stable@vger.kernel.org>
Fixes: 6d7a20c07760 (drm/etnaviv: replace hangcheck with scheduler timeout)
Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h   |    3 +++
 drivers/gpu/drm/etnaviv/etnaviv_sched.c |   24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -142,6 +142,9 @@ struct etnaviv_gpu {
 	struct work_struct sync_point_work;
 	int sync_point_event;
 
+	/* hang detection */
+	u32 hangcheck_dma_addr;
+
 	void __iomem *mmio;
 	int irq;
 
--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -21,6 +21,7 @@
 #include "etnaviv_gem.h"
 #include "etnaviv_gpu.h"
 #include "etnaviv_sched.h"
+#include "state.xml.h"
 
 static int etnaviv_job_hang_limit = 0;
 module_param_named(job_hang_limit, etnaviv_job_hang_limit, int , 0444);
@@ -96,6 +97,29 @@ static void etnaviv_sched_timedout_job(s
 {
 	struct etnaviv_gem_submit *submit = to_etnaviv_submit(sched_job);
 	struct etnaviv_gpu *gpu = submit->gpu;
+	u32 dma_addr;
+	int change;
+
+	/*
+	 * If the GPU managed to complete this jobs fence, the timout is
+	 * spurious. Bail out.
+	 */
+	if (fence_completed(gpu, submit->out_fence->seqno))
+		return;
+
+	/*
+	 * If the GPU is still making forward progress on the front-end (which
+	 * should never loop) we shift out the timeout to give it a chance to
+	 * finish the job.
+	 */
+	dma_addr = gpu_read(gpu, VIVS_FE_DMA_ADDRESS);
+	change = dma_addr - gpu->hangcheck_dma_addr;
+	if (change < 0 || change > 16) {
+		gpu->hangcheck_dma_addr = dma_addr;
+		schedule_delayed_work(&sched_job->work_tdr,
+				      sched_job->sched->timeout);
+		return;
+	}
 
 	/* block scheduler */
 	kthread_park(gpu->sched.thread);


