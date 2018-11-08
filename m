Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3367ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C6A20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVJlsU2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C6A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbeKIHoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730393AbeKIHoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:07 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDC2920892;
        Thu,  8 Nov 2018 22:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714796;
        bh=8Pc36kETOyESt388nlIfWSxxlhJZ+1Q4vx8l3GJ4suo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVJlsU2P3RdaSJyLm83y4hnvI1p4J9KJ7f7Xah/uHcs+SRaAFHp1Putryshb5miLg
         QqOHpo4lNrQl+E1bljTQ6cCeey4k+TmltYJ2fba0z3xmphK3AjG3dxbNYGB5/0irwg
         mUSlPQ58Ch/owPnXsDCMRrvQgHnW5pGeAGYa0Fm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 104/171] drm/msm: Fix possible null dereference on failure of get_pages()
Date:   Thu,  8 Nov 2018 13:51:14 -0800
Message-Id: <20181108215134.936530591@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



