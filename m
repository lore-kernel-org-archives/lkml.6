Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9957BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6196B208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsex3l1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6196B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeJYWtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbeJYWtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:11 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50EBF20854;
        Thu, 25 Oct 2018 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476974;
        bh=KhME3cJQXf6kKyu8q6gImjGt3dDN6PXYaS+s390rP44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsex3l1hGDPh4Yh6g5v43OUYOuR3N/vAamM7IaixaTyKNabtWEwVb4piy60ssdzwF
         UqwuIDQXiJR7lUuVfU8bIbxIvXHmgaRmvLVt7e6xXq58gk3rTaL1iOuSFbzFBOiKwc
         G5MlVbKvUYvnD7NH2iZ9b9uk4vcEo3ixYt1hf3/E=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 75/98] drm/msm: Fix possible null dereference on failure of get_pages()
Date:   Thu, 25 Oct 2018 10:14:00 -0400
Message-Id: <20181025141423.213774-75-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 7145127513c4..795660e29b2c 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -118,17 +118,19 @@ static void put_pages(struct drm_gem_object *obj)
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
-- 
2.17.1

