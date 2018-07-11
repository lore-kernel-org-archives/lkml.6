Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6BBC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA8520BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q20FrrOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA8520BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbeGKJoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:44:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54354 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732628AbeGKJo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:44:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id i139-v6so1759584wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hSmuPT04ey1U4iYRelgasoauscoIOrW4wwIqOVRaXYw=;
        b=Q20FrrOF3D6KVUv22rSGpOLhLgdfVwqIrbtC9ntFxoDFenik7SaJZNVQZcXjROjvDg
         q9H6aMg9yVilfL+PuHfJPZTIQB1TzV3ZVOVQqIawF/45T+7YX6jo+PUINA2a8oLq+Nst
         qTu5b9DHY+FxulTxAYRb+6Dd/O4HbBMYAWTsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hSmuPT04ey1U4iYRelgasoauscoIOrW4wwIqOVRaXYw=;
        b=kK7vG14BcI6gfnLn3GWSunuJaKihMjmqeuKL4j+d/LZh3NKKewoxnXVJzVOPSy6Ey3
         YQaFIHhvOwpONzzx+aXqD7q/cbAynL0H4UClB7TCb/Az+TUX4jEXPbB/QWjpz8/OIL1W
         I6xOHTsZxz+pwNe/rmzqeozKfWRaRr+GKJiELgrfNltHX7oC6sweOqg6vylvqeF9r9dG
         nEk7zT+RYzxJpVKbIalGr1vP+aVERs8Xq8E0x7qA1+su9aYIZNnlJ2bXncQ2tSZtF/CL
         o8XeJOwbZKRn4n/qiDys4k26H/1qpJGRlY7AT+a7NZ1jsd21FZKodDDh0nlhxMG10axK
         pY4Q==
X-Gm-Message-State: APt69E26LIkxTJ1HuhySfApZero7JesofwNZ6ye8pWhdEuNg0/Q2vRgp
        xfK9p+4YvB+y/9X0fC6v/wHhwA==
X-Google-Smtp-Source: AAOMgpcYDaY61Eovm74nEZrrCMaAzlQyp6fFmT0vnNg7PiCBM2gseWIfCiBdATlLkyRGw9AyBTEEsg==
X-Received: by 2002:a1c:9809:: with SMTP id a9-v6mr11999792wme.15.1531302059628;
        Wed, 11 Jul 2018 02:40:59 -0700 (PDT)
Received: from localhost.localdomain (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id t124-v6sm1641311wmt.29.2018.07.11.02.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 02:40:58 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>
Subject: [PATCH 8/8] fbdev/efifb: honour UEFI memory map attributes when mapping the fb
Date:   Wed, 11 Jul 2018 11:40:40 +0200
Message-Id: <20180711094040.12506-9-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Peter Jones <pjones@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/video/fbdev/efifb.c | 51 +++++++++++++++++++++++++++++--------
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
@@ -371,7 +399,10 @@ static int efifb_probe(struct platform_device *dev)
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
-- 
2.17.1

