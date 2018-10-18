Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D632BECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D94920645
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1u/dPFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D94920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbeJSCCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbeJSCCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:02:33 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98262205C9;
        Thu, 18 Oct 2018 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885628;
        bh=QH0CTNT0akYVJ5nG5oRLqjDGPH5h/nk7C1d7UV6PH0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G1u/dPFQHJNuOOgsmI+Ud7DLLMyTYtkuNU6mq5TldxVaTX7esdiJclhe1ghJ+1WI/
         0VEq7kZ8CisZXnv/6mLw6iUKMRMrrCX3ZyG+caRAikWMvgEVXdUrD1FA9/JIraAjep
         iM05OmYnZFiFuX1nQtu7DNpXMu0+WbUo2Wo724WY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 21/41] drm: mali-dp: Call drm_crtc_vblank_reset on device init
Date:   Thu, 18 Oct 2018 19:54:36 +0200
Message-Id: <20181018175420.482666168@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/arm/malidp_drv.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -617,6 +617,7 @@ static int malidp_bind(struct device *de
 	drm->irq_enabled = true;
 
 	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
+	drm_crtc_vblank_reset(&malidp->crtc);
 	if (ret < 0) {
 		DRM_ERROR("failed to initialise vblank\n");
 		goto vblank_fail;


