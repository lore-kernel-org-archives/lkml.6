Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F328AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A74D20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bk2zXYJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A74D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeICSKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:10:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45158 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeICSJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:09:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so702819wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eGdPVS1hmmh8A+MBC/MKcmxcBqsPEV4vpqI/JhInOdQ=;
        b=bk2zXYJsd5qP+ubx7dGmOsNXlRSo6T2It/SjpwRKRMEkhTjXJGgEsKmfBcRiWJNa8H
         GrtzKmwsgqgVYeNLvZGGfAozic4+k7gJqvqlfc2vKIZu34jpIjUx67Jo1rrSIaLqImn1
         RP2B2/LzOQihCPC1s7cTMMxfFLU1XbcbKjCJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eGdPVS1hmmh8A+MBC/MKcmxcBqsPEV4vpqI/JhInOdQ=;
        b=osvkj4rOSytyxPNWtbanznFcbDU+W2ofXHaplhJaPM2100SxCB3+ZptwuV88Y2QqAU
         Y3eIVkHj+rb/326miEnCsTscYSF2p69W+4Zh/RPHkPyRvLJJvr+7AKKVUrH12F9TCXEb
         +OxPGPE7tX9arrzd4GxlgJ3esRVp/gZ1xCvkdZyfx7RSyxQIsYOg4InXQEnNbLuqZ+LZ
         EcVCvKawtumB/cxHRTrflo3aClQLLmwR1aU3TB3SLS+WKGMt/lPqPq9pJl3Yg8vAKdDI
         VOB4QOBXHxEmllNh6DAneB9s0xqtbn5P+GF/CnbNyj0YYb1kr0Nu4mIVccrsip4/MJy+
         JIsw==
X-Gm-Message-State: APzg51CMYfAasQxwKw3lIJb8psM9S7oyu9Nw6Sa4+sTm58EStzqgWQRk
        cPofVm3QkOAVf5KbN6KDByLSeEXE3GU=
X-Google-Smtp-Source: ANB0VdZWiH4oHb6tIQ+Q4eneKMKPC8jCCnmpaZspBdoxpy1i87Vgw80xIeGgA/OtHiUfDmpwrU+cLQ==
X-Received: by 2002:a5d:4a44:: with SMTP id v4-v6mr19190365wrs.278.1535982582262;
        Mon, 03 Sep 2018 06:49:42 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:10c6:f4fe:894b:34a5:5366:e59c])
        by smtp.gmail.com with ESMTPSA id z16-v6sm14750416wrq.78.2018.09.03.06.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:49:41 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     yannick.fertre@st.com, philippe.cornu@st.com, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] drm: stm: implement get_scanout_position function
Date:   Mon,  3 Sep 2018 15:49:27 +0200
Message-Id: <20180903134927.27583-1-benjamin.gaignard@linaro.org>
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

