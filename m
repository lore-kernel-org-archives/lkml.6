Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE668C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9550E22466
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9550E22466
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933572AbeFYMSv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:18:51 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.178]:38967 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933170AbeFYMSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:18:48 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 9A845244E430
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 07:18:47 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id XQSFfaYRDSjJAXQSFf77NC; Mon, 25 Jun 2018 07:18:47 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=55734 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fXQSF-002agD-3D; Mon, 25 Jun 2018 07:18:47 -0500
Date:   Mon, 25 Jun 2018 07:18:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/gma500: Fix potential NULL pointer dereference
Message-ID: <20180625121844.GA12466@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fXQSF-002agD-3D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:55734
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fb is being dereferenced before it is null checked, hence there
is a potential null pointer dereference.

Fix this by moving the pointer dereference after fb has been
properly null checked at line 74: if (!fb)

Addresses-Coverity-ID: 1470169 ("Dereference before null check")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/gma500/gma_display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
index c8f071c..f767579 100644
--- a/drivers/gpu/drm/gma500/gma_display.c
+++ b/drivers/gpu/drm/gma500/gma_display.c
@@ -60,7 +60,7 @@ int gma_pipe_set_base(struct drm_crtc *crtc, int x, int y,
 	struct drm_psb_private *dev_priv = dev->dev_private;
 	struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
 	struct drm_framebuffer *fb = crtc->primary->fb;
-	struct gtt_range *gtt = to_gtt_range(fb->obj[0]);
+	struct gtt_range *gtt;
 	int pipe = gma_crtc->pipe;
 	const struct psb_offset *map = &dev_priv->regmap[pipe];
 	unsigned long start, offset;
@@ -76,6 +76,8 @@ int gma_pipe_set_base(struct drm_crtc *crtc, int x, int y,
 		goto gma_pipe_cleaner;
 	}
 
+	gtt = to_gtt_range(fb->obj[0]);
+
 	/* We are displaying this buffer, make sure it is actually loaded
 	   into the GTT */
 	ret = psb_gtt_pin(gtt);
-- 
2.7.4

