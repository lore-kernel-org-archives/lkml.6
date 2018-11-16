Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFBCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2BF2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2BF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbeKPViM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:38:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727567AbeKPViM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:38:12 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 34CEBD8C8322A;
        Fri, 16 Nov 2018 19:26:12 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Fri, 16 Nov 2018
 19:26:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <robdclark@gmail.com>, <airlied@linux.ie>, <seanpaul@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <jsanka@codeaurora.org>,
        <jcrouse@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/msm: dpu: Fix "WARNING: invalid free of devm_ allocated data"
Date:   Fri, 16 Nov 2018 19:25:26 +0800
Message-ID: <20181116112526.10552-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dpu_enc' is a member of 'drm_enc'
And 'drm_enc' got allocated with devm_kzalloc in dpu_encoder_init.

This gives this error message:
./drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:459:1-6:
 WARNING: invalid free of devm_ allocated data

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 82c55ef..99526d9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -455,8 +455,6 @@ static void dpu_encoder_destroy(struct drm_encoder *drm_enc)
 
 	drm_encoder_cleanup(drm_enc);
 	mutex_destroy(&dpu_enc->enc_lock);
-
-	kfree(dpu_enc);
 }
 
 void dpu_encoder_helper_split_config(
-- 
2.7.0


