Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD4B2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498980;
	bh=lh/rjUa4OvjOA4iFm8L77lWnIGHETLprCbsn53q3oR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TXsBk8+t65ooxxe7WuM0ehAbMF3AQd7ifSLkT0WyyxpNZqCOsbmYcnorxgb7X4GbJ
	 HmVBWKkMGUQCpK8BzTbbPOaJVeI2sAvi1Rn4zeAcfuVuEChnONUw5/sw1outspjABF
	 dgzyFl2OPuZG8ax8sivSX404N3g6hP5zDlprm6WA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391262AbfBROJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391247AbfBROJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:09:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CDB1217D7;
        Mon, 18 Feb 2019 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498975;
        bh=lh/rjUa4OvjOA4iFm8L77lWnIGHETLprCbsn53q3oR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRKVaG/6ut2ukLUR6sLKRoyE4C56+lPBvh1qwBCS+ivkRhyLEIUaf9Bd7N8+UjaYx
         syeWW+uF+vPst+qFWv4KNwRuQk8RY8+hsAbArlqdOPJZfDJao+1c9ex8gy2LEiuElQ
         Jfu0xH0Mx02HqX5NBMvJn13ft9o1AZfll9B0h4QQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Fabian Frederick <ffrederick@users.sourceforge.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Geoff Levand <geoff@infradead.org>,
        James Simmons <jsimmons@users.sf.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 037/108] fbdev: fbmem: behave better with small rotated displays and many CPUs
Date:   Mon, 18 Feb 2019 14:43:33 +0100
Message-Id: <20190218133521.246228410@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f75df8d4b4fabfad7e3cba2debfad12741c6fde7 ]

Blitting an image with "negative" offsets is not working since there
is no clipping. It hopefully just crashes. For the bootup logo, there
is protection so that blitting does not happen as the image is drawn
further and further to the right (ROTATE_UR) or further and further
down (ROTATE_CW). There is however no protection when drawing in the
opposite directions (ROTATE_UD and ROTATE_CCW).

Add back this protection.

The regression is 20-odd years old but the mindless warning-killing
mentality displayed in commit 34bdb666f4b2 ("fbdev: fbmem: remove
positive test on unsigned values") is also to blame, methinks.

Fixes: 448d479747b8 ("fbdev: fb_do_show_logo() updates")
Signed-off-by: Peter Rosin <peda@axentia.se>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Fabian Frederick <ffrederick@users.sourceforge.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
cc: Geoff Levand <geoff@infradead.org>
Cc: James Simmons <jsimmons@users.sf.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbmem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 8a29ec5992fd..ea2bd6208a2f 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -433,7 +433,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 			image->dx += image->width + 8;
 		}
 	} else if (rotate == FB_ROTATE_UD) {
-		for (x = 0; x < num; x++) {
+		u32 dx = image->dx;
+
+		for (x = 0; x < num && image->dx <= dx; x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dx -= image->width + 8;
 		}
@@ -445,7 +447,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 			image->dy += image->height + 8;
 		}
 	} else if (rotate == FB_ROTATE_CCW) {
-		for (x = 0; x < num; x++) {
+		u32 dy = image->dy;
+
+		for (x = 0; x < num && image->dy <= dy; x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dy -= image->height + 8;
 		}
-- 
2.19.1



