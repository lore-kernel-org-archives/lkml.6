Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32DBC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1C720855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jt1J7aQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1C720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeLJJFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:05:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37768 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeLJJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:05:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so10274239wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 01:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=acAAxuC8xw1vTrdEMgWFf+3ymowNGDjPcrhaXEGaw/k=;
        b=jt1J7aQyGQlJI3EAKqTBItpaPYQr688BavuyAc1+va5mHIYQwqWazQN6De0z89j3+s
         yVGuuXZF791gkZG9rMGo966zlZF0sy25P5URvAf5V77O9lTV+tdH20U45zoEC5pJ7db/
         mML7K3qJ9sw4qMK+09+oOp6k5MQM3RK2hPfp0qVGbkBFVY80aX8iK62ccYm9M8ANtXsV
         5AOstZOIeVtqw9MQuZp7yOGIOMrmgFCCbdrVHgfdbKhAAhJLzb8H59xh5iaVYw5k5rpG
         8JFSSP+pdhT8FK2l1c99UeyY9yrTXmf7TmWSyCwd3U03ZmPcoIu7fyZZSMDcn2p5otP+
         TMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=acAAxuC8xw1vTrdEMgWFf+3ymowNGDjPcrhaXEGaw/k=;
        b=KhjEXFMVvTLG6IOch4yoMX8k+dA7Jf5icPkWL2g6/xpZ8TKrdds1wENGqe9pOz7ckz
         nP12u1zzE+jq6xVzS356aZjF/4H3DzG7ob4fFReZWPkcq1S2belRsKwgDVYbx69C9gs5
         m8NxedUiaqLzxPhHEBuSmTc4sRUz0BHswG40GQrRVNRE+1CbjBvqtKSumF91mLmW0gkz
         4rsymU7Wr+EKqwENU1Wu+RDW49ecGYL3+05nHepwX8b5WHituXIb5Xv2fwyzNLuI46b7
         6LgYl7RUigcmyq8ZpzsRka/uIr6Utf43jphZ3BYtlL5lRSeH6lKk3yMhWYgMtmWhX0sy
         bF2w==
X-Gm-Message-State: AA+aEWYEByKLn40oSDBRnkajFropVtPxz45USyRoMxvuXMtfsgDa33qd
        7v+HjOi49U3mzikt4hQ/9UVGkb/RHbasxg==
X-Google-Smtp-Source: AFSGD/WwDn7wNpxnXfrYlXOznRcRKD+iMC5hbzSFdAA/4q2QjwKIvN0sVQqBy4Pu5KcJY4BK5C9y8Q==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190mr10597829wmg.13.1544432709087;
        Mon, 10 Dec 2018 01:05:09 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id s202sm11066031wme.40.2018.12.10.01.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 01:05:08 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/meson: remove firmware framebuffers
Date:   Mon, 10 Dec 2018 10:04:48 +0100
Message-Id: <20181210090448.4301-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we are using simplefb or another conflicting framebuffer, make
the call to drm_fb_helper_remove_conflicting_framebuffers()

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index d3443125e661..82fbd7ae80e4 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -159,6 +159,22 @@ static void meson_vpu_init(struct meson_drm *priv)
 	writel_relaxed(0x20000, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
 }
 
+static void meson_remove_framebuffers(void)
+{
+        struct apertures_struct *ap;
+
+        ap = alloc_apertures(1);
+        if (!ap)
+                return;
+
+        /* The framebuffer can be located anywhere in RAM */
+        ap->ranges[0].base = 0;
+        ap->ranges[0].size = ~0;
+
+        drm_fb_helper_remove_conflicting_framebuffers(ap, "meson-drm-fb", false);
+        kfree(ap);
+}
+
 static int meson_drv_bind_master(struct device *dev, bool has_components)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -242,6 +258,9 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (ret)
 		goto free_drm;
 
+	/* Remove early framebuffers (ie. simplefb) */
+	meson_remove_framebuffers();
+
 	drm_mode_config_init(drm);
 	drm->mode_config.max_width = 3840;
 	drm->mode_config.max_height = 2160;
-- 
2.19.2

