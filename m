Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37617C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E796B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E796B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967828AbeFRIfI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:35:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35928 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967772AbeFRIfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:35:06 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 60A18BAD;
        Mon, 18 Jun 2018 08:35:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 125/189] drm/omap: fix possible NULL ref issue in tiler_reserve_2d
Date:   Mon, 18 Jun 2018 10:13:41 +0200
Message-Id: <20180618081214.264958183@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -389,12 +389,16 @@ int tiler_unpin(struct tiler_block *bloc
 struct tiler_block *tiler_reserve_2d(enum tiler_fmt fmt, uint16_t w,
 		uint16_t h, uint16_t align)
 {
-	struct tiler_block *block = kzalloc(sizeof(*block), GFP_KERNEL);
+	struct tiler_block *block;
 	u32 min_align = 128;
 	int ret;
 	unsigned long flags;
 	u32 slot_bytes;
 
+	block = kzalloc(sizeof(*block), GFP_KERNEL);
+	if (!block)
+		return ERR_PTR(-ENOMEM);
+
 	BUG_ON(!validfmt(fmt));
 
 	/* convert width/height to slots */


