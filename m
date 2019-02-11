Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC03C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134F220844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895533;
	bh=GjvTZ6JmuAvkzkUcGQM4nIRPqeioaPU6Sbz1RfycSPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MLjMJObWRIhaGTwpLuqJbsgt0x1akIZcx9Ba+kIT2W0R+nGkNqnfrJ5V9ok4dOJ/x
	 NP2Uteg/7AF5boMmbElOsf3/tb6NZ9z84hRhu6NK1fgFGyHsoNqpNASe3wxyAIIyuj
	 HNXDBPkVVnwibfgjAAC44ELzJgN7l59RZK2nndWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfBKOcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfBKOcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:32:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 784E8214DA;
        Mon, 11 Feb 2019 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895528;
        bh=GjvTZ6JmuAvkzkUcGQM4nIRPqeioaPU6Sbz1RfycSPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdXobGqLxuGawvs44i5z6E/H48VvNT1IcqnkVaeH2EaqPi7PzNce1k8/GzgonFNqq
         7444v+qhTXy8ZHiah6LvGk2KWWC8b7zbPhoWwdMhjgtaZpmrSgJYM3Wef7oWQNGh5Q
         Iw8YLhd3te5Rk7BDY67TCqZJHtmmnYzc6+f9qR+4=
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
Subject: [PATCH 4.20 234/352] fbdev: fbmem: behave better with small rotated displays and many CPUs
Date:   Mon, 11 Feb 2019 15:17:41 +0100
Message-Id: <20190211141902.086042105@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 861bf8081619..7dd6924feaa8 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -436,7 +436,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
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
@@ -448,7 +450,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
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



