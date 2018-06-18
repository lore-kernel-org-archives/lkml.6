Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B568C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C312A20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C312A20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934922AbeFRITU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:19:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54836 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeFRITQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:19:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0D3C5C50;
        Mon, 18 Jun 2018 08:19:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Emil Velikov <emil.velikov@collabora.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 059/279] drm/msm: dont deref error pointer in the msm_fbdev_create error path
Date:   Mon, 18 Jun 2018 10:10:44 +0200
Message-Id: <20180618080611.274697870@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emil Velikov <emil.velikov@collabora.com>

[ Upstream commit 789d4c300e10eb2096ee83c3497118e67ccc951e ]

Currently the error pointer returned by msm_alloc_stolen_fb gets passed
to drm_framebuffer_remove. The latter handles only NULL pointers, thus
a nasty crash will occur.

Drop the unnecessary fail label and the associated checks - both err and
fb will be set at this stage.

Cc: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_fbdev.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -92,8 +92,7 @@ static int msm_fbdev_create(struct drm_f
 
 	if (IS_ERR(fb)) {
 		dev_err(dev->dev, "failed to allocate fb\n");
-		ret = PTR_ERR(fb);
-		goto fail;
+		return PTR_ERR(fb);
 	}
 
 	bo = msm_framebuffer_bo(fb, 0);
@@ -151,13 +150,7 @@ static int msm_fbdev_create(struct drm_f
 
 fail_unlock:
 	mutex_unlock(&dev->struct_mutex);
-fail:
-
-	if (ret) {
-		if (fb)
-			drm_framebuffer_remove(fb);
-	}
-
+	drm_framebuffer_remove(fb);
 	return ret;
 }
 


