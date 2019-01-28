Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81935C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513002084C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693867;
	bh=5IVPJ2181u7WN/+savm7OD2JXwg7cpo1YXSi4AOzU5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2u+5tSgHe1uxeLntLGvFJS1jdY78PgHQB2oUZoEyH5msVXY31MoyWLDdq+6x+pROo
	 Pv/Nzr4yHveOqBxaqZtvlUldPSDmtx65tpWIrd5Ah54Yhl00HZT7uJpZ2XcmxTcm4R
	 Po7n8QuHN6wa1XArvjoy4R9HrVPs7otd0riBlwng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbfA1QXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730265AbfA1QXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8EA721738;
        Mon, 28 Jan 2019 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692581;
        bh=5IVPJ2181u7WN/+savm7OD2JXwg7cpo1YXSi4AOzU5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2SUKa6vbsK/KN+qWjS9/XTodpDVyLOMucC5wGAmIPFlz48f4n+4YbWSKXw5R9USzg
         BEE9OCr6qOOB6mshDc9fsmeUpJZiMa6Kmr3VNfy6u/D6s6f2qNqT0pIlNzq50yEPWu
         qUybjlnEumRvI169yIOF2z5Jde+JFzA7/vD/tm3I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Fabian Frederick <ffrederick@users.sourceforge.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Geoff Levand <geoff@infradead.org>,
        James Simmons <jsimmons@users.sf.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 076/107] fbdev: fbmem: behave better with small rotated displays and many CPUs
Date:   Mon, 28 Jan 2019 11:19:16 -0500
Message-Id: <20190128161947.57405-76-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

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
index 74273bc7ca9a..a1d93151c059 100644
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

