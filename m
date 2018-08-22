Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEE0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C135214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="d76XWmxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C135214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeHVMS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:18:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44534 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbeHVMSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:18:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so883658edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z4YaKXzJ/DownRwu4yv1jXZW8lTAGwrCMpU9ehgypc4=;
        b=d76XWmxNBPKF2ilzx595VNc8Fb69toGGSwPhmi4orJx6Q32PdRq9eRDWJ5NY5SUIoW
         lXizKQdmV06CqSvFYDg1Z9MLrgb2fgfPTONZ4mBOPbFvacepXNzPVf5S2ZTf5vsjcaLo
         zYy2OyMB5XIjbzysXPjq7BLXFE4r241d7PD/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z4YaKXzJ/DownRwu4yv1jXZW8lTAGwrCMpU9ehgypc4=;
        b=TZUg3JwJ4nefFAkJUi0qhb+wKodPwP4ZprA9HKwGCzuTuy+sJwDYKMEGo0XgLWv2Nu
         iMLdfedjsk5jhTwd1s4qZSyKN5xjzVBnTsAyAT11fwWSHrHym/uO2yfvHMAa8N5jQAFr
         IZd5Ij2l+F17XQhm6UDqSk/Noer7VLwvSVF0fWPThS9qFtVqOdcGCQyV96Hn5w17XaBw
         G+qs5EQZzjdKBY9l7nRRYx3jjJ1BOewKd4gbmdEfpVclCkpwD6MOJvoNv6qNV6pCQlyc
         Hazor/3o9sBpigKTEJOEa0SjuG9r5y02JnOvvb9mwzACQTrPYxr3drovyiktUGKKctJF
         vdxg==
X-Gm-Message-State: AOUpUlGPWbPzBIAQ+ZKNVDL2UucmjlPoC/8UTUrFscPHytzQcpCzndgx
        X9b68HzY6kQATPicKqmZMghbog==
X-Google-Smtp-Source: AA+uWPzAaBN0YUaOkXa9n2AysLGFpumX2evUm4a/aTID+b2O4fqiFRFgv06TKiNogRx4zNQGMA/g0g==
X-Received: by 2002:a50:b8c5:: with SMTP id l63-v6mr64588855ede.80.1534928056364;
        Wed, 22 Aug 2018 01:54:16 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id r21-v6sm636418eds.7.2018.08.22.01.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 01:54:15 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 3/4] fbdev: Add FBINFO_HIDE_SMEM_START flag
Date:   Wed, 22 Aug 2018 10:54:04 +0200
Message-Id: <20180822085405.10787-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
References: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM drivers really, really, really don't want random userspace to
share buffer behind it's back, bypassing the dma-buf buffer sharing
machanism. For that reason we've ruthlessly rejected any IOCTL
exposing the physical address of any graphics buffer.

Unfortunately fbdev comes with that built-in. We could just set
smem_start to 0, but that means we'd have to hand-roll our own fb_mmap
implementation. For good reasons many drivers do that, but
smem_start/length is still super convenient.

Hence instead just stop the leak in the ioctl, to keep fb mmap working
as-is. A second patch will set this flag for all drm drivers.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/video/fbdev/core/fbmem.c | 4 ++++
 include/linux/fb.h               | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 609438d2465b..549d0f86fcf3 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1116,6 +1116,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		if (!lock_fb_info(info))
 			return -ENODEV;
 		fix = info->fix;
+		if (info->flags & FBINFO_HIDE_SMEM_START)
+			fix.smem_start = 0;
 		unlock_fb_info(info);
 
 		ret = copy_to_user(argp, &fix, sizeof(fix)) ? -EFAULT : 0;
@@ -1326,6 +1328,8 @@ static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,
 	if (!lock_fb_info(info))
 		return -ENODEV;
 	fix = info->fix;
+	if (info->flags & FBINFO_HIDE_SMEM_START)
+		fix.smem_start = 0;
 	unlock_fb_info(info);
 	return do_fscreeninfo_to_user(&fix, compat_ptr(arg));
 }
diff --git a/include/linux/fb.h b/include/linux/fb.h
index fa8c6f9c9c3a..f42b09ca71f8 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -456,6 +456,13 @@ struct fb_tile_ops {
  * and host endianness. Drivers should not use this flag.
  */
 #define FBINFO_BE_MATH  0x100000
+/*
+ * Hide smem_start in the FBIOGET_FSCREENINFO IOCTL. This is used by modern DRM
+ * drivers to stop userspace from trying to share buffers behind the kernel's
+ * back. Instead dma-buf based buffer sharing should be used.
+ */
+#define FBINFO_HIDE_SMEM_START  0x200000
+
 
 struct fb_info {
 	atomic_t count;
-- 
2.18.0

