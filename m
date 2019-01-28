Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49692C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E171B2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="hxyfj+YD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfA1KEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:04:43 -0500
Received: from mout02.posteo.de ([185.67.36.66]:57467 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfA1KEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:04:42 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A509C2400FC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:04:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548669880; bh=qZmb/C+xRGeTA0pyxMfIlRobHToBGwXPBkxzlgge6M4=;
        h=From:To:Cc:Subject:Date:From;
        b=hxyfj+YD1wFDf0icZGQUC0oW9zbqtFTqvZnBgm42sdDMHkb4ECl4v2PgiTfjq8a2i
         /nID4rxbH/21jNHFVwss/IkiIsEda3rxybYyCNuuAe5+SkNsVWDSojpepUIgbFC85A
         cxUvQRrR7EwF8NEmdQE0WsPrX/KSmyVXvMhymyb17Jf8cqKiFBoT4cqDzkuzdUjtu9
         kZmw8yhWP2tP5KRQzvuOxjVmdo3yMgoM7eTkCNe4oPXPnxIaXbO3DMurm2cJeESmBi
         peuQi8fTAXYwOT++2epxlzZwyi5JGfxsSWNjGre2aH/WCAW98xJu8bvG8yUuc8+1Ba
         1F+WxYRCfnKzg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43p4x2674wz9rxf;
        Mon, 28 Jan 2019 11:04:38 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        b.zolnierkie@samsung.com
Cc:     daniel.vetter@ffwll.ch, manfred.schlaegl@ginzinger.com,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH] fbdev: fbmem: fix memory access if logo is bigger than the screen
Date:   Mon, 28 Jan 2019 11:04:35 +0100
Message-Id: <20190128100435.759-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

There is no clipping on the x or y axis for logos larger that the framebuffer
size. Therefore: a logo bigger than screen size leads to invalid memory access:

[    1.254664] Backtrace:
[    1.254728] [<c02714e0>] (cfb_imageblit) from [<c026184c>] (fb_show_logo+0x620/0x684)
[    1.254763]  r10:00000003 r9:00027fd8 r8:c6a40000 r7:c6a36e50 r6:00000000 r5:c06b81e4
[    1.254774]  r4:c6a3e800
[    1.254810] [<c026122c>] (fb_show_logo) from [<c026c1e4>] (fbcon_switch+0x3fc/0x46c)
[    1.254842]  r10:c6a3e824 r9:c6a3e800 r8:00000000 r7:c6a0c000 r6:c070b014 r5:c6a3e800
[    1.254852]  r4:c6808c00
[    1.254889] [<c026bde8>] (fbcon_switch) from [<c029c8f8>] (redraw_screen+0xf0/0x1e8)
[    1.254918]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:c070d5a0 r5:00000080
[    1.254928]  r4:c6808c00
[    1.254961] [<c029c808>] (redraw_screen) from [<c029d264>] (do_bind_con_driver+0x194/0x2e4)
[    1.254991]  r9:00000000 r8:00000000 r7:00000014 r6:c070d5a0 r5:c070d5a0 r4:c070d5a0

So prevent displaying a logo bigger than screen size and avoid invalid
memory access.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 drivers/video/fbdev/core/fbmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index cb43a2258c51..4721491e6c8c 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -431,6 +431,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 {
 	unsigned int x;
 
+	if (image->width > info->var.xres || image->height > info->var.yres)
+		return;
+
 	if (rotate == FB_ROTATE_UR) {
 		for (x = 0;
 		     x < num && image->dx + image->width <= info->var.xres;
-- 
2.20.1

