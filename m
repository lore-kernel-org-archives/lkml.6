Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC96C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EFC20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="TMaPBTHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfBBGYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:24:17 -0500
Received: from tomli.me ([153.92.126.73]:45102 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfBBGYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:24:16 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2019 01:23:43 EST
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id e6c1c7bf;
        Sat, 2 Feb 2019 06:17:30 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b76:77ab)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Feb 2019 06:17:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=zRRs+2REmb3uRgcDWxj43u5Ln6Xr+n114zN49vJ2tyE=; b=TMaPBTHUa0/0/rB6u1qmIxiXNbdw4AlqLYL5HBP10gU/+qkrGywGZdPoUpGmiqtW5nDFdyzFgMriNHzZ3KLWkIynt8jk+AIVKek3ny3/StHD8aFQMk5NMEf5Kcu2oI54Xuzlbt1In9+j8FEZkPfFgCpuhxyjHjnW1SHwM9buO3VDQEpL9Dc0d67ImStTZWjUkVf9y0o8RCv9FirFvyVzka0orz094sMwaE+m5dE/PT0o915nl1wYr3T/Xt3Ofg8Asj8002DWx22gw3rf2xRICSJCkHP4eA+LI6XCzvwcMK96ZH2Cvmo6tgasB2oJcOPiuIxgQINuGP2pK6FmWJcYww==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4/8] fbdev: sm712fb: support 2D acceleration on SM712 w/ Little-Endian CPU.
