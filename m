Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2726C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE597217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298197;
	bh=xHmccNNFbX4NCX6E+MqWaW1CbykNwYIz0CNVcAVdjGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cenZU1aJZfnUvaXQ9waI4jzu0PV0/A0YgNNARUn4XgvnC/H2Un7EnmgDJ/X8UEald
	 UBNMBsMbdOHswsRcs2F9jxiHyeQx22O4OTWuZFwTdov/EMiV4tHDfahUMGwretZWUW
	 1Y+xMot6sen8VXv/rqvwWdeyem3j1MXfHsIrx0cA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbeLTJ34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbeLTJ3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AD6020989;
        Thu, 20 Dec 2018 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298193;
        bh=xHmccNNFbX4NCX6E+MqWaW1CbykNwYIz0CNVcAVdjGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZ4KZvCc7Lp6F1cR2IyCNkEITFRDSxbYIklgZlz6ZbfxO2oKExmW1QdW/VG0+AGA6
         CV3L/nRMM9L5LEO0XypAi42L/OB6e7f0daIYP7Kp60SBF5Z2jUzmH+VRfan4PnSRXs
         tWZGAt78tmWe1SqR138JIvSTJF4/+sLJqBslKLPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 35/67] drm/msm: dpu: Fix "WARNING: invalid free of devm_ allocated data"
Date:   Thu, 20 Dec 2018 10:18:47 +0100
Message-Id: <20181220085904.934362035@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



