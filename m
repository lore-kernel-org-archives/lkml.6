Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7525BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1696627F20
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xz52LIvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1696627F20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965222AbeF2NCE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:02:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55717 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935222AbeF2NCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:02:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so2119991wmv.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eGdPVS1hmmh8A+MBC/MKcmxcBqsPEV4vpqI/JhInOdQ=;
        b=Xz52LIvtEadWImfaXrITpg5+zYdgE4cDFSgJzXuG6jYGlCE/iqA7hcv2bKvplD6JVh
         EQHSuP8mgxCh//ThyeI/n0cmGgDo1yrgsSszaF56WexPCnX8olNpx2dosgg6dxzwRm1u
         egfYTkdqYJPSzCSgBIKRRgwDWRehmcxu/r0dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eGdPVS1hmmh8A+MBC/MKcmxcBqsPEV4vpqI/JhInOdQ=;
        b=Wlrede1KY13ANOJc9dXLfPaIkUUsZBe8BeJjvvO/cFBU89ls6wxid/ruYWhBwInufk
         s2uimh/+tZRaaiD84rs5tYN4ccXbSAi3H+jeJ3s7ZjPCD5y1/fHTuFaZuy9uvF7kQywa
         0ST9bzOPBvNS+McNpzB9nc5Oz4LNcuodL7YUNO2G8QjIAsY+CQmqt/xPtDCEo/6NG8x2
         +zXdhqK/4HxNtAVUnT1/Yy8qUxBKQsfEoXgsD5hoM1waQQW79xJgfe4j02P8ZMxm1T2D
         UuZvI2kHPJVrSE0/LMEZYkuCftlx8lbpHS4QWRaumb7Ob2e69u+JvnqXo6RI+tQo9yBp
         yNrQ==
X-Gm-Message-State: APt69E3xE5M9FGWkE0LI295pHZIKpcWcBI9nmcKgNnhlss6/C7thp9+a
        H3nUgTA97G86vzdB7Fwapz6JUf5+oY8=
X-Google-Smtp-Source: AAOMgpeCNZx3i4HCQw5/CXkchWB0eQMZRA0QL7AJyAX/txyAqVsVdl28C11K9FlZjHkOq1NtBgUlcQ==
X-Received: by 2002:a1c:a016:: with SMTP id j22-v6mr888972wme.1.1530277321604;
        Fri, 29 Jun 2018 06:02:01 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([80.215.34.152])
        by smtp.gmail.com with ESMTPSA id q70-v6sm2218724wmd.45.2018.06.29.06.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 06:02:00 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     yannick.fertre@st.com, philippe.cornu@st.com, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] drm: stm: implement get_scanout_position function
Date:   Fri, 29 Jun 2018 15:01:40 +0200
Message-Id: <20180629130140.16004-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware allow to read the position in scanout buffer so
we can use this information to make wait of vblank more accurate.

Active area bounds (start, end, total height) have already been
computed and written in ltdc registers, read them and get the
current line position to compute vpos value.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/gpu/drm/stm/drv.c  |  2 ++
 drivers/gpu/drm/stm/ltdc.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/stm/ltdc.h |  5 +++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 8698e08313e1..ac53383350e3 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -72,6 +72,8 @@ static struct drm_driver drv_driver = {
 	.gem_prime_vmap = drm_gem_cma_prime_vmap,
 	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
 	.gem_prime_mmap = drm_gem_cma_prime_mmap,
+	.get_scanout_position = ltdc_crtc_scanoutpos,
+	.get_vblank_timestamp = drm_calc_vbltimestamp_from_scanoutpos,
 };
 
 static int drv_load(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index d997a6014d6c..05b714673042 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -148,6 +148,8 @@
 #define IER_TERRIE	BIT(2)		/* Transfer ERRor Interrupt Enable */
 #define IER_RRIE	BIT(3)		/* Register Reload Interrupt enable */
 
+#define CPSR_CYPOS	GENMASK(15, 0)	/* Current Y position */
+
 #define ISR_LIF		BIT(0)		/* Line Interrupt Flag */
 #define ISR_FUIF	BIT(1)		/* Fifo Underrun Interrupt Flag */
 #define ISR_TERRIF	BIT(2)		/* Transfer ERRor Interrupt Flag */
@@ -622,6 +624,49 @@ static void ltdc_crtc_disable_vblank(struct drm_crtc *crtc)
 	reg_clear(ldev->regs, LTDC_IER, IER_LIE);
 }
 
+bool ltdc_crtc_scanoutpos(struct drm_device *ddev, unsigned int pipe,
+			  bool in_vblank_irq, int *vpos, int *hpos,
+			  ktime_t *stime, ktime_t *etime,
+			  const struct drm_display_mode *mode)
+{
+	struct ltdc_device *ldev = ddev->dev_private;
+	int line, vactive_start, vactive_end, vtotal;
+
+	if (stime)
+		*stime = ktime_get();
+
+	/* The active area starts after vsync + front porch and ends
+	 * at vsync + front porc + display size.
+	 * The total height also include back porch.
+	 * We have 3 possible cases to handle:
+	 * - line < vactive_start: vpos = line - vactive_start and will be
+	 * negative
+	 * - vactive_start < line < vactive_end: vpos = line - vactive_start
+	 * and will be positive
+	 * - line > vactive_end: vpos = line - vtotal - vactive_start
+	 * and will negative
+	 *
+	 * Computation for the two first cases are identical so we can
+	 * simplify the code and only test if line > vactive_end
+	 */
+	line = reg_read(ldev->regs, LTDC_CPSR) & CPSR_CYPOS;
+	vactive_start = reg_read(ldev->regs, LTDC_BPCR) & BPCR_AVBP;
+	vactive_end = reg_read(ldev->regs, LTDC_AWCR) & AWCR_AAH;
+	vtotal = reg_read(ldev->regs, LTDC_TWCR) & TWCR_TOTALH;
+
+	if (line > vactive_end)
+		*vpos = line - vtotal - vactive_start;
+	else
+		*vpos = line - vactive_start;
+
+	*hpos = 0;
+
+	if (etime)
+		*etime = ktime_get();
+
+	return true;
+}
+
 static const struct drm_crtc_funcs ltdc_crtc_funcs = {
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index 1e16d6afb0d2..b8c5cc41e17a 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -37,6 +37,11 @@ struct ltdc_device {
 	struct fps_info plane_fpsi[LTDC_MAX_LAYER];
 };
 
+bool ltdc_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
+			  bool in_vblank_irq, int *vpos, int *hpos,
+			  ktime_t *stime, ktime_t *etime,
+			  const struct drm_display_mode *mode);
+
 int ltdc_load(struct drm_device *ddev);
 void ltdc_unload(struct drm_device *ddev);
 
-- 
2.15.0

