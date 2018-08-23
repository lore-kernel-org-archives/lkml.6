Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF77C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A1520A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A1520A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeHWLoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:44:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeHWLhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:37:21 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01F23BB6;
        Thu, 23 Aug 2018 08:08:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 060/130] drm/exynos: decon5433: Fix per-plane global alpha for XRGB modes
Date:   Thu, 23 Aug 2018 09:52:56 +0200
Message-Id: <20180823074931.323888518@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit ab337fc274a1957ff0771f19e826c736253f7c39 ]

Set per-plane global alpha to maximum value to get proper blending of
XRGB and ARGB planes. This fixes the strange order of overlapping planes.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -291,8 +291,8 @@ static void decon_update_plane(struct ex
 		COORDINATE_Y(state->crtc.y + state->crtc.h - 1);
 	writel(val, ctx->addr + DECON_VIDOSDxB(win));
 
-	val = VIDOSD_Wx_ALPHA_R_F(0x0) | VIDOSD_Wx_ALPHA_G_F(0x0) |
-		VIDOSD_Wx_ALPHA_B_F(0x0);
+	val = VIDOSD_Wx_ALPHA_R_F(0xff) | VIDOSD_Wx_ALPHA_G_F(0xff) |
+		VIDOSD_Wx_ALPHA_B_F(0xff);
 	writel(val, ctx->addr + DECON_VIDOSDxC(win));
 
 	val = VIDOSD_Wx_ALPHA_R_F(0x0) | VIDOSD_Wx_ALPHA_G_F(0x0) |


