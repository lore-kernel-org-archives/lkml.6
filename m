Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165498AbeE1OUo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161766AbeE1KfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:35:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 199/329] drm/imx: move arming of the vblank event to atomic_flush
Date: Mon, 28 May 2018 12:02:08 +0200
Message-Id: <20180528100258.799786553@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit 6a055b92de15af987b4027826d43aa103c65a3c4 ]

Right now the vblank event completion is racing with the atomic update,
which is especially bad when the PRE is in use, as one of the hardware
issue workaround might extend the atomic commit for quite some time.

If the vblank IRQ happens to trigger during that time, we will prematurely
signal the atomic commit completion to userspace, which causes tearing
when userspace re-uses a framebuffer we haven't managed to flip away from
yet.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/imx/ipuv3-crtc.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/imx/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
@@ -189,7 +189,11 @@ static void ipu_crtc_atomic_begin(struct
 				  struct drm_crtc_state *old_crtc_state)
 {
 	drm_crtc_vblank_on(crtc);
+}
 
+static void ipu_crtc_atomic_flush(struct drm_crtc *crtc,
+				  struct drm_crtc_state *old_crtc_state)
+{
 	spin_lock_irq(&crtc->dev->event_lock);
 	if (crtc->state->event) {
 		WARN_ON(drm_crtc_vblank_get(crtc));
@@ -257,6 +261,7 @@ static const struct drm_crtc_helper_func
 	.mode_set_nofb = ipu_crtc_mode_set_nofb,
 	.atomic_check = ipu_crtc_atomic_check,
 	.atomic_begin = ipu_crtc_atomic_begin,
+	.atomic_flush = ipu_crtc_atomic_flush,
 	.atomic_disable = ipu_crtc_atomic_disable,
 	.enable = ipu_crtc_enable,
 };
