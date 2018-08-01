Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9B8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879B02083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879B02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbeHAUHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:07:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404451AbeHATDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 41C551064;
        Wed,  1 Aug 2018 17:01:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 155/336] drm/nouveau: remove fence wait code from deferred client work handler
Date:   Wed,  1 Aug 2018 18:48:10 +0200
Message-Id: <20180801165035.053908707@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 11e451e74050d9e9030581ce40337838acfcea5b ]

Fences attached to deferred client work items now originate from channels
belonging to the client, meaning we can be certain they've been signalled
before we destroy a client.

This closes a race that could happen if the dma_fence_wait_timeout() call
didn't succeed.  When the fence was later signalled, a use-after-free was
possible.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -116,24 +116,22 @@ nouveau_name(struct drm_device *dev)
 }
 
 static inline bool
-nouveau_cli_work_ready(struct dma_fence *fence, bool wait)
+nouveau_cli_work_ready(struct dma_fence *fence)
 {
-	if (!dma_fence_is_signaled(fence)) {
-		if (!wait)
-			return false;
-		WARN_ON(dma_fence_wait_timeout(fence, false, 2 * HZ) <= 0);
-	}
+	if (!dma_fence_is_signaled(fence))
+		return false;
 	dma_fence_put(fence);
 	return true;
 }
 
 static void
-nouveau_cli_work_flush(struct nouveau_cli *cli, bool wait)
+nouveau_cli_work(struct work_struct *w)
 {
+	struct nouveau_cli *cli = container_of(w, typeof(*cli), work);
 	struct nouveau_cli_work *work, *wtmp;
 	mutex_lock(&cli->lock);
 	list_for_each_entry_safe(work, wtmp, &cli->worker, head) {
-		if (!work->fence || nouveau_cli_work_ready(work->fence, wait)) {
+		if (!work->fence || nouveau_cli_work_ready(work->fence)) {
 			list_del(&work->head);
 			work->func(work);
 		}
@@ -162,16 +160,16 @@ nouveau_cli_work_queue(struct nouveau_cl
 }
 
 static void
-nouveau_cli_work(struct work_struct *w)
-{
-	struct nouveau_cli *cli = container_of(w, typeof(*cli), work);
-	nouveau_cli_work_flush(cli, false);
-}
-
-static void
 nouveau_cli_fini(struct nouveau_cli *cli)
 {
-	nouveau_cli_work_flush(cli, true);
+	/* All our channels are dead now, which means all the fences they
+	 * own are signalled, and all callback functions have been called.
+	 *
+	 * So, after flushing the workqueue, there should be nothing left.
+	 */
+	flush_work(&cli->work);
+	WARN_ON(!list_empty(&cli->worker));
+
 	usif_client_fini(cli);
 	nouveau_vmm_fini(&cli->vmm);
 	nvif_mmu_fini(&cli->mmu);


