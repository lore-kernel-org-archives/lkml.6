Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A146CECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6207420870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6207420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeGPAFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:05:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeGPAFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:05:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNeNg1923059
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:40:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNeMqQ923055;
        Sun, 15 Jul 2018 16:40:22 -0700
Date:   Sun, 15 Jul 2018 16:40:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-38ac0287b7f4f3922e25fd8f81db67f2c13d16bb@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, b.zolnierkie@samsung.com,
        hpa@zytor.com, mingo@kernel.org, lersek@redhat.com,
        linux-kernel@vger.kernel.org, pjones@redhat.com,
        torvalds@linux-foundation.org, ard.biesheuvel@linaro.org
Reply-To: torvalds@linux-foundation.org, pjones@redhat.com,
          lersek@redhat.com, linux-kernel@vger.kernel.org,
          ard.biesheuvel@linaro.org, tglx@linutronix.de,
          b.zolnierkie@samsung.com, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <20180711094040.12506-9-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-9-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] fbdev/efifb: Honour UEFI memory map attributes when
 mapping the FB
Git-Commit-ID: 38ac0287b7f4f3922e25fd8f81db67f2c13d16bb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  38ac0287b7f4f3922e25fd8f81db67f2c13d16bb
Gitweb:     https://git.kernel.org/tip/38ac0287b7f4f3922e25fd8f81db67f2c13d16bb
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Wed, 11 Jul 2018 11:40:40 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:43:12 +0200

fbdev/efifb: Honour UEFI memory map attributes when mapping the FB

If the framebuffer address provided by the Graphics Output Protocol
(GOP) is covered by the UEFI memory map, it will tell us which memory
attributes are permitted when mapping this region. In some cases,
(KVM guest on ARM), violating this will result in loss of coherency,
which means that updates sent to the framebuffer by the guest will
not be observeable by the host, and the emulated display simply does
not work.

So if the memory map contains such a description, take the attributes
field into account, and add support for creating WT or WB mappings of
the framebuffer region.

Tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180711094040.12506-9-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/video/fbdev/efifb.c | 51 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 46a4484e3da7..c6f78d27947b 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -20,7 +20,7 @@
 #include <drm/drm_connector.h>  /* For DRM_MODE_PANEL_ORIENTATION_* */
 
 static bool request_mem_succeeded = false;
-static bool nowc = false;
+static u64 mem_flags = EFI_MEMORY_WC | EFI_MEMORY_UC;
 
 static struct fb_var_screeninfo efifb_defined = {
 	.activate		= FB_ACTIVATE_NOW,
@@ -68,8 +68,12 @@ static int efifb_setcolreg(unsigned regno, unsigned red, unsigned green,
 
 static void efifb_destroy(struct fb_info *info)
 {
-	if (info->screen_base)
-		iounmap(info->screen_base);
+	if (info->screen_base) {
+		if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
+			iounmap(info->screen_base);
+		else
+			memunmap(info->screen_base);
+	}
 	if (request_mem_succeeded)
 		release_mem_region(info->apertures->ranges[0].base,
 				   info->apertures->ranges[0].size);
@@ -104,7 +108,7 @@ static int efifb_setup(char *options)
 			else if (!strncmp(this_opt, "width:", 6))
 				screen_info.lfb_width = simple_strtoul(this_opt+6, NULL, 0);
 			else if (!strcmp(this_opt, "nowc"))
-				nowc = true;
+				mem_flags &= ~EFI_MEMORY_WC;
 		}
 	}
 
@@ -164,6 +168,7 @@ static int efifb_probe(struct platform_device *dev)
 	unsigned int size_remap;
 	unsigned int size_total;
 	char *option = NULL;
+	efi_memory_desc_t md;
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
 		return -ENODEV;
@@ -272,12 +277,35 @@ static int efifb_probe(struct platform_device *dev)
 	info->apertures->ranges[0].base = efifb_fix.smem_start;
 	info->apertures->ranges[0].size = size_remap;
 
-	if (nowc)
-		info->screen_base = ioremap(efifb_fix.smem_start, efifb_fix.smem_len);
-	else
-		info->screen_base = ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len);
+	if (!efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
+		if ((efifb_fix.smem_start + efifb_fix.smem_len) >
+		    (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
+			pr_err("efifb: video memory @ 0x%lx spans multiple EFI memory regions\n",
+			       efifb_fix.smem_start);
+			err = -EIO;
+			goto err_release_fb;
+		}
+		/*
+		 * If the UEFI memory map covers the efifb region, we may only
+		 * remap it using the attributes the memory map prescribes.
+		 */
+		mem_flags |= EFI_MEMORY_WT | EFI_MEMORY_WB;
+		mem_flags &= md.attribute;
+	}
+	if (mem_flags & EFI_MEMORY_WC)
+		info->screen_base = ioremap_wc(efifb_fix.smem_start,
+					       efifb_fix.smem_len);
+	else if (mem_flags & EFI_MEMORY_UC)
+		info->screen_base = ioremap(efifb_fix.smem_start,
+					    efifb_fix.smem_len);
+	else if (mem_flags & EFI_MEMORY_WT)
+		info->screen_base = memremap(efifb_fix.smem_start,
+					     efifb_fix.smem_len, MEMREMAP_WT);
+	else if (mem_flags & EFI_MEMORY_WB)
+		info->screen_base = memremap(efifb_fix.smem_start,
+					     efifb_fix.smem_len, MEMREMAP_WB);
 	if (!info->screen_base) {
-		pr_err("efifb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
+		pr_err("efifb: abort, cannot remap video memory 0x%x @ 0x%lx\n",
 			efifb_fix.smem_len, efifb_fix.smem_start);
 		err = -EIO;
 		goto err_release_fb;
@@ -371,7 +399,10 @@ err_fb_dealoc:
 err_groups:
 	sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
 err_unmap:
-	iounmap(info->screen_base);
+	if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
+		iounmap(info->screen_base);
+	else
+		memunmap(info->screen_base);
 err_release_fb:
 	framebuffer_release(info);
 err_release_mem:
