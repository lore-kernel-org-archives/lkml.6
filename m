Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA019ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A92120645
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A92120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJUSJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 14:09:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726980AbeJUSJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 14:09:15 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 639B7233212B3;
        Sun, 21 Oct 2018 17:55:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sun, 21 Oct 2018 17:55:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/radeon/kms: remove set but not used variable 'pll'
Date:   Sun, 21 Oct 2018 10:05:59 +0000
Message-ID: <1540116359-164086-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/radeon/radeon_legacy_tv.c: In function 'radeon_legacy_tv_init_restarts':
drivers/gpu/drm/radeon/radeon_legacy_tv.c:435:21: warning:
 variable 'pll' set but not used [-Wunused-but-set-variable]
  struct radeon_pll *pll;
  
It never used since introduction in commit
4ce001abafaf ("drm/radeon/kms: add initial radeon tv-out support.")
Also remove related variables 'dev, rdev, radeon_crtc'

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_legacy_tv.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_legacy_tv.c b/drivers/gpu/drm/radeon/radeon_legacy_tv.c
index 4278272..3dae2c4 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_tv.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_tv.c
@@ -421,24 +421,14 @@ static void radeon_legacy_write_tv_restarts(struct radeon_encoder *radeon_encode
 
 static bool radeon_legacy_tv_init_restarts(struct drm_encoder *encoder)
 {
-	struct drm_device *dev = encoder->dev;
-	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
 	struct radeon_encoder_tv_dac *tv_dac = radeon_encoder->enc_priv;
-	struct radeon_crtc *radeon_crtc;
 	int restart;
 	unsigned int h_total, v_total, f_total;
 	int v_offset, h_offset;
 	u16 p1, p2, h_inc;
 	bool h_changed;
 	const struct radeon_tv_mode_constants *const_ptr;
-	struct radeon_pll *pll;
-
-	radeon_crtc = to_radeon_crtc(radeon_encoder->base.crtc);
-	if (radeon_crtc->crtc_id == 1)
-		pll = &rdev->clock.p2pll;
-	else
-		pll = &rdev->clock.p1pll;
 
 	const_ptr = radeon_legacy_tv_get_std_mode(radeon_encoder, NULL);
 	if (!const_ptr)

