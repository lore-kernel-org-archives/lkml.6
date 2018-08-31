Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9E3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6897020837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lwzUbKf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6897020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeHaWVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:21:43 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46808 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaWVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:21:43 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D9466158B;
        Fri, 31 Aug 2018 20:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1535739183;
        bh=jWuzLck6TyfXYDEbqVJjXmAtXFOVtqHAiCpwEE6xHxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwzUbKf9UoIkm+MBXsiv6PL2vpz0Z56Weubvg7XLWLFCv9aOUQcujS5q4fQ7aBbpa
         mFQKoB+OekxjS7dMS03tbMh1/DvMvmgD607A39zLy2IpNQFZvycSJc3AV3ZmMlFn72
         vuZH1eNmvc5lONQJcusVgvpuIW+mP/aDm8OzrXEc=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 1/3] drm: rcar-du: Update Gen3 output limitations
Date:   Fri, 31 Aug 2018 19:12:57 +0100
Message-Id: <20180831181259.29529-2-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831181259.29529-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180831181259.29529-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R-Car Gen3 DU utilises the VSP1 hardware for memory access. The
limits on the RPF and WPF in this pipeline are 8190x8190.

Update the supported maximum sizes accordingly.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index ed7fa3204892..7c7aff8cdf77 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -512,12 +512,22 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
-	dev->mode_config.max_width = 4095;
-	dev->mode_config.max_height = 2047;
 	dev->mode_config.normalize_zpos = true;
 	dev->mode_config.funcs = &rcar_du_mode_config_funcs;
 	dev->mode_config.helper_private = &rcar_du_mode_config_helper;
 
+	if (rcdu->info->gen < 3) {
+		dev->mode_config.max_width = 4095;
+		dev->mode_config.max_height = 2047;
+	} else {
+		/*
+		 * The Gen3 DU uses the VSP1 for memory access, and is limited
+		 * to frame sizes of 8190x8190.
+		 */
+		dev->mode_config.max_width = 8190;
+		dev->mode_config.max_height = 8190;
+	}
+
 	rcdu->num_crtcs = hweight8(rcdu->info->channels_mask);
 
 	ret = rcar_du_properties_init(rcdu);
-- 
2.17.1

