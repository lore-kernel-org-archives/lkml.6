Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BE8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F7A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544053;
	bh=G5XxjqRYjlgJItjFkK6C+IMaj0YQL8bHLhUNpZkW6EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s6iVqpcJicH6cUrt2puZgQJ28DVZuDZktHGA7jes6WofhEOtlEnSS7mBoriPsqWbS
	 GOgkDRIVQSeqKFO0EIBXOO3ghbcODSHGN+6fVBUT+/u+6wa+Q3J9CUbkf+WdralurX
	 l2OdbAVcTnwRCWPIbdPBuKQ7bZvA4eTnjfsNsWXY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F7A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbeLKQAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:00:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730232AbeLKP57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCE8A205C9;
        Tue, 11 Dec 2018 15:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543879;
        bh=G5XxjqRYjlgJItjFkK6C+IMaj0YQL8bHLhUNpZkW6EQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQle9haOoBApUtjyeiAECeZLCDKpXaLIPHa0MTnD2NdBqu5qM/xIH1/wJHhUc5zo2
         AvJ6iF0QJIFjcgUt+4DqiOfzgSJI81leGL7ETWtY+7S9N3r72MjucroevvZieIGEff
         qozHB6PuTBMnO/eEUW007nM2zKaenamE5Me+TXH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Foss <robert.foss@collabora.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4.19 099/118] drm/msm: Move fence put to where failure occurs
Date:   Tue, 11 Dec 2018 16:41:58 +0100
Message-Id: <20181211151648.269110604@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Foss <robert.foss@collabora.com>

commit 2189463dba3eac10d7264a40ede12fc1a3c06fb1 upstream.

If dma_fence_wait fails to wait for a supplied in-fence in
msm_ioctl_gem_submit, make sure we release that in-fence.

Also remove this dma_fence_put() from the 'out' label.

Signed-off-by: Robert Foss <robert.foss@collabora.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/msm/msm_gem_submit.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -410,7 +410,6 @@ int msm_ioctl_gem_submit(struct drm_devi
 	struct msm_file_private *ctx = file->driver_priv;
 	struct msm_gem_submit *submit;
 	struct msm_gpu *gpu = priv->gpu;
-	struct dma_fence *in_fence = NULL;
 	struct sync_file *sync_file = NULL;
 	struct msm_gpu_submitqueue *queue;
 	struct msm_ringbuffer *ring;
@@ -443,6 +442,8 @@ int msm_ioctl_gem_submit(struct drm_devi
 	ring = gpu->rb[queue->prio];
 
 	if (args->flags & MSM_SUBMIT_FENCE_FD_IN) {
+		struct dma_fence *in_fence;
+
 		in_fence = sync_file_get_fence(args->fence_fd);
 
 		if (!in_fence)
@@ -452,11 +453,13 @@ int msm_ioctl_gem_submit(struct drm_devi
 		 * Wait if the fence is from a foreign context, or if the fence
 		 * array contains any fence from a foreign context.
 		 */
-		if (!dma_fence_match_context(in_fence, ring->fctx->context)) {
+		ret = 0;
+		if (!dma_fence_match_context(in_fence, ring->fctx->context))
 			ret = dma_fence_wait(in_fence, true);
-			if (ret)
-				return ret;
-		}
+
+		dma_fence_put(in_fence);
+		if (ret)
+			return ret;
 	}
 
 	ret = mutex_lock_interruptible(&dev->struct_mutex);
@@ -582,8 +585,6 @@ int msm_ioctl_gem_submit(struct drm_devi
 	}
 
 out:
-	if (in_fence)
-		dma_fence_put(in_fence);
 	submit_cleanup(submit);
 	if (ret)
 		msm_gem_submit_free(submit);


