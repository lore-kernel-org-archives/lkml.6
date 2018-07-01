Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9154C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D28325B63
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D28325B63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeGASrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:47:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752670AbeGAQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:11:46 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5878A86A;
        Sun,  1 Jul 2018 16:11:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 25/85] drm/omap: fix possible NULL ref issue in tiler_reserve_2d
Date:   Sun,  1 Jul 2018 18:01:43 +0200
Message-Id: <20180701153123.374624319@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 6a0f0c55619f0b82a677cab72e77c3444a5eee58 ]

tiler_reserve_2d allocates memory but does not check if it got the
memory. Add the check and return ENOMEM on failure.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180329104038.29154-2-tomi.valkeinen@ti.com
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -356,11 +356,15 @@ int tiler_unpin(struct tiler_block *bloc
 struct tiler_block *tiler_reserve_2d(enum tiler_fmt fmt, uint16_t w,
 		uint16_t h, uint16_t align)
 {
-	struct tiler_block *block = kzalloc(sizeof(*block), GFP_KERNEL);
+	struct tiler_block *block;
 	u32 min_align = 128;
 	int ret;
 	unsigned long flags;
 
+	block = kzalloc(sizeof(*block), GFP_KERNEL);
+	if (!block)
+		return ERR_PTR(-ENOMEM);
+
 	BUG_ON(!validfmt(fmt));
 
 	/* convert width/height to slots */


