Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D64C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1750F20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eShaXWHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1750F20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeHaWVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:21:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46826 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaWVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:21:45 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5CA891A8D;
        Fri, 31 Aug 2018 20:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1535739183;
        bh=4oo/JeLSgFbeFct6d/OA532vHh1L+2k4uHPWMGCfWNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eShaXWHwBVl4t4+BTJtisM4YlOxdd9G7zmYSB0zg4LG+HqVCrgN8skKNj3Tgqnv1n
         P8t7is8prx1O27Y0R5umzjHBeE05HZiWZ50ZxVYC7aXAkAm3yhAK2PGGPJotYt/Xf1
         EerxTTUaI0gFe8rgZT73Gz+mo5hWomLmFnyMZ3WM=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 2/3] drm: rcar-du: Add pixel format support
Date:   Fri, 31 Aug 2018 19:12:58 +0100
Message-Id: <20180831181259.29529-3-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831181259.29529-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180831181259.29529-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

This patch supports pixel format of RGB332, ARGB4444, XRGB4444,
BGR888, RGB888, BGRA8888, BGRX8888 and YVYU.
VYUY pixel format is not supported by H/W specification.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

---

This patch does not remove existing support for multiplanar YVUY, even
though the hardware does not explicitly provide it, because we support
it through software by swapping the plane buffers.

 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 7c7aff8cdf77..d1bd174ec893 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -124,6 +124,38 @@ static const struct rcar_du_format_info rcar_du_format_infos[] = {
 		.fourcc = DRM_FORMAT_YVU444,
 		.bpp = 24,
 		.planes = 3,
+	}, {
+		.fourcc = DRM_FORMAT_RGB332,
+		.bpp = 8,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_ARGB4444,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_XRGB4444,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_BGR888,
+		.bpp = 24,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_RGB888,
+		.bpp = 24,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_BGRA8888,
+		.bpp = 32,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_BGRX8888,
+		.bpp = 32,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_YVYU,
+		.bpp = 16,
+		.planes = 1,
 	},
 };
 
-- 
2.17.1