Date:   Sat,  2 Feb 2019 14:16:44 +0800
Message-Id: <20190202061648.30374-5-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
References: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, in staging/sm7xxfb (now fbdev/sm712fb), 2D acceleration
was implemented, but after its submission, a critical bug that causes
total system hang was discovered, as a stopgap measure, 2D ops was
completele removed in commit 3af805735a25 ("staging: sm7xx: remove the
buggy 2D acceleration support") and never implemented again.

It created a massive usability problem - on YeeLoong 8089, a notable
MIPS platform which uses SM712 - even scrolling a single line of text
on the console required an unaccelerated screen redraw, running "dmesg"
typically takes 8-11 seconds, and absurdly, printf(), became a significant
performance bottleneck that slows down GCC and "make", make the computer
largely unusable.

So I decided to take a look. Most of the my actual development was done
in 2014 in a personal out-of-tree driver, I did not mainline it because
2D acceleration was not working properly in 24-bit color. I discovered
the solution in early 2019 and now it's ready to be mainlined.

This commit reimplements the 2D acceleration for sm712fb. Unlike the
original implementation, which was messy and unnecessarily complicated
by calling a 2D acceleration wrapper file with many unneeded functions,
this is a minimum and (relatively) clean implementation. My tests have
shown that running "dmesg" only takes 0.9 seconds, a performance boost
of 950%. System hangs did not occur in my tests.

Currently, 2D acceleration is only supported on SM712 with little-endian
CPUs, it's disabled on Big Endian systems and SM720 chips as a safety
measure, since I code for myself without any monetary or hardware support
from any company or OEMs, I don't have the hardware and it's completely
untested. I should be also to purchase a Big Endian test platform and add
proper support soon.  If you have a Big-Endian platform with SM7xx
available for testing, please send an E-mail to me immediately! Thanks!

Finally, thanks to Miodrag Vallat and other OpenBSD developers, this
work would be impossible without their code, that served as a reference
implementation for me.

As a historical note, though I'm not extremely sure, but I believe the
source of the original system hang was a type punning.

    unsigned char ajRemain[4];
    SMTC_write2Ddataport(0, *(unsigned long *)ajRemain);

Type punning is undefined behavior in C, and here it caused an unaligned
memory access, which is illegal on MIPS, thus crashing the computer.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/sm712.h   |   3 +
 drivers/video/fbdev/sm712fb.c | 396 +++++++++++++++++++++++++++++++++-
 2 files changed, 392 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
index 6d096c1b254c..b026bb3172aa 100644
--- a/drivers/video/fbdev/sm712.h
+++ b/drivers/video/fbdev/sm712.h
@@ -139,7 +139,10 @@ static inline u8 smtc_seqr(u8 reg)
 #define DE_CTRL_HOST_SHIFT			22
 #define DE_CTRL_HOST_SRC_IS_MONO		0x01
 #define DE_CTRL_FORMAT_XY			0x00
+#define DE_CTRL_FORMAT_8BIT			0x00
+#define DE_CTRL_FORMAT_16BIT			0x10
 #define DE_CTRL_FORMAT_24BIT			0x30
+#define DE_CTRL_FORMAT_32BIT			0x20
 
 /*
  * 32-bit I/O for 2D opeartions.
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 8d63bbfef9ea..133e31f75d67 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -47,6 +47,7 @@
 #include <linux/module.h>
 #include <linux/console.h>
 #include <linux/screen_info.h>
+#include <linux/delay.h>
 
 #include <linux/pm.h>
 
@@ -62,11 +63,14 @@ struct smtcfb_info {
 	u8  chip_rev_id;
 
 	void __iomem *lfb;	/* linear frame buffer */
+	void __iomem *dp_port;  /* drawing processor data port */
 	void __iomem *dp_regs;	/* drawing processor control regs */
 	void __iomem *vp_regs;	/* video processor control regs */
 	void __iomem *cp_regs;	/* capture processor control regs */
 	void __iomem *mmio;	/* memory map IO port */
 
+	bool accel;		/* whether to actually use drawing processor */
+
 	u_int width;
 	u_int height;
 	u_int hz;
@@ -75,6 +79,7 @@ struct smtcfb_info {
 };
 
 void __iomem *smtc_regbaseaddress;	/* Memory Map IO starting address */
+void __iomem *smtc_dprbaseaddress;	/* DPR, 2D control registers */
 
 static const struct fb_var_screeninfo smtcfb_var = {
 	.xres           = 1024,
@@ -789,14 +794,21 @@ static const struct modeinit vgamode[] = {
 	},
 };
 
-static struct screen_info smtc_scr_info;
 
+/* prototypes of two cross-referenced functions */
+static void smtcfb_reset_accel(void);
+static int smtcfb_init_accel(struct smtcfb_info *fb);
+
+static struct screen_info smtc_scr_info;
 static char *mode_option;
+static bool accel = true;  /* can be ignored if not supported */
+static bool accel_status_reported;
 
-/* process command line options, get vga parameter */
+/* process command line options, get vga and accel parameter */
 static void __init sm7xx_vga_setup(char *options)
 {
 	int i;
+	char *this_opt;
 
 	if (!options || !*options)
 		return;
@@ -813,9 +825,20 @@ static void __init sm7xx_vga_setup(char *options)
 			smtc_scr_info.lfb_height =
 						vesa_mode_table[i].lfb_height;
 			smtc_scr_info.lfb_depth  = vesa_mode_table[i].lfb_depth;
-			return;
+			break;
 		}
 	}
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
+
+		if (!strcmp(this_opt, "accel:0"))
+			accel = false;
+		else if (!strcmp(this_opt, "accel:1"))
+			accel = true;
+	}
+	accel_status_reported = false;
 }
 
 static void sm712_setpalette(int regno, unsigned int red, unsigned int green,
@@ -1284,7 +1307,42 @@ static void smtcfb_setmode(struct smtcfb_info *sfb)
 	sfb->width  = sfb->fb->var.xres;
 	sfb->height = sfb->fb->var.yres;
 	sfb->hz = 60;
+
+	/*
+	 * We reset the 2D engine twice, once before the modesetting, once
+	 * after the modesetting (mandatory), since users may chance the
+	 * mode on-the-fly. Just be safe.
+	 */
+	smtcfb_reset_accel();
+
 	smtc_set_timing(sfb);
+
+	/*
+	 * Currently, 2D acceleration is only supported on SM712 with
+	 * little-endian CPUs, it's disabled on Big Endian systems and SM720
+	 * chips as a safety measure. Since I don't have monetary or hardware
+	 * support from any company or OEMs, I don't have the hardware and
+	 * it's completely untested. I should be also to purchase a Big Endian
+	 * test platform and add proper support soon. I still have to spend
+	 * 200 USD+ to purchase this piece of 1998's hardware, yikes! If you
+	 * have a Big-Endian platform with SM7xx available for testing, please
+	 * send an E-mail to Tom, thanks!
+	 */
+#ifdef __BIG_ENDIAN
+	sfb->accel = false;
+	if (accel)
+		dev_info(&sfb->pdev->dev,
+			"2D acceleration is unsupported on Big Endian.\n");
+#endif
+	if (!accel) {
+		sfb->accel = false;
+		dev_info(&sfb->pdev->dev,
+			"2D acceleration is disabled by the user.\n");
+	}
+
+	/* reset 2D engine after a modesetting is mandatory */
+	smtcfb_reset_accel();
+	smtcfb_init_accel(sfb);
 }
 
 static int smtc_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
