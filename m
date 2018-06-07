Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id niIKKoNCGVtofAAAmS7hNA
	; Thu, 07 Jun 2018 14:34:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EDF12608BA; Thu,  7 Jun 2018 14:34:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 25D3F607E7;
	Thu,  7 Jun 2018 14:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25D3F607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933996AbeFGOet (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:34:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40360 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933760AbeFGOep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:34:45 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbS-0005hK-7p; Thu, 07 Jun 2018 15:09:26 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003CP-2g; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Christian =?UTF-8?Q?K=C3=B6nig?=" <christian.koenig@amd.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.564212335@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 333/410] drm/radeon: fix KV harvesting
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

From: Alex Deucher <alexander.deucher@amd.com>

commit 0b58d90f89545e021d188c289fa142e5ff9e708b upstream.

Always set the graphics values to the max for the
asic type.  E.g., some 1 RB chips are actually 1 RB chips,
others are actually harvested 2 RB chips.

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=99353
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/radeon/cik.c | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3299,35 +3299,8 @@ static void cik_gpu_init(struct radeon_d
 	case CHIP_KAVERI:
 		rdev->config.cik.max_shader_engines = 1;
 		rdev->config.cik.max_tile_pipes = 4;
-		if ((rdev->pdev->device == 0x1304) ||
-		    (rdev->pdev->device == 0x1305) ||
-		    (rdev->pdev->device == 0x130C) ||
-		    (rdev->pdev->device == 0x130F) ||
-		    (rdev->pdev->device == 0x1310) ||
-		    (rdev->pdev->device == 0x1311) ||
-		    (rdev->pdev->device == 0x131C)) {
-			rdev->config.cik.max_cu_per_sh = 8;
-			rdev->config.cik.max_backends_per_se = 2;
-		} else if ((rdev->pdev->device == 0x1309) ||
-			   (rdev->pdev->device == 0x130A) ||
-			   (rdev->pdev->device == 0x130D) ||
-			   (rdev->pdev->device == 0x1313) ||
-			   (rdev->pdev->device == 0x131D)) {
-			rdev->config.cik.max_cu_per_sh = 6;
-			rdev->config.cik.max_backends_per_se = 2;
-		} else if ((rdev->pdev->device == 0x1306) ||
-			   (rdev->pdev->device == 0x1307) ||
-			   (rdev->pdev->device == 0x130B) ||
-			   (rdev->pdev->device == 0x130E) ||
-			   (rdev->pdev->device == 0x1315) ||
-			   (rdev->pdev->device == 0x1318) ||
-			   (rdev->pdev->device == 0x131B)) {
-			rdev->config.cik.max_cu_per_sh = 4;
-			rdev->config.cik.max_backends_per_se = 1;
-		} else {
-			rdev->config.cik.max_cu_per_sh = 3;
-			rdev->config.cik.max_backends_per_se = 1;
-		}
+		rdev->config.cik.max_cu_per_sh = 8;
+		rdev->config.cik.max_backends_per_se = 2;
 		rdev->config.cik.max_sh_per_se = 1;
 		rdev->config.cik.max_texture_channel_caches = 4;
 		rdev->config.cik.max_gprs = 256;
