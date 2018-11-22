Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EA0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FD720684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wW52EcV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FD720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438053AbeKWClG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:41:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39046 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391924AbeKWClG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:41:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so9611317wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 08:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=avXVXp5/1rPIrpnI1Fss2xx2pja/uAfXzl4UBTq39+k=;
        b=wW52EcV90WmSABXnWBouUYFMl+m+jX6cNxzLnZziUHaEL/7bJpzT9cmQYiusVWmArV
         9XJIkCts42X5KzCocJeTPcGu5y73pPZvpjmHOS43YIT/3QAH+DZjjBPU0pFeuAx9gcKV
         +dWO3ca5IrCC7kqyGO6uo9ObDBtitzXSRBG9R6LqHO19dNx9gnZ6Rh2kfbJt63v0/o2L
         aM6MQaWfXMLTUpVgHOdIz1ir/p8laZx4PpxK7mKAo6Gx/m/bfMQY53O6faDzc0zFzL56
         JXhOoHMHb6YSBibgA+TI3camtvWrJ/2pwsMb5V4v9rqa1A+gSrD4qxdFpgXRq5GxkxPM
         ZrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=avXVXp5/1rPIrpnI1Fss2xx2pja/uAfXzl4UBTq39+k=;
        b=EO2UmouHEyCUXiFgjnT7fMkcJMciI7uYWCwIe1ecHY7S4tgK5J6Rrzu+10jRf4+Tho
         D61Vzuk28bzO78nvpkrNGI/f+Exq2wSpXaMnrgWLRLTu9+ze5Jl00Xt38MPHEf+5Ti2y
         sL64IOVCWxbY8Xp4hvV5FtwijDF9PTXEyuQ4aGjQ5k26iIvSJpJUHxNEXiq63qd5PFHO
         ArcMKsH1pWlu00LK7IPS4BusxYn8CPRsBaAuQUkZPVDo0v4N18sMEK4x9zRDaXGwGYym
         tbMDikG1u/wIkHiNSqov/DtmINBFrUjySI4BQmVdJazH6DVHx1yZ+yBRM/rOz4t3VCW6
         +seQ==
X-Gm-Message-State: AA+aEWY3+AlyOJKJ5DPZz5+udM/EK3Psjhkx9Y6ybd8le47FTheuZSzt
        OHa0I3o8bCK8XooIasw9u7jlEw==
X-Google-Smtp-Source: AFSGD/UhZNeUOyDkE2gZnGrKr75oCTTjbVKDqHid/3a77ZabgIERDU9PKRNbFDJI+MUHuVS/aJ6ooA==
X-Received: by 2002:a1c:e184:: with SMTP id y126mr7300225wmg.13.1542902465973;
        Thu, 22 Nov 2018 08:01:05 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v189-v6sm5058288wmd.40.2018.11.22.08.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Nov 2018 08:01:05 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/meson: Fixes for drm_crtc_vblank_on/off support
Date:   Thu, 22 Nov 2018 17:01:03 +0100
Message-Id: <20181122160103.10993-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Linux 4.17, calls to drm_crtc_vblank_on/off are mandatory, and we get
a warning when ctrc is disabled :
" driver forgot to call drm_crtc_vblank_off()"

But, the vsync IRQ was not totally disabled due the transient hardware
state and specific interrupt line, thus adding proper IRQ masking from
the HHI system control registers.

The last change fixes a race condition introduced by calling the added
drm_crtc_vblank_on/off when an HPD event occurs from the HDMI connector,
triggering a WARN_ON() in the _atomic_begin() callback when the CRTC
is disabled, thus also triggering a WARN_ON() in drm_vblank_put() :

WARNING: CPU: 0 PID: 1185 at drivers/gpu/drm/meson/meson_crtc.c:157 meson_crtc_atomic_begin+0x78/0x80
[...]
Call trace:
  meson_crtc_atomic_begin+0x78/0x80
  drm_atomic_helper_commit_planes+0x140/0x218
  drm_atomic_helper_commit_tail+0x38/0x80
  commit_tail+0x7c/0x80
  drm_atomic_helper_commit+0xdc/0x150
  drm_atomic_commit+0x54/0x60
  restore_fbdev_mode_atomic+0x198/0x238
  restore_fbdev_mode+0x6c/0x1c0
  drm_fb_helper_restore_fbdev_mode_unlocked+0x7c/0xf0
  drm_fb_helper_set_par+0x34/0x60
  drm_fb_helper_hotplug_event.part.28+0xb8/0xc8
  drm_fbdev_client_hotplug+0xa4/0xe0
  drm_client_dev_hotplug+0x90/0xe0
  drm_kms_helper_hotplug_event+0x3c/0x48
  drm_helper_hpd_irq_event+0x134/0x168
  dw_hdmi_top_thread_irq+0x3c/0x50
