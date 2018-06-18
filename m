Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CE3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CB7208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CB7208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965747AbeFRKDc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:03:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54548 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935052AbeFRIST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:18:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 00553C7F;
        Mon, 18 Jun 2018 08:18:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 057/279] drm/msm: Fix possible null dereference on failure of get_pages()
Date:   Mon, 18 Jun 2018 10:10:42 +0200
Message-Id: <20180618080611.195804843@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

[ Upstream commit 3976626ea3d2011f8fd3f3a47070a8b792018253 ]

Commit 62e3a3e342af changed get_pages() to initialise
msm_gem_object::pages before trying to initialise msm_gem_object::sgt,
so that put_pages() would properly clean up pages in the failure
case.

However, this means that put_pages() now needs to check that
msm_gem_object::sgt is not null before trying to clean it up, and
this check was only applied to part of the cleanup code.  Move
it all into the conditional block.  (Strictly speaking we don't
need to make the kfree() conditional, but since we can't avoid
checking for null ourselves we may as well do so.)

Fixes: 62e3a3e342af ("drm/msm: fix leak in failed get_pages")
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_gem.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -132,17 +132,19 @@ static void put_pages(struct drm_gem_obj
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
 	if (msm_obj->pages) {
-		/* For non-cached buffers, ensure the new pages are clean
-		 * because display controller, GPU, etc. are not coherent:
-		 */
-		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
-			dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
-					msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		if (msm_obj->sgt) {
+			/* For non-cached buffers, ensure the new
+			 * pages are clean because display controller,
+			 * GPU, etc. are not coherent:
+			 */
+			if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
+				dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
+					     msm_obj->sgt->nents,
+					     DMA_BIDIRECTIONAL);
 
-		if (msm_obj->sgt)
 			sg_free_table(msm_obj->sgt);
-
-		kfree(msm_obj->sgt);
+			kfree(msm_obj->sgt);
+		}
 
 		if (use_pages(obj))
 			drm_gem_put_pages(obj, msm_obj->pages, true, false);