@@ -1324,6 +1382,317 @@ static struct fb_ops smtcfb_ops = {
 	.fb_write     = smtcfb_write,
 };
 
+static int smtcfb_wait(struct smtcfb_info *fb)
+{
+	int i;
+	u8 reg;
+
+	smtc_dprr(DPR_DE_CTRL);
+	for (i = 0; i < 10000; i++) {
+		reg = smtc_seqr(SCR_DE_STATUS);
+		if ((reg & SCR_DE_STATUS_MASK) == SCR_DE_ENGINE_IDLE)
+			return 0;
+		udelay(1);
+	}
+	dev_err(&fb->pdev->dev, "2D engine hang detected!\n");
+	return -EBUSY;
+}
+
+static void
+smtcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+{
+	u32 width = rect->width, height = rect->height;
+	u32 dx = rect->dx, dy = rect->dy;
+	u32 color;
+
+	struct smtcfb_info *sfb = info->par;
+
+	if (unlikely(info->state != FBINFO_STATE_RUNNING))
+		return;
+
+	if (unlikely(rect->rop != ROP_COPY)) {
+		/*
+		 * It must be ROP_XOR. It's only used to combine a hardware
+		 * cursor with the screen, and should never occur. Included
+		 * for completeness. If one wants to implement hardware cursor
+		 * (you don't, hardware only has RGB332 cursor), ROP2_XOR
+		 * should be implemented here.
+		 */
+		cfb_fillrect(info, rect);
+		return;
+	}
+
+	if ((rect->dx >= info->var.xres_virtual) ||
+	    (rect->dy >= info->var.yres_virtual))
+		return;
+
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
+	    info->fix.visual == FB_VISUAL_DIRECTCOLOR)
+		color = ((u32 *) (info->pseudo_palette))[rect->color];
+	else
+		color = rect->color;
+
+	if (sfb->fb->var.bits_per_pixel == 24) {
+		/*
+		 * In 24-bit mode, all x, y coordinates and widths (but not
+		 * height) must be multipiled by three.
+		 */
+		dx *= 3;
+		dy *= 3;
+		width *= 3;
+
+		/*
+		 * In 24-bit color mode, SOLIDFILL will sometimes put random
+		 * color stripes of garbage on the screen, it seems to be a
+		 * hardware bug. Alternatively, we initialize MONO_PATTERN_LOW
+		 * & HIGH with 0xffffffff (all ones, and we have already set
+		 * that in smtcfb_init_accel). Since the color of this mono
+		 * pattern is controlled by DPR_FG_COLOR, BITBLTing it with
+		 * ROP_COPY is effectively a rectfill().
+		 */
+		smtc_dprw(DPR_FG_COLOR, color);
+		smtc_dprw(DPR_DST_COORDS, DPR_COORDS(dx, dy));
+		smtc_dprw(DPR_SPAN_COORDS, DPR_COORDS(width, height));
+		smtc_dprw(DPR_DE_CTRL, DE_CTRL_START | DE_CTRL_ROP2_SELECT |
+				DE_CTRL_ROP2_SRC_IS_PATTERN |
+				(DE_CTRL_COMMAND_BITBLT <<
+						DE_CTRL_COMMAND_SHIFT) |
+				(DE_CTRL_ROP2_COPY <<
+						DE_CTRL_ROP2_SHIFT));
+	} else {
+		smtc_dprw(DPR_FG_COLOR, color);
+		smtc_dprw(DPR_DST_COORDS, DPR_COORDS(dx, dy));
+		smtc_dprw(DPR_SPAN_COORDS, DPR_COORDS(width, height));
+		smtc_dprw(DPR_DE_CTRL, DE_CTRL_START | DE_CTRL_ROP2_SELECT |
+				(DE_CTRL_COMMAND_SOLIDFILL <<
+						DE_CTRL_COMMAND_SHIFT) |
+				(DE_CTRL_ROP2_COPY <<
+						DE_CTRL_ROP2_SHIFT));
+	}
+	smtcfb_wait(sfb);
+}
+
+static void
+smtcfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+{
+	u32 sx = area->sx, sy = area->sy;
+	u32 dx = area->dx, dy = area->dy;
+	u32 height = area->height, width = area->width;
+	u32 direction;
+
+	struct smtcfb_info *sfb = info->par;
+
+	if (unlikely(info->state != FBINFO_STATE_RUNNING))
+		return;
+	if ((sx >= info->var.xres_virtual) || (sy >= info->var.yres_virtual))
+		return;
+
+	if (sy < dy || (sy == dy && sx <= dx)) {
+		sx += width - 1;
+		dx += width - 1;
+		sy += height - 1;
+		dy += height - 1;
+		direction = DE_CTRL_RTOL;
+	} else {
+		direction = 0;
+	}
+
+	if (sfb->fb->var.bits_per_pixel == 24) {
+		sx *= 3;
+		sy *= 3;
+		dx *= 3;
+		dy *= 3;
+		width *= 3;
+		if (direction == DE_CTRL_RTOL) {
+			/*
+			 * some hardware shenanigan from the original git
+			 * commit, that is never clearly mentioned in the
+			 * official datasheet. Not sure whether it even
+			 * works correctly.
+			 */
+			sx += 2;
+			dx += 2;
+		}
+	}
+
+	smtc_dprw(DPR_SRC_COORDS, DPR_COORDS(sx, sy));
+	smtc_dprw(DPR_DST_COORDS, DPR_COORDS(dx, dy));
+	smtc_dprw(DPR_SPAN_COORDS, DPR_COORDS(width, height));
+	smtc_dprw(DPR_DE_CTRL,
+			DE_CTRL_START | DE_CTRL_ROP2_SELECT | direction |
+			(DE_CTRL_COMMAND_BITBLT << DE_CTRL_COMMAND_SHIFT) |
+			(DE_CTRL_ROP2_COPY << DE_CTRL_ROP2_SHIFT));
+	smtcfb_wait(sfb);
+}
+
+static void
+smtcfb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+	u32 dx = image->dx, dy = image->dy;
+	u32 width = image->width, height = image->height;
+	u32 fg_color, bg_color;
+
+	u32 total_bytes, total_dwords, leftovers;
+	u32 i;
+	u32 idx = 0;
+	u32 scanline = image->width >> 3;
+
+	struct smtcfb_info *sfb = info->par;
+
+	if (unlikely(info->state != FBINFO_STATE_RUNNING))
+		return;
+	if ((image->dx >= info->var.xres_virtual) ||
+	    (image->dy >= info->var.yres_virtual))
+		return;
+
+	if (unlikely(image->depth != 1)) {
+		/* unsupported depth, fallback to draw Tux */
+		cfb_imageblit(info, image);
+		return;
+	}
+
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
+	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
+		fg_color = ((u32 *) (info->pseudo_palette))[image->fg_color];
+		bg_color = ((u32 *) (info->pseudo_palette))[image->bg_color];
+	} else {
+		fg_color = image->fg_color;
+		bg_color = image->bg_color;
+	}
+
+	/* total bytes we need to write */
+	total_bytes = (width + 7) / 8;
+	total_dwords = (total_bytes & ~3) / 4;
+	leftovers = total_bytes & 3;
+
+	if (sfb->fb->var.bits_per_pixel == 24) {
+		dx *= 3;
+		dy *= 3;
+		width *= 3;
+	}
+	smtc_dprw(DPR_SRC_COORDS, 0);
+	smtc_dprw(DPR_DST_COORDS, DPR_COORDS(dx, dy));
+	smtc_dprw(DPR_SPAN_COORDS, DPR_COORDS(width, height));
+	smtc_dprw(DPR_FG_COLOR, fg_color);
+	smtc_dprw(DPR_BG_COLOR, bg_color);
+	smtc_dprw(DPR_DE_CTRL, DE_CTRL_START | DE_CTRL_ROP2_SELECT |
+			(DE_CTRL_COMMAND_HOSTWRITE << DE_CTRL_COMMAND_SHIFT) |
+			(DE_CTRL_HOST_SRC_IS_MONO << DE_CTRL_HOST_SHIFT) |
+			(DE_CTRL_ROP2_COPY << DE_CTRL_ROP2_SHIFT));
+
+	for (i = 0; i < height; i++) {
+		iowrite32_rep(sfb->dp_port, &image->data[idx], total_dwords);
+		if (leftovers) {
+			/*
+			 * We can set info->pixmap.scan_align/buf_align = 4
+			 * for automatic padding. But it would be sometimes
+			 * incompatible with cfb_*(), especially imageblit()
+			 * when depth = 1. In case we need to fallback (e.g.
+			 * debugging), it would be inconvenient, so we pad it
+			 * manually.
+			 */
+			writel_relaxed(
+				pad_to_dword(
+					&image->data[idx + total_dwords * 4],
+					leftovers),
+				sfb->dp_port);
+		}
+		idx += scanline;
+	}
+	mb();  /* ensure all writes to dp_port have finished */
+	smtcfb_wait(sfb);
+}
+
+static void smtcfb_reset_accel(void)
+{
+	u8 reg;
+
+	/* enable Zoom Video Port, 2D Drawing Engine and Video Processor */
+	smtc_seqw(0x21, smtc_seqr(0x21) & 0xf8);
+
+	/* abort pending 2D Drawing Engine operations */
+	reg = smtc_seqr(0x15);
+	smtc_seqw(0x15, reg | 0x30);
+	smtc_seqw(0x15, reg);
+}
+
+/*
+ * Function smtcfb_reset_accel(); should be called before calling
+ * this function
+ */
+static int smtcfb_init_accel(struct smtcfb_info *fb)
+{
+
+	if (accel && !fb->accel) {
+		fb->fb->flags |= FBINFO_HWACCEL_NONE;
+		return 0;
+	} else if (!accel && !fb->accel) {
+		fb->fb->flags |= FBINFO_HWACCEL_DISABLED;
+		return 0;
+	}
+
+	if (smtcfb_wait(fb) != 0) {
+		fb->fb->flags |= FBINFO_HWACCEL_NONE;
+		dev_err(&fb->pdev->dev,
+			"2D acceleration initialization failed!\n");
+		fb->accel = false;
+		return -1;
+	}
+
+	smtc_dprw(DPR_CROP_TOPLEFT_COORDS, DPR_COORDS(0, 0));
+
+	/* same width for DPR_PITCH and DPR_SRC_WINDOW */
+	smtc_dprw(DPR_PITCH, DPR_COORDS(fb->fb->var.xres, fb->fb->var.xres));
+	smtc_dprw(DPR_SRC_WINDOW,
+			DPR_COORDS(fb->fb->var.xres, fb->fb->var.xres));
+
+	switch (fb->fb->var.bits_per_pixel) {
+	case 8:
+		smtc_dprw_16(DPR_DE_FORMAT_SELECT,
+				DE_CTRL_FORMAT_XY | DE_CTRL_FORMAT_8BIT);
+		break;
+	case 16:
+		smtc_dprw_16(DPR_DE_FORMAT_SELECT,
+				DE_CTRL_FORMAT_XY | DE_CTRL_FORMAT_16BIT);
+		break;
+	case 24:
+		smtc_dprw_16(DPR_DE_FORMAT_SELECT,
+				DE_CTRL_FORMAT_XY | DE_CTRL_FORMAT_24BIT);
+		smtc_dprw(DPR_PITCH,
+				DPR_COORDS(fb->fb->var.xres * 3,
+						fb->fb->var.xres * 3));
+		break;
+	case 32:
+		smtc_dprw_16(DPR_DE_FORMAT_SELECT,
+				DE_CTRL_FORMAT_XY | DE_CTRL_FORMAT_32BIT);
+		break;
+	}
+
+	smtc_dprw(DPR_BYTE_BIT_MASK, 0xffffffff);
+	smtc_dprw(DPR_COLOR_COMPARE_MASK, 0);
+	smtc_dprw(DPR_COLOR_COMPARE, 0);
+	smtc_dprw(DPR_SRC_BASE, 0);
+	smtc_dprw(DPR_DST_BASE, 0);
+	smtc_dprw(DPR_MONO_PATTERN_LO32, 0xffffffff);
+	smtc_dprw(DPR_MONO_PATTERN_HI32, 0xffffffff);
+	smtc_dprr(DPR_DST_BASE);
+
+	smtcfb_ops.fb_copyarea = smtcfb_copyarea;
+	smtcfb_ops.fb_fillrect = smtcfb_fillrect;
+	smtcfb_ops.fb_imageblit = smtcfb_imageblit;
+	fb->fb->flags |= FBINFO_HWACCEL_COPYAREA |
+			 FBINFO_HWACCEL_FILLRECT |
+			 FBINFO_HWACCEL_IMAGEBLIT |
+			 FBINFO_READS_FAST;
+
+	/* don't spam the kernel log after each modesetting */
+	if (!accel_status_reported)
+		dev_info(&fb->pdev->dev, "2D acceleration is enabled.\n");
+	accel_status_reported = true;
+
+	return 0;
+}
+
 /*
  * Unmap in the memory mapped IO registers
  */
