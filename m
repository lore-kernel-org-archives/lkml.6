Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565FDC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1189720880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675388;
	bh=R/vDS0v/GEG93jmo2Fm+5ulH4DFWH0Jo5QZMF00pSuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xZGlC3me5WNo6WfW0/PoISEdvz7CGC+1lqyjPkqbax6dBptafi5/s2EV2XTDkXg68
	 csc0Hips5liZtSFbflseIwLggHRAyynXFLfzak9/BTbjj/YwLGKEX9ezHyM6pkpxdh
	 xfAnrFTUPNS7fRL2M4JXsx4XKcdmkCiiYoMTBbfo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1189720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeLME3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:29:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbeLME3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3763520879;
        Thu, 13 Dec 2018 04:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675384;
        bh=R/vDS0v/GEG93jmo2Fm+5ulH4DFWH0Jo5QZMF00pSuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lsg1FpdHraIUX/sYsv0x5YlGVLDsfJglsb30/ZN3slV5oJLJRzeJqYV5nIeWXiHBt
         5iTmB7/HqmwKtg/dxhlSsRjEux0qIvyb1FbJxREPjm7l0rBNpSI4j4rnFXktQkutWO
         qWCDrINT/rsLx5kogz4zakxAZcMRaWI+JgFsyf/Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 34/73] drm/msm: dpu: Fix "WARNING: invalid free of devm_ allocated data"
Date:   Wed, 12 Dec 2018 23:27:59 -0500
Message-Id: <20181213042838.75160-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit ce25aa3ee6939d83979cccf7adc5737cba9a0cb7 ]

'dpu_enc' is a member of 'drm_enc'
And 'drm_enc' got allocated with devm_kzalloc in dpu_encoder_init.

This gives this error message:
./drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:459:1-6:
 WARNING: invalid free of devm_ allocated data

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1b4de3486ef9..ec3fd67378c1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -503,8 +503,6 @@ static void dpu_encoder_destroy(struct drm_encoder *drm_enc)
 
 	drm_encoder_cleanup(drm_enc);
 	mutex_destroy(&dpu_enc->enc_lock);
-
-	kfree(dpu_enc);
 }
 
 void dpu_encoder_helper_split_config(
-- 
2.19.1

