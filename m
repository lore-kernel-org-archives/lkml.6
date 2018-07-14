Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35111ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CE72086B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CE72086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeGNM4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 08:56:20 -0400
Received: from www.osadl.org ([62.245.132.105]:36844 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbeGNM4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 08:56:20 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6ECWu8X023927;
        Sat, 14 Jul 2018 14:32:56 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Gustavo Padovan <gustavo@padovan.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] drm: re-enable error handling
Date:   Sat, 14 Jul 2018 14:32:12 +0200
Message-Id: <1531571532-22733-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_legacy_ctxbitmap_next() returns idr_alloc() which can return
-ENOMEM, -EINVAL or -ENOSPC none of which are -1 . but the call sites 
of drm_legacy_ctxbitmap_next() seem to be assuming that the error case
would be -1 (original return of drm_ctxbitmap_next() prior to 2.6.23
was actually -1). Thus reenable error handling by checking for < 0.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 62968144e673 ("drm: convert drm context code to use Linux idr")
---

Problem located with experimental coccinelle script

The noted Fixes tag is one of the commits that removed the -1 return
value in 2.6.23 in drm_ctxbitmap_next() but thats not the only change
that must have taken place to invalidate the error check.

Patch was compile tested with: x86_64_defconfig

Patch is against 4.18-rc4 (localversion-next is next-20180713)

 drivers/gpu/drm/drm_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
index 3c4000f..f973d28 100644
--- a/drivers/gpu/drm/drm_context.c
+++ b/drivers/gpu/drm/drm_context.c
@@ -372,7 +372,7 @@ int drm_legacy_addctx(struct drm_device *dev, void *data,
 		ctx->handle = drm_legacy_ctxbitmap_next(dev);
 	}
 	DRM_DEBUG("%d\n", ctx->handle);
-	if (ctx->handle == -1) {
+	if (ctx->handle < 0) {
 		DRM_DEBUG("Not enough free contexts.\n");
 		/* Should this return -EBUSY instead? */
 		return -ENOMEM;
-- 
2.1.4