[...]
WARNING: CPU: 0 PID: 1185 at drivers/gpu/drm/drm_vblank.c:1026 drm_vblank_put+0xb4/0xc8
[...]
 Call trace:
  drm_vblank_put+0xb4/0xc8
  drm_crtc_vblank_put+0x24/0x30
  drm_atomic_helper_wait_for_vblanks.part.9+0x130/0x2b8
  drm_atomic_helper_commit_tail+0x68/0x80
[...]

The issue is that vblank need to be enabled in any occurence of :
- atomic_enable()
- atomic_begin() and state->enable == true, which was not the case

Moving the CRTC enable code to a common function and calling in one
of these occurence solves this race condition and makes sure vblank
is enabled in each call to _atomic_begin() from the HPD event leading
to drm_atomic_helper_commit_planes().

To Summarize :
- Make sure that the CRTC code will call the drm_crtc_vblank_on()/off()
- *Really* mask the Vsync IRQ
- Initialize and enable vblank at the first _atomic_begin()/_atomic_enable()

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c | 27 +++++++++++++++++++++++++--
 drivers/gpu/drm/meson/meson_venc.c |  3 +++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index d78168f979db..75d97f1b2e8f 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -46,6 +46,7 @@ struct meson_crtc {
 	struct drm_crtc base;
 	struct drm_pending_vblank_event *event;
 	struct meson_drm *priv;
+	bool enabled;
 };
 #define to_meson_crtc(x) container_of(x, struct meson_crtc, base)
 
@@ -81,8 +82,7 @@ static const struct drm_crtc_funcs meson_crtc_funcs = {
 
 };
 
-static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
-				     struct drm_crtc_state *old_state)
+static void meson_crtc_enable(struct drm_crtc *crtc)
 {
 	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
 	struct drm_crtc_state *crtc_state = crtc->state;
@@ -106,6 +106,22 @@ static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
 	writel_bits_relaxed(VPP_POSTBLEND_ENABLE, VPP_POSTBLEND_ENABLE,
 			    priv->io_base + _REG(VPP_MISC));
 
+	drm_crtc_vblank_on(crtc);
+
+	meson_crtc->enabled = true;
+}
+
+static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
+				     struct drm_crtc_state *old_state)
+{
+	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
+	struct meson_drm *priv = meson_crtc->priv;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	if (!meson_crtc->enabled)
+		meson_crtc_enable(crtc);
+
 	priv->viu.osd1_enabled = true;
 }
 
@@ -117,6 +133,8 @@ static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	DRM_DEBUG_DRIVER("\n");
 
+	drm_crtc_vblank_off(crtc);
+
 	priv->viu.osd1_enabled = false;
 	priv->viu.osd1_commit = false;
 
@@ -135,6 +153,8 @@ static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
 
 		crtc->state->event = NULL;
 	}
+
+	meson_crtc->enabled = false;
 }
 
 static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -143,6 +163,9 @@ static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
 	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
 	unsigned long flags;
 
+	if (crtc->state->enable && !meson_crtc->enabled)
+		meson_crtc_enable(crtc);
+
 	if (crtc->state->event) {
 		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
 
diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 9be0376e0329..ab72ddda242d 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -71,6 +71,7 @@
  */
 
 /* HHI Registers */
+#define HHI_GCLK_MPEG2		0x148 /* 0x52 offset in data sheet */
 #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
 #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
 #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 offset in data sheet */
@@ -1663,10 +1664,12 @@ unsigned int meson_venci_get_field(struct meson_drm *priv)
 void meson_venc_enable_vsync(struct meson_drm *priv)
 {
 	writel_relaxed(2, priv->io_base + _REG(VENC_INTCTRL));
+	regmap_update_bits(priv->hhi, HHI_GCLK_MPEG2, BIT(25), BIT(25));
 }
 
 void meson_venc_disable_vsync(struct meson_drm *priv)
 {
+	regmap_update_bits(priv->hhi, HHI_GCLK_MPEG2, BIT(25), 0);
 	writel_relaxed(0, priv->io_base + _REG(VENC_INTCTRL));
 }
 
-- 
2.19.1

