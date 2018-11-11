Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D91A20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D91A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbeKLFw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:52:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51078 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730697AbeKLFsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:31 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsq-0000oM-Ks; Sun, 11 Nov 2018 19:59:00 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001jm-RU; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Sean Paul" <seanpaul@chromium.org>,
        "Nicholas Mc Guire" <hofrat@osadl.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.625280545@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 260/366] drm: re-enable error handling
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

commit d530b5f1ca0bb66958a2b714bebe40a1248b9c15 upstream.

drm_legacy_ctxbitmap_next() returns idr_alloc() which can return
-ENOMEM, -EINVAL or -ENOSPC none of which are -1 . but the call sites
of drm_legacy_ctxbitmap_next() seem to be assuming that the error case
would be -1 (original return of drm_ctxbitmap_next() prior to 2.6.23
was actually -1). Thus reenable error handling by checking for < 0.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 62968144e673 ("drm: convert drm context code to use Linux idr")
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/1531571532-22733-1-git-send-email-hofrat@osadl.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/drm_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_context.c
+++ b/drivers/gpu/drm/drm_context.c
@@ -316,7 +316,7 @@ int drm_addctx(struct drm_device *dev, v
 		ctx->handle = drm_ctxbitmap_next(dev);
 	}
 	DRM_DEBUG("%d\n", ctx->handle);
-	if (ctx->handle == -1) {
+	if (ctx->handle < 0) {
 		DRM_DEBUG("Not enough free contexts.\n");
 		/* Should this return -EBUSY instead? */
 		return -ENOMEM;

