Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 26NXBVM9GVsKPwAAmS7hNA
	; Thu, 07 Jun 2018 14:13:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0DCFD608B8; Thu,  7 Jun 2018 14:13:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F1FB96089E;
	Thu,  7 Jun 2018 14:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1FB96089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeFGOLv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:11:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39555 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933168AbeFGOJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:40 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbG-0005Zp-0P; Thu, 07 Jun 2018 15:09:14 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003Fp-W8; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Michel =?UTF-8?Q?D=C3=A4nzer?=" <michel.daenzer@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.710052669@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 361/410] drm/radeon: fix prime teardown order
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit 0f4f715bc6bed3bf14c5cd7d5fe88d443e756b14 upstream.

We unmapped imported DMA-bufs when the GEM handle was dropped, not when the
hardware was done with the buffere.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/radeon/radeon_gem.c    | 2 --
 drivers/gpu/drm/radeon/radeon_object.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -34,8 +34,6 @@ void radeon_gem_object_free(struct drm_g
 	struct radeon_bo *robj = gem_to_radeon_bo(gobj);
 
 	if (robj) {
-		if (robj->gem_base.import_attach)
-			drm_prime_gem_destroy(&robj->gem_base, robj->tbo.sg);
 		radeon_bo_unref(&robj);
 	}
 }
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -91,6 +91,8 @@ static void radeon_ttm_bo_destroy(struct
 	mutex_unlock(&bo->rdev->gem.mutex);
 	radeon_bo_clear_surface_reg(bo);
 	radeon_bo_clear_va(bo);
+	if (bo->gem_base.import_attach)
+		drm_prime_gem_destroy(&bo->gem_base, bo->tbo.sg);
 	drm_gem_object_release(&bo->gem_base);
 	kfree(bo);
 }
