Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6A6C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D70D208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107216;
	bh=4YS5FJ6x+BNS1h2+FHBXoQkM6qt5lTaO84TZPeWx7a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VinTe9bwJdJNZHtR1lncv7SZlUMdcg4wfpaQGpV46p/WboiO4lL4i2LPXIchLKtLk
	 ZtvKogeYViIH5aQRa+UOdDKkiBeDUuUtiRrdYq/tLpPE3mfDcGVJjLWgqBtB/l1we2
	 UppU31u4CGk6s0qSWqQ7qm5gIjfh8sNXf8aq6e88=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D70D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeLFOkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeLFOkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AD2A20672;
        Thu,  6 Dec 2018 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107213;
        bh=4YS5FJ6x+BNS1h2+FHBXoQkM6qt5lTaO84TZPeWx7a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjCcLq2cGOUo3UcBtp9V4HGZRk+gJQc4vKQW5VKifXgcFB07GsXqc2nZ/RSrLhyaD
         YfOIf9DzpQ+WwwPt1labaJvG9vceq1/d4aAHW5boQo21uFgps1eHNBMkGFbOb3mt/1
         tguuMCRwjSTZmJb6iynCr2m6DEp/xMolwUFDwdIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        Lyude Paul <lyude@redhat.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4.19 18/41] drm/meson: Fixes for drm_crtc_vblank_on/off support
Date:   Thu,  6 Dec 2018 15:38:58 +0100
Message-Id: <20181206142951.235667815@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

commit 2bcd3ecab773f73211c45bb1430bb52ac641f271 upstream.

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

The issue is that vblank need to be enabled in any occurrence of :
- atomic_enable()
- atomic_begin() and state->enable == true, which was not the case

Moving the CRTC enable code to a common function and calling in one of
these occurrence solves this race condition and makes sure vblank is
enabled in each call to _atomic_begin() from the HPD event leading to
drm_atomic_helper_commit_planes().

To Summarize :
- Make sure that the CRTC code will call the drm_crtc_vblank_on()/off()
- *Really* mask the Vsync IRQ
- Initialize and enable vblank at the first
  atomic_begin()/_atomic_enable()

Cc: stable@vger.kernel.org # 4.17+
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
[fixed typos+added cc for stable]
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181122160103.10993-1-narmstrong@baylibre.com
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/meson/meson_crtc.c |   27 +++++++++++++++++++++++++--
 drivers/gpu/drm/meson/meson_venc.c |    3 +++
 2 files changed, 28 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -45,6 +45,7 @@ struct meson_crtc {
 	struct drm_crtc base;
 	struct drm_pending_vblank_event *event;
 	struct meson_drm *priv;
+	bool enabled;
 };
 #define to_meson_crtc(x) container_of(x, struct meson_crtc, base)
 
@@ -80,8 +81,7 @@ static const struct drm_crtc_funcs meson
 
 };
 
-static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
-				     struct drm_crtc_state *old_state)
+static void meson_crtc_enable(struct drm_crtc *crtc)
 {
 	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
 	struct drm_crtc_state *crtc_state = crtc->state;
@@ -101,6 +101,22 @@ static void meson_crtc_atomic_enable(str
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
 
@@ -110,6 +126,8 @@ static void meson_crtc_atomic_disable(st
 	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
 	struct meson_drm *priv = meson_crtc->priv;
 
+	drm_crtc_vblank_off(crtc);
+
 	priv->viu.osd1_enabled = false;
 	priv->viu.osd1_commit = false;
 
@@ -124,6 +142,8 @@ static void meson_crtc_atomic_disable(st
 
 		crtc->state->event = NULL;
 	}
+
+	meson_crtc->enabled = false;
 }
 
 static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -132,6 +152,9 @@ static void meson_crtc_atomic_begin(stru
 	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
 	unsigned long flags;
 
+	if (crtc->state->enable && !meson_crtc->enabled)
+		meson_crtc_enable(crtc);
+
 	if (crtc->state->event) {
 		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
 
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -71,6 +71,7 @@
  */
 
 /* HHI Registers */
+#define HHI_GCLK_MPEG2		0x148 /* 0x52 offset in data sheet */
 #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
 #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
 #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 offset in data sheet */
@@ -1529,10 +1530,12 @@ unsigned int meson_venci_get_field(struc
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
 