@@ -1457,10 +1826,14 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 			goto failed_fb;
 		}
 
-		sfb->mmio = (smtc_regbaseaddress =
-		    sfb->lfb + 0x00700000);
+		sfb->mmio = sfb->lfb + 0x00700000;
+		sfb->dp_port = sfb->lfb + 0x00400000;
 		sfb->dp_regs = sfb->lfb + 0x00408000;
 		sfb->vp_regs = sfb->lfb + 0x0040c000;
+
+		smtc_regbaseaddress = sfb->mmio;
+		smtc_dprbaseaddress = sfb->dp_regs;
+		sfb->accel = accel;
 		if (sfb->fb->var.bits_per_pixel == 32) {
 			sfb->lfb += big_addr;
 			dev_info(&pdev->dev, "sfb->lfb=%p\n", sfb->lfb);
@@ -1482,10 +1855,16 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		smem_size = SM722_VIDEOMEMORYSIZE;
 		sfb->dp_regs = ioremap(mmio_base, 0x00a00000);
 		sfb->lfb = sfb->dp_regs + 0x00200000;
-		sfb->mmio = (smtc_regbaseaddress =
-		    sfb->dp_regs + 0x000c0000);
+		sfb->mmio = sfb->dp_regs + 0x000c0000;
 		sfb->vp_regs = sfb->dp_regs + 0x800;
 
+		smtc_regbaseaddress = sfb->mmio;
+		smtc_dprbaseaddress = sfb->dp_regs;
+		sfb->accel = false;
+		if (accel)
+			dev_info(&pdev->dev,
+				"2D acceleration is unsupported on SM720\n");
+
 		smtc_seqw(0x62, 0xff);
 		smtc_seqw(0x6a, 0x0d);
 		smtc_seqw(0x6b, 0x02);
@@ -1659,6 +2038,9 @@ static void __exit sm712fb_exit(void)
 
 module_exit(sm712fb_exit);
 
+module_param(accel, bool, 0444);
+MODULE_PARM_DESC(accel, "Use Acceleration (2D Drawing) Engine (default = 1)");
+
 MODULE_AUTHOR("Siliconmotion ");
 MODULE_DESCRIPTION("Framebuffer driver for SMI Graphic Cards");
 MODULE_LICENSE("GPL");
-- 
2.20.1

