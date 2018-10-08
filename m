Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483F0C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CFF21557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrETrTpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CFF21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeJHWjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbeJHWjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4432021526;
        Mon,  8 Oct 2018 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012411;
        bh=DiXarsVzerL7xtTlf5708Mu/Ib2vg9d/3A+Sw17UCYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrETrTpKXQ9vgyZOxMcjxLuZ0jhAI/gAMJ+KFjJCNvmTocbLjvyKS9JNTLIW7jyx1
         n4OQ83vwFsC3+9EUH94TvESwrmcEzZB6jVQJV7EMmkzGv/cF/MIG24drWRysM7Ll0N
         2wfjwQR+3waM65vlkAhJZKNHtFyvq97en/m3UY/U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 23/32] drm: mali-dp: Call drm_crtc_vblank_reset on device init
Date:   Mon,  8 Oct 2018 11:26:20 -0400
Message-Id: <20181008152629.70812-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>

[ Upstream commit 69be1984ded00a11b1ed0888c6d8e4f35370372f ]

Currently, if userspace calls drm_wait_vblank before the crtc is
activated the crtc vblank_enable hook is called, which in case of
malidp driver triggers some warninngs. This happens because on
device init we don't inform the drm core about the vblank state
by calling drm_crtc_vblank_on/off/reset which together with
drm_vblank_get have some magic that prevents calling drm_vblank_enable
when crtc is off.

Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 1a57cc28955e..ff3348ee9595 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -617,6 +617,7 @@ static int malidp_bind(struct device *dev)
 	drm->irq_enabled = true;
 
 	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
+	drm_crtc_vblank_reset(&malidp->crtc);
 	if (ret < 0) {
 		DRM_ERROR("failed to initialise vblank\n");
 		goto vblank_fail;
-- 
2.17.1

