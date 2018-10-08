Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FC6C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A263521557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am6LjwSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A263521557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeJHWll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbeJHWjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A7521569;
        Mon,  8 Oct 2018 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012440;
        bh=KOYuWa3NE0/GB6Bvk9ZNEKgdN51InkCTWNkkZ2IAUP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Am6LjwSOvUtJQpGuv3zPENxbHY6C48Nb2dHidBnP0tQ3/wsI8Fgdgiw3pyZQFqmgb
         r3uDcUVTxJ8N67WHFGUS3ePRcafGzylLR8JYqTY5bdQGasaFBSol3DBfPxcmT5SkH7
         t+KIE6Jyt3a0H5VBz6jv8rfCydtfjMYIZdWLgPWE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 17/23] drm: mali-dp: Call drm_crtc_vblank_reset on device init
Date:   Mon,  8 Oct 2018 11:26:57 -0400
Message-Id: <20181008152703.70891-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152703.70891-1-sashal@kernel.org>
References: <20181008152703.70891-1-sashal@kernel.org>
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
index 9280358b8f15..59d484736b4e 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -378,6 +378,7 @@ static int malidp_bind(struct device *dev)
 		goto irq_init_fail;
 
 	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
+	drm_crtc_vblank_reset(&malidp->crtc);
 	if (ret < 0) {
 		DRM_ERROR("failed to initialise vblank\n");
 		goto vblank_fail;
-- 
2.17.1

