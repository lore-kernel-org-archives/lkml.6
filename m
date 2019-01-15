Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A594FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8E620645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571324;
	bh=kdYlxra1zt9emappoVfZFX/Db+FXcOV2e6nkt77cN3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aRRaK2z5e6oXGJ6niQcnLFynFVW2thMRzIajZiveWMJBnv/YNPyqssa/+K8GHT/ev
	 HUgBScM7rz08bRPB+kgV9GuTLH29DSs3/O6pN5vPs0+e2G6WnpB99LU3TZmtfTQN7q
	 fPj7EoaTBGzqu8F/sSx1i1sgay8EONhdiIYkqMhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbfAOQzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:55:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732977AbfAOQm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40CA2054F;
        Tue, 15 Jan 2019 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570545;
        bh=kdYlxra1zt9emappoVfZFX/Db+FXcOV2e6nkt77cN3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vfHlooVMfblT2jY1IUw2FDAjnfrcbvfscPJ92afyso/A4gIFZ/XVxwxkAFMvd+nUC
         tk/BxOwtHebnaYR7xNurEtCBGPSjL5b25m+7Kp7R8s52QzYCmbawqG7xayoCXJaNm0
         moUcN6OyOWD+5/CHctE264YhU7olvAv8ycKJDhz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eric Anholt <eric@anholt.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        Ben Skeggs <skeggsb@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4.19 32/50] drm/fb_helper: Allow leaking fbdev smem_start
Date:   Tue, 15 Jan 2019 17:36:08 +0100
Message-Id: <20190115154911.762987756@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neil Armstrong <narmstrong@baylibre.com>

commit 4be9bd10e22dfc7fc101c5cf5969ef2d3a042d8a upstream.

Since "drm/fb: Stop leaking physical address", the default behaviour of
the DRM fbdev emulation is to set the smem_base to 0 and pass the new
FBINFO_HIDE_SMEM_START flag.

The main reason is to avoid leaking physical addresse to user-space, and
it follows a general move over the kernel code to avoid user-space to
manipulate physical addresses and then use some other mechanisms like
dma-buf to transfer physical buffer handles over multiple subsystems.

But, a lot of devices depends on closed sources binaries to enable
OpenGL hardware acceleration that uses this smem_start value to
pass physical addresses to out-of-tree modules in order to render
into these physical adresses. These should use dma-buf buffers allocated
from the DRM display device instead and stop relying on fbdev overallocation
to gather DMA memory (some HW vendors delivers GBM and Wayland capable
binaries, but older unsupported devices won't have these new binaries
and are doomed until an Open Source solution like Lima finalizes).

Since these devices heavily depends on this kind of software and because
the smem_start population was available for years, it's a breakage to
stop leaking smem_start without any alternative solutions.

This patch adds a Kconfig depending on the EXPERT config and an unsafe
kernel module parameter tainting the kernel when enabled.

A clear comment and Kconfig help text was added to clarify why and when
this patch should be reverted, but in the meantime it's a necessary
feature to keep.

Cc: Dave Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Noralf Trønnes <noralf@tronnes.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Ben Skeggs <skeggsb@gmail.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Dave Airlie <airlied@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1538136355-15383-1-git-send-email-narmstrong@baylibre.com
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/gpu/drm/Kconfig         |   20 ++++++++++++++++++++
 drivers/gpu/drm/drm_fb_helper.c |   25 +++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -110,6 +110,26 @@ config DRM_FBDEV_OVERALLOC
 	  is 100. Typical values for double buffering will be 200,
 	  triple buffering 300.
 
+config DRM_FBDEV_LEAK_PHYS_SMEM
+	bool "Shamelessly allow leaking of fbdev physical address (DANGEROUS)"
+	depends on DRM_FBDEV_EMULATION && EXPERT
+	default n
+	help
+	  In order to keep user-space compatibility, we want in certain
+	  use-cases to keep leaking the fbdev physical address to the
+	  user-space program handling the fbdev buffer.
+	  This affects, not only, Amlogic, Allwinner or Rockchip devices
+	  with ARM Mali GPUs using an userspace Blob.
+	  This option is not supported by upstream developers and should be
+	  removed as soon as possible and be considered as a broken and
+	  legacy behaviour from a modern fbdev device driver.
+
+	  Please send any bug reports when using this to your proprietary
+	  software vendor that requires this.
+
+	  If in doubt, say "N" or spread the word to your closed source
+	  library vendor.
+
 config DRM_LOAD_EDID_FIRMWARE
 	bool "Allow to specify an EDID data set instead of probing for it"
 	depends on DRM
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -56,6 +56,25 @@ MODULE_PARM_DESC(drm_fbdev_overalloc,
 		 "Overallocation of the fbdev buffer (%) [default="
 		 __MODULE_STRING(CONFIG_DRM_FBDEV_OVERALLOC) "]");
 
+/*
+ * In order to keep user-space compatibility, we want in certain use-cases
+ * to keep leaking the fbdev physical address to the user-space program
+ * handling the fbdev buffer.
+ * This is a bad habit essentially kept into closed source opengl driver
+ * that should really be moved into open-source upstream projects instead
+ * of using legacy physical addresses in user space to communicate with
+ * other out-of-tree kernel modules.
+ *
+ * This module_param *should* be removed as soon as possible and be
+ * considered as a broken and legacy behaviour from a modern fbdev device.
+ */
+#if IS_ENABLED(CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM)
+static bool drm_leak_fbdev_smem = false;
+module_param_unsafe(drm_leak_fbdev_smem, bool, 0600);
+MODULE_PARM_DESC(fbdev_emulation,
+		 "Allow unsafe leaking fbdev physical smem address [default=false]");
+#endif
+
 static LIST_HEAD(kernel_fb_helper_list);
 static DEFINE_MUTEX(kernel_fb_helper_lock);
 
@@ -3041,6 +3060,12 @@ int drm_fb_helper_generic_probe(struct d
 	fbi->screen_size = fb->height * fb->pitches[0];
 	fbi->fix.smem_len = fbi->screen_size;
 	fbi->screen_buffer = buffer->vaddr;
+	/* Shamelessly leak the physical address to user-space */
+#if IS_ENABLED(CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM)
+	if (drm_leak_fbdev_smem && fbi->fix.smem_start == 0)
+		fbi->fix.smem_start =
+			page_to_phys(virt_to_page(fbi->screen_buffer));
+#endif
 	strcpy(fbi->fix.id, "DRM emulated");
 
 	drm_fb_helper_fill_fix(fbi, fb->pitches[0], fb->format->depth);


