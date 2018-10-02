Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E55C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735C5206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RiEx4+cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735C5206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJBRAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:00:49 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46824 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBRAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:00:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181002101814euoutp013531eed718c67aae0a0995ca55999ca3~Zw0_NBntP3096230962euoutp01C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 10:18:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181002101814euoutp013531eed718c67aae0a0995ca55999ca3~Zw0_NBntP3096230962euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538475494;
        bh=JFkfuPGCy/l8d4ClWzacZ8udeSDDQ61UVqgV+kgRIuI=;
        h=To:Cc:From:Subject:Date:References:From;
        b=RiEx4+ccqHoSuZA0skmINlv8tq3FIaBUPoWRtf6rQZpQDfJc3eN+vV/ZrqWkBFOCI
         AvFpTbKYwEiOMTyIbo1j4b+0YWvgahJ6sNp9tgSvLyKhuPk3dRv2BukhgAL41LEhrk
         hpXO5dKWDnar/mYXiNXSHueBOFdyEU/j83SVLLsQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181002101813eucas1p1f476b69c0f7f87fb550ccb67ed51eba8~Zw090CqnL1848718487eucas1p1j;
        Tue,  2 Oct 2018 10:18:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E2.AC.04441.5E543BB5; Tue,  2
        Oct 2018 11:18:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181002101812eucas1p28c4a9b388a99a32b9a292fb0cdcce816~Zw089uDZp3206032060eucas1p2t;
        Tue,  2 Oct 2018 10:18:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181002101812eusmtrp2a7a8e45aeb84025765ea6a095b3f3a9d~Zw08sW8ay0823008230eusmtrp2F;
        Tue,  2 Oct 2018 10:18:12 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-e1-5bb345e50c0d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 25.83.04284.4E543BB5; Tue,  2
        Oct 2018 11:18:12 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181002101812eusmtip11de8d8c94e519bf75f50a6fc94b7322b~Zw08UhG2X0509005090eusmtip1F;
        Tue,  2 Oct 2018 10:18:12 +0000 (GMT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [GIT PULL] fbdev fixes for v4.19-rc7
Date:   Tue, 2 Oct 2018 12:18:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduznOd2nrpujDRZ/kLK48vU9m0Xz4vVs
        Fif6PrBaXN41h83iUd9bdgdWjxMzfrN47J+7ht3jfvdxJo/Pm+QCWKK4bFJSczLLUov07RK4
        MhoXTWQr6DauOH7Ot4HxpGYXIyeHhICJxI+J+1i6GLk4hARWMEqsur2KHcL5wijxbvUKqMxn
        RokvDy8wwrT8efQDKrGcUaK9aRIzSEJI4D2jRNOqchBbRMBYov/sLLBRzAKTGCX+rPkBVsQm
        YCUxsX0V2CRhAV2Jmx+PsoDYLAIqEvfmHgdq4OAQFYiQ6D+jDhLmFRCUODnzCVgJs4C8xPa3
        c5hBZkoIfGeT6Lj4hw2iqEzi5/YPUNe5SGw8vI0JwhaWeHV8CzuELSPxf+d8Jojm6YwSb34t
        ZYFw1jNKrDlzDKrDWuLw8YusIFcwC2hKrN+lDxF2lDgx8RjYcRICfBI33gpCHMQnMWnbdGaI
        MK9ER5sQRLWaxIZlG9hg1nbtXMkMYXtIzH19jAUSVrES876/Yp3AqDALyZuzkLw5C+GGBYzM
        qxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQKTyel/xz/tYPx6KekQowAHoxIPL4P8pmgh
        1sSy4srcQ4wSHMxKIrys1pujhXhTEiurUovy44tKc1KLDzFKc7AoifMum7cxWkggPbEkNTs1
        tSC1CCbLxMEp1cBokDlt5TZ9d/kO+ZZX99Y8sq+qDl/RvPOHHx/T+jfGa5YHua/NZy6f8Is1
        UtRzn8NSp/Is8df3Otrcpkw8aHtO6ZnQRQOOriWhrWrH9qUd3Pnhhsba5XKXNrPoBU/+5Hf+
        Mkf4/vRN0fW3Zr+weM8jVnS09pNOp0pK7I2jZ+OWKscdvCbs/GCtEktxRqKhFnNRcSIA4P1v
        wiIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsVy+t/xu7pPXDdHG2yaJGVx5et7NovmxevZ
        LE70fWC1uLxrDpvFo7637A6sHidm/Gbx2D93DbvH/e7jTB6fN8kFsETp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZTQumshW0G1ccfycbwPjSc0u
        Rk4OCQETiT+PfrB0MXJxCAksZZQ4+uQoWxcjB1BCRuL4+jKIGmGJP9e62EBsIYG3jBIn5kWA
        2CICxhL9Z2exg/QyC0xilPh2YycLSIJNwEpiYvsqRhBbWEBX4ubHo2BxXgE7ifPnV4MNYhFQ
        kbg39zg7iC0qECFx62EHVI2gxMmZT8BsZgF1iT/zLjFD2PIS29/OYZ7AyD8LSdksJGWzkJQt
        YGRexSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERjy24793LyD8dLG4EOMAhyMSjy8DPKbooVY
        E8uKK3MPMUpwMCuJ8LJab44W4k1JrKxKLcqPLyrNSS0+xGgKdPhEZinR5HxgPOaVxBuaGppb
        WBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamBU1Cx1dmtR3bL5zcKVu8u+dZmV
        Ouybx/FBhDk/41KLyAKJo90mmet4REvfaIrMWC3iNC9TNvDAkc6s43xWDSGCu28dXrYh3J6r
        I9Dz0uftB9l5fQ3dGkxfvLWyeWzFpHtNWpx7hXHTRZMDD4K/+a5pC8x7WZl5PeLrU4fFzw+z
        2XrH+ulNuqfEUpyRaKjFXFScCABicpHIjwIAAA==
Message-Id: <20181002101812eucas1p28c4a9b388a99a32b9a292fb0cdcce816~Zw089uDZp3206032060eucas1p2t@eucas1p2.samsung.com>
X-CMS-MailID: 20181002101812eucas1p28c4a9b388a99a32b9a292fb0cdcce816
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181002101812eucas1p28c4a9b388a99a32b9a292fb0cdcce816
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181002101812eucas1p28c4a9b388a99a32b9a292fb0cdcce816
References: <CGME20181002101812eucas1p28c4a9b388a99a32b9a292fb0cdcce816@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull fbdev fixes for v4.19-rc7 (please see the signed tag
description for details).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.19-rc7

for you to fetch changes up to 7c968791f7753bf0e52a21729498509ea3dd751b:

  video/fbdev/stifb: Fix spelling mistake in fall-through annotation (2018-09-26 18:50:54 +0200)

----------------------------------------------------------------
fbdev fixes for v4.19-rc7:

- fix OMAPFB_MEMORY_READ ioctl to not leak kernel memory in omapfb driver
  (Tomi Valkeinen)

- add missing prepare/unprepare clock operations in pxa168fb driver
  (Lubomir Rintel)

- add nobgrt option in efifb driver to disable ACPI BGRT logo restore
  (Hans de Goede)

- fix spelling mistake in fall-through annotation in stifb driver
  (Gustavo A. R. Silva)

- fix URL for uvesafb repository in the documentation (Adam Jackson)

----------------------------------------------------------------
Adam Jackson (1):
      uvesafb: Fix URLs in the documentation

Bartlomiej Zolnierkiewicz (1):
      Merge tag 'v4.19-rc5' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next

Gustavo A. R. Silva (1):
      video/fbdev/stifb: Fix spelling mistake in fall-through annotation

Hans de Goede (1):
      efifb: BGRT: Add nobgrt option

Lubomir Rintel (1):
      pxa168fb: prepare the clock

Tomi Valkeinen (1):
      fbdev/omapfb: fix omapfb_memory_read infoleak

 Documentation/fb/uvesafb.txt                    | 5 +++--
 MAINTAINERS                                     | 2 +-
 drivers/video/fbdev/efifb.c                     | 6 ++++++
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c | 5 ++++-
 drivers/video/fbdev/pxa168fb.c                  | 6 +++---
 drivers/video/fbdev/stifb.c                     | 2 +-
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/fb/uvesafb.txt b/Documentation/fb/uvesafb.txt
index f6362d8..aa92419 100644
--- a/Documentation/fb/uvesafb.txt
+++ b/Documentation/fb/uvesafb.txt
@@ -15,7 +15,8 @@ than x86.  Check the v86d documentation for a list of currently supported
 arches.
 
 v86d source code can be downloaded from the following website:
-  http://dev.gentoo.org/~spock/projects/uvesafb
+
+  https://github.com/mjanusz/v86d
 
 Please refer to the v86d documentation for detailed configuration and
 installation instructions.
@@ -177,7 +178,7 @@ from the Video BIOS if you set pixclock to 0 in fb_var_screeninfo.
 
 --
  Michal Januszewski <spock@gentoo.org>
- Last updated: 2009-03-30
+ Last updated: 2017-10-10
 
  Documentation of the uvesafb options is loosely based on vesafb.txt.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 02a3961..97e565f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15389,7 +15389,7 @@ S:	Maintained
 UVESAFB DRIVER
 M:	Michal Januszewski <spock@gentoo.org>
 L:	linux-fbdev@vger.kernel.org
-W:	http://dev.gentoo.org/~spock/projects/uvesafb/
+W:	https://github.com/mjanusz/v86d
 S:	Maintained
 F:	Documentation/fb/uvesafb.txt
 F:	drivers/video/fbdev/uvesafb.*
diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 3946649..ba906876 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -42,6 +42,7 @@ struct bmp_dib_header {
 	u32 colors_important;
 } __packed;
 
+static bool use_bgrt = true;
 static bool request_mem_succeeded = false;
 static u64 mem_flags = EFI_MEMORY_WC | EFI_MEMORY_UC;
 
@@ -160,6 +161,9 @@ static void efifb_show_boot_graphics(struct fb_info *info)
 	void *bgrt_image = NULL;
 	u8 *dst = info->screen_base;
 
+	if (!use_bgrt)
+		return;
+
 	if (!bgrt_tab.image_address) {
 		pr_info("efifb: No BGRT, not showing boot graphics\n");
 		return;
@@ -290,6 +294,8 @@ static int efifb_setup(char *options)
 				screen_info.lfb_width = simple_strtoul(this_opt+6, NULL, 0);
 			else if (!strcmp(this_opt, "nowc"))
 				mem_flags &= ~EFI_MEMORY_WC;
+			else if (!strcmp(this_opt, "nobgrt"))
+				use_bgrt = false;
 		}
 	}
 
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
index ef69273..a3edb20 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
@@ -496,6 +496,9 @@ static int omapfb_memory_read(struct fb_info *fbi,
 	if (!access_ok(VERIFY_WRITE, mr->buffer, mr->buffer_size))
 		return -EFAULT;
 
+	if (mr->w > 4096 || mr->h > 4096)
+		return -EINVAL;
+
 	if (mr->w * mr->h * 3 > mr->buffer_size)
 		return -EINVAL;
 
@@ -509,7 +512,7 @@ static int omapfb_memory_read(struct fb_info *fbi,
 			mr->x, mr->y, mr->w, mr->h);
 
 	if (r > 0) {
-		if (copy_to_user(mr->buffer, buf, mr->buffer_size))
+		if (copy_to_user(mr->buffer, buf, r))
 			r = -EFAULT;
 	}
 
diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index def3a50..d059d04 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -712,7 +712,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	/*
 	 * enable controller clock
 	 */
-	clk_enable(fbi->clk);
+	clk_prepare_enable(fbi->clk);
 
 	pxa168fb_set_par(info);
 
@@ -767,7 +767,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 failed_free_cmap:
 	fb_dealloc_cmap(&info->cmap);
 failed_free_clk:
-	clk_disable(fbi->clk);
+	clk_disable_unprepare(fbi->clk);
 failed_free_fbmem:
 	dma_free_coherent(fbi->dev, info->fix.smem_len,
 			info->screen_base, fbi->fb_start_dma);
@@ -807,7 +807,7 @@ static int pxa168fb_remove(struct platform_device *pdev)
 	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
 		    info->screen_base, info->fix.smem_start);
 
-	clk_disable(fbi->clk);
+	clk_disable_unprepare(fbi->clk);
 
 	framebuffer_release(info);
 
diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index 045e8af..9e88e3f 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1157,7 +1157,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 			dev_name);
 		   goto out_err0;
 		}
-		/* fall though */
+		/* fall through */
 	case S9000_ID_ARTIST:
 	case S9000_ID_HCRX:
 	case S9000_ID_TIMBER:

