Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B7DC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A9F20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A9F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbeJNXen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:34:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37477 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727972AbeJNXen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:34:43 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM0-0004cJ-Jb; Sun, 14 Oct 2018 16:30:52 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLT-0000NY-PP; Sun, 14 Oct 2018 16:30:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Jordan Crouse" <jcrouse@codeaurora.org>,
        "Rob Clark" <robdclark@gmail.com>,
        "Ben Hutchings" <ben.hutchings@codethink.co.uk>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.32353457@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 176/366] drm/msm: Fix possible null dereference on
 failure of get_pages()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

commit 3976626ea3d2011f8fd3f3a47070a8b792018253 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/msm/msm_gem.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -110,17 +110,19 @@ static void put_pages(struct drm_gem_obj
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
 
 		if (iommu_present(&platform_bus_type))
 			drm_gem_put_pages(obj, msm_obj->pages, true, false);

